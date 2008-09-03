From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 4/4] Switch usage of AnyObjectId.toString() to new AnyObjectId.name()
Date: Thu, 4 Sep 2008 00:05:55 +0200
Message-ID: <200809040005.55643.robin.rosenberg.lists@dewire.com>
References: <20080903170438.GA28315@spearce.org> <1220477294-23268-1-git-send-email-robin.rosenberg@dewire.com> <1220477294-23268-2-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Sep 04 00:09:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb0Xf-0004qJ-Bf
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 00:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbYICWIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 18:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbYICWIa
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 18:08:30 -0400
Received: from av8-1-sn3.vrr.skanova.net ([81.228.9.183]:36436 "EHLO
	av8-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbYICWI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 18:08:29 -0400
Received: by av8-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 31CE43826A; Thu,  4 Sep 2008 00:08:28 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av8-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 0EDEF381F0; Thu,  4 Sep 2008 00:08:28 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id ABEE037E4A;
	Thu,  4 Sep 2008 00:08:27 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1220477294-23268-2-git-send-email-robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94864>


The order of the patches should be
Add name to AnyObjectId
Switch usage.. in jgit
Switch usage.. in egit
Change toString to the new behaviour

-- robin
