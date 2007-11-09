From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/3] rev-list: Introduce --no-output to avoid /dev/null redirects
Date: Fri, 9 Nov 2007 04:12:19 -0500
Message-ID: <20071109091219.GQ14735@spearce.org>
References: <20071108080052.GB16690@spearce.org> <7vejezx4b2.fsf@gitster.siamese.dyndns.org> <20071109081204.GB2794@steel.home> <7vsl3fvlrb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 10:12:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqPuq-00045B-Hf
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 10:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbXKIJM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 04:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbXKIJMZ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 04:12:25 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58487 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbXKIJMX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 04:12:23 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IqPuU-00070y-W7; Fri, 09 Nov 2007 04:12:19 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2B65420FBAE; Fri,  9 Nov 2007 04:12:19 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vsl3fvlrb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64148>

Junio C Hamano <gitster@pobox.com> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
> > Junio C Hamano, Fri, Nov 09, 2007 08:32:01 +0100:
> >> 
> >> The function names noshow_xxx() looked a bit funny, but I do not
> >> offhand have better alternatives to offer.
> >
> > "hide", "skip", "ignore"?
> 
> But look at what the functions do.  The original show_xxx() was
> to print and then process.  Shawn splitted them into show_xxx()
> and noshow_xxx(), leaft the printing part in the former, made
> the former call the latter at the end, and moved the processing
> to the latter.  So it is not any of the three words.

In my latest patch series I've gone with "finish_xxx()" as it is
finishing our usage of that object.  I'll be resubmitting a new
series soon.

-- 
Shawn.
