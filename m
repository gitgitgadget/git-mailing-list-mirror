From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/4] trivial patches
Date: Wed,  8 May 2013 20:16:54 -0500
Message-ID: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 09 03:18:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaFVM-0000py-6S
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 03:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab3EIBSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 21:18:25 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:65193 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817Ab3EIBSY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 21:18:24 -0400
Received: by mail-oa0-f54.google.com with SMTP id j1so2848504oag.13
        for <git@vger.kernel.org>; Wed, 08 May 2013 18:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=FAv56q49gwcvsDTQGwutbaynSgQLZOCZLycV5IS/jQI=;
        b=lvIlr4HdDjwkkc+sAuWZYNr2uq4GCExjIFgBd9YAChftnwHC4QM82xRGmIxeccVwPI
         QUpq1onX4NUwJ+0a3zru/xSN6VXtrUD/dSwoX+CFfwqnFZsbA4iaYYNqgayMKAes6qrR
         QnBJs2ACUWjzCCCJfbGJ366kOxTFNmCZelhXkmw4L4OdFGpklj8HP9xNsdD6FNePw92J
         IlXjeBG5KdyAEUGk6rWBMO+j1ftLtyHVz+2eA53cAqMFdeMUlgz+RYnD12OYiaf0UPAJ
         ZwqFGhacNfqHltlSSamEJ/QpV2MAViww+jNSASqocWNIjV4GpsMP++Lis8KAvrtm78dQ
         26JQ==
X-Received: by 10.182.110.169 with SMTP id ib9mr1961311obb.13.1368062303894;
        Wed, 08 May 2013 18:18:23 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ri8sm1163959oeb.0.2013.05.08.18.18.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 18:18:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.553.gac13664
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223698>

Hi,

Here's a bunch of trivial style cleanup patches.

Felipe Contreras (4):
  documentation: trivial style cleanups
  transport-helper: trivial style cleanup
  {fast-export,transport-helper}: style cleanups
  fast-export: trivial cleanup

 Documentation/git-am.txt               |  7 +++----
 Documentation/git-archive.txt          |  2 +-
 Documentation/git-check-ref-format.txt |  3 +--
 Documentation/git-clone.txt            |  4 ++--
 Documentation/git-commit.txt           |  2 +-
 Documentation/git-config.txt           |  3 +--
 Documentation/git-daemon.txt           |  5 ++---
 Documentation/git-difftool.txt         |  3 +--
 Documentation/git-fast-export.txt      | 10 +++++-----
 Documentation/git-fetch-pack.txt       |  6 +++---
 Documentation/git-fmt-merge-msg.txt    |  3 +--
 Documentation/git-fsck.txt             |  6 ++----
 Documentation/git-grep.txt             |  2 +-
 Documentation/git-mailinfo.txt         |  2 +-
 Documentation/git-merge.txt            |  3 +--
 Documentation/git-mergetool.txt        |  2 +-
 Documentation/git-push.txt             |  3 +--
 Documentation/git-remote.txt           |  2 +-
 Documentation/git-revert.txt           |  2 +-
 Documentation/git-update-index.txt     | 10 ++++------
 builtin/fast-export.c                  | 29 +++++++++++++----------------
 transport-helper.c                     |  3 +--
 22 files changed, 48 insertions(+), 64 deletions(-)

-- 
1.8.3.rc1.553.gac13664
