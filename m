From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Don't define _XOPEN_SOURCE on MacOSX and FreeBSD as it is too restricting
Date: Thu, 21 Dec 2006 20:04:03 -0500
Message-ID: <20061222010403.GC14773@spearce.org>
References: <Pine.LNX.4.64.0612201524230.3576@woody.osdl.org> <caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com> <7vtzzq3wo6.fsf@assigned-by-dhcp.cox.net> <caf068570612201654s3949202cl55bd21307ca59453@mail.gmail.com> <7vodpy3vxi.fsf@assigned-by-dhcp.cox.net> <86vek6vyc7.fsf@blue.stonehenge.com> <caf068570612201735o776e01a8he2e9ab90fc2ee4f@mail.gmail.com> <20061221103938.GA7055@fiberbit.xs4all.nl> <20061221112835.GA7713@fiberbit.xs4all.nl> <7v64c492fv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Roeland <marco.roeland@xs4all.nl>,
	Terje Sten Bjerkseth <terje@bjerkseth.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Rocco Rutte <pdmef@gmx.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 02:04:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxYpo-0004pn-Ih
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 02:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423177AbWLVBEO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 20:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423172AbWLVBEO
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 20:04:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58335 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423177AbWLVBEM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 20:04:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GxYpH-00066I-Um; Thu, 21 Dec 2006 20:03:56 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3383320FB65; Thu, 21 Dec 2006 20:04:04 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64c492fv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35110>

Junio C Hamano <junkio@cox.net> wrote:
>  #0.5 Have you checked the tip of 'master' that has Terje's
>       patch?  It was reported to work yesterday and that is what
>       was committed already.

OK, but that isn't applied in next for some reason.  I'm still
carrying around my own version of Terje's patch.  :-(
 
>  #1   __APPLE__ vs __APPLE_CC__ is not something I can decide (I
>       do not run a Mac).  If MaxOS is derived from FreeBSD, does
>       it by chance define __FreeBSD as well?

__FreeBSD doesn't work here on my Mac.

-- 
Shawn.
