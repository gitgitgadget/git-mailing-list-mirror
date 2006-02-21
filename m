From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Tue, 21 Feb 2006 22:57:42 +0100
Message-ID: <20060221215742.GA5948@steel.home>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de> <20060220191011.GA18085@hand.yhbt.net> <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net> <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com> <43FB79E2.1040307@vilain.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 22:58:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBfWR-0000p8-Cf
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 22:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWBUV57 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 16:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWBUV56
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 16:57:58 -0500
Received: from devrace.com ([198.63.210.113]:16392 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S964861AbWBUV56 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 16:57:58 -0500
Received: from tigra.home (p54A05C42.dip.t-dialin.net [84.160.92.66])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k1LLvjKi075398;
	Tue, 21 Feb 2006 15:57:46 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FBfVv-0000V4-00; Tue, 21 Feb 2006 22:57:43 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FBfVu-0001uZ-UL; Tue, 21 Feb 2006 22:57:42 +0100
To: Sam Vilain <sam@vilain.net>
Content-Disposition: inline
In-Reply-To: <43FB79E2.1040307@vilain.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16555>

Sam Vilain, Tue, Feb 21, 2006 21:36:50 +0100:
> >
> >>* Eric, thanks for the hint.  I have this four-patch series.
> >>  Could people with perl 5.6 please check them?
> >
> >
> >Does not work here (ActiveState Build 811, Perl 5.8.6):
> >
> >$ perl -e 'open(F, "-|")'
> >'-' is not recognized as an internal or external command,
> >operable program or batch file.
> 
> Portability, Ease of Coding, Few CPAN Module Dependencies.  Pick any two.
> 

Sometimes an upgrade is just out of question. Besides, that'd mean an
upgrade to another operating system, because very important scripts
over here a just not portable to anything else but
    "ActiveState Perl on Windows (TM)"
I just have no choice.
