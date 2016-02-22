From: Peter Dave Hello <hsu@peterdavehello.org>
Subject: contrib/diff-highlight: stop hard-coding perl location
Date: Mon, 22 Feb 2016 13:54:26 +0800
Message-ID: <CA+boQ6YWWkudgwC7zn-3UPWqfkw+uJZgwcBWcGvJDcCUakjzHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 06:55:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXjSm-0002oq-H3
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 06:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbcBVFzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 00:55:10 -0500
Received: from sender163-mail.zoho.com ([74.201.84.163]:25554 "EHLO
	sender163-mail.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbcBVFzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 00:55:09 -0500
Received: from mail-qk0-f172.google.com (mail-qk0-f172.google.com [209.85.220.172]) by mx.zohomail.com
	with SMTPS id 1456120507176462.0177456220031; Sun, 21 Feb 2016 21:55:07 -0800 (PST)
Received: by mail-qk0-f172.google.com with SMTP id s68so52114529qkh.3
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 21:55:06 -0800 (PST)
Received: by 10.140.37.69 with HTTP; Sun, 21 Feb 2016 21:54:26 -0800 (PST)
X-Gm-Message-State: AG10YOSwgqcv+Y+FYZNWUcikw0/NfRbezoq18Q4c89zCmA86EfJQOGRmIjOD7xl18BjVRrrEsRDR5NOyyAot4Q==
X-Received: by 10.55.75.131 with SMTP id y125mr31856520qka.61.1456120506285;
 Sun, 21 Feb 2016 21:55:06 -0800 (PST)
X-Gmail-Original-Message-ID: <CA+boQ6YWWkudgwC7zn-3UPWqfkw+uJZgwcBWcGvJDcCUakjzHA@mail.gmail.com>
X-Zoho-Virus-Status: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286882>

From: Peter Dave Hello <hsu@peterdavehello.org>

Use `#!/usr/bin/env perl` instead of `#!/usr/bin/perl`,
the util "env" can help located the "perl",
so that it can work on FreeBSD and other platforms.

Signed-off-by: Peter Dave Hello <hsu@peterdavehello.org>
---
 contrib/diff-highlight/diff-highlight | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/diff-highlight/diff-highlight
b/contrib/diff-highlight/diff-highlight
index ffefc31..b57b0fd 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl

 use 5.008;
 use warnings FATAL => 'all';

--
