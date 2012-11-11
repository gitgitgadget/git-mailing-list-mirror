From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/7] New remote-bzr remote helper
Date: Sun, 11 Nov 2012 15:19:51 +0100
Message-ID: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:20:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXYOw-0007nI-5e
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911Ab2KKOUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:20:16 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47320 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab2KKOUP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:20:15 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2064575bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=RNGySGcp50fmDi+mmkSxBxlb3UmeIigUXMXKFPNxSmo=;
        b=gi1R3WdGJD00U4U+I/Pi2lS9a+yyVXQ5s9L8RmXJ4AsDThYaSZakY95ZIexIf2/zwQ
         NR8cdPZ5J0x6QhUilT6wmkRoGNqtBhyp+yS9HotrYALDSEnLDVsmOIz5aS/EHYsd68k+
         GPmPfh3pzLD+7aZXYOu4bqcfXgtILzeiEJ5c6kRLGw3SR59vdhUoIC7JslcRsGQ+SEcz
         UBhRNYa+z4TsrfaOuRcWiMp+qJyyra/e9Jx0aGQwZsPoo20mqgom+0wcyDPRTFWIOvrv
         YaEEdGIOE6chfTJW0gm5SrtLTm1FDVXtZMTBJaGmanm6crU+OG2dIUA7b4Jzzw7Zr5u2
         /VFw==
Received: by 10.204.128.155 with SMTP id k27mr5881945bks.26.1352643614467;
        Sun, 11 Nov 2012 06:20:14 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id r15sm1504395bkw.9.2012.11.11.06.20.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:20:13 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209374>

Hi,

This is a re-roll of the previous series to add support to fetch and push
special modes, and refactor some related code.

Cheers.

Changes since v2:

 * Add support for special modes
 * Minor refactoring and cleanups

Changes since v1:

 * Rewritten to avoid bzr-fastimport

Felipe Contreras (7):
  Add new remote-bzr transport helper
  remote-bzr: add support for pushing
  remote-bzr: add support for remote repositories
  remote-bzr: update working tree
  remote-bzr: add simple tests
  remote-bzr: add support for fecthing special modes
  remote-bzr: add support to push special modes

 contrib/remote-helpers/git-remote-bzr | 713 ++++++++++++++++++++++++++++++++++
 contrib/remote-helpers/test-bzr.sh    | 143 +++++++
 2 files changed, 856 insertions(+)
 create mode 100755 contrib/remote-helpers/git-remote-bzr
 create mode 100755 contrib/remote-helpers/test-bzr.sh

-- 
1.8.0
