From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: [EGIT] [PATCH v2 0/1] Make sure to setup a clone the same as git-clone does
Date: Mon, 23 Feb 2009 18:45:22 +0100
Message-ID: <cover.1235410609.git.ferry.huberts@pelagic.nl>
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 18:47:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbetU-0007tZ-RL
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 18:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbZBWRpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 12:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752331AbZBWRpf
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 12:45:35 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:40493 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752131AbZBWRpe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2009 12:45:34 -0500
Received: from localhost.localdomain (unknown [192.168.0.101])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 28CA158BDBA;
	Mon, 23 Feb 2009 18:45:31 +0100 (CET)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111161>

Currently the plugin does not setup the default remote branch, something that
git-clone does do.

This patch fixes the issue and makes the plugin setup a cloned repository
exactly the same as git-clone.

Ferry Huberts (1):
  Make sure to set up the default remote branch correctly

 .../org/spearce/egit/core/op/CloneOperation.java   |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)
