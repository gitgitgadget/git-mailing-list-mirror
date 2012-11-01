From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/3] Introduce diff.submodule
Date: Thu,  1 Nov 2012 16:13:47 +0530
Message-ID: <1351766630-4837-1-git-send-email-artagnon@gmail.com>
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 11:44:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTsFw-0006gV-QP
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 11:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189Ab2KAKoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 06:44:00 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62157 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab2KAKn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 06:43:59 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1641298pad.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 03:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/Z+f16r2uqhyB51q8rqAD+Ed8msnUTn7zY6IXoB80dA=;
        b=XKrMbcRO26CVK+Dxay2Gzm7HB6RrdBn0OGEwwOyLfEKcGraZkLz1aolSosfKggZx2M
         Dg4fOl7KkjQlX9OcyQK4caAYisZoOYP6tKrRcPHpvRxUN7W/YmiSptghzZlUncV+a1Z4
         wphOWosnC3ehGc09RtYX3DyO/k6V9DOCgFYL88n3JCcY5jKIyNRQ6V1jIX2QxYHWwwP1
         2qAzcj9JRiRnwM8Rzcq+9OTKdG0S6noaKo16y8ozj0DOptmJCecuLuaCYej5DdDCwphA
         +Tf+r6InKL5bOyyWNaMyOqOfxiKy7Iwpban8oNMeBFrmi2x3nwxLYlK/UttZCEYlG7VF
         lJwQ==
Received: by 10.68.236.8 with SMTP id uq8mr11928394pbc.156.1351766639025;
        Thu, 01 Nov 2012 03:43:59 -0700 (PDT)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id vw4sm3855414pbc.26.2012.11.01.03.43.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 03:43:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208869>

Hi,

v1 is here:
http://mid.gmane.org/1349196670-2844-1-git-send-email-artagnon@gmail.com

I've fixed the issues pointed out in the review by Jens.

Sorry about the delay; need to find a new dayjob.

Ramkumar Ramachandra (3):
  Documentation: move diff.wordRegex from config.txt to diff-config.txt
  diff: introduce diff.submodule configuration variable
  submodule: display summary header in bold

 Documentation/config.txt         |    6 ------
 Documentation/diff-config.txt    |   13 +++++++++++++
 Documentation/diff-options.txt   |    3 ++-
 builtin/diff.c                   |    4 ++++
 cache.h                          |    1 +
 diff.c                           |    7 ++++++-
 submodule.c                      |    8 ++++----
 submodule.h                      |    2 +-
 t/t4041-diff-submodule-option.sh |   30 +++++++++++++++++++++++++++++-
 9 files changed, 60 insertions(+), 14 deletions(-)

-- 
1.7.8.1.362.g5d6df.dirty
