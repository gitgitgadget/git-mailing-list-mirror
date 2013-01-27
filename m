From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 0/4] Documentation: Auto-generate merge tool lists
Date: Sun, 27 Jan 2013 13:24:42 -0800
Message-ID: <1359321886-80523-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 22:25:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzZiz-0004jC-4G
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 22:25:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756405Ab3A0VYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 16:24:52 -0500
Received: from mail-ia0-f177.google.com ([209.85.210.177]:38471 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756338Ab3A0VYu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 16:24:50 -0500
Received: by mail-ia0-f177.google.com with SMTP id h8so3315219iaa.22
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 13:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=e9SKJJ/cqh4ZaX85OGrsP5PvtMCFa7yffGNM5iIWlTc=;
        b=0MCok25TlmkLbhCZBS8RBoTCIyRpVq+t5OTXmjZwUhEZ6oxCCF7szKHrqPrn+n2iHU
         CM2A2dX+XM6zqHDL1lip2EvaalZDBQsyfW4WsAc0O7Z5J3/8vsJdZONrPut+q60Ueoni
         DI49jZ/1w/7GaBy+lJ4R6oZ89XpBud918nC5y9ca8K/3wBJV8BqeBfffYYw+n0ckada3
         pL11qImdGu/lBGq/8qKQmlxwJBhFKda4DHCOj1mrRRBiglQnTFsHZF4jEo+BekQ5UVC1
         BPYt4xix/+QQoescwThZJSBbRz/PO1b8mqqXAf8wFU0Vqjnk0KfSWKn/11Tga0tMnhvQ
         hTmg==
X-Received: by 10.50.197.169 with SMTP id iv9mr3436625igc.32.1359321890403;
        Sun, 27 Jan 2013 13:24:50 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id mj6sm4503782igc.9.2013.01.27.13.24.48
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 13:24:49 -0800 (PST)
X-Mailer: git-send-email 1.8.0.13.gf25ae33
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214733>

Refactor the mergetool-lib so that we can reuse it in
Documentation/Makefile.  The end result is that the
diff.tool and merge.tool documentation now includes
an auto-generated list of all available tools.

This applies on top of jk/mergetool in pu.

David Aguilar (4):
  mergetool--lib: Simplify command expressions
  mergetool--lib: Improve the help text in guess_merge_tool()
  mergetool--lib: Add functions for finding available tools
  doc: Generate a list of valid merge tools

 Documentation/.gitignore       |   1 +
 Documentation/Makefile         |  16 +++++-
 Documentation/diff-config.txt  |  13 ++---
 Documentation/merge-config.txt |  12 ++---
 git-mergetool--lib.sh          | 108 ++++++++++++++++++++++-------------------
 5 files changed, 87 insertions(+), 63 deletions(-)

-- 
1.8.0.13.gf25ae33
