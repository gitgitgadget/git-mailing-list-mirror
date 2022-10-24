Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9CDC67871
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 23:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJXXuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 19:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJXXtz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 19:49:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE13024CC92
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 15:07:58 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k8so9481480wrh.1
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 15:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RkTm5E5cXfIKAWWr0sLQN2qso04YFCS8FOwLsC+irw=;
        b=G/STuY/ffMKGofiFVCnL0ZzxsdsSJrcuE41Q3327palOXT388KrcXGgSu6+dLHPwg9
         rKeCNqlZTMmAv+/sV1F4bT3kTOOe15twvJcW9M2e30fZViPaNi6QogTNo6Zp+nkRYMbZ
         M4rJvjOkLnspLxw+UTDXQ9CEUpGlXNygIcLBszKfv6GA8rHCVLuDIgwE5C8E7UWk4tTf
         PxqRPosHdi6Y3fiXCtAnctzxo4tnRMZEKAac83enNz79hoDmGR5dtFGXChATdiQ9ohNh
         pG0yQbMUs/iF6mLD8vmLUcEUiHWkedLEk7MQZq1bZKxxaAcBF/PMArXrYTp8oTuR7h98
         ipIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RkTm5E5cXfIKAWWr0sLQN2qso04YFCS8FOwLsC+irw=;
        b=xPoIGUWJ37q+3YRDdddEW7q4uBcjDe9RkgoCgN/CTjpVnKpXmloaFsWPO2Pd5UNcg8
         t9CbyLCjKGlJ6We8PKMwDiyB5eVYI7GmUjcOm6fmNsyw/waH/nDJhGfqhiZoapUqkzcQ
         xXghWwopM10xs57IUC5lgolx2v55GcLiy7kR5+5NA8pZJwxppqXC5NdeB1tJ6SiT1AP4
         oRNpG4Z3yGEH2O1NLn1H3f7galw5lMtPWdT6yTdGANwf/JxrwFTvUYuIQuB7EHa2SzMq
         TgPLQA9NPQsHwCPA3BqF2U/ANrgwtO6S3YYsnDFBvvAUi/2qgj7JyZYzTVe3r8VqdCD0
         nADA==
X-Gm-Message-State: ACrzQf3Q2jt/E14yfItDYiApcVo8Ut0kpbP+zn6ZJQ8YsgQLRVt5K9zd
        nO3cRSK0IIYucCAqNo6qBD+HlLF6Hi0=
X-Google-Smtp-Source: AMsMyM5sTtj+TojbnoB1hWUlD6drnwtkRld2wTVIOg8meUkx3ytwwqr5LJ4b43w8GDFrNC4ocTzEIQ==
X-Received: by 2002:adf:b646:0:b0:221:76eb:b3ba with SMTP id i6-20020adfb646000000b0022176ebb3bamr22587769wre.237.1666649240635;
        Mon, 24 Oct 2022 15:07:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c3b0200b003c6bd91caa5sm939600wms.17.2022.10.24.15.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 15:07:20 -0700 (PDT)
Message-Id: <pull.1345.v4.git.1666649239302.gitgitgadget@gmail.com>
In-Reply-To: <pull.1345.v3.git.1666338109778.gitgitgadget@gmail.com>
References: <pull.1345.v3.git.1666338109778.gitgitgadget@gmail.com>
From:   "Julia Ramer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 22:07:19 +0000
Subject: [PATCH v4] embargoed releases: also describe the git-security list
 and the process
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     git-security@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Ramer <prplr@github.com>,
        Keanen Wold <keanenwold@github.com>,
        Veronica Giaudrone <veronica.Giaudrone@microsoft.com>,
        Bri Brothers <brbrot@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Julia Ramer <gitprplr@gmail.com>,
        Julia Ramer <gitprplr@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Julia Ramer <gitprplr@gmail.com>

