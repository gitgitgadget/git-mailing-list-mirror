From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Repository Security
Date: Tue, 23 Jan 2007 12:46:28 +1300
Message-ID: <46a038f90701221546n7a956a31n936aacb1c979730e@mail.gmail.com>
References: <200701221433.13257.andre@masella.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 00:46:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H98rx-0003C0-Jb
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 00:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbXAVXqb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 18:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbXAVXqb
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 18:46:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:9279 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268AbXAVXqa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 18:46:30 -0500
Received: by nf-out-0910.google.com with SMTP id o25so53518nfa
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 15:46:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o2vl4qoAKrby94wxbJAHxkbGoUUuDmQ+rFxFZa1Q14vDSdLW1p7ZZLN7IknosvnX9xwt+hru+tHStcA51xalbbq4OMmCTlXyUbUagMQSsP0AJyk5UC17nIJMnbAVFwlByWaCBAtclkSRwola1PQpplD0gkGj43DDjnmXfCRUj44=
Received: by 10.48.43.19 with SMTP id q19mr191258nfq.1169509588846;
        Mon, 22 Jan 2007 15:46:28 -0800 (PST)
Received: by 10.49.35.7 with HTTP; Mon, 22 Jan 2007 15:46:28 -0800 (PST)
To: "Andre Masella" <andre@masella.no-ip.org>
In-Reply-To: <200701221433.13257.andre@masella.no-ip.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37469>

On 1/23/07, Andre Masella <andre@masella.no-ip.org> wrote:
> As I understand it, none of the repository backends allow any per-user
> per-branch access control. SSH and HTTP come the closest with the right
> hooks, but since the repository is writeable by those users, there is little
> to stop them from changing the repository directly.

For this kind of scenario, use one repo per developer with GIT+SSH. It
changes your usage pattern slightly (pull from all repos before push)
but this is easy to setup. And you can even enforce the "won't let you
push unless you are up-to-date with the other repositories" via a
fancy pre-update hook script on the repo.

Or you may chose to have an integration repo _as well_ as public per-dev repos.

> So, before I start, I would like to get ideas from others...or be told this is
> a waste of time. Thanks.

Not entirely a waste of time, but there is a very git-style way of
addressing this that will probably save you time...


martin
