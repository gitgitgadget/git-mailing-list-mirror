From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: [EGIT] [PATCH v3 0/1] Make sure to setup a clone the same as git-clone does
Date: Mon, 23 Feb 2009 19:55:22 +0100
Message-ID: <cover.1235415204.git.ferry.huberts@pelagic.nl>
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 19:57:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbfzL-0000iu-Aq
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 19:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680AbZBWSzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 13:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754762AbZBWSzg
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 13:55:36 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:58488 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754709AbZBWSzf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2009 13:55:35 -0500
Received: from localhost.localdomain (unknown [192.168.0.101])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 3560958BDBA;
	Mon, 23 Feb 2009 19:55:31 +0100 (CET)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111167>

Currently the plugin does not setup the default remote branch, something that
git-clone does do.

This patch fixes the issue and makes the plugin setup a cloned repository
exactly the same as git-clone.

Ferry Huberts (1):
  Make sure to set up the default remote branch correctly

 .../org/spearce/egit/core/op/CloneOperation.java   |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)
