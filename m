From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] [git-gui] i18n: Fix a bunch of still untranslated strings.
Date: Sun, 3 Feb 2008 21:25:00 -0500
Message-ID: <20080204022500.GK24004@spearce.org>
References: <200802021020.18017.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 03:25:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLr1h-0001fF-Gx
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 03:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971AbYBDCZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 21:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755967AbYBDCZI
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 21:25:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41061 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092AbYBDCZH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 21:25:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JLr0w-0005OB-Tj; Sun, 03 Feb 2008 21:24:54 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CA0E720FBAE; Sun,  3 Feb 2008 21:25:01 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200802021020.18017.stimming@tuhh.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72455>

Christian Stimming <stimming@tuhh.de> wrote:
> 
> I'm unsure about the hunk in lib/index.tcl, though - this
> might have to be rewritten. All others are rather trivial.

That hunk should be OK.  The [mc] call is happening later on,
as we eval the script in {} at the global level while we try
to invoke rescan.

Thanks.
 
-- 
Shawn.
