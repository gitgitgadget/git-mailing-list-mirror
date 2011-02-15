From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 00/10] Cleaning up --help-all inconsistencies
Date: Tue, 15 Feb 2011 14:09:03 +0100
Message-ID: <cover.1297774306.git.git@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 15 14:12:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpKhd-00043h-1v
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 14:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345Ab1BONMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 08:12:19 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57918 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751089Ab1BONMS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 08:12:18 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0471A20759;
	Tue, 15 Feb 2011 08:12:18 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 15 Feb 2011 08:12:18 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=IOndPmK62oNtTLgIdELFIPSgpF4=; b=R+wOIaWtB8vxT93Z9wjK3ppMSvFlYNRZDmuQ2ixJg4ZpRHhPHAADgtk4cBcK+dkL0xYmSXZ+BfJthmzQHJGW9ver+PsG/eD+2QQB0MSvmjk4iLX2MgIKeicTna29d/AWjTotfsh/oRsCs9xxjxehG7h8R7JI5+QdPLLPc7oPAtg=
X-Sasl-enc: 9DRYRt3wuMsHwP7S2dVwI9v0lkNNQKzSQ1Idu4lzu9vE 1297775537
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8244E40593C;
	Tue, 15 Feb 2011 08:12:17 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <cover.1297695910.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166843>

v2 incorporates the changes as discussed so far.
It comes with three bonus patches which enforce the use of lowercase
<identifiers> (as per CodingGuidelines) in command messages (usage).
Besides the guidelines, this is also the prevailing style in code.
Documentation is a different issue.

patches 1,3,5 are unchanged wrt v1.

The last 3 are divided according to the grep expressions which I used to
identify candidates.

Michael J Gruber (10):
  commit,tag: use same wording for -F
  commit,status: describe --porcelain just like push
  clone,init: describe --template using the same wording
  commit,merge,tag: describe -m likewise
  add: describe --patch like checkout, reset
  commit,status: describe -u likewise
  git-tag.txt: list all modes in the description
  Make <identifier> lowercase as per CodingGuidelines
  Make <identifier> lowercase as per CodingGuidelines
  Make <identifier> lowercase as per CodingGuidelines

 Documentation/git-tag.txt |   11 ++++++-----
 builtin/add.c             |    2 +-
 builtin/clone.c           |    4 ++--
 builtin/commit.c          |   22 +++++++++++-----------
 builtin/config.c          |    2 +-
 builtin/fast-export.c     |    4 ++--
 builtin/fetch.c           |    6 +++---
 builtin/init-db.c         |    2 +-
 builtin/merge.c           |    2 +-
 builtin/notes.c           |   16 ++++++++--------
 builtin/read-tree.c       |    4 ++--
 builtin/tag.c             |    6 +++---
 parse-options.h           |    2 +-
 t/t0040-parse-options.sh  |    2 +-
 test-parse-options.c      |    2 +-
 15 files changed, 44 insertions(+), 43 deletions(-)

-- 
1.7.4.1.74.gf39475.dirty
