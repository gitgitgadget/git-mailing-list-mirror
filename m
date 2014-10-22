From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/2] document signature formats
Date: Wed, 22 Oct 2014 17:16:52 +0200
Message-ID: <cover.1413990838.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 17:17:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgxen-0006rX-A0
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 17:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbaJVPQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2014 11:16:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56726 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752197AbaJVPQ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Oct 2014 11:16:56 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by gateway2.nyi.internal (Postfix) with ESMTP id C71F5209CA
	for <git@vger.kernel.org>; Wed, 22 Oct 2014 11:16:55 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 22 Oct 2014 11:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:subject:date
	:message-id; s=smtpout; bh=YLnsv4RvYJfgSYR/RGyNzyU1fIc=; b=A9gkn
	W+NAqa/xtlZ6z5vr/JELAlDp0wSY1C6UTHYrhF87rHp1U8i1tGxK7OakkfeGGn5J
	T3CReyotkCC+m2L+kRNQBk4K4VRlk6wDOknid6SewlRhAl7Lyvrp6x4GTTcfA4Nm
	Ze+TSmXkJgewnA0PjmR74hzHXfumDvgEIODuMs=
X-Sasl-enc: ds5ObvZDBUkI2g37SdWbvOzq/+BCXPbILKhlKcu5cDlB 1413991015
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7054C68012D;
	Wed, 22 Oct 2014 11:16:55 -0400 (EDT)
X-Mailer: git-send-email 2.1.2.756.gfa53a0a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a first shot at documenting the various signatures that we use
in a technical document. If something like this is deemed useful
I should probably recreate the sample signatures using our testlib
keys and users in a v2.

Michael J Gruber (2):
  Documentation/technical: signature formats
  Documentation/technical: document push certificate format

 Documentation/Makefile                       |   1 +
 Documentation/technical/signature-format.txt | 161 +++++++++++++++++++++++++++
 2 files changed, 162 insertions(+)
 create mode 100644 Documentation/technical/signature-format.txt

-- 
2.1.2.756.gfa53a0a
