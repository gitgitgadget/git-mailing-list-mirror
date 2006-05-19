From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 0/5] Ref log updates
Date: Fri, 19 May 2006 03:27:51 -0400
Message-ID: <20060519072751.GA22257@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 09:28:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgzP5-0005Fm-UW
	for gcvg-git@gmane.org; Fri, 19 May 2006 09:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWESH1z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 03:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWESH1z
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 03:27:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:23491 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750989AbWESH1z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 03:27:55 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FgzOp-0002ha-OO; Fri, 19 May 2006 03:27:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A8E07212691; Fri, 19 May 2006 03:27:51 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20328>

The following series of patches applies on top of 'pu' and my prior
series of ref log related patches.

Most of these are bug fixes and test cases.

* [PATCH 1/5] General ref log reading improvements.

	Performance improvements and minor bug fixes in the log
	parser.

* [PATCH 2/5] Added logs/ directory to repository layout.

	Minor documentation update that I missed in the last round.

* [PATCH 3/5] Force writing ref if it doesn't exist.

	If a ref doesn't exist make sure we write it anyway.
	I found a few cases were we weren't writing the ref; this
	appears to have it fixed.

* [PATCH 4/5] Log ref updates made by fetch.

	Fully enable ref logging for the *-fetch family of tools.

* [PATCH 5/5] Change 'master@noon' syntax to 'master@{noon}'.

	Support parsing ':' in date strings correctly, especially
	in the face of 'master@2005-06-12 16:12:foo'.

-- 
Shawn.
