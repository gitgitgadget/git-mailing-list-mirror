From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 0/3]More diffs for commit/status
Date: Thu,  5 Mar 2015 15:13:01 +0100
Message-ID: <cover.1425564336.git.git@drmicha.warpmail.net>
References: <xmqqr3t479ey.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 15:13:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTWWX-0008IT-PV
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 15:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981AbbCEONI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 09:13:08 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36057 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755610AbbCEONH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2015 09:13:07 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A6FDE20704
	for <git@vger.kernel.org>; Thu,  5 Mar 2015 09:13:04 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 05 Mar 2015 09:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=OscnBK9sU+l1Bo
	YrgK+MColY4vk=; b=O9ni/UpEW4B8D7DeagCBJfUxit/SCKx8uSVLeXECURa9j7
	E5SdT+efRlfjJUn1Pu2rRj45TmiAU23Be1ISVsgcdFoUS6bn5rCkQYQrxDfmQdPW
	pQ1Wyg4Uh65sBfutQyVrg/9YR2n0umfjyvufFgOpI42kWZqrtgJg3/+735Tgc=
X-Sasl-enc: C56pLkgPauHy4OFEsL6nwLaQ6pIh6udOe0lM8NHmpV4z 1425564785
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7ABAC6801B9;
	Thu,  5 Mar 2015 09:13:05 -0500 (EST)
X-Mailer: git-send-email 2.3.1.303.g5174db1
In-Reply-To: <xmqqr3t479ey.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264836>

v3 has the following changes:
- new leading patch by Junio to clean up t7508 (slightly modified by myself)
- adjust tests accordingly
- revert back to standard c/,i/ resp. i/,w/ diff prefixes with a header line

Open questionis for 3/3:
- Do we need the header to stick out even more? (I don't think so, although
  having the STATUS_HEADER color to be different may help.)
- Do we want the header line also for "status -v"? (I would say yes, but that
  would be a change to current behaviour.)

Junio C Hamano (1):
  t7508: .gitignore 'expect' and 'output' files

Michael J Gruber (2):
  t7508: test git status -v
  commit/status: show the index-worktree diff with -v -v

 Documentation/git-commit.txt |   4 ++
 t/t7508-status.sh            | 102 +++++++++++++++----------------------------
 wt-status.c                  |  16 +++++++
 3 files changed, 55 insertions(+), 67 deletions(-)

-- 
2.3.1.303.g5174db1
