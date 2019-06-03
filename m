Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FDAC1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 20:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfFCUSc (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 16:18:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41485 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfFCUS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 16:18:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id x25so16405118eds.8
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 13:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YcWbENHNK+UUS7XO+IiRNvSefnYhAhkhMgBW7SKeNvE=;
        b=i+OVPUgVA9Aq8Bd+5JbxnPlqQiTxAzHOiuuTj9s+z7Ct5/8gga5nG5hHSvLaXCVyxB
         T3Gan6U0JRys4iYy+iD2LZqpPbJM39gVB5RbLmwz0rX+TvKzdBzVhWX//EzTAEUs/pWI
         gVv/rMmjxc+eZaGEOQfqaKXWTD+cB+0xGjZ3vdK+1mcqtxy+sPeqw8JwgvJzj78ZXk6n
         p5tfSFV7jPvUy4D9k+lOQ8OkYhcNl8ZJcd+2SIA++IdVk+RcCR26RMP/CC5H6oKM8T59
         usc+izJDgNvnzmG2rX3k074lUwkCwqk9p4uewiLmCX7fI47qUDA6F+Lm5W2a0VX3L1RA
         Hqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YcWbENHNK+UUS7XO+IiRNvSefnYhAhkhMgBW7SKeNvE=;
        b=mOZD7uFUYcJcUM6tE5K8R//6abC7Om+vOkY0zob6sa6id3/hb2LH8ZDZBx0BjP6x60
         5PUULUUlpKhaxrqV0LUwSPqbgvpOEBi3h1RBhafkGOWTjv+z1ShISPeQ/FalqsFHZZf3
         apyaj8ukLka+zjzEu09p+CDsE2Jhtv2GSWGELmW/XOL6f2qKa+WLHvIemdvT/sjG5E18
         Y5Dl/674v8iWHjfOd8vd+dkY01/JUQgTTY5ffnECUI0paKICfFkuAtoYQQWqroEfNbEL
         bxLj6cXM+iemqp/0hBII9bHTXIX/MBCjjz/NsD10KDJSfMAamZsRrQbmpxlpRFdZk2U6
         UQsg==
X-Gm-Message-State: APjAAAUIsWOfCCVCRtq2qUhREvV93ItyNeyGoTzCH00K3E8RGjix3aW/
        EyXfOPui7DNl4k3oxcYz1kf6scEK
X-Google-Smtp-Source: APXvYqxGN73QQ65fvS6eKfgLhqGWod1tCRbQx7FQMz6Q+ivZTykXA5fLNq5vpqu24KCfjIB4Fi+BGw==
X-Received: by 2002:a50:86dc:: with SMTP id 28mr3542278edu.132.1559593104896;
        Mon, 03 Jun 2019 13:18:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g23sm2485266edp.29.2019.06.03.13.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:18:24 -0700 (PDT)
Date:   Mon, 03 Jun 2019 13:18:24 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 20:18:14 GMT
Message-Id: <2d6bf8513d928765d7411a28c526d9c77237b3fe.1559593097.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.254.git.gitgitgadget@gmail.com>
References: <pull.254.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 08/11] fetch: add --[no-]show-forced-updates argument
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

After updating a set of remove refs during a 'git fetch', we walk the
commits in the new ref value and not in the old ref value to discover
if the update was a forced update. This results in two things happening
during the command:

 1. The line including the ref update has an additional "(forced-update)"
    marker at the end.

 2. The ref log for that remote branch includes a bit saying that update
    is a forced update.

For many situations, this forced-update message happens infrequently, or
is a small bit of information among many ref updates. Many users ignore
these messages, but the calculation required here slows down their fetches
significantly. Keep in mind that they do not have the opportunity to
calculate a commit-graph file containing the newly-fetched commits, so
these comparisons can be very slow.

Add a '--[no-]show-forced-updates' option that allows a user to skip this
calculation. The only permanent result is dropping the forced-update bit
in the reflog.

Include a new fetch.showForcedUpdates config setting that allows this
behavior without including the argument in every command. The config
setting is overridden by the command-line arguments.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/fetch.txt  |  5 +++++
 Documentation/fetch-options.txt | 13 +++++++++++++
 builtin/fetch.c                 | 11 ++++++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index cbfad6cdbb..ba890b5884 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -63,3 +63,8 @@ fetch.negotiationAlgorithm::
 	Unknown values will cause 'git fetch' to error out.
 +
 See also the `--negotiation-tip` option for linkgit:git-fetch[1].
+
+fetch.showForcedUpdates::
+	Set to false to enable `--no-show-forced-updates` in
+	linkgit:git-fetch[1] and linkgit:git-pull[1] commands.
+	Defaults to true.
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 91c47752ec..5801d23ae4 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -221,6 +221,19 @@ endif::git-pull[]
 	When multiple `--server-option=<option>` are given, they are all
 	sent to the other side in the order listed on the command line.
 
+--show-forced-updates::
+	By default, git checks if a branch is force-updated during
+	fetch. This can be disabled through fetch.showForcedUpdates, but
+	the --show-forced-updates option guarantees this check occurs.
+	See linkgit:git-config[1].
+
+--no-show-forced-updates::
+	By default, git checks if a branch is force-updated during
+	fetch. Pass --no-show-forced-updates or set fetch.showForcedUpdates
+	to false to skip this check for performance reasons. If used during
+	'git-pull' the --ff-only option will still check for forced updates
+	before attempting a fast-forward update. See linkgit:git-config[1].
+
 -4::
 --ipv4::
 	Use IPv4 addresses only, ignoring IPv6 addresses.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4ba63d5ac6..571c255218 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -39,6 +39,7 @@ enum {
 };
 
 static int fetch_prune_config = -1; /* unspecified */
+static int fetch_show_forced_updates = 1;
 static int prune = -1; /* unspecified */
 #define PRUNE_BY_DEFAULT 0 /* do we prune by default? */
 
@@ -79,6 +80,11 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(k, "fetch.showforcedupdates")) {
+		fetch_show_forced_updates = git_config_bool(k, v);
+		return 0;
+	}
+
 	if (!strcmp(k, "submodule.recurse")) {
 		int r = git_config_bool(k, v) ?
 			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
@@ -169,6 +175,8 @@ static struct option builtin_fetch_options[] = {
 	OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
 			N_("report that we have only objects reachable from this object")),
 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
+	OPT_BOOL(0, "show-forced-updates", &fetch_show_forced_updates,
+		 N_("check for forced-updates on all updated branches")),
 	OPT_END()
 };
 
@@ -773,9 +781,10 @@ static int update_local_ref(struct ref *ref,
 		return r;
 	}
 
-	if (in_merge_bases(current, updated)) {
+	if (!fetch_show_forced_updates || in_merge_bases(current, updated)) {
 		struct strbuf quickref = STRBUF_INIT;
 		int r;
+
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-- 
gitgitgadget

