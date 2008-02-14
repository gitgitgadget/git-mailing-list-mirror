From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 0/5] Better fast-import crash handling
Date: Thu, 14 Feb 2008 01:34:25 -0500
Message-ID: <20080214063425.GJ24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 07:35:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPXgX-00057C-Bl
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 07:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034AbYBNGea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 01:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754968AbYBNGea
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 01:34:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60573 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895AbYBNGe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 01:34:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JPXfv-0004U3-HL; Thu, 14 Feb 2008 01:34:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E46B120FBAE; Thu, 14 Feb 2008 01:34:25 -0500 (EST)
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73856>

Today I was cleaning out my git tree and found these commits laying
in a branch I had forgotten about.  Rebased onto current master
and offered for inclusion.  :)

  1)  fast-import: check return value from unpack_entry()

This may be worth putting into maint.

  2)  Include annotated tags in fast-import crash reports
  3)  Include the fast-import marks table in crash reports
  4)  Finish current packfile during fast-import crash handler
  5)  Update fast-import documentation to discuss crash reports

I'd consider the rest to be master worthy, for 1.5.5.

-- 
Shawn.
