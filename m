From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Add option for changing the width of the commit message text box
Date: Fri, 7 Mar 2008 21:00:26 -0500
Message-ID: <20080308020026.GV8410@spearce.org>
References: <1204832320-22800-1-git-send-email-ediap@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Adam =?utf-8?Q?Pi=C4=85tyszek?= <ediap@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Mar 08 03:01:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXoNF-0007l5-GA
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 03:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760AbYCHCAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 21:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760016AbYCHCAl
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 21:00:41 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36545 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758084AbYCHCA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 21:00:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JXoMC-0004Dr-HA; Fri, 07 Mar 2008 21:00:16 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8F55720FBAE; Fri,  7 Mar 2008 21:00:26 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1204832320-22800-1-git-send-email-ediap@users.sourceforge.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76540>

Adam Pityszek <ediap@users.sourceforge.net> wrote:
> The width of the commit message text area is currently hard-coded
> to 75 characters. This value might be not optimal for some projects.
> For instance users who would like to generate GNU-style ChangeLog
> file from git commit message might prefer commit messages of width
> no longer than 70 characters.
> 
> This patch adds a global and per repository option "Commit Message
> Text Width", which could be used to change the width of the commit
> message text area.

Thanks.
 
> Ideally, I would like to have an automated line wrapping in the commit
> message text area. Unfortunately the "-wrap words" switch only wraps the
> lines for displaying purposes and this has no effect on the committed message
> itself.
 
Yea, I fought with that myself for a while and just settled on
a 75 character wide text area.

-- 
Shawn.
