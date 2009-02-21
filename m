From: ferry.huberts@pelagic.nl
Subject: [EGIT] [PATCH 0/2] Make sure to setup a clone the same as git-clone does
Date: Sat, 21 Feb 2009 16:17:46 +0100
Message-ID: <cover.1235228532.git.ferry.huberts@pelagic.nl>
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 16:20:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Latdv-0002Vg-LH
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 16:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbZBUPR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 10:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753205AbZBUPR5
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 10:17:57 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:55607 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752183AbZBUPRz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Feb 2009 10:17:55 -0500
Received: from localhost.localdomain (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 1F85758BDBA;
	Sat, 21 Feb 2009 16:17:53 +0100 (CET)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110959>

From: Ferry Huberts <ferry.huberts@pelagic.nl>

Currently the plugin does not setup core.bare=false and also does not setup
the default (pull) remote branch for master, two things that git-clone does
do.

The first ommision is not a problem, but seconds is. When using git-clone
it by default sets up the master to pull from the remote master.

This patch series fixes both issues and makes the plugin setup a cloned
repository exactly the same as git-clone.

Ferry Huberts (2):
  Make sure to set core.bare to false when cloning
  Make sure to set up the default (pull) remote branch for master

 .../org/spearce/egit/core/op/CloneOperation.java   |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)
