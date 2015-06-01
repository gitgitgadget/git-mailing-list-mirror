From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/2] uniform error messages for index read and write
Date: Mon,  1 Jun 2015 15:50:03 +0200
Message-ID: <cover.1433166363.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 15:50:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzQ6Y-0003JG-Fj
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 15:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbbFANuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 09:50:09 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54884 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752429AbbFANuH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 09:50:07 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id DBBCD381F9A
	for <git@vger.kernel.org>; Mon,  1 Jun 2015 09:50:06 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Mon, 01 Jun 2015 09:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:message-id:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp;
	 bh=hTz6yUlU+3aVUP9Vao8HHsrJ+v4=; b=EVmkJs8JRzF4LLRSI3UARspVRlKa
	DkZbUlc9EldOjFXU/4gW1YQnpslbtZLu3OPId+G0nX6hNsde5o4H3A1+zBI8DDzx
	VXdrwLN3OiRAC2OLxKAp0hE9K7Xd4el9bHhLWlriHwBYFmP33tG6MImp0gilEqCl
	sy/x0WYAf7lqhBw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=hTz6yUlU+3aVUP9Vao8HHsrJ+v
	4=; b=EY1PPRX0Giv9jChu3A8E7eRRXb/jfSK7RfyIXjWpZoEaeOzLpGyZdy5G+5
	+8viYMPJ8Z75GkbkVh49WHSkDWt7mheikvtEtX6iJx/nKg/g047sYb0dQ8HuSxC5
	X6xCAwPtBF3yrJ8FTf4Wj4VZP+Vl+TJ4QH/vV7mkWcoQKmifY=
X-Sasl-enc: JOyGRSmlwDB01XD9zdVf7uJLH711pWfQhtqJYfnKsQFG 1433166606
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 71E776800F5;
	Mon,  1 Jun 2015 09:50:06 -0400 (EDT)
X-Mailer: git-send-email 2.4.2.548.g1e81565
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270409>

Currently we use different messages for the same error.
Make them uniform.

Michael J Gruber (2):
  show-index: uniform error messages for index read
  messages: uniform error messages for index write

 builtin/add.c            |  2 +-
 builtin/apply.c          |  2 +-
 builtin/checkout-index.c |  2 +-
 builtin/checkout.c       |  4 ++--
 builtin/clone.c          |  2 +-
 builtin/commit.c         | 17 ++++++++++-------
 builtin/merge.c          |  2 +-
 builtin/mv.c             |  2 +-
 builtin/read-tree.c      |  2 +-
 builtin/rm.c             |  2 +-
 builtin/update-index.c   |  2 +-
 merge-recursive.c        |  2 +-
 merge.c                  |  2 +-
 rerere.c                 |  2 +-
 sequencer.c              |  5 +++--
 show-index.c             |  4 ++--
 16 files changed, 29 insertions(+), 25 deletions(-)

-- 
2.4.2.548.g1e81565
