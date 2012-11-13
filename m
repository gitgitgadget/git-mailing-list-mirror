From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 0/4] Introduce diff.submodule
Date: Tue, 13 Nov 2012 21:12:43 +0530
Message-ID: <1352821367-3611-1-git-send-email-artagnon@gmail.com>
References: <http://mid.gmane.org/1352653146-3932-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 16:43:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYIdp-0000lX-Ar
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 16:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080Ab2KMPmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 10:42:55 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:38905 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab2KMPmy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 10:42:54 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so3254712dak.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zEvs1enlfqU2Jr/tGJqcTmHNNBA0HcJxWgxqIiV+amE=;
        b=JnIV0tGlWvrfRUrxUgxhWN3aNV0z5Xt6RlYN1LDT2yZlGBWxnLjM3x7KluZARuEQoX
         AwoFnhMtOv1MhXl2YoNHuQxfITUcBvSp3EicEEG+7tRi2qYsDw1zgQVdf25z7mGPeyFx
         WHPDR8tEmUa7yWynQNfqzgBZrWvBgUWjtoNXGKt2WBgcf6us33mk/IgxTIxV8y8Vpf5c
         NPM48cz4md933lV9fuc2gTrQqS5nD7Qu3DUem7q4uAZ1d/GTBDgMq/ABFqU/i2dHAhb/
         Uu9pHft2KXIsv0RTuQ7boVOfoQySGB3a2oQunLQN1DQ4g2bKCxzVXe5lM+izXRWQoXJn
         5HVA==
Received: by 10.68.194.101 with SMTP id hv5mr27116071pbc.121.1352821374491;
        Tue, 13 Nov 2012 07:42:54 -0800 (PST)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id hs2sm3546550pbc.22.2012.11.13.07.42.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 07:42:53 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <http://mid.gmane.org/1352653146-3932-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209619>

v1 is here: http://mid.gmane.org/1349196670-2844-1-git-send-email-artagnon@gmail.com
v2 is here: http://mid.gmane.org/1351766630-4837-1-git-send-email-artagnon@gmail.com
v3 is here: http://mid.gmane.org/1352653146-3932-1-git-send-email-artagnon@gmail.com

This version was prepared in response to Peff's review of v3.
What changed:
* Functional code simplified and moved to git_diff_ui_config.
* Peff contributed one additional patch to the series.

Thanks.

Ram

Jeff King (1):
  diff: rename "set" variable

Ramkumar Ramachandra (3):
  Documentation: move diff.wordRegex from config.txt to diff-config.txt
  diff: introduce diff.submodule configuration variable
  submodule: display summary header in bold

 Documentation/config.txt         |    6 -----
 Documentation/diff-config.txt    |   13 ++++++++++
 Documentation/diff-options.txt   |    3 +-
 diff.c                           |   46 ++++++++++++++++++++++++++++---------
 submodule.c                      |    8 +++---
 submodule.h                      |    2 +-
 t/t4041-diff-submodule-option.sh |   30 ++++++++++++++++++++++++-
 7 files changed, 84 insertions(+), 24 deletions(-)

-- 
1.7.8.1.362.g5d6df.dirty
