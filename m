From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Force new line at end of commit message
Date: Mon, 24 Dec 2007 23:46:00 -0500
Message-ID: <20071225044600.GP14735@spearce.org>
References: <87ve6ub3u7.fsf@gollum.intra.norang.ca> <8763yof9lg.fsf@gollum.intra.norang.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Bernt Hansen <bernt@alumni.uwaterloo.ca>
X-From: git-owner@vger.kernel.org Tue Dec 25 05:46:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J71gU-0001LP-0I
	for gcvg-git-2@gmane.org; Tue, 25 Dec 2007 05:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbXLYEqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2007 23:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbXLYEqF
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Dec 2007 23:46:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44858 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbXLYEqE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2007 23:46:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J71fp-0001PW-8i; Mon, 24 Dec 2007 23:45:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 57E0620FBAE; Mon, 24 Dec 2007 23:46:00 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <8763yof9lg.fsf@gollum.intra.norang.ca>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69226>

[... comments for patch in reply to Dscho's reply...]

Bernt Hansen <bernt@alumni.uwaterloo.ca> wrote:
> Sorry I don't have an automated test for git-gui.  Are there any?

No.  I didn't really build git-gui very well for that sort of thing.
Part of my long-term plan for git-gui is to do refactoring on it
so that we can create automated tests for the lower level parts
(the logic behind the GUI).  Then we can actually do some automated
testing.

Wow.  I just realized git-gui is almost 14 months old.  Its probably
going to be another year before the above said refactoring is
completely finished, but its something that needs to be done if
git-gui is going to survive its terrible twos.

-- 
Shawn.
