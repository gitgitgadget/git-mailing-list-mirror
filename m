From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCHES] Assorted minor fixes
Date: Mon, 9 Jun 2008 20:31:44 -0400
Message-ID: <20080610003144.GD4389@spearce.org>
References: <1213051816-4046-1-git-send-email-robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 02:32:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5rmz-000764-GS
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 02:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbYFJAbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 20:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbYFJAbs
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 20:31:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47252 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbYFJAbr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 20:31:47 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K5rlv-00052Q-Bp; Mon, 09 Jun 2008 20:31:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 47A5620FBAE; Mon,  9 Jun 2008 20:31:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1213051816-4046-1-git-send-email-robin.rosenberg.lists@dewire.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84462>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
>  .../egit/core/op/ConnectProviderOperation.java     |   15 ++++++-
>  org.spearce.egit.ui/icons/toolbar/trackd.png       |  Bin 0 -> 387 bytes
>  org.spearce.egit.ui/icons/toolbar/tracke.png       |  Bin 0 -> 411 bytes
>  org.spearce.egit.ui/plugin.properties              |    2 +-
>  org.spearce.egit.ui/plugin.xml                     |   19 +++++----
>  .../src/org/spearce/egit/ui/UIText.java            |    3 +
>  .../egit/ui/internal/actions/ResetAction.java      |    2 +-
>  .../spearce/egit/ui/internal/actions/Track.java    |   40 +++++++++++++++++---
>  .../internal/decorators/GitResourceDecorator.java  |    2 +-
>  .../egit/ui/internal/history/GitHistoryPage.java   |   24 +++++++++---
>  .../ui/internal/sharing/ExistingOrNewPage.java     |   17 ++++++++
>  .../egit/ui/internal/sharing/SharingWizard.java    |   16 +++++++-
>  .../src/org/spearce/egit/ui/uitext.properties      |    1 +
>  13 files changed, 115 insertions(+), 26 deletions(-)

How did you you send this series?  Its not format-patch output.
The diff-stat is missing from each commit, and there's no ---
to split message from diff.  I didn't bother trying to run them
through git-am yet as I assume I can just fetch from you, I'm
just saying the patches look "odd".

-- 
Shawn.
