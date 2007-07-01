From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Making binary diffs
Date: Sun, 1 Jul 2007 02:17:10 -0400
Message-ID: <20070701061710.GR32223@spearce.org>
References: <93c3eada0706302314m20616a17s762704606c881278@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 08:17:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4skH-0004xT-9M
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 08:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbXGAGRP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 02:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbXGAGRP
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 02:17:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53135 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbXGAGRO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 02:17:14 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I4skC-0006sB-8r; Sun, 01 Jul 2007 02:17:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E67AE20FBAE; Sun,  1 Jul 2007 02:17:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <93c3eada0706302314m20616a17s762704606c881278@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51279>

Geoff Russell <geoffrey.russell@gmail.com> wrote:
> "git format-patch" generates binary diffs for binary files (e.g pdfs)
> in its patches,
> but "git diff -p" just tells me that a binary file is different and doesn't
> generate the actual diff.

--binary::
    In addition to --full-index, output "binary diff" that
    can be applied with "git apply".

Should work with all of the "diff things" like `git diff`,
`git log`, etc.  See the diff-options.txt in Documentation.

-- 
Shawn.
