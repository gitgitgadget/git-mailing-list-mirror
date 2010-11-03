From: =?UTF-8?q?Philip=20J=C3=A4genstedt?= <philip@foolip.org>
Subject: [PATCH] Documentation: fix misnested -l and --contains in git-tag synopsis
Date: Wed,  3 Nov 2010 12:17:09 +0100
Message-ID: <1288783029-11226-1-git-send-email-philip@foolip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Philip=20J=C3=A4genstedt?= <philip@foolip.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 12:16:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDbKN-0002dZ-5W
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 12:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543Ab0KCLQU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 07:16:20 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61976 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395Ab0KCLQS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 07:16:18 -0400
Received: by ewy7 with SMTP id 7so157004ewy.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 04:16:17 -0700 (PDT)
Received: by 10.14.48.74 with SMTP id u50mr555280eeb.49.1288782977244;
        Wed, 03 Nov 2010 04:16:17 -0700 (PDT)
Received: from localhost.localdomain ([83.218.67.122])
        by mx.google.com with ESMTPS id v51sm6473578eeh.22.2010.11.03.04.16.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 04:16:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160595>

This has been broken since the --contains option was added in
commit 32c35cfb1e9c8523b9d60e5095f1c49ebaef0279

Signed-off-by: Philip J=C3=A4genstedt <philip@foolip.org>
---
 Documentation/git-tag.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 31c78a8..8ad89d7 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
-'git tag' [-n[<num>]] -l [--contains <commit>] [<pattern>]
+'git tag' [-n[<num>]] -l [<pattern>] [--contains <commit>]
 'git tag' -v <tagname>...
=20
 DESCRIPTION
--=20
1.7.1
