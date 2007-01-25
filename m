From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Hash name is SHA-1
Date: Thu, 25 Jan 2007 14:05:16 -0500
Message-ID: <20070125190516.GD13089@spearce.org>
References: <11697294071178-git-send-email-vonbrand@inf.utfsm.cl> <1169729410294-git-send-email-vonbrand@inf.utfsm.cl> <20070125170120.GA13089@spearce.org> <Pine.LNX.4.64.0701251209100.3011@xanadu.home> <200701251856.l0PIu8pP032403@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Thu Jan 25 20:05:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA9ue-00012U-6U
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 20:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030488AbXAYTF2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 14:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030510AbXAYTF2
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 14:05:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44772 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030488AbXAYTF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 14:05:27 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HA9uM-0008M0-7D; Thu, 25 Jan 2007 14:05:14 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6784520FBAE; Thu, 25 Jan 2007 14:05:16 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200701251856.l0PIu8pP032403@laptop13.inf.utfsm.cl>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37751>

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> wrote:
> Nicolas Pitre <nico@cam.org> wrote:
> > Maybe the patch could be restricted to documentation fixes only for now?
> 
> That's what I tried to do. But just changing the documentation without
> changing (some) of the messages and so on just gets you worse
> inconsistency.

I'm not at all against updating output messages to match the
documentation.  Indeed, its good to make them consistent.

It just would be a lot easier to review the patch if it wasn't 1600+
lines, _especially_ when some of the hunks really aren't related
to the theme of the patch.

Of course with the amount of time I've now spent writing email
saying how hard it is to review the original patch, I could have just
read through the entire thing and given it another set of eyeballs.
Argh, another great misuse of my time.  :-)

-- 
Shawn.
