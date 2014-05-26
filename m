From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 00/15] Rearrange xcalloc arguments
Date: Tue, 27 May 2014 00:33:41 +0900
Message-ID: <1401118436-66090-1-git-send-email-modocache@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 26 17:34:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wowux-0003qI-Tj
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 17:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbaEZPeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 11:34:20 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:42912 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbaEZPeR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 11:34:17 -0400
Received: by mail-pb0-f53.google.com with SMTP id md12so7769599pbc.26
        for <git@vger.kernel.org>; Mon, 26 May 2014 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=tyL3/s8lVdORVuqj4XCQjXxnBhebuHf5opsZao6zDjA=;
        b=Q4c95pneMIZcM8+bhCUUTTXl4WyI5gcwFFJZbLfROQuzPJ+B1WNsfI3f6RHTfLLe3W
         GLSH5iCYKsbycIUxguLJJBPkSOHOn20FSYEfDogEwf/ugKLGdKoQuj06RH/R9Ln62JpU
         aqt5YNuXq9E+mHu0eOK6fWalXRJyqhGz0cVHX8HdJvQ+wxcbxC4agqgU57tg754nFBeE
         DUDxy7w/vHBYBiJhJpPz1/zV+4uV5pIz7AZng59FutWRG7gVWPeaLlX0rBxb6Yhqqm6o
         EX6RHqzelqolanSwwVyY2y9fTcOgCgthgZrYSP6QBg92K6YV33h59gRDiHSYsemZepDB
         WO8g==
X-Received: by 10.66.177.168 with SMTP id cr8mr28485388pac.128.1401118456892;
        Mon, 26 May 2014 08:34:16 -0700 (PDT)
Received: from localhost.localdomain (p3080-ipbf5805marunouchi.tokyo.ocn.ne.jp. [60.46.42.80])
        by mx.google.com with ESMTPSA id mt1sm18850446pbb.31.2014.05.26.08.34.15
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 08:34:16 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.543.gc8042da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250092>

xcalloc takes two arguments: the number of elements and their size.
The vast majority of the Git codebase passes these arguments in the
correct order, but there are some exceptions. This patch series
corrects those exceptions.

Brian Gesiak (15):
  builtin/add.c: rearrange xcalloc arguments
  builtin/ls-remote.c: rearrange xcalloc arguments
  builtin/remote.c: rearrange xcalloc arguments
  commit.c: rearrange xcalloc arguments
  config.c: rearrange xcalloc arguments
  diff.c: rearrange xcalloc arguments
  hash.c: rearrange xcalloc arguments
  hash.h: rearrange xcalloc arguments
  http-push.c: rearrange xcalloc arguments
  imap-send.c: rearrange xcalloc arguments
  notes.c: rearrange xcalloc arguments
  pack-revindex.c: rearrange xcalloc arguments
  reflog-walk.c: rearrange xcalloc arguments
  remote.c: rearrange xcalloc arguments
  transport-helper.c: rearrange xcalloc arguments

builtin/add.c       | 2 +-
builtin/ls-remote.c | 2 +-
builtin/remote.c    | 8 ++++----
commit.c            | 2 +-
config.c            | 4 ++--
diff.c              | 2 +-
hash.c              | 2 +-
hash.h              | 2 +-
http-push.c         | 2 +-
imap-send.c         | 2 +-
notes.c             | 6 +++---
pack-revindex.c     | 2 +-
reflog-walk.c       | 8 ++++----
remote.c            | 2 +-
transport-helper.c  | 2 +-
15 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.0.0.rc1.543.gc8042da
