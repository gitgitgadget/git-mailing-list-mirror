From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 1/2] Issue 23: Resolve tag^0 as tag^{commit}
Date: Fri, 12 Sep 2008 00:47:58 +0200
Message-ID: <200809120047.58484.robin.rosenberg.lists@dewire.com>
References: <20080911213927.GA20238@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Sep 12 00:49:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kduya-0007Zb-Fr
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 00:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614AbYIKWsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 18:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753453AbYIKWsR
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 18:48:17 -0400
Received: from av8-2-sn3.vrr.skanova.net ([81.228.9.184]:40164 "EHLO
	av8-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbYIKWsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 18:48:16 -0400
Received: by av8-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id A118F37F25; Fri, 12 Sep 2008 00:48:14 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av8-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 78DFE37E7F; Fri, 12 Sep 2008 00:48:14 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 3055F37E4C;
	Fri, 12 Sep 2008 00:48:14 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080911213927.GA20238@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95659>

torsdagen den 11 september 2008 23.39.27 skrev Jonas Fonseca:
> Repository.resolve("tag^0") failed with "not a commit". Fix it and add a
> test case for it.

It seems this case is not *that* special. It is tag^N == tag^{commit}^N
Same for tag~N == tag^{commit}~N-

My fault, i guess, but it would be nice of you fixed it while you are at it.

Second, the testcase in the second patch fails on my machine.

testDerefTaggedTagTree(org.spearce.jgit.lib.T0008_testparserev)
junit.framework.ComparisonFailure: expected:<[269e1253bad5c247c6bde37aa48ae1e03138206c]> but was:<[be83157b4ffe650d728ba4f98ad47b623b0d0c20]>
	at junit.framework.Assert.assertEquals(Assert.java:81)
	at junit.framework.Assert.assertEquals(Assert.java:87)
	at org.spearce.jgit.lib.T0008_testparserev.testDerefTaggedTagTree(T0008_testparserev.java:123)

-- robin
