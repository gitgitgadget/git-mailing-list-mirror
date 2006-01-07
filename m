From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-mv.perl: use stderr for error output and cleanup
Date: Sat, 7 Jan 2006 11:28:20 +0100
Message-ID: <20060107102820.GB5536@steel.home>
References: <81b0412b0601050349s6bec1a36jc410fd315fbbc4c@mail.gmail.com> <7vek3lq8wu.fsf@assigned-by-dhcp.cox.net> <86wthd7ypx.fsf@blue.stonehenge.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 11:28:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvBJc-00056w-Af
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 11:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbWAGK2v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 05:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932711AbWAGK2u
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 05:28:50 -0500
Received: from devrace.com ([198.63.210.113]:44553 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932343AbWAGK2u (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 05:28:50 -0500
Received: from tigra.home (p54A073FD.dip.t-dialin.net [84.160.115.253])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k07ASQb6045289;
	Sat, 7 Jan 2006 04:28:27 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EvBJ6-0000Cl-00; Sat, 07 Jan 2006 11:28:20 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EvBJ6-0001WO-PI; Sat, 07 Jan 2006 11:28:20 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86wthd7ypx.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14251>

Randal L. Schwartz, Fri, Jan 06, 2006 23:55:54 +0100:
> >>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
> 
> Junio> So I'd prefer not touching for (@df) { print H "$_\n" } loops.
> 
> Being as I'm a *bit* familiar with Perl, I'd write that as:
> 
>   print H "$_\0" for @deletedfiles;
> 

Does not work for old Perl
