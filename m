From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv4 0/3]
Date: Fri,  6 Mar 2015 10:43:32 +0100
Message-ID: <cover.1425634616.git.git@drmicha.warpmail.net>
References: <mqqfv9j2nqu.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 10:43:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTonI-0000tE-De
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 10:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932876AbbCFJnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 04:43:40 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59052 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932636AbbCFJni (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2015 04:43:38 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 3526220B63
	for <git@vger.kernel.org>; Fri,  6 Mar 2015 04:43:36 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 06 Mar 2015 04:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=RztdmCGW9iD6c6
	NUMIyOxjdsqMw=; b=nWl417dWkp+A+eiKDrr2PAaCzn3dMpCkF7khhhuy9N5GdO
	QkkXNNUYpOf4IoIETmr1coBOROCd2enihKz5WEmFX2BnpVHyZr33ujmuRNvnmCCZ
	+5PJoxlBG1SSf05HQOkm2nJFUJ63ecWZlWtWBdBW0XwV29vKbCzNbKeSDp4hs=
X-Sasl-enc: 0zjkd2NU9RoyOjhZl62iDYGqt4c14FvLyBCg6XZMUOxC 1425635017
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0E05EC00297;
	Fri,  6 Mar 2015 04:43:36 -0500 (EST)
X-Mailer: git-send-email 2.3.1.303.g5174db1
In-Reply-To: <mqqfv9j2nqu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264902>

v4 has an additional line with 50*"-" before the second header (if there
is any).

Also, if status spewed out a cut-line (for commit) we emit a trailer
line before the first header (if there is any) so that it doesn't get
sucked in visually with the cut line description.

If there is only a "second" header it stands out by itself already due
to quinti-dashed line.

Junio C Hamano (1):
  t7508: .gitignore 'expect' and 'output' files

Michael J Gruber (2):
  t7508: test git status -v
  commit/status: show the index-worktree diff with -v -v

 Documentation/git-commit.txt |   4 ++
 t/t7508-status.sh            | 103 +++++++++++++++----------------------------
 wt-status.c                  |  20 +++++++++
 3 files changed, 60 insertions(+), 67 deletions(-)

-- 
2.3.1.303.g5174db1
