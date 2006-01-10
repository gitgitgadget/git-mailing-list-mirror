From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-mv.perl: use stderr for error output and cleanup
Date: Tue, 10 Jan 2006 23:24:08 +0100
Message-ID: <20060110222408.GB3155@steel.home>
References: <81b0412b0601050349s6bec1a36jc410fd315fbbc4c@mail.gmail.com> <7vek3lq8wu.fsf@assigned-by-dhcp.cox.net> <86wthd7ypx.fsf@blue.stonehenge.com> <20060107102820.GB5536@steel.home> <7vk6dcl49x.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 23:24:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwRug-0004uG-SZ
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 23:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWAJWYU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 17:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWAJWYT
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 17:24:19 -0500
Received: from devrace.com ([198.63.210.113]:46609 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932355AbWAJWYS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 17:24:18 -0500
Received: from tigra.home (p54A070EB.dip.t-dialin.net [84.160.112.235])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k0AMOCTT022568;
	Tue, 10 Jan 2006 16:24:13 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EwRuS-0000b8-00; Tue, 10 Jan 2006 23:24:08 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EwRuS-0007Kw-6t; Tue, 10 Jan 2006 23:24:08 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk6dcl49x.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14462>

Junio C Hamano, Sat, Jan 07, 2006 11:29:46 +0100:
> >>
> >>   print H "$_\0" for @deletedfiles;
> >
> > Does not work for old Perl
> 
> How old may I ask?
> 

5.4, probably. I never seen it anymore. Was a standard installation of
some Solaris box.
