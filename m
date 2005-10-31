From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild bug)
Date: Tue, 1 Nov 2005 09:44:24 +1300
Message-ID: <46a038f90510311244n5fc35166k43ea2410e92d83d4@mail.gmail.com>
References: <43652934.8000308@zytor.com>
	 <7vy84ajl4c.fsf@assigned-by-dhcp.cox.net>
	 <20051031064105.GV8041@shell0.pdx.osdl.net>
	 <43663EEA.5050102@zytor.com> <7v4q6xfpqg.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90510311213n565010d6g5586a7484b25da7e@mail.gmail.com>
	 <Pine.LNX.4.64.0510311230290.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, "H. Peter Anvin" <hpa@zytor.com>,
	git@vger.kernel.org, Sebastian Kuzminsky <seb@highlab.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 21:45:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWgW4-0008Qq-2j
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 21:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbVJaUoZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 15:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVJaUoZ
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 15:44:25 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:10385 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964827AbVJaUoY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 15:44:24 -0500
Received: by xproxy.gmail.com with SMTP id i30so1076791wxd
        for <git@vger.kernel.org>; Mon, 31 Oct 2005 12:44:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qd1btJ+aTWLfokLtqC4+rNtLKml/5LpEDapFrKV8yHVCPnFpf5INqO01RDJqhh4MSWtQAW4jtTjZewtvlqJi8Tyt6YRGPrKxWLe+rmV3MVYtCQ2NXUy8kY3gxlL3nDpT84g3U0s4BD0iYoK2HOryDP3ZZ6Ry4/Yyp7cMhSgekpg=
Received: by 10.65.205.1 with SMTP id h1mr495472qbq;
        Mon, 31 Oct 2005 12:44:24 -0800 (PST)
Received: by 10.64.232.18 with HTTP; Mon, 31 Oct 2005 12:44:24 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510311230290.27915@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10884>

On 11/1/05, Linus Torvalds <torvalds@osdl.org> wrote:
> I really really prefer gitk in the core, even if it means that there's
> that strange tcl/tk dependency.

I agree, but that's kind of a bummer for servers where someone just
wants to publish a couple of repos. tk depends on xlibs/libx11 and
that's just _nasty_.

git-core should be good for deployment on a server. Perhaps we want to
provide a git-scm package that brings in all the goodies you're likely
to want, including gitk?


martin
