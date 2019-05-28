Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25AE1F462
	for <e@80x24.org>; Tue, 28 May 2019 18:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfE1SPs (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 14:15:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38593 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfE1SPs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 14:15:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id g13so3313325edu.5
        for <git@vger.kernel.org>; Tue, 28 May 2019 11:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oPv1+GSMHYpg8lENhgVU7itiDv/mckB6iLZ9NU4JWHo=;
        b=rnc456uWbGraRpEUmu9w4mJXl2Q4m6f5fiB++OF07zM7qpMbw1KmtFUnCuQkMVpmmQ
         uz5iWeJSMLb+BJbxtl6d7fO370JojQVggskET1O3LAvVvz5BtxqmYej47a4o8Z3APqXh
         HEPFCmQ/XLfSEeUXALIqMv9sWDBuWxgLvZOM57cfgSJqP9+n809LN/ptNDLsEL/0xwkU
         F7bCy+ud+hSGuCs6GbFuHtB1gVvqZrhZQJ3kXrlvmnWqHzR09D3o2kI4nLrnvKqomaXy
         G0RgxJQSfietVI1NmIuPGRBiS3GsxCbB07JdOBzGDbXe/Y4u3TxttqKxKrlB629AXQI0
         2KSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oPv1+GSMHYpg8lENhgVU7itiDv/mckB6iLZ9NU4JWHo=;
        b=kPWAwMMO336xF8ZLHeWMbPD77qryk6SwS4AZchCGp9ECC/V6Uj2quuCVJWPewEnEF9
         O+R+N3tq5BkGFgYu2TKc4a6MfLk8OHkZAd31CbSmhSkguZ3EagYmtQMI+4P6zTqivCwX
         U8HKzlqPdFUt2B3bgKBetH4ty8cF9ETK1m67OV+j8ZAhWoHsFsRhhSM5fYVpqo6PKIGz
         3Ir5YHPEtc8mtltWY+TfUk7iaYOEybmcPiYUPQJMyAQE7Gf1jRkhkLSCXaHB8wqvEBCf
         d02fHbJcQk5UvlbwSu/RQ5b8XsOFhfAbQM7SS1Z3EJmRQ3eGlesITJ8WfM8CQZ6GjMj8
         x8MA==
X-Gm-Message-State: APjAAAU3HSybCTukm7JEf4dwZwWRtIdI38Mvzqykgl6D7weqbZuNgO01
        T4mwqA4nPGqxZuz8/I35KsT2iU7+QV4=
X-Google-Smtp-Source: APXvYqyNLVlc8wSsg6K+fS5SYz1H10R4V8neAxgwk65rnMULr3ihzzI8UrQPiuV+NhoLJpTEi9F6NQ==
X-Received: by 2002:a50:fb01:: with SMTP id d1mr125329778edq.267.1559067346549;
        Tue, 28 May 2019 11:15:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm4450956edb.23.2019.05.28.11.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:15:46 -0700 (PDT)
Date:   Tue, 28 May 2019 11:15:46 -0700 (PDT)
X-Google-Original-Date: Tue, 28 May 2019 18:15:44 GMT
Message-Id: <5e89d1aceb9125231797a355e9465d1a41a1741c.1559067344.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.183.v2.git.gitgitgadget@gmail.com>
References: <pull.183.git.gitgitgadget@gmail.com>
        <pull.183.v2.git.gitgitgadget@gmail.com>
From:   "Mike Mueller via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] p4 unshelve: fix "Not a valid object name HEAD0" on
 Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Mike Mueller <mike.mueller@moodys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mike Mueller <mike.mueller@moodys.com>

git p4 unshelve was failing with these errors:

fatal: Not a valid object name HEAD0
Command failed: git cat-file commit HEAD^0

(git version 2.21.0.windows.1, python 2.7.16)

The pOpen call used by git-p4 to invoke the git command can take either a
string or an array as a first argument. The array form is preferred
because platform-specific escaping of special characters will be
handled automatically.(https://docs.python.org/2/library/subprocess.html)
The extractLogMessageFromGitCommit method was, however, using the string
form and so the caret (^) character in the HEAD^0 argument was not being
escaped on Windows.  The caret happens to be the escape character, which
is why the git command was receiving HEAD0.

The behaviour can be confirmed by typing ECHO HEAD^0 at the command-
prompt, which emits HEAD0.

The solution is simply to use the array format of passing the command to
fOpen, which is recommended and used in other parts of this code anyway.

Signed-off-by: Mike Mueller <mike.mueller@moodys.com>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 5b79920f46..0b5bfcbc5e 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -737,7 +737,7 @@ def extractLogMessageFromGitCommit(commit):
 
     ## fixme: title is first line of commit, not 1st paragraph.
     foundTitle = False
-    for log in read_pipe_lines("git cat-file commit %s" % commit):
+    for log in read_pipe_lines(["git", "cat-file", "commit", commit]):
        if not foundTitle:
            if len(log) == 1:
                foundTitle = True
-- 
gitgitgadget
