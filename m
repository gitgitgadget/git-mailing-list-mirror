From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Deprecation/Removal schedule
Date: Tue, 6 Feb 2007 16:26:14 +0100
Message-ID: <81b0412b0702060726o17cd3521u633a6c4deb07b9d3@mail.gmail.com>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net> <45C896F3.5000007@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Feb 06 16:26:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HESD9-0004Dk-3E
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 16:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbXBFP0Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 10:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbXBFP0Q
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 10:26:16 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:52645 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbXBFP0P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 10:26:15 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1561864wri
        for <git@vger.kernel.org>; Tue, 06 Feb 2007 07:26:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nKixEkBjph0hqstqfds5gdOPWZfbvljwlNkM5l+nOAiz5GokxD/6FV7BRc0AKWQ/GcL64/mU5+kyo6zKZqfc57MdX6UdxJb9LJYGQrQqmk1+4vxGeGncx1VaudPliPRTy13/hde8zAmf2cC7o3WfCITqRUOejvmjRPjJwmj1Pcc=
Received: by 10.78.47.15 with SMTP id u15mr1723525huu.1170775574148;
        Tue, 06 Feb 2007 07:26:14 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Tue, 6 Feb 2007 07:26:14 -0800 (PST)
In-Reply-To: <45C896F3.5000007@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38849>

On 2/6/07, Andreas Ericsson <ae@op5.se> wrote:
> Junio C Hamano wrote:
> >
> > * git-lost-found
> >
> >   Although it has served us well, I think it is about to outlive
> >   its usefulness, thanks to the recent "reflog by default"
> >   change.
> >
>
> Nonono. Please no. This has saved me more times than I can even care
> to remember. Especially whenever I'm teaching newcomers how to git.
> I really wouldn't want to not have it there in case its needed and
> some schmuck upgrades git and then loses something vital because he
> forgot to enable the reflog on an old repo.

It's functionality is superseded by "git fsck --unreachable",
see this discussion.
