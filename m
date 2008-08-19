From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 00/14] TreeWalk D/F conflict detection
Date: Tue, 19 Aug 2008 15:54:03 -0700
Message-ID: <20080819225403.GG24212@spearce.org>
References: <1219186314-24048-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 00:55:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVa79-0003a0-9D
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 00:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358AbYHSWyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 18:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755346AbYHSWyG
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 18:54:06 -0400
Received: from george.spearce.org ([209.20.77.23]:50456 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755322AbYHSWyE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 18:54:04 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E553C38375; Tue, 19 Aug 2008 22:54:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1219186314-24048-1-git-send-email-spearce@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92932>

Sorry about that, my git-send-email directory had this cover letter
laying around in it from last time.  There is no series, I only meant
to post the single patch "Support path names longer than 4095...".

> Shawn O. Pearce (14):
>   Detect path names which overflow the name length field in the index
>   Fix NB.decodeUInt16 to correctly handle the high byte
>   Add test cases for NB.encode and NB.decode family of routines
>   Fix DirCache's skip over null byte padding when reading a DIRC file
>   Fix usage of assertEquals in DirCacheIteratorTest
>   Refactor AbstractTreeIterator.pathCompare to force another mode
>   Micro-optimize AbstractTreeIterator.pathCompare
>   Optimize path comparsion within subtrees during TreeWalk
>   Refactor AbstractTreeIterator semantics to start on first entry
>   Make all AbstractTreeIterator implementations bi-directional
>   Expose beginning of iterator indication from AbstractTreeIterator
>   Allow application code to set ObjectIds in DirCacheEntry
>   Create NameConflictTreeWalk to transparently detect D/F conflicts
>   Add test case for NameConflictTreeWalk
...
>  18 files changed, 1418 insertions(+), 207 deletions(-)

-- 
Shawn.
