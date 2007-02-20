From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add a compat/strtoumax.c for Solaris 8.
Date: Mon, 19 Feb 2007 19:35:33 -0500
Message-ID: <20070220003533.GB28314@spearce.org>
References: <17777.1171930976@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jason Riedy <ejr@EECS.Berkeley.EDU>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 01:36:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJIzA-0001zQ-Fz
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965745AbXBTAfj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965747AbXBTAfj
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:35:39 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59709 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965745AbXBTAfi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:35:38 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HJIyb-0002io-Qc; Mon, 19 Feb 2007 19:35:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B9BAE20FBAE; Mon, 19 Feb 2007 19:35:33 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <17777.1171930976@lotus.CS.Berkeley.EDU>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40177>

Jason Riedy <ejr@EECS.Berkeley.EDU> wrote:
> Solaris 8 was pre-c99, and they weren't willing to commit to
> the strtoumax definition according to /usr/include/inttypes.h.
> 
> This adds NO_STRTOUMAX and NO_STRTOULL for ancient systems.
> If NO_STRTOUMAX is defined, the routine in compat/strtoumax.c
> will be used instead.  That routine passes its arguments to
> strtoull unless NO_STRTOULL is defined.  If NO_STRTOULL, then
> the routine uses strtoul (unsigned long).

Ack'd (this and the fast-import patch that follows).

This is a better version than the patch I sent out last night,
so Junio please drop my patch in favor of Jason's.

-- 
Shawn.
