From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH v2 0/4] All is too much
Date: Fri, 14 May 2010 20:26:48 +0200
Message-ID: <cover.1273861341.git.git@drmicha.warpmail.net>
References: <4BED7574.4070503@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 20:27:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCzb9-0006mi-2B
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 20:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183Ab0ENS0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 14:26:53 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55835 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752563Ab0ENS0w (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 14:26:52 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 61254F5DDD;
	Fri, 14 May 2010 14:26:51 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 14 May 2010 14:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=Cy8kRTQcmjhckkPia6BW033j7Yc=; b=ozVGd4a3Aw9p078MP31bcC6YqhxlppiWi4uVjI7DKm2aCa87AhAJjyQASzwBDdVTpxo6Qadj9Tt+ibEU7aT0keLfYtGLNA9t1HNlBJAuQ5lEjogI9pYemA5q0O4BD/p5Vg54wZ4O6zf9g4txdGMc92IPM5X3rQanKzctHX0Ljis=
X-Sasl-enc: Zm0XqNiugJt3cKSW6ld2PpRLkfm/0EDmPE2tbn6W1SKQ 1273861607
Received: from localhost (p5485982A.dip0.t-ipconnect.de [84.133.152.42])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A7DF04CFCBD;
	Fri, 14 May 2010 14:26:47 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.240.geeaa4d
In-Reply-To: <4BED7574.4070503@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147106>

Resent with correct rebasing/squasing:
1,2 are unchanged
The introduction of tests for the new options is moved from 3 to 4 as
originally intended.

Michael J Gruber (4):
  rev-parse: deprecate use as an option sifter
  t6018: add tests for rev-list's --branches and --tags
  t6018: make sure all tested symbolic names are different revs
  revlist: Introduce --lrbranches and --locals revision specifiers

 Documentation/git-rev-list.txt     |    2 ++
 Documentation/git-rev-parse.txt    |   14 ++++++++++----
 Documentation/rev-list-options.txt |    8 ++++++++
 builtin/rev-list.c                 |    2 ++
 revision.c                         |   12 ++++++++++++
 t/t6018-rev-list-glob.sh           |   33 ++++++++++++++++++++++++++++++++-
 6 files changed, 66 insertions(+), 5 deletions(-)
