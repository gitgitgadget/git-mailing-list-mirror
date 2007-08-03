From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Thu, 2 Aug 2007 23:07:05 -0400
Message-ID: <20070803030705.GK20052@spearce.org>
References: <46AFCF3E.5010805@alum.mit.edu> <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de> <46B215E2.8010307@fs.ei.tum.de> <EDE86758-FFD0-4CED-A2C9-033FA13DD3B6@zib.de> <46B2309E.3060804@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	users@cvs2svn.tigris.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 05:07:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGnVc-0001hx-8h
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 05:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758392AbXHCDHV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 23:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757279AbXHCDHU
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 23:07:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56692 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757261AbXHCDHT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 23:07:19 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IGnVF-0005Ss-CS; Thu, 02 Aug 2007 23:07:01 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BE9BA20FBAE; Thu,  2 Aug 2007 23:07:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46B2309E.3060804@fs.ei.tum.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54664>

Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
> Steffen Prohaska wrote:
> >I remember that togit reported a broken pipe. My feeling was
> >that git-fastimport aborted, which may be reason why tohg
> >worked better.
> 
> yah, that pretty much tells me it is shawn's bug :)  but without more 
> details, it is very hard to diagnose.  tohg should tell you which rcs revs 
> are the offenders.  be sure to use a recent fromcvs however.

Tonight I'm going to try and add crash dump reporting to fast-import.
Once that's in it should make debugging some of these failed imports
easier, as we'll be able to see the immediate commands leading up
to the crash and the internal state of fast-import when it barfed.

Of course one needs to locate an ugly repository and run on it...

-- 
Shawn.
