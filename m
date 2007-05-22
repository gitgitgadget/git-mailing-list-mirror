From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Tue, 22 May 2007 23:56:59 +0200
Message-ID: <20070522215659.GJ30871@steel.home>
References: <11796842882917-git-send-email-skimo@liacs.nl> <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net> <20070520195930.GX942MdfPADPa@greensroom.kotnet.org> <4650EA2E.7070204@midwinter.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue May 22 23:57:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqcLs-0004Lb-UP
	for gcvg-git@gmane.org; Tue, 22 May 2007 23:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757429AbXEVV5H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 17:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756427AbXEVV5H
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 17:57:07 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:24454 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757429AbXEVV5G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 17:57:06 -0400
Received: from tigra.home (Fc8ee.f.strato-dslnet.de [195.4.200.238])
	by post.webmailer.de (mrclete mo60) (RZmta 6.5)
	with ESMTP id C0437fj4MI1AN3 ; Tue, 22 May 2007 23:57:00 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2AD85277BD;
	Tue, 22 May 2007 23:57:00 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id ED141D195; Tue, 22 May 2007 23:56:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4650EA2E.7070204@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow37lQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48124>

Steven Grimm, Mon, May 21, 2007 02:39:10 +0200:
> Sven Verdoolaege wrote:
> >It's pretty easy to add a "submodule.*.skip" or "submodule.*.ignore".
> >Since the subcloning only happens at checkout, you could set these
> >before doing a checkout.
> >  
> 
> Can I take this to mean that you intend the default behavior to be to 
> check out all subprojects, with individual ones suppressed via 
> configuration as needed?

Neither fetch nor checkout none of them and leave the subproject
fetch+checkout as exercise to the user?