With the recent turnover on the git-security list, questions came up how
things are usually run. Rather than answering questions individually,
extend Git's existing documentation about security vulnerabilities to
describe the git-security mailing list, how things are run on that list,
and what to expect throughout the process from the time a security bug
is reported all the way to the time when a fix is released.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Julia Ramer <gitprplr@gmail.com>
---
    embargoed releases: also describe the git-security list and the process
    
    Changes since v3:
    
     * minor formatting corrections
     * clarified the language based on v3 feedback
    
    Changes since v2:
    
     * squashed Junio's patch with very minor modifications
     * incorporated further feedback since v2
    
    Changes since v1:
    
     * Fixed the build
     * Changed the wording based on various feedback

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1345%2Fprplr%2Fupdate_embargo_doc-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1345/prplr/update_embargo_doc-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1345

Range-diff vs v3:

 1:  96250f139a9 ! 1:  b6ecc919dbb embargoed releases: also describe the git-security list and the process
     @@ Documentation/howto/coordinate-embargoed-releases.txt: releases with packagers,
       
      -Open a Security Advisory draft
      -------------------------------
     --
     --The first step is to https://github.com/git/git/security/advisories/new[open an
     --advisory]. Technically, it is not necessary, but it is convenient and saves a
     --bit of hassle. This advisory can also be used to obtain the CVE number and it
     --will give us a private fork associated with it that can be used to collaborate
     --on a fix.
     --
     --Release date of the embargoed version
     ---------------------------------------
     --
     --If the vulnerability affects Windows users, we want to have our friends over at
     --Visual Studio on board. This means we need to target a "Patch Tuesday" (i.e. a
     --second Tuesday of the month), at the minimum three weeks from heads-up to
     --coordinated release.
     --
     --If the vulnerability affects the server side, or can benefit from scans on the
     --server side (i.e. if `git fsck` can detect an attack), it is important to give
     --all involved Git repository hosting sites enough time to scan all of those
     --repositories.
      +The `git-security` mailing list
      +-------------------------------
      +
     @@ Documentation/howto/coordinate-embargoed-releases.txt: releases with packagers,
      +redirected to the public mailing list), how to remediate the issue, determining
      +the timeline of the disclosure as well as aligning priorities and
      +requirements.
     -+
     + 
     +-The first step is to https://github.com/git/git/security/advisories/new[open an
     +-advisory]. Technically, it is not necessary, but it is convenient and saves a
     +-bit of hassle. This advisory can also be used to obtain the CVE number and it
     +-will give us a private fork associated with it that can be used to collaborate
     +-on a fix.
      +Communications
      +~~~~~~~~~~~~~~
     -+
     + 
     +-Release date of the embargoed version
     +--------------------------------------
      +If you are a stakeholder, it is a good idea to pay close attention to the
      +discussions, as pertinent information may be buried in the middle of a lively
      +conversation that might not look relevant to your interests. For example, the
     @@ Documentation/howto/coordinate-embargoed-releases.txt: releases with packagers,
      +for multiple, separate vulnerabilities into the same embargoed release. Most
      +mail threads are not usually structured specifically to communicate
      +agreements, assessments or timelines.
     -+
     + 
     +-If the vulnerability affects Windows users, we want to have our friends over at
     +-Visual Studio on board. This means we need to target a "Patch Tuesday" (i.e. a
     +-second Tuesday of the month), at the minimum three weeks from heads-up to
     +-coordinated release.
      +Typical timeline
      +----------------
     -+
     + 
     +-If the vulnerability affects the server side, or can benefit from scans on the
     +-server side (i.e. if `git fsck` can detect an attack), it is important to give
     +-all involved Git repository hosting sites enough time to scan all of those
     +-repositories.
      +- A potential vulnerability is reported to the `git-security` mailing list.
      +
     -+- The security-list members start a discussion to give an initial
     ++- The members of the git-security list start a discussion to give an initial
      +  assessment of the severity of the reported potential vulnerability.
      +  We aspire to do so within a few days.
      +
     @@ Documentation/howto/coordinate-embargoed-releases.txt: releases with packagers,
      +  details).
      +
      +- Code review can take place in a variety of different locations,
     -+  depending on context. These are: patches sent inline on the
     -+  git-security list, a private fork on GitHub associated with the
     -+  draft security advisory, or the git/cabal repository.
     ++  depending on context. These are: patches sent inline on the git-security list,
     ++  a private fork on GitHub associated with the draft security advisory, or the
     ++  git/cabal repository.
      +
     -+  Contributors working on a fix should consider beginning by sending
     -+  patches to the git-security list (inline with the original thread),
     -+  since they are accessible to all subscribers, along with the original
     -+  reporter.
     ++- Contributors working on a fix should consider beginning by sending
     ++  patches to the git-security list (inline with the original thread), since they
     ++  are accessible to all subscribers, along with the original reporter.
      +
      +- Once the review has settled and everyone involved in the review agrees that
     -+  the patches are ready, the Git maintainer, and others determine a release date
     -+  as well as the release trains that are serviced. The decision regarding which
     -+  versions need a backported fix is based on input from the reporter, the
     -+  contributor who worked on the patches, and from stakeholders.   Operators
     -+  of hosting sites who may want to analyze whether the given issue is exploited
     -+  via any of the repositories they host, and binary packagers who want to
     -+  make sure their product gets patched adequately against the vulnerability,
     -+  for example, may want to give their input at this stage.
     ++  the patches are nearing the finish line, the Git maintainer, and others
     ++  determine a release date as well as the release trains that are serviced. The
     ++  decision regarding which versions need a backported fix is based on input from
     ++  the reporter, the contributor who worked on the patches, and from
     ++  stakeholders. Operators of hosting sites who may want to analyze whether the
     ++  given issue is exploited via any of the repositories they host, and binary
     ++  packagers who want to make sure their product gets patched adequately against
     ++  the vulnerability, for example, may want to give their input at this stage.
      +
      +- While the Git community does its best to accommodate the specific timeline
      +  requests of the various binary packagers, the nature of the issue may preclude
     @@ Documentation/howto/coordinate-embargoed-releases.txt: releases with packagers,
      +  interest of the Git users community to shorten the disclosure and release
      +  timeline, and packagers may need to adapt accordingly.
      +
     -+- Subsequently, branches with the fixes are pushed to private repositories that
     -+  are owned by the Git project, with tightly controlled access.
     ++- Subsequently, branches with the fixes are pushed to the git/cabal repository.
      +
     -+- The tags are created by the Git maintainer and pushed to the same
     -+  repositories.
     ++- The tags are created by the Git maintainer and pushed to the same repository.
      +
      +- The Git for Windows, Git for macOS, BSD, Debian, etc. maintainers prepare the
      +  corresponding release artifacts, based on the tags created that have been
     @@ Documentation/howto/coordinate-embargoed-releases.txt: releases with packagers,
      +- Less than a week before the release, a mail with the relevant information is
      +  sent to <distros@vs.openwall.org> (see below), a list used to pre-announce
      +  embargoed releases of open source projects to the stakeholders of all major
     -+  distributions of Linux as well as other OSes. This includes a Git bundle
     -+  of the tagged version(s), but no further specifics of the vulnerability.
     ++  distributions of Linux as well as other OSes.
      +
      +- Public communication is then prepared in advance of the release date. This
      +  includes blog posts and mails to the Git and Git for Windows mailing lists.
     @@ Documentation/howto/coordinate-embargoed-releases.txt: Thanks,
       
       ....
       To: oss-security@lists.openwall.com
     +@@ Documentation/howto/coordinate-embargoed-releases.txt: it goes to <developer>.
     + 
     + Thanks,
     + <name>
     +-....
     ++....
     + \ No newline at end of file


 .../howto/coordinate-embargoed-releases.txt   | 165 +++++++++++++++---
 1 file changed, 140 insertions(+), 25 deletions(-)

