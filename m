From: "John Rigby" <jcrigby@gmail.com>
Subject: Re: Problems with branches
Date: Fri, 26 Jan 2007 17:08:05 -0700
Message-ID: <4b73d43f0701261608i15fda894k904df8c7263a58eb@mail.gmail.com>
References: <4b73d43f0701261551oef411f7tfd5cdbfdce7f6abc@mail.gmail.com>
	 <7vfy9xtjxs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 27 01:08:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAb76-0000Ut-Qz
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 01:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbXA0AIJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 19:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbXA0AIJ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 19:08:09 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:47845 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbXA0AII (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 19:08:08 -0500
Received: by nz-out-0506.google.com with SMTP id s1so821327nze
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 16:08:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sc76JKAGFMShJvwI0W8b9tKxXjXSSeDz7m1A39n5Q4yRunJwZxzjpnFjvYTHs1otK5Co/97jvLkDFbZOws1s2p6H+PG65bNp5AC1J+nXNYSsSDV60xd1OAmykaup13iC4F13UE5MwjQeCDwV7HjkKawIZ1hkpyvzsgPP7LM518I=
Received: by 10.114.202.15 with SMTP id z15mr143773waf.1169856485533;
        Fri, 26 Jan 2007 16:08:05 -0800 (PST)
Received: by 10.114.156.18 with HTTP; Fri, 26 Jan 2007 16:08:05 -0800 (PST)
In-Reply-To: <7vfy9xtjxs.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37907>

Doh!  Thanks, I didn't realize that this was a 1.5 thing.

On 1/26/07, Junio C Hamano <junkio@cox.net> wrote:
> "John Rigby" <jcrigby@gmail.com> writes:
>
> > + git-merge mybranch
> > fatal: Needed a single revision
> > Usage: /home/jrigby/bin/git-merge [-n] [--no-commit] [--squash] [-s
> > <strategy>]... <merge-message> <head> <remote>+
> >
> > Could some kind soul help me pull my head out?
>
> Probably you are using v1.4.4.X.
>
> The change to make git-merge accessible as the first level UI
> happened during the preparation for the upcoming v1.5.0, and is
> available only in v1.5.0-rc0 and newer versions (the latest is
> at v1.5.0-rc2).
>
> If you replace "git-merge mybranch" with "git-pull . mybranch"
> you should be Ok.
>
>
