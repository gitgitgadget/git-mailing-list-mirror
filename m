Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52F0D1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 19:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeHJWSi (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 18:18:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38747 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeHJWSi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 18:18:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so4989524pfh.5
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n8sbfOUAjveeG9L5H4wg9M1dEWXDoj13RsKwshe1Jxs=;
        b=FDyHuKephWHKEokk8bX5axVTULnGkjxY8wVhPxTh/gXj1grnnONRPoz2nhm/YZFa/v
         bdtIdSGp2R35CZddrAatEPp4cJaHMVK4Ka2DMi55gkPnP7ccBT8kJnnxtxWOhx2g+6DG
         yvuQ3e0NwpldIC0Iv4BaZ5MN9tSepucgDcl4/0FJ3kl/GVDP75/Zn8PhjBzih8Y5vB/o
         8EnFbNEo0nth2crD2Z1foREi486ek2F3ejbfjIeiH3CuNTNDTmSxgMAqPTFEkupf3wMx
         e0v51s5GUrRfOAEbneVeaF/Hbmzs+/5noEcKLJiLSLxb0I3wIHl50Y91QoV8guhg5ccx
         +1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n8sbfOUAjveeG9L5H4wg9M1dEWXDoj13RsKwshe1Jxs=;
        b=W9RJkbiFizDims0WYmhlGpoHjTLC4eu0/Lij92pQWcWbLenjDPuWL4HbrtzA/1I8JH
         fcKIgRpF8fipmUnyxoukJxurzBOYuXloR0Oo5ruOde4zp4nzeIVpIv5Fd+uFd1uj6SHJ
         +iglhq/ihyrqV9ixg9WJzJL4Kxks8ZrUoA8bcFYgYWwQizTeUR60TDolq8guIna4qv+A
         AIJO/rCsimCokhRTqMeVYPSHsdZzN/5V9iLyrzXo3wRD3qHrrY1YDrMwnmt6+BCoRXuI
         WWnlJdTkRofmVhB6zcntxer8HnlkeYkuVesAq41p4n/wvUBCET6c+3L9S6exclHcQin7
         vuWA==
X-Gm-Message-State: AOUpUlFPmkTHq2qxD13b9Rg+Q7aSKNXv9bdATTA0DgtRLCx9nQQE9GoM
        o/Rmkf9SZY4mWlG2SX0hHvC7jQGo
X-Google-Smtp-Source: AA+uWPyJa9C2nz4pty4iV6DNlZ1wXiNLIF3qXkByfdH75qLd2JOX5eYbai31lhFbDoqThVnle3IRSQ==
X-Received: by 2002:a62:23c2:: with SMTP id q63-v6mr8333105pfj.91.1533930441290;
        Fri, 10 Aug 2018 12:47:21 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id o27-v6sm20211995pfj.35.2018.08.10.12.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 12:47:20 -0700 (PDT)
Date:   Fri, 10 Aug 2018 12:47:20 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 19:47:13 GMT
Message-Id: <a19904682f6984de21fbf77240ff5fb6eed1b744.1533930437.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.17.v2.git.gitgitgadget@gmail.com>
References: <pull.17.git.gitgitgadget@gmail.com>
        <pull.17.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/4] Introduce a function to lock/unlock file descriptors
 when appending
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This function will be used to make write accesses in trace_write() a bit
safer.

Note: this patch takes a very different approach for cross-platform
support than Git is historically taking: the original approach is to
first implement everything on Linux, using the functions available on
Linux, and then trying to emulate these functions on platforms that do
not have those functions such as Windows.

This leads to all kinds of undesirable quirks in Git's source code (and
performance characteristics) because of the lack of a proper abstraction
layer: instead of declaring functions for the functionality we
*actually* need, we abuse POSIX functions to say what we need, even if
those functions serve much broader purposes (and do not make at all
clear what the caller wants of them).

For example, when Git wants to determine whether a path refers to a
symbolic link, it calls lstat(). That POSIX function has to be emulated
on Windows, painstakingly filling all the information lstat() would,
only for the caller to throw away everything except that one bit of
information, and all of the time figuring out the mtime/atime/ctime and
file size and whatnot was spent in vain.

If we were to follow that approach, we would extend the fcntl()
emulation in compat/mingw.c after this commit, to support the function
added in this commit.

But fcntl() allows a lot more versatile file region locking that we
actually need, so by necessity the fcntl() emulation would be quite
complex: To support the `l_whence = SEEK_CUR` (which we would use, if it
did not require so much book-keeping due to our writing between locking
and unlocking the file), we would have to call `SetFilePointerEx()`
(after obtaining the `HANDLE` on which all Win32 API functions work
instead of the integer file descriptors used by all POSIX functions).
Multiplying the number of Win32 API round-trips. Of course, we could
implement an incomplete emulation of fcntl()'s F_WRLCK, but that would
be unsatisfying.

An alternative approach would be to use the `flock()` function, whose
semantics are much closer to existing Win32 API. But `flock()` is not
even a POSIX standard, so we would have to implement emulation of
`flock()` for *other* platforms. And it would again be the wrong thing
to do, as we would once again fail to have an abstraction that clearly
says what *exact*functionality we want to use.

This commit expressly tries to set a precedent for a better approach:
Let's introduce a proper abstraction: a function that says in its name
precisely what Git wants it to do (as opposed to *how* it does it on
Linux): lock_or_unlock_fd_for_appending().

The next commit will provide a Windows-specific implementation of this
function/functionality.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-compat-util.h |  2 ++
 wrapper.c         | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 9a64998b2..13b83bade 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1202,6 +1202,8 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
 #define getc_unlocked(fh) getc(fh)
 #endif
 
+extern int lock_or_unlock_fd_for_appending(int fd, int lock_it);
+
 /*
  * Our code often opens a path to an optional file, to work on its
  * contents when we can successfully open it.  We can ignore a failure
diff --git a/wrapper.c b/wrapper.c
index e4fa9d84c..5aecbda34 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -690,3 +690,19 @@ int xgethostname(char *buf, size_t len)
 		buf[len - 1] = 0;
 	return ret;
 }
+
+#ifndef GIT_WINDOWS_NATIVE
+int lock_or_unlock_fd_for_appending(int fd, int lock_it)
+{
+	struct flock flock;
+
+	flock.l_type = lock_it ? F_WRLCK : F_UNLCK;
+
+	/* (un-)lock the whole file */
+	flock.l_whence = SEEK_SET;
+	flock.l_start = 0;
+	flock.l_len = 0;
+
+	return fcntl(fd, F_SETLKW, &flock);
+}
+#endif
-- 
gitgitgadget

