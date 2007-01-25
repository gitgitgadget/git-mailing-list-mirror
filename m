From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Consolidate {receive,fetch}.unpackLimit
Date: Thu, 25 Jan 2007 00:14:19 -0500
Message-ID: <20070125051419.GB20345@spearce.org>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vzm8ansrt.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701231129501.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0701231101040.3011@xanadu.home> <7v1wljc3hb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 25 06:14:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9wwR-0005MK-7Y
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 06:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933231AbXAYFO1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 00:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933238AbXAYFO1
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 00:14:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50134 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933231AbXAYFO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 00:14:27 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H9wwL-0002ir-7x; Thu, 25 Jan 2007 00:14:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E104B20FBAE; Thu, 25 Jan 2007 00:14:19 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v1wljc3hb.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37708>

Junio C Hamano <junkio@cox.net> wrote:
> This allows transfer.unpackLimit to specify what these two
> configuration variables want to set.
> 
> We would probably want to deprecate the two separate variables,
> as I do not see much point in specifying them independently.

Indeed.  I was going to fix this too, but reuse receive.unpackLimit.
From my point of view both fetch and receive-pack are recieving
objects into this repository; and in either case I want the same
behavior with regards to loose object/pack management.

-- 
Shawn.
