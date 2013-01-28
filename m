From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 0/4] Auto-generate mergetool lists
Date: Sun, 27 Jan 2013 16:52:22 -0800
Message-ID: <1359334346-5879-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 01:52:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzcy2-0000zj-Df
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 01:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652Ab3A1Awc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 19:52:32 -0500
Received: from mail-ia0-f172.google.com ([209.85.210.172]:61520 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352Ab3A1Awb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 19:52:31 -0500
Received: by mail-ia0-f172.google.com with SMTP id u8so3504465iag.31
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 16:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=qGLNM5Svr02v/VA11Pmn2nNRX/whkM8ZJCWAw53pk5w=;
        b=GCcozpJGXXw0sAtd3DHwa6LF5XHVpy4+xXr8uu69ISudpf/dnrxRFrovoQdk4kX8+c
         Lujbxw5JhtYEKmbKlkf8wyRBNyJyN5DJEyEvE5A8XdGe9Le/uNxfeAsPfpEQ46d60kQR
         07Y0ytdx0VX2GXvN20iY+3cnV8uym4A6VIJsfygUbd6QlsfjcwiCcJnFKgEBM7M3rIZr
         NTCeUpyKU8FN8vr3eZjmOlKFQbqm83wJ/sD3RNclRpXND7a63gh+l5Bp0/v/j5csCuFf
         1MPFpwZg74L0S335pFWd0kNNuTx4ajV5Z2TkhNCe9tFF9Zyfq2p0NQJM/96ps8umHLhw
         7tZw==
X-Received: by 10.42.202.84 with SMTP id fd20mr7809536icb.20.1359334350387;
        Sun, 27 Jan 2013 16:52:30 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id ke8sm1868421igc.17.2013.01.27.16.52.28
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 16:52:29 -0800 (PST)
X-Mailer: git-send-email 1.8.0.13.g3ff16bb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214758>

This is round two of this series.
I think this touched on everything brought up in the code review.
4/4 could use a review as I'm not completely familiar with the
makefile dependencies, though it seems to work correctly.

David Aguilar (4):
  mergetool--lib: Simplify command expressions
  mergetool--lib: Improve the help text in guess_merge_tool()
  mergetool--lib: Add functions for finding available tools
  doc: Generate a list of valid merge tools

 Documentation/.gitignore       |   1 +
 Documentation/Makefile         |  22 +++++++-
 Documentation/diff-config.txt  |  13 ++---
 Documentation/merge-config.txt |  12 ++---
 git-mergetool--lib.sh          | 116 ++++++++++++++++++++++-------------------
 5 files changed, 96 insertions(+), 68 deletions(-)

-- 
1.8.0.13.g3ff16bb
