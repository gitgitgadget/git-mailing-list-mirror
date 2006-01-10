From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-mv.perl: use stderr for error output and cleanup
Date: Tue, 10 Jan 2006 23:26:04 +0100
Message-ID: <20060110222604.GC3155@steel.home>
References: <81b0412b0601050349s6bec1a36jc410fd315fbbc4c@mail.gmail.com> <7vek3lq8wu.fsf@assigned-by-dhcp.cox.net> <86wthd7ypx.fsf@blue.stonehenge.com> <20060107102820.GB5536@steel.home> <86sls0498w.fsf@blue.stonehenge.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 23:29:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwRzA-00068q-Sg
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 23:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbWAJW26 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 17:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbWAJW26
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 17:28:58 -0500
Received: from devrace.com ([198.63.210.113]:42244 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932575AbWAJW25 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 17:28:57 -0500
Received: from tigra.home (p54A070EB.dip.t-dialin.net [84.160.112.235])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k0AMQ8Nx022585;
	Tue, 10 Jan 2006 16:26:17 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EwRwK-0000bu-00; Tue, 10 Jan 2006 23:26:04 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EwRwK-0007L3-4x; Tue, 10 Jan 2006 23:26:04 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86sls0498w.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14464>

Randal L. Schwartz, Sat, Jan 07, 2006 11:34:23 +0100:
> >> >>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
> Junio> So I'd prefer not touching for (@df) { print H "$_\n" } loops.
> >> 
> >> Being as I'm a *bit* familiar with Perl, I'd write that as:
> >> 
> >> print H "$_\0" for @deletedfiles;
> >> 
> 
> Alex> Does not work for old Perl
> 
> Correct.  It was added for Perl 5.5, first released on 22 July 1998.
> 
> Are you really saying you need this code to run on Perl 5.4?

No, probably not. I definitely don't care, just wanted to point it
out as another one kind of a strange setup (as if activestat perl +
cygwin isn't enough...)
