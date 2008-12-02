From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH v2 0/8] Unit test cleanups
Date: Tue, 2 Dec 2008 08:38:56 -0800
Message-ID: <20081202163856.GR23984@spearce.org>
References: <20081127214916.GD23984@spearce.org> <1228088435-23722-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fonseca@diku.dk
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 17:41:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7YII-0006Bf-UC
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 17:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbYLBQi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 11:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730AbYLBQi6
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 11:38:58 -0500
Received: from george.spearce.org ([209.20.77.23]:37870 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbYLBQi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 11:38:57 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id E85EC38200; Tue,  2 Dec 2008 16:38:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1228088435-23722-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102157>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> A completele reworked set of patches, including fixing a couple
> more forgot-to-close bugs and Shawns suggestion that we disable
> memory mapping in junit tests by default.
...
> Robin Rosenberg (8):
>   Drop unneeded code in unit tests
>   Cleanup malformed test cases
>   Turn off memory mapping in JGit unit tests by default
>   Add a counter to make sure the test repo name is unique
>   Make the cleanup less verbose when it fails to delete temporary
>     stuff.
>   Cleanup after each test.
>   Close files opened by unit testing framework
>   Hard failure on unit test cleanups if they fail.
> 
>  .../tst/org/spearce/jgit/lib/PackWriterTest.java   |    3 +
>  .../org/spearce/jgit/lib/RepositoryTestCase.java   |  152 +++++++++++++++++---
>  .../tst/org/spearce/jgit/lib/T0007_Index.java      |   10 +-
>  3 files changed, 139 insertions(+), 26 deletions(-)

Merged.  The series looked really good to me.  Second time is the
charm, eh?  :-)

-- 
Shawn.
