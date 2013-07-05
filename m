From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v10 0/5] Incremental updates against 'next' branch
Date: Fri,  5 Jul 2013 16:01:45 +0400
Message-ID: <cover.1373024281.git.Alex.Crezoff@gmail.com>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
Cc: John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 05 14:02:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv4iX-0004To-PC
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 14:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757290Ab3GEMCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 08:02:05 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:59183 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757055Ab3GEMCE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 08:02:04 -0400
Received: by mail-la0-f50.google.com with SMTP id dy20so1992490lab.9
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 05:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=96+fFGTgxTtI7O5Qu6gaPIy7elSyullN+aJrDf9nv2k=;
        b=xiNvBEK9VjAABq5YzZF8r0gRzhC6CyFsDebgFra8LdqemvCD/oi+jqSl2AX/eZbm+E
         W0et02IsnoylDHM0VE+FC1LlsK8Rt+8ONHPYaYpPiaP56rKZo5VZkDK52r9h/FEurFd7
         VdHJZuXcI3nhbxfx399DP8r8jXjxt9wT5zOkwGKozqKCTX2DdABSbb7frw1ROhai8dx4
         ygX2jC/OwmSUG9lHtmtDTIZHzI0RnKF5LZx4KWWM7rFOfXOBBUjZT5w+gXdCyjqDPxad
         4d7kkz8fpJc/P5VlOKzefq9lKFced3dbppjjLr0i15uUBtKlN3ztYDUJSgYy5Donc0rx
         +HWw==
X-Received: by 10.152.44.133 with SMTP id e5mr5065805lam.15.1373025719321;
        Fri, 05 Jul 2013 05:01:59 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id c4sm2760755lae.7.2013.07.05.05.01.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 05:01:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.16.gb1f0d63
In-Reply-To: <cover.1372939482.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229653>

This patches series includes following changes against v9
1. [PATCH v10 1/5] t4041, t4205, t6006, t7102: use iso8859-1 rather than iso-8859-1
    reworded. reasons of renaming explained "here and now" but not only
    redirects to an older commit which did the same.
2. [PATCH v10 2/5] t4205 (log-pretty-formats): revert back single quotes
    little change to commit message (added "(log-pretty-formats)" after
    "t4205")
3. [PATCH v10 3/5] t4205, t6006, t7102: make functions better readable
    reworded. comments reformatted. function 'test_format' refactored.
4. [PATCH v10 4/5] t6006 (rev-list-format): add tests for "%b" and "%s" for the case i18n.commitEncoding is not set
    reworded. Now whole file is in utf-8. Tested output messages are
    converted from utf-8 to iso8859-1 "on the fly" and written fo files.
5. [PATCH v10 5/5] t4205 (log-pretty-formats): avoid using `sed`
    little change to commit message (added "(log-pretty-formats)" after
    "t4205")

And references to "de6029a2d7734a93a9e27b9c4471862a47dd8123" commit in
all patch messages replaced with "de6029a (pretty: Add failing
tests: --format output should honor logOutputEncoding, 2013-06-26)"

P.S. This patch series is an incremental updates on top of (7c375214 t4205:
replace .\+ with ..* in sed commands, 2013-07-01) as far as v7 patches
were applied to the 'next' branch but there were more improvements made
in v8.

Alexey Shumkin (5):
  t4041, t4205, t6006, t7102: use iso8859-1 rather than iso-8859-1
  t4205 (log-pretty-formats): revert back single quotes
  t4205, t6006, t7102: make functions better readable
  t6006 (rev-list-format): add tests for "%b" and "%s" for the case
    i18n.commitEncoding is not set
  t4205 (log-pretty-formats): avoid using `sed`

 t/t4041-diff-submodule-option.sh |   4 +-
 t/t4205-log-pretty-formats.sh    | 143 +++++++++++++++++++--------------------
 t/t6006-rev-list-format.sh       |  83 ++++++++++++-----------
 t/t7102-reset.sh                 |  20 +++---
 4 files changed, 125 insertions(+), 125 deletions(-)

-- 
1.8.3.2.16.gb1f0d63
