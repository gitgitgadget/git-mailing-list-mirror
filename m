From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 2 Mar 2006 23:09:30 +0100
Message-ID: <20060302220930.GE6183@steel.home>
References: <20060302164405.GB7292@trixie.casa.cgf.cx> <20060302165510.GB18929@spearce.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 23:10:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEvzq-0007X2-T2
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 23:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWCBWKD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 17:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbWCBWKC
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 17:10:02 -0500
Received: from devrace.com ([198.63.210.113]:26130 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1752067AbWCBWKB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 17:10:01 -0500
Received: from tigra.home (p54A05596.dip.t-dialin.net [84.160.85.150])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k22M9YlE017816;
	Thu, 2 Mar 2006 16:09:40 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FEvzG-0005rb-00; Thu, 02 Mar 2006 23:09:30 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FEvzG-0002E5-9n; Thu, 02 Mar 2006 23:09:30 +0100
To: Shawn Pearce <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20060302165510.GB18929@spearce.org>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17113>

Shawn Pearce, Thu, Mar 02, 2006 17:55:10 +0100:
> Maybe I missed this but why are people using the native Windows
> ActiveState Perl with GIT+Cygwin when Cygwin has a Cygwin-ized Perl
> installation available?

because the people _can't_ use cygwin's perl. There are a lot of
reasons mainly: administrative, perl script incompatibilities and
cygwin.dll incompatibilities (if you use perl from cygwin, it'll need
the correct cygwin.dll. And if a build process uses cygwin tools from,
for example, QNX Momentics it often comes to clashes).

> I've been using the Cygwin Perl with GIT without any problems
> whatsoever.  Including the open(I, "-|")... exec(@argv) code that
> doesn't work correctly in ActiveState and started this whole thread.

Unfortunately...
