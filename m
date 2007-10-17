From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Deltifying? (was [PATCH 3/6] pack-objects: no delta possible...)
Date: Tue, 16 Oct 2007 22:15:55 -0400
Message-ID: <20071017021555.GP13801@spearce.org>
References: <1192586150-13743-1-git-send-email-nico@cam.org> <1192586150-13743-2-git-send-email-nico@cam.org> <1192586150-13743-3-git-send-email-nico@cam.org> <1192586150-13743-4-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 04:16:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhySA-0006sV-Oj
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 04:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995AbXJQCP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 22:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754231AbXJQCP7
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 22:15:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51670 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbXJQCP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 22:15:58 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IhyRl-0006Zs-7Z; Tue, 16 Oct 2007 22:15:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 910FE20FBAE; Tue, 16 Oct 2007 22:15:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1192586150-13743-4-git-send-email-nico@cam.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61314>

Nicolas Pitre <nico@cam.org> wrote:
>  			start_progress(&progress_state, "Deltifying objects",

Totally unrelated to this patch but yesterday a coworker called the
Grammar Police on me because Git said "Deltifying objects" in their
console window during a fetch or push operation.  I told them it was
perfectly valid, they disagreed.  I got free coffee out of the deal.

But still, it bothers some users that we use perhaps less than
commonly accepted English in an important tool's output.  Seeing it
in your context just reminded me of that discussion yesterday.

-- 
Shawn.
