From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH v2 0/8] Unit test cleanups
Date: Mon,  1 Dec 2008 00:40:27 +0100
Message-ID: <1228088435-23722-1-git-send-email-robin.rosenberg@dewire.com>
References: <20081127214916.GD23984@spearce.org>
Cc: git@vger.kernel.org, fonseca@diku.dk,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Dec 01 00:42:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6vvf-0001xS-8S
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 00:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbYK3Xko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 18:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753493AbYK3Xkn
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 18:40:43 -0500
Received: from mail.dewire.com ([83.140.172.130]:25184 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457AbYK3Xkn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 18:40:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 409F1147D545;
	Mon,  1 Dec 2008 00:40:40 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tqdSQa0iWGry; Mon,  1 Dec 2008 00:40:37 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id DFB8414433E9;
	Mon,  1 Dec 2008 00:40:36 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
In-Reply-To: <20081127214916.GD23984@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101986>

A completele reworked set of patches, including fixing a couple
more forgot-to-close bugs and Shawns suggestion that we disable
memory mapping in junit tests by default.

-- robin

Robin Rosenberg (8):
  Drop unneeded code in unit tests
  Cleanup malformed test cases
  Turn off memory mapping in JGit unit tests by default
  Add a counter to make sure the test repo name is unique
  Make the cleanup less verbose when it fails to delete temporary
    stuff.
  Cleanup after each test.
  Close files opened by unit testing framework
  Hard failure on unit test cleanups if they fail.

 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |    3 +
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |  152 +++++++++++++++++---
 .../tst/org/spearce/jgit/lib/T0007_Index.java      |   10 +-
 3 files changed, 139 insertions(+), 26 deletions(-)
