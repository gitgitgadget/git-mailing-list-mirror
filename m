Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AB8920282
	for <e@80x24.org>; Wed, 21 Jun 2017 03:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbdFUDCf (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 23:02:35 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34444 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753016AbdFUDCd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 23:02:33 -0400
Received: by mail-pg0-f65.google.com with SMTP id j186so25004312pge.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 20:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=MDgTNfyTSaAcNmLZpVUSe+BTNBrhr3Zrp65RrZAIyog=;
        b=pcCv1kL2JZ2d5+U0MUH4aOLc6QHFwwB9p8AGwTHqC+fgkcHu4zPYaWkvCmW5oeNr8P
         Hf5APWlLtAltIBiJwLeyj8RiH3AaKAaFIC+P0OQQ2ZBdUqK7Up/WiMJIbEzPsNxav5HO
         fyXttYkSgnkYwQXt9zIVvjWi5MDzss2euTC+zwUSXtXzPY69wMEgQRFLbF9jWeaQbS0J
         jAnJDjH0eODCqEpmnVgIaAKsKEyqrS6AwuhqKKTYlUXCEGOy33/YNyT434J3rWOjM39g
         Fhdv6AlABgVELGV2qqqif8FZpI9mKofA33fMNS6MY2SXT/O/ivj4uLyfIxNTmgL5wyCR
         OfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=MDgTNfyTSaAcNmLZpVUSe+BTNBrhr3Zrp65RrZAIyog=;
        b=VCfQP69wL4YqmJP8mlUDZ8IV+FPJBIqn0+s7aNG7pIkfSn0O9gu1IcPU4VS1MCf60J
         Fr+ObA6llmJ7uTpl83BebCL3I6pUv7FQoUK6AUeE1m4bfyRfeC9o+00cMFgCkiB/fxH/
         4BlGckZdHSov4l2bhxiwhtjV5mZEqPslulVrRKM595cDzjWGZvr9P0Zeta5cyIfhXYvl
         TILwi5lp6Rvd75CUUWiLv+8V5Hroy6CM68MlrszV3szgtW3eOesoYPSuciLJngVmBwbX
         Piicg+M7FvXueKmnQo9JBdetS63m1xYyptRWOliH05aeyevLlaj5T6ElKEs5y5zfsAU8
         ns/w==
X-Gm-Message-State: AKS2vOz09eQASubfr7RP2PnMr5PZM1lxfrivqFb3ajoynzmvauCEs4Vl
        3aHftkJDmXJqE23F4NdHxA==
X-Received: by 10.84.209.228 with SMTP id y91mr39241319plh.210.1498014153016;
        Tue, 20 Jun 2017 20:02:33 -0700 (PDT)
Received: from unique-pc ([182.73.79.179])
        by smtp.googlemail.com with ESMTPSA id o8sm29425161pgn.52.2017.06.20.20.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 20:02:32 -0700 (PDT)
Message-ID: <1498014140.5419.3.camel@gmail.com>
Subject: [PATCH/FINALRFC] Documentation/git-submodule: cleanup
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Wed, 21 Jun 2017 08:32:20 +0530
In-Reply-To: <CAGZ79kbJB8dFUYu_70TAYbFWxLQiACEWMrE8M71GSEpnXqqzQQ@mail.gmail.com>
References: <CAGZ79kbMhQpxUa5TXK=WCzzKUCZ5vx3oC+fFTTozpgQihsUjTA@mail.gmail.com>
         <20170620031214.7616-1-kaarticsivaraam91196@gmail.com>
         <CAGZ79kbJx4p2y6Vjp3dVBP2pd=MYa_j3Mxfv=zUygHY-bHj0wQ@mail.gmail.com>
         <CAGZ79kbJB8dFUYu_70TAYbFWxLQiACEWMrE8M71GSEpnXqqzQQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "add" section for 'git-submodule' is redundant in
its description and the short synopsis line. Fix it.

Remove the redundant mentioning of the 'repository' argument
being mandatory.

The text is hard to read because of back-references, so remove
those.

Replace the word "humanish" by "canonical" as that conveys better
what we do to guess the path.

While at it, quote all occurrences of '.gitmodules' as that is an
important file in the submodule context, also link to it on its
first mention.

Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 In case no other changes are required then this is the final version
 of the patch.


 Documentation/git-submodule.txt | 49 ++++++++++++++++++---------------
--------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-
submodule.txt
index 74bc6200d..6e07bade3 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -63,14 +63,6 @@ add [-b <branch>] [-f|--force] [--name <name>] [
--reference <repository>] [--dep
 	to the changeset to be committed next to the current
 	project: the current project is termed the "superproject".
 +
-This requires at least one argument: <repository>. The optional
-argument <path> is the relative location for the cloned submodule
-to exist in the superproject. If <path> is not given, the
-"humanish" part of the source repository is used ("repo" for
-"/path/to/repo.git" and "foo" for "host.xz:foo/.git").
-The <path> is also used as the submodule's logical name in its
-configuration entries unless `--name` is used to specify a logical
name.
-+
 <repository> is the URL of the new submodule's origin repository.
 This may be either an absolute URL, or (if it begins with ./
 or ../), the location relative to the superproject's default remote
@@ -87,21 +79,22 @@ If the superproject doesn't have a default remote
configured
 the superproject is its own authoritative upstream and the current
 working directory is used instead.
 +
-<path> is the relative location for the cloned submodule to
-exist in the superproject. If <path> does not exist, then the
-submodule is created by cloning from the named URL. If <path> does
-exist and is already a valid Git repository, then this is added
-to the changeset without cloning. This second form is provided
-to ease creating a new submodule from scratch, and presumes
-the user will later push the submodule to the given URL.
+The optional argument <path> is the relative location for the cloned
+submodule to exist in the superproject. If <path> is not given, the
+canonical part of the source repository is used ("repo" for
+"/path/to/repo.git" and "foo" for "host.xz:foo/.git"). If <path>
+exists and is already a valid Git repository, then it is staged
+for commit without cloning. The <path> is also used as the submodule's
+logical name in its configuration entries unless `--name` is used
+to specify a logical name.
 +
-In either case, the given URL is recorded into .gitmodules for
-use by subsequent users cloning the superproject. If the URL is
-given relative to the superproject's repository, the presumption
-is the superproject and submodule repositories will be kept
-together in the same relative location, and only the
-superproject's URL needs to be provided: git-submodule will correctly
-locate the submodule using the relative URL in .gitmodules.
+The given URL is recorded into `.gitmodules` for use by subsequent
users
+cloning the superproject. If the URL is given relative to the
+superproject's repository, the presumption is the superproject and
+submodule repositories will be kept together in the same relative
+location, and only the superproject's URL needs to be provided.
+git-submodule will correctly locate the submodule using the relative
+URL in `.gitmodules`.
 
 status [--cached] [--recursive] [--] [<path>...]::
 	Show the status of the submodules. This will print the SHA-1
of the
@@ -123,7 +116,7 @@ too (and can also report changes to a submodule's
work tree).
 init [--] [<path>...]::
 	Initialize the submodules recorded in the index (which were
 	added and committed elsewhere) by setting
`submodule.$name.url`
-	in .git/config. It uses the same setting from .gitmodules as
+	in .git/config. It uses the same setting from `.gitmodules` as
 	a template. If the URL is relative, it will be resolved using
 	the default remote. If there is no default remote, the current
 	repository will be assumed to be upstream.
@@ -197,7 +190,7 @@ configuration variable:
 	none;; the submodule is not updated.
 
 If the submodule is not yet initialized, and you just want to use the
-setting as stored in .gitmodules, you can automatically initialize the
+setting as stored in `.gitmodules`, you can automatically initialize
the
 submodule with the `--init` option.
 
 If `--recursive` is specified, this command will recurse into the
@@ -220,7 +213,7 @@ foreach [--recursive] <command>::
 	Evaluates an arbitrary shell command in each checked out
submodule.
 	The command has access to the variables $name, $path, $sha1
and
 	$toplevel:
-	$name is the name of the relevant submodule section in
.gitmodules,
+	$name is the name of the relevant submodule section in
`.gitmodules`,
 	$path is the name of the submodule directory relative to the
 	superproject, $sha1 is the commit as recorded in the
superproject,
 	and $toplevel is the absolute path to the top-level of the
superproject.
@@ -242,7 +235,7 @@ git submodule foreach 'echo $path `git rev-parse
HEAD`'
 
 sync [--recursive] [--] [<path>...]::
 	Synchronizes submodules' remote URL configuration setting
-	to the value specified in .gitmodules. It will only affect
those
+	to the value specified in `.gitmodules`. It will only affect
those
 	submodules which already have a URL entry in .git/config (that
is the
 	case when they are initialized or freshly added). This is
useful when
 	submodule URLs change upstream and you need to update your
local
@@ -413,7 +406,7 @@ for linkgit:git-clone[1]'s `--reference` and `
--shared` options carefully.
 --[no-]recommend-shallow::
 	This option is only valid for the update command.
 	The initial clone of a submodule will use the recommended
-	`submodule.<name>.shallow` as provided by the .gitmodules file
+	`submodule.<name>.shallow` as provided by the `.gitmodules`
file
 	by default. To ignore the suggestions use `--no-recommend-
shallow`.
 
 -j <n>::
@@ -429,7 +422,7 @@ for linkgit:git-clone[1]'s `--reference` and `
--shared` options carefully.
 
 FILES
 -----
-When initializing submodules, a .gitmodules file in the top-level
directory
+When initializing submodules, a `.gitmodules` file in the top-level
directory
 of the containing repository is used to find the url of each
submodule.
 This file should be formatted in the same way as `$GIT_DIR/config`.
The key
 to each submodule url is "submodule.$name.url".  See
linkgit:gitmodules[5]
-- 
2.11.0
