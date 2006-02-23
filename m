From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Convert open("-|") to qx{} calls
Date: Thu, 23 Feb 2006 22:14:03 +0100
Message-ID: <20060223211403.GB5827@steel.home>
References: <Pine.LNX.4.63.0602231532470.29635@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0602230738s3445bd86h2d1d670e0ef5daed@mail.gmail.com> <86hd6qgit5.fsf@blue.stonehenge.com> <7v1wxuhsgw.fsf@assigned-by-dhcp.cox.net> <863bi9hq6u.fsf@blue.stonehenge.com> <Pine.LNX.4.63.0602232039160.30630@wbgn013.biozentrum.uni-wuerzburg.de> <86lkw1g647.fsf@blue.stonehenge.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 22:14:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCNn1-0004me-Ea
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 22:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWBWVOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 16:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWBWVOR
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 16:14:17 -0500
Received: from devrace.com ([198.63.210.113]:58380 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751773AbWBWVOQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2006 16:14:16 -0500
Received: from tigra.home (p54A06B17.dip.t-dialin.net [84.160.107.23])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k1NLE4pA033929;
	Thu, 23 Feb 2006 15:14:05 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FCNml-0000iH-00; Thu, 23 Feb 2006 22:14:03 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FCNml-0001fB-2P; Thu, 23 Feb 2006 22:14:03 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86lkw1g647.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16667>

Randal L. Schwartz, Thu, Feb 23, 2006 21:41:44 +0100:
> Johannes> Now that our local Perl guru joined the discussion, may I ask what
> Johannes> is, and what is not quoted when put inside qx{}?
> 
> Nothing is quoted.  Your string acts as if it was XXX in:
> 
>         sh -c 'XXX'
> 

Not so for ActiveState. It'll just run the first non-whitespace word
passing the rest of the line in its command-line.
It's not even worse then to pass it all to cmd/command :)
