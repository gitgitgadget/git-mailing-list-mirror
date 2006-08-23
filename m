From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] adding support for md5
Date: Wed, 23 Aug 2006 00:14:53 -0400
Message-ID: <20060823041453.GA25796@spearce.org>
References: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com> <Pine.LNX.4.64.0608191339010.11811@g5.osdl.org> <20060821204430.GA2700@tuatara.stupidest.org> <7vr6z9s376.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 06:15:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFk9h-0002wW-FX
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 06:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWHWEPb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 00:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWHWEPb
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 00:15:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52893 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932341AbWHWEPb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 00:15:31 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GFk9J-0008Gc-By; Wed, 23 Aug 2006 00:15:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E568B20FB7D; Wed, 23 Aug 2006 00:14:53 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr6z9s376.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25892>

Junio C Hamano <junkio@cox.net> wrote:
> I personally am not interested in making this configurable at
> all.  The hashcmp() change on the other hand to abstract out 20
> was a good preparation, if we ever want to switch to longer
> hashes we would know where to look.

What about all of those memcpy(a, b, 20)'s?  :-)

I can see us wanting to support say SHA-128 or SHA-256 in a few
years.  Especially as processors get faster and better attacks are
developed against SHA-1 such that its no longer really the best
trade-off hash function available.

-- 
Shawn.
