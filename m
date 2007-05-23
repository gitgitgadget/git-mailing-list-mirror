From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: [PATCH] Document branch.autosetupmerge.
Date: Wed, 23 May 2007 07:07:54 +0200
Message-ID: <4653CC2A.5070202@lu.unisi.ch>
References: <d4cf37a60705182240s414243a6wae69d26f70f64dd5@mail.gmail.com>	<7vveepxr7m.fsf@assigned-by-dhcp.cox.net>	<d4cf37a60705190931rca1187ap9b98becb6c7c3b2a@mail.gmail.com>	<200705202230.24362.Josef.Weidendorfer@gmx.de>	<d4cf37a60705221722t2167a0e8x810689218b87fb39@mail.gmail.com> <7vwsz05qcq.fsf@assigned-by-dhcp.cox.net>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wink Saville <wink@saville.com>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 03:05:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr1lw-0007H5-Hz
	for gcvg-git@gmane.org; Thu, 24 May 2007 03:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920AbXEXBEn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 21:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757280AbXEXBEm
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 21:04:42 -0400
Received: from smtp.lu.unisi.ch ([195.176.178.41]:1143 "EHLO smtp.lu.unisi.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756920AbXEXBEm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 21:04:42 -0400
X-Greylist: delayed 71773 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 May 2007 21:04:41 EDT
Received: from mail.lu.unisi.ch ([195.176.178.40]) by smtp.lu.unisi.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 23 May 2007 07:10:06 +0200
Received: from scientist.local ([213.140.22.65] RDNS failed) by mail.lu.unisi.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 23 May 2007 07:07:44 +0200
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <7vwsz05qcq.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 23 May 2007 05:07:44.0162 (UTC) FILETIME=[4BD80820:01C79CF8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48213>

This patch documents the branch.autosetupmerge config option, adding
in commit 0746d19a.

Signed-Off-By: Paolo Bonzini  <bonzini@gnu.org>
---

  config.txt |    7 +++++++
  1 files changed, 7 insertions(+)

	> I notice that Paolo did not update Documentation/config.txt
	> when he add this feature with 0746d19a; care to send in a patch
	> to correct this?
	
	Sure.

	Paolo.

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 179cb17..de3c276 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -280,4 +280,11 @@ apply.whitespace::
  	Tells `git-apply` how to handle whitespaces, in the same way
  	as the '--whitespace' option. See gitlink:git-apply[1].

+branch.autosetupmerge::
+	Tells `git-branch' and `git-checkout' to setup new branches
+	so that gitlink:git-pull[1] will appropriately merge from that
+	remote branch.  Note that even if this option is not set,
+	this behavior can be chosen per-branch using the `--track`
+	and `--no-track` options.  This option defaults to false.
+
  branch.<name>.remote::