diff --git a/Documentation/howto/coordinate-embargoed-releases.txt b/Documentation/howto/coordinate-embargoed-releases.txt
index 601aae88e9a..e653775bab1 100644
--- a/Documentation/howto/coordinate-embargoed-releases.txt
+++ b/Documentation/howto/coordinate-embargoed-releases.txt
@@ -1,9 +1,10 @@
 Content-type: text/asciidoc
-Abstract: When a critical vulnerability is discovered and fixed, we follow this
- script to coordinate a public release.
+Abstract: When a vulnerability is reported, we follow these guidelines to
+ assess the vulnerability, create and review a fix, and coordinate embargoed
+ security releases.
 
 How we coordinate embargoed releases
-====================================
+------------------------------------
 
 To protect Git users from critical vulnerabilities, we do not just release
 fixed versions like regular maintenance releases. Instead, we coordinate
@@ -11,33 +12,147 @@ releases with packagers, keeping the fixes under an embargo until the release
 date. That way, users will have a chance to upgrade on that date, no matter
 what Operating System or distribution they run.
 
-Open a Security Advisory draft
-------------------------------
+The `git-security` mailing list
+-------------------------------
+
+Responsible disclosures of vulnerabilities, analysis, proposed fixes as
+well as the orchestration of coordinated embargoed releases all happen on the
+`git-security` mailing list at <git-security@googlegroups.com>.
+
+In this context, the term "embargo" refers to the time period that information
+about a vulnerability is kept under wraps and only shared on a need-to-know
+basis. This is necessary to protect Git's users from bad actors who would
+otherwise be made aware of attack vectors that could be exploited. "Lifting the
+embargo" refers to publishing the version that fixes the vulnerabilities.
+
+Audience of the `git-security` mailing list
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Anybody may contact the `git-security` mailing list by sending an email
+to <git-security@googlegroups.com>, though the archive is closed to the
+public and only accessible to subscribed members.
+
+There are a few dozen subscribed members: core Git developers who are trusted
+with addressing vulnerabilities, and stakeholders (i.e. owners of products
+affected by security vulnerabilities in Git).
+
+Most of the discussions revolve around assessing the severity of the reported
+issue (including the decision whether the report is security-relevant or can be
+redirected to the public mailing list), how to remediate the issue, determining
+the timeline of the disclosure as well as aligning priorities and
+requirements.
 
