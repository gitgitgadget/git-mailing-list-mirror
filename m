From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: [EGIT] [PATCH v1 0/1] Add an ignored icon
Date: Mon, 23 Feb 2009 20:03:43 +0100
Message-ID: <cover.1235415747.git.ferry.huberts@pelagic.nl>
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 20:06:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbg7L-0003YQ-TK
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 20:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbZBWTD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 14:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbZBWTDz
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 14:03:55 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:34492 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752345AbZBWTDz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2009 14:03:55 -0500
Received: from localhost.localdomain (unknown [192.168.0.101])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 32B0F58BDBA;
	Mon, 23 Feb 2009 20:03:52 +0100 (CET)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111170>

Add an ignored icon to the label decorations page and make
sure that it is actually decorated: from now on do not ignore
ignored resources during decoration.

Ferry Huberts (1):
  Add an ignored icon

 org.spearce.egit.ui/icons/ovr/ignored.gif          |  Bin 0 -> 102 bytes
 .../egit/ui/PluginPreferenceInitializer.java       |    1 +
 .../src/org/spearce/egit/ui/UIIcons.java           |    4 ++++
 .../src/org/spearce/egit/ui/UIPreferences.java     |    2 ++
 .../src/org/spearce/egit/ui/UIText.java            |    3 +++
 .../decorators/GitLightweightDecorator.java        |   11 ++++++++---
 .../preferences/GitDecoratorPreferencePage.java    |   12 ++++++++++++
 .../src/org/spearce/egit/ui/uitext.properties      |    1 +
 8 files changed, 31 insertions(+), 3 deletions(-)
 create mode 100644 org.spearce.egit.ui/icons/ovr/ignored.gif
