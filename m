Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1CD52047F
	for <e@80x24.org>; Mon,  7 Aug 2017 18:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbdHGSVT (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 14:21:19 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37599 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751875AbdHGSVS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 14:21:18 -0400
Received: by mail-wm0-f45.google.com with SMTP id t201so13365832wmt.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AjGyIIY+m2GL05ZY5NSj+ZgMFOvKbPdTVE9paHLGrqc=;
        b=FrDltceTL+QAu3WejFpJvLAVDmsuqG2eb9JzK7tcTEiEGrNF4Y8ArZ6J/kZrAiEe1U
         mrtL4v1bWsqWevO0ZxiMIN5Sr6QDjcuGNW1VqoM75l6Ip6uxgWkNLyUUZtW9cj+8Yc1P
         /XESzcP99jTxCDF0kMktCit5SUh6ztNIGuwN4cCctpOUr9sxuQ3IGLjWNPmBFdM3qlfr
         5U5xMr/9jJFJLA3r3fpjlHkOsnSqEGtaQJvzQ2bOsLlAjScytKpJM2GzvW+4iM6mklg+
         zmtsV/8DwxnsJjo39dMkD0l/W2NiKJ9jHodXMh55No0QHgt4GB0fY6mqdcIJZSihiyqI
         M0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AjGyIIY+m2GL05ZY5NSj+ZgMFOvKbPdTVE9paHLGrqc=;
        b=FmcvLh0BG3WZKLUy0GEYVGMBkR+LF+KSeu9Nh8/cM+/PpwuXXbY9atiBlRygVGhD8m
         tQvrvldaYdplPDPB9fZI6CgHQEvpYx1IYoN3jsaayx6+vTKfrw0ioipUTHzDYZmc3LHS
         VYnUNVDqMth9Ug42RDtHPOwhm9M+Q+8d6oQD9IbptNj/eRTqczfyh6MsfrnBnuM6f4ds
         CQVfDUsC9QxJJfzvf94slQdifVqzCOo1ed6i+NnhxfxD3GMkz3SYWA93W4j7lg6JdhF6
         DYKhDE1n435BVGLEqhIhVfPWIl1lQPGltNZDUbR80MqC3FsKaQYtcUAwp8p+Aj/ir/KW
         AOcw==
X-Gm-Message-State: AHYfb5hxSIWoM4nwBrM6PXhL1+fUlSgxFYElsKHls4Zd3hNazRGXMbT1
        b/dyBtB6U4CgVHCy
X-Received: by 10.28.30.88 with SMTP id e85mr1166592wme.10.1502130076972;
        Mon, 07 Aug 2017 11:21:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id e27sm11519422wra.25.2017.08.07.11.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 11:21:16 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Dave Borowitz <dborowitz@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/6] Doc/git-{push,send-pack}: correct --sign= to --signed=
Date:   Mon,  7 Aug 2017 20:20:45 +0200
Message-Id: <8721e94741955eb32b3e8f08ff7f7319c79f93bf.1502128418.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.5.g0f7b1ed27
In-Reply-To: <cover.1502128418.git.martin.agren@gmail.com>
References: <cover.1502128418.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we're about to touch the behavior of --signed=, do this as a
preparatory step.

The documentation mentions --sign=, and it works. But that's just
because it's an unambiguous abbreviation of --signed, which is how it is
actually implemented. This was added in commit 30261094 ("push: support
signing pushes iff the server supports it", 2015-08-19). Back when that
series was developed [1] [2], there were suggestions about both --sign=
and --signed=. The final implementation settled on --signed=, but some
of the documentation and commit messages ended up using --sign=.

The option is referred to as --signed= in Documentation/config.txt
(under push.gpgSign).

One could argue that we have promised --sign for two years now, so we
should implement it as an alias for --signed. (Then we might also
deprecate the latter, something which was considered already then.) That
would be a slightly more intrusive change.

This minor issue would only be a problem once we want to implement some
other option --signfoo, but the earlier we do this step, the better.

[1] v1-thread:
https://public-inbox.org/git/1439492451-11233-1-git-send-email-dborowitz@google.com/T/#u

[2] v2-thread:
https://public-inbox.org/git/1439998007-28719-1-git-send-email-dborowitz@google.com/T/#m6533a6c4707a30b0d81e86169ff8559460cbf6eb

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-push.txt      | 4 ++--
 Documentation/git-send-pack.txt | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 0a639664f..3e76e99f3 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-v | --verbose]
 	   [-u | --set-upstream] [--push-option=<string>]
-	   [--[no-]signed|--sign=(true|false|if-asked)]
+	   [--[no-]signed|--signed=(true|false|if-asked)]
 	   [--force-with-lease[=<refname>[:<expect>]]]
 	   [--no-verify] [<repository> [<refspec>...]]
 
@@ -141,7 +141,7 @@ already exists on the remote side.
 	information, see `push.followTags` in linkgit:git-config[1].
 
 --[no-]signed::
---sign=(true|false|if-asked)::
+--signed=(true|false|if-asked)::
 	GPG-sign the push request to update refs on the receiving
 	side, to allow it to be checked by the hooks and/or be
 	logged.  If `false` or `--no-signed`, no signing will be
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 966abb0df..f51c64939 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
 		[--verbose] [--thin] [--atomic]
-		[--[no-]signed|--sign=(true|false|if-asked)]
+		[--[no-]signed|--signed=(true|false|if-asked)]
 		[<host>:]<directory> [<ref>...]
 
 DESCRIPTION
@@ -71,7 +71,7 @@ be in a separate packet, and the list must end with a flush packet.
 	refs.
 
 --[no-]signed::
---sign=(true|false|if-asked)::
+--signed=(true|false|if-asked)::
 	GPG-sign the push request to update refs on the receiving
 	side, to allow it to be checked by the hooks and/or be
 	logged.  If `false` or `--no-signed`, no signing will be
-- 
2.14.0.5.g0f7b1ed27