-The first step is to https://github.com/git/git/security/advisories/new[open an
-advisory]. Technically, it is not necessary, but it is convenient and saves a
-bit of hassle. This advisory can also be used to obtain the CVE number and it
-will give us a private fork associated with it that can be used to collaborate
-on a fix.
+Communications
+~~~~~~~~~~~~~~
 
-Release date of the embargoed version
--------------------------------------
+If you are a stakeholder, it is a good idea to pay close attention to the
+discussions, as pertinent information may be buried in the middle of a lively
+conversation that might not look relevant to your interests. For example, the
+tentative timeline might be agreed upon in the middle of discussing code
+comment formatting in one of the patches and whether or not to combine fixes
+for multiple, separate vulnerabilities into the same embargoed release. Most
+mail threads are not usually structured specifically to communicate
+agreements, assessments or timelines.
 
-If the vulnerability affects Windows users, we want to have our friends over at
-Visual Studio on board. This means we need to target a "Patch Tuesday" (i.e. a
-second Tuesday of the month), at the minimum three weeks from heads-up to
-coordinated release.
+Typical timeline
+----------------
 
-If the vulnerability affects the server side, or can benefit from scans on the
-server side (i.e. if `git fsck` can detect an attack), it is important to give
-all involved Git repository hosting sites enough time to scan all of those
-repositories.
+- A potential vulnerability is reported to the `git-security` mailing list.
+
+- The members of the git-security list start a discussion to give an initial
+  assessment of the severity of the reported potential vulnerability.
+  We aspire to do so within a few days.
+
+- After discussion, if consensus is reached that it is not critical enough
+  to warrant any embargo, the reporter is redirected to the public Git mailing
+  list. This ends the reporter's interaction with the `git-security` list.
+
+- If it is deemed critical enough for an embargo, ideas are presented on how to
+  address the vulnerability.
+
+- Usually around that time, the Git maintainer or their delegate(s) open a draft
+  security advisory in the `git/git` repository on GitHub (see below for more
+  details).
+
+- Code review can take place in a variety of different locations,
+  depending on context. These are: patches sent inline on the git-security list,
+  a private fork on GitHub associated with the draft security advisory, or the
+  git/cabal repository.
+
+- Contributors working on a fix should consider beginning by sending
+  patches to the git-security list (inline with the original thread), since they
+  are accessible to all subscribers, along with the original reporter.
+
+- Once the review has settled and everyone involved in the review agrees that
+  the patches are nearing the finish line, the Git maintainer, and others
+  determine a release date as well as the release trains that are serviced. The
+  decision regarding which versions need a backported fix is based on input from
+  the reporter, the contributor who worked on the patches, and from
+  stakeholders. Operators of hosting sites who may want to analyze whether the
+  given issue is exploited via any of the repositories they host, and binary
+  packagers who want to make sure their product gets patched adequately against
+  the vulnerability, for example, may want to give their input at this stage.
+
+- While the Git community does its best to accommodate the specific timeline
+  requests of the various binary packagers, the nature of the issue may preclude
+  a prolonged release schedule. For fixes deemed urgent, it may be in the best
+  interest of the Git users community to shorten the disclosure and release
+  timeline, and packagers may need to adapt accordingly.
+
+- Subsequently, branches with the fixes are pushed to the git/cabal repository.
+
+- The tags are created by the Git maintainer and pushed to the same repository.
+
+- The Git for Windows, Git for macOS, BSD, Debian, etc. maintainers prepare the
+  corresponding release artifacts, based on the tags created that have been
+  prepared by the Git maintainer.
+
+- The release artifacts prepared by various binary packagers can be
+  made available to stakeholders under embargo via a mail to the
+  `git-security` list.
+
+- Less than a week before the release, a mail with the relevant information is
+  sent to <distros@vs.openwall.org> (see below), a list used to pre-announce
+  embargoed releases of open source projects to the stakeholders of all major
+  distributions of Linux as well as other OSes.
+
+- Public communication is then prepared in advance of the release date. This
+  includes blog posts and mails to the Git and Git for Windows mailing lists.
+
+- On the day of the release, at around 10am Pacific Time, the Git maintainer
+  pushes the tag and the `master` branch to the public repository, then sends
+  out an announcement mail.
+
+- Once the tag is pushed, the Git for Windows maintainer publishes the
+  corresponding tag and creates a GitHub Release with the associated release
+  artifacts (Git for Windows installer, Portable Git, MinGit, etc).
+
+- Git for Windows release is then announced via a mail to the public Git and
+  Git for Windows mailing lists as well as via a tweet.
+
+- Ditto for distribution packagers for Linux and other platforms:
+  their releases are announced via their preferred channels.
+
+- A mail to <oss-security@lists.openwall.org> (see below for details) is sent
+  as a follow-up to the <distros@vs.openwall.org> one, describing the
+  vulnerability in detail, often including a proof of concept of an exploit.
+
+Note: The Git project makes no guarantees about timelines, but aims to keep
+embargoes reasonably short in the interest of keeping Git's users safe.
+
+Opening a Security Advisory draft
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The first step is to https://github.com/git/git/security/advisories/new[open
+an advisory]. Technically, this is not necessary. However, it is the most
+convenient way to obtain the CVE number and it give us a private repository
+associated with it that can be used to collaborate on a fix.
 
 Notifying the Linux distributions
----------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 At most two weeks before release date, we need to send a notification to
-distros@vs.openwall.org, preferably less than 7 days before the release date.
+<distros@vs.openwall.org>, preferably less than 7 days before the release date.
 This will reach most (all?) Linux distributions. See an example below, and the
 guidelines for this mailing list at
 https://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists[here].
@@ -65,7 +180,7 @@ created using a command like this:
 	tar cJvf cve-xxx.bundle.tar.xz cve-xxx.bundle
 
 Example mail to distros@vs.openwall.org
----------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 ....
 To: distros@vs.openwall.org
@@ -101,7 +216,7 @@ Thanks,
 ....
 
 Example mail to oss-security@lists.openwall.com
------------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 ....
 To: oss-security@lists.openwall.com
@@ -128,4 +243,4 @@ it goes to <developer>.
 
 Thanks,
 <name>
-....
+....
\ No newline at end of file

base-commit: e72d93e88cb20b06e88e6e7d81bd1dc4effe453f
-- 
gitgitgadget
