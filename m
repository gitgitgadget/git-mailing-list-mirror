From: John Keeping <john@keeping.me.uk>
Subject: [RFC/PATCH 0/2] submodule: drop the top-level requirement
Date: Sun,  7 Apr 2013 20:55:19 +0100
Message-ID: <cover.1365364193.git.john@keeping.me.uk>
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 08:45:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5p6-0000sy-TV
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933519Ab3DGTze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 15:55:34 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:55023 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933430Ab3DGTze (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 15:55:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 2D6D36064E0;
	Sun,  7 Apr 2013 20:55:32 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vv0xR31LYOig; Sun,  7 Apr 2013 20:55:31 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 11C2E6064AA;
	Sun,  7 Apr 2013 20:55:25 +0100 (BST)
X-Mailer: git-send-email 1.8.2.694.ga76e9c3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220367>

With the recent discussion, I wondered how hard it would be to add
SUBDIRECTORY_OK=Yes to git-submodule.sh and it doesn't seem that bad.

Note that this series currently lacks both tests and documentation
updates.  Also I have made no attempt to change the output from any
commands, so submodule paths are always printed relative to the
top-level of the repository.

Consider this series a proof-of-concept, to see whether I'm on
completely the wrong course.

John Keeping (2):
  rev-parse: add --filename-prefix option
  submodule: drop the top-level requirement

 builtin/rev-parse.c | 17 ++++++++++++-----
 git-submodule.sh    |  7 +++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

-- 
1.8.2.694.ga76e9c3.dirty
