From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] Show total transferred as part of throughput progress
Date: Fri, 2 Nov 2007 00:59:50 -0400
Message-ID: <20071102045950.GZ14735@spearce.org>
References: <1193950797-29631-1-git-send-email-nico@cam.org> <1193950797-29631-2-git-send-email-nico@cam.org> <1193950797-29631-3-git-send-email-nico@cam.org> <1193950797-29631-4-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 06:00:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inodj-0002R1-46
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 06:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbXKBE76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 00:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbXKBE76
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 00:59:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39636 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbXKBE75 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 00:59:57 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1InodL-0004nN-Vq; Fri, 02 Nov 2007 00:59:52 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7DB7320FBAE; Fri,  2 Nov 2007 00:59:50 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1193950797-29631-4-git-send-email-nico@cam.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63061>

Nicolas Pitre <nico@cam.org> wrote:
> Right now it is infeasible to offer to the user a reasonable concept
> of when a clone will be complete as we aren't able to come up with
> the final pack size until after we have actually transferred the
> entire thing to the client.  However in many cases users can work
> with a rough rule-of-thumb; for example it is somewhat well known
> that git.git is about 16 MiB today and that linux-2.6.git is over
> 120 MiB.
...
> [from an initial proposal from Shawn O. Pearce]

Thanks for rewriting this.  I agree, your replacement patch is
much better looking than my proposal.  I also see Junio has already
applied it to next.  Excellent.
 
-- 
Shawn.
