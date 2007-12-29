From: "Dan McGee" <dpmcgee@gmail.com>
Subject: Re: generated HTML contains broken links
Date: Sat, 29 Dec 2007 10:24:58 -0600
Message-ID: <449c10960712290824yd2c5783l8d0ba91bbad95789@mail.gmail.com>
References: <87sl1mqt10.fsf@offby1.atm01.sea.blarg.net>
	 <4775B87D.4010507@gmail.com>
	 <20071229155705.GA23659@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Eric Hanchrow" <offby1@blarg.net>, git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Dec 29 17:25:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8eVI-0007FM-21
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 17:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbXL2QZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 11:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753901AbXL2QZB
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 11:25:01 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:56089 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbXL2QZA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 11:25:00 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3890573rvb.1
        for <git@vger.kernel.org>; Sat, 29 Dec 2007 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NiqaLBtfMekPT+ghh8MckxC9wDkS5vh8w4OygIgGWuM=;
        b=xef4FeotdnqiZS6SuTn17RPbuKSOXFqGiQmjPzfwj9+tA3qdYzTwbtz7wpMDEd6F/Y7hoK8stnyS0BARqkKjxAD29Bsy2Z2F/7df5yVc2D2Jlh8Oj6P6I9F4XzNaMOILHO18ou4d02fAwd8w2qODf7ZdWXSQd1P9gRujRwyeqcM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=u8a6e2Ukv/nG4plCPOKzzRiq8NjitVOItBUp6X5tYfL9YKAA9hwjadFEwMgNeMM5gEitMQY9gDBq0TZUMWLE308snN7YPAJjUzkXcBVuO78gvFogYDURRpsEL4e5hfQEuvTgS3WXL1wSNIpFJl1vpIXb5PMZrE/5qUoYpzdPNTQ=
Received: by 10.141.205.10 with SMTP id h10mr145199rvq.110.1198945499018;
        Sat, 29 Dec 2007 08:24:59 -0800 (PST)
Received: by 10.141.53.1 with HTTP; Sat, 29 Dec 2007 08:24:58 -0800 (PST)
In-Reply-To: <20071229155705.GA23659@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69318>

On Dec 29, 2007 9:57 AM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Fri, Dec 28, 2007 at 09:01:17PM -0600, Dan McGee <dpmcgee@gmail.com> wrote:
> > Generated man pages from Junio:
> > HOOKS
> >        This command can run commit-msg, pre-commit, and post-commit hooks. See
> >        [1]hooks for more information.
> >
> > SEE ALSO
> >        git-add(1), git-rm(1), git-mv(1), git-merge(1), git-commit-tree(1)
> >
> > AUTHOR
> >        Written by Linus Torvalds <torvalds@osdl.org> and Junio C Hamano
> >        <junkio@cox.net>
> >
> > GIT
> >        Part of the git(7) suite
> >
> > Man pages generated locally (with Asciidoc 8.2.3 or 8.2.5):
> > HOOKS
> >        This command can run commit-msg, pre-commit, and post-commit hooks. See
> >        hooks[5] for more information.
> >
> > SEE ALSO
> >        git1[1], git1[2], git1[8], git1[6], git1[9]
> >
> > AUTHOR
> >        Written by Linus Torvalds <torvalds@osdl.org> and Junio C Hamano
> >        <junkio@cox.net>
> >
> > GIT
> >        Part of the git7[10] suite
>
> http://code.toofishes.net/gitweb.cgi?p=pacman.git;a=commitdiff;h=b3c6bdda38f7e370e1f80f02a61f1d3f08c1b57d
>
> here is the commit that fixed the problem for pacman. what do you think,
> should we rename gitlink to something else, too - or should we contact
> upstream to notify them about they caused a breakage?

I've tried twice now to send a patch to the list...please let me know
if it isn't working, because I am getting CCed on the send, and the
mailing list address is set in the sendemail.to variable. I did notice
that send-email doesn't even prompt you for confirmation of the
default "to" address if you have this variable set, so I'm not sure if
something weird is happening there.

-Dan
