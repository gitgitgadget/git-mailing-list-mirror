Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A9A71FF6D
	for <e@80x24.org>; Mon, 28 Nov 2016 02:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753548AbcK1CQA (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Nov 2016 21:16:00 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36835 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753290AbcK1CP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2016 21:15:58 -0500
Received: by mail-pg0-f45.google.com with SMTP id f188so51042632pgc.3
        for <git@vger.kernel.org>; Sun, 27 Nov 2016 18:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JNweu3zhWgfRDa6WwI+2AT6Xcnfq6A4ls/kgV6Ih2O8=;
        b=hceosBMhKkimC04x97eSm9o7MhJ/QjpN/PAP/gscHDgyq2JACa/y5cSL6ZRmS4ZKYm
         DLiU/+ILxkEoLgeAdP8P+O6OLca+p6Kj/zYGQ9NMvUeirij6aWdSDoDbUNwoCdFVSYgb
         vHMph7wv76qls23Rk82xbr1180O7sHCixbtieUnLna2B1fps7DsULCjG0a1zKmhC4Dct
         C1jEMdUocUgpT9cokZjLtq09wgrReL0kShGsJbVx7EQJAwo6YQLyzFtktGP0CsbTxzpa
         a28SSe9wIwGF6ZO/DipmW6SGQ9oMS17N0Haq74rzvDCOOxnk/B1CGQtrb+r/LCXu387x
         wsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JNweu3zhWgfRDa6WwI+2AT6Xcnfq6A4ls/kgV6Ih2O8=;
        b=VaoyTRCvQNU/2WzJ6Oz8IqfD60nJk0EDXexeUju13yt2nWkNJvZoEd3II0bQrpvwwZ
         nCPsAU4044gXjIgwN/8oyzNgx2baGpygKaZEiBpW/hf1ARE7VIb2Vl9X9teJ2j8G0r5s
         18FPpoZDs9Cwul1T0iPNb1ZQ1dyIGfNQ01LE04drW6+g29F2nMjce6JT3cpm4U3zyoDI
         bR+u9WS+v7oWZP1UhwFp6y9T4YjQK/NXyxajGI8zNtEmqMYZ3QWR4j8iFiPWGFVz3x19
         4vqh1QPQQDNkYAcVuEylNvUBNMrazew+In5WLqXkhBZYiGi83QGZWx2hRUm5JXsl7YJa
         rpWA==
X-Gm-Message-State: AKaTC01G+ifCUV4FiQbrB1TNwQp97HzPwYZEDeoALRhC+SRcUfY056foTXEsx1cdx8ahjg==
X-Received: by 10.84.142.70 with SMTP id 64mr42832923plw.177.1480299357923;
        Sun, 27 Nov 2016 18:15:57 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id g22sm64720779pgn.20.2016.11.27.18.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Nov 2016 18:15:57 -0800 (PST)
Date:   Sun, 27 Nov 2016 18:15:54 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Dun Peal <dunpealer@gmail.com>, Git ML <git@vger.kernel.org>
Subject: Re: trustExitCode doesn't apply to vimdiff mergetool
Message-ID: <20161128021554.GA30863@gmail.com>
References: <CAD03jn5PAZcFeesaq2osjo7cYd1frWZeN0odNqTh+AMxSEmLgQ@mail.gmail.com>
 <20161127050818.rmjpvha64y4wosq2@sigill.intra.peff.net>
 <CAD03jn7gU9g7NyDk_3wYTKsYQUtRGg6msvumZqUDs44hMOVX7w@mail.gmail.com>
 <20161127165559.j5okxyztwescheug@sigill.intra.peff.net>
 <20161128014538.GA18691@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161128014538.GA18691@gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 27, 2016 at 05:45:38PM -0800, David Aguilar wrote:
> On Sun, Nov 27, 2016 at 11:55:59AM -0500, Jeff King wrote:
> > On Sun, Nov 27, 2016 at 08:46:40AM -0500, Dun Peal wrote:
> > 
> > > Ignoring a non-zero exit code from the merge tool, and assuming a
> > > successful merge in that case, seems like the wrong default behavior
> > > to me.
> > 
> > Yeah, I'm inclined to agree. But like I said, I'm not too familiar with
> > this area, so maybe there are subtle things I'm missing.
> 
> I think this may have been an oversight in how the
> trust-exit-code feature is implemented across builtins.
> 
> Right now, specific builtin tools could in theory opt-in to the
> feature, but I think it should be handled in a central place.
> For vimdiff, the exit code is not considered because the
> scriptlet calls check_unchanged(), which only cares about
> modifciation time.
> 
> I have a patch that makes it so that none of the tools do the
> check_unchanged logic themselves and instead rely on the
> library code to handle it for them.  This makes the
> implementation uniform across all tools, and allows tools to
> opt-in to trustExitCode=true.
> 
> This means that all of the builtin tools will default to
> trustExitCode=false, and they can opt-in by setting the
> configuration variable.
> 
> For tkdiff and kdiff3, this is a subtle change in behavior, but
> not one that should be problematic, and the upside is that we'll
> have consistency across all tools.
> 
> In this scenario specifically, what happens is that the
> scriptlet is calling check_unchanged(), which checks the
> modification time of the file, and if the file is new then it
> assumes that the merge succeeded.  check_unchanged() is clearing
> the exit code.
> 
> Try the patch below.  I tested it with vimdiff and it seems to
> provide the desired behavior:
> - the modificaiton time behavior is the default
> - setting mergetool.vimdiff.trustExitCode = true will make it
>   honor vim's exit code via :cq
> 
> One possible idea that could avoid the subtle tkdiff/kdiff3
> change in behavior would be to allow the scriptlets to advertise
> their preference for the default trustExitCode setting.  These
> tools could say, "default to true", and the rest can assume
> false.
> 
> If others feel that this is worth the extra machinery, and the
> mental burden of tools having different defaults, then that
> could be implemented as a follow-up patch.  IMO I'd be okay with
> not needing it and only adding it if someone notices, but if
> others feel otherwise we can do it sooner rather than later.
> 
> Thoughts?

For the curious, here is what that patch might look like.
This allows scriptlets to redefine trust_exit_code() so that
they can advertise that they prefer default=true.

The main benefit of this is that we're preserving the original
behavior before these patches.  I'll let this sit out here for
comments for a few days to see what others think.

--- >8 ---
Date: Sun, 27 Nov 2016 18:08:08 -0800
Subject: [PATCH] mergetool: restore trustExitCode behavior for builtins tools

deltawalker, diffmerge, emerge, kdiff3, kompare, and tkdiff originally
provided behavior that matched trustExitCode=true.

The default for all tools is trustExitCode=false, which conflicts with
these tools' defaults.  Allow tools to advertise their own default value
for trustExitCode so that users do not need to opt-in to the original
behavior.

While this makes the default inconsistent between tools, it can still be
overridden, and it makes it consistent with the current Git behavior.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool--lib.sh  | 15 +++++++++++++--
 mergetools/deltawalker |  6 ++++++
 mergetools/diffmerge   |  6 ++++++
 mergetools/emerge      |  6 ++++++
 mergetools/kdiff3      |  6 ++++++
 mergetools/kompare     |  6 ++++++
 mergetools/tkdiff      |  6 ++++++
 7 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 3d8a873ab..be079723a 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -120,6 +120,12 @@ setup_user_tool () {
 	merge_tool_cmd=$(get_merge_tool_cmd "$tool")
 	test -n "$merge_tool_cmd" || return 1
 
+	trust_exit_code () {
+		# user-defined tools default to trustExitCode = false
+		git config --bool "mergetool.$1.trustExitCode" ||
+		echo false
+	}
+
 	diff_cmd () {
 		( eval $merge_tool_cmd )
 	}
@@ -153,6 +159,12 @@ setup_tool () {
 		echo "$1"
 	}
 
+	trust_exit_code () {
+		# built-in tools default to trustExitCode = false
+		git config --bool "mergetool.$1.trustExitCode" ||
+		echo false
+	}
+
 	if ! test -f "$MERGE_TOOLS_DIR/$tool"
 	then
 		setup_user_tool
@@ -221,8 +233,7 @@ run_merge_cmd () {
 	merge_cmd "$1"
 	status=$?
 
-	trust_exit_code=$(git config --bool \
-		"mergetool.$1.trustExitCode" || echo false)
+	trust_exit_code=$(trust_exit_code "$1")
 	if test "$trust_exit_code" = "false"
 	then
 		check_unchanged
diff --git a/mergetools/deltawalker b/mergetools/deltawalker
index b3c71b623..ad978f83d 100644
--- a/mergetools/deltawalker
+++ b/mergetools/deltawalker
@@ -19,3 +19,9 @@ merge_cmd () {
 translate_merge_tool_path() {
 	echo DeltaWalker
 }
+
+trust_exit_code () {
+	# Default to trustExitCode = true
+	git config --bool "mergetool.$1.trustExitCode" ||
+	echo true
+}
diff --git a/mergetools/diffmerge b/mergetools/diffmerge
index f138cb4e7..437b34996 100644
--- a/mergetools/diffmerge
+++ b/mergetools/diffmerge
@@ -12,3 +12,9 @@ merge_cmd () {
 			--result="$MERGED" "$LOCAL" "$REMOTE"
 	fi
 }
+
+trust_exit_code () {
+	# Default to trustExitCode = true
+	git config --bool "mergetool.$1.trustExitCode" ||
+	echo true
+}
diff --git a/mergetools/emerge b/mergetools/emerge
index 7b895fdb1..8c950d678 100644
--- a/mergetools/emerge
+++ b/mergetools/emerge
@@ -20,3 +20,9 @@ merge_cmd () {
 translate_merge_tool_path() {
 	echo emacs
 }
+
+trust_exit_code () {
+	# Default to trustExitCode = true
+	git config --bool "mergetool.$1.trustExitCode" ||
+	echo true
+}
diff --git a/mergetools/kdiff3 b/mergetools/kdiff3
index 793d1293b..9d94876b9 100644
--- a/mergetools/kdiff3
+++ b/mergetools/kdiff3
@@ -21,3 +21,9 @@ merge_cmd () {
 		>/dev/null 2>&1
 	fi
 }
+
+trust_exit_code () {
+	# Default to trustExitCode = true
+	git config --bool "mergetool.$1.trustExitCode" ||
+	echo true
+}
diff --git a/mergetools/kompare b/mergetools/kompare
index 433686c12..0ae0bdc02 100644
--- a/mergetools/kompare
+++ b/mergetools/kompare
@@ -5,3 +5,9 @@ can_merge () {
 diff_cmd () {
 	"$merge_tool_path" "$LOCAL" "$REMOTE"
 }
+
+trust_exit_code () {
+	# Default to trustExitCode = true
+	git config --bool "mergetool.$1.trustExitCode" ||
+	echo true
+}
diff --git a/mergetools/tkdiff b/mergetools/tkdiff
index 618c438e8..d73792a21 100644
--- a/mergetools/tkdiff
+++ b/mergetools/tkdiff
@@ -10,3 +10,9 @@ merge_cmd () {
 		"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
 	fi
 }
+
+trust_exit_code () {
+	# Default to trustExitCode = true
+	git config --bool "mergetool.$1.trustExitCode" ||
+	echo true
+}
-- 
2.11.0.rc3.1.g2633b1d.dirty
