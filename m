Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 147A91F454
	for <e@80x24.org>; Sun,  3 Nov 2019 20:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfKCU1D (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 15:27:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37203 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfKCU1C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 15:27:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id t1so8852884wrv.4
        for <git@vger.kernel.org>; Sun, 03 Nov 2019 12:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=QtPD6aqcB2TUyRJygJP9jevFDJlaBPozvmNdrUNSj04=;
        b=kyZcYR5Cr6sHVXifpkom56zjk2u0EzFwIADnW+5/3tBLKKkGHdoWK3NUbwbn1Ng9IC
         q42ss6pY8CJQQDwBhjW7DEVp0WWKlownkQ/Ke6Lb37arQHdsMLoedQMh7saYGFXoymBt
         I8TKxsQs/aD4CmKeLCmKooPL9sMYklgXx1y/DzTHafMyj+nPUIXbREgNbIwG5OKj4+ol
         skR1P2IEh7ej0LqE+rA64yqqj+n/W2P1JiP1gZG7AVUIMmkWHfrIwdmkBnGeTRot8SDc
         n5bz87mEDJ57tupdkeQJxKELoucAdC/69FIwBzo9uuXzhVKyr3hgxUz1TfRWSzqvrqqo
         MmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=QtPD6aqcB2TUyRJygJP9jevFDJlaBPozvmNdrUNSj04=;
        b=CiWMgd4hTqprsimgtH3XLeKoT43dsPKB2v/AHJ6s2yV9tRyDNkIHjge7BIuVuPLo/J
         ESgkpNzNUmA0FgsAuzIayyj4F3p0EeymmzAKgAMQgBpl+G06GtFx55qeB1H4LQNa8typ
         50yXqaJ+wtZKo9A0r5pNQDR51t47NMGkoXpgiMTxZRwo2up2PI/u7ZTISzeRT5efPcqt
         dxQXZgVJebhCkFZ+oeYGQ7LArM8e0Tu8COaTI6UjvhroI1XXRRj8AyRdIFba/X5Rd6hd
         wG8k9TwiWW50Ko3GJes1a0to1kPSKcKgUEBnw823rWmws0G3ZeLOWud0WjhF8Gq/0gJM
         v0HQ==
X-Gm-Message-State: APjAAAXO49BWEDSwOSJ7VJo6wcjMYMv50rJ/Tar7WcVSWk3Mf7dgi9iq
        KkcmVRhBsifi/FnvOjx/skIv8KBa
X-Google-Smtp-Source: APXvYqxYINBUTjSgxWoxjO24C/2c+DYPeWoktj+nnO8jieX+c9PFCmjhA6iOoaTacseru5Krqcq0dw==
X-Received: by 2002:adf:cd8f:: with SMTP id q15mr10857730wrj.21.1572812820544;
        Sun, 03 Nov 2019 12:27:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 62sm16561752wre.38.2019.11.03.12.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Nov 2019 12:27:00 -0800 (PST)
Message-Id: <d88ea544d93ffc9b222ac3a4974df4c499e76430.1572812819.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.432.v2.git.1572812819.gitgitgadget@gmail.com>
References: <pull.432.git.1572127149.gitgitgadget@gmail.com>
        <pull.432.v2.git.1572812819.gitgitgadget@gmail.com>
From:   "qusielle via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 03 Nov 2019 20:26:58 +0000
Subject: [PATCH v2 1/1] add: respect `--ignore-errors` when `lstat()` reports
 errors
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        qusielle <31454380+qusielle@users.noreply.github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: qusielle <31454380+qusielle@users.noreply.github.com>

"git add --ignore-errors" command fails immediately when lstat returns
an error, despite the ignore errors' flag is enabled.

There could be files that triggers an error on stat(), when other files
proceed correctly.
Issue can be reproduced when running git under Cygwin and some target files
have utf-8 long names (200+ utf chars). Windows can handle them, but all
operations on them failed under Cygwin.
Issue can not be reproduced with usual latin/numeric only names.
For example, create a file with 220 'й' letters by Windows Explorer,
then in Cygwin:

 # Here and below "ййй..." means the line of й copied 220 times.
$ echo -n 'ййй...' | wc -c  # check the real size
440

$ ls -la
ls: cannot access 'ййй...'$'\320': No such file or directory
-????????? ? ?              ?        ?            ? 'ййй...'$'\320'

$ ls й*
ls: cannot access 'ййй...'$'\320': No such file or directory

$ stat й*
stat: cannot stat 'ййй...'$'\320': No such file or directory

In my perspective, it's okay to skip these problematic files when ignore
error flag is specified, but official Git terminates entire git add command
when such files come up. But with proposed patch it is the desired behavior:

$ git add --ignore-errors .
error: ййй... can only add regular files, symbolic links or git-directories
 # All other files have been added correctly.

Signed-off-by: Qusielle <qusielle@gmail.com>
---
 read-cache.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 133f790fa4..791ef65bac 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -801,8 +801,12 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 int add_file_to_index(struct index_state *istate, const char *path, int flags)
 {
 	struct stat st;
-	if (lstat(path, &st))
-		die_errno(_("unable to stat '%s'"), path);
+	if (lstat(path, &st)) {
+		if (flags & ADD_CACHE_IGNORE_ERRORS)
+			return -1;
+		else
+			die_errno(_("unable to stat '%s'"), path);
+	}
 	return add_to_index(istate, path, &st, flags);
 }
 
-- 
gitgitgadget
