Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B47A01F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbeKJPXT (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:23:19 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35918 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbeKJPXS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:23:18 -0500
Received: by mail-lj1-f193.google.com with SMTP id s15-v6so3377989lji.3
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WiJ2xj4BPH8hleybSN6Kz1GRTth+CLKyy03xrcgcQNk=;
        b=k9JEXVGAkRnCCCWUvBj6+Cj25tTd0No8hGqlb6rwtnMQb6ec3JS5VfVW30/tpeE2VZ
         VvN0ObQq8oOUKGrvK3/fd/OrJQXSoMmGWtzoCO+HgKKc0Xwx9722L+wdEDvsN2ar+c/b
         +jZcIjJsxLTesJXosKlQiRWvag8MYmabqM1HO+W29yIznsLr8YjF8A7yUUHl4Cl0EDeZ
         3wqLCfhBgfqbEbtZsz32lGSqzmb+x+MIBDO1nhqvY/b20ghUNj8PpEAlv4E6gxaxpupf
         MxxvXL1cy0k9Xx8gjRLFYyNsOfwBQvG7K5ZNehNH60PWtHT36umMIGPdRh4skgCTRQK/
         HV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WiJ2xj4BPH8hleybSN6Kz1GRTth+CLKyy03xrcgcQNk=;
        b=i3xXrk7phOlEaEtsfkVUUYW18MeBcVmiuuUUN7peizboPW0XRkPre/0TKmKr17CX/8
         viJZDwvWzCu2kwexeC1XjADBpSJP2DS/pwDG3athJ3/Vn/fLcPo7b2VdGZJz0lQ56L27
         aOrWc22L61stUXW4uUmusX+jII3XYyJOiNc41eujmYTWjBlGm/NrD96PbRCwzHq3n37+
         UPvrhN2860p/OOjNr1W1BIcadgha51cbhnXlGI0XUQSWBdLYINfaQV91BHUJAdmyUXRm
         3StXx1d1TeIY1tKwNhnzxAH/y30VTnifx/K/qlfxyBzMH+0Ir29sNnGHlIdhhjDtV3D2
         xsXg==
X-Gm-Message-State: AGRZ1gIkq2liSiUCHjZiwCSqGAksCVX8gFtHG9wt1tld+AYxLUSFidJT
        qG6PeKFCdohM90+3zEBmtHY=
X-Google-Smtp-Source: AJdET5els7bxaGJmoUyQ0hhUBj8sHwmFlfY5vGiGpacNMq35SDTzLeAZG3gvahBOyCh44+123kohVA==
X-Received: by 2002:a2e:8945:: with SMTP id b5-v6mr7343131ljk.55.1541826981909;
        Fri, 09 Nov 2018 21:16:21 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm1769663lfe.42.2018.11.09.21.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:16:20 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v3 00/16] Mark more strings for translation
Date:   Sat, 10 Nov 2018 06:15:59 +0100
Message-Id: <20181110051615.8641-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181105192059.20303-1-pclouds@gmail.com>
References: <20181105192059.20303-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 is just small touchups here and there after the review comments
from v2.

Range-diff against v2:
 1:  e77c203313 !  1:  936f84d4b3 git.c: mark more strings for translation
    @@ -3,7 +3,7 @@
         git.c: mark more strings for translation
     
         One string is slightly updated to keep consistency with the rest:
    -    die() should with lowercase.
    +    die() should begin with lowercase.
     
      diff --git a/git.c b/git.c
      --- a/git.c
 2:  12c9468696 =  2:  8ff2de14bf alias.c: mark split_cmdline_strerror() strings for translation
 3:  bf662dc105 =  3:  8e147f6bff archive.c: mark more strings for translation
 4:  1d032b0fdf =  4:  5d574460eb attr.c: mark more string for translation
 5:  2c3ad8c262 =  5:  8e37efb756 read-cache.c: turn die("internal error") to BUG()
 6:  df25ac78b1 =  6:  83b7b6d029 read-cache.c: mark more strings for translation
 7:  241e5a7450 =  7:  4bd085682d read-cache.c: add missing colon separators
 8:  8f60728b0f =  8:  fb72be3a1e reflog: mark strings for translation
 9:  24d2ed6682 =  9:  711812d70b remote.c: turn some error() or die() to BUG()
10:  26e8cee291 = 10:  0213c1f5eb remote.c: mark messages for translation
11:  2409f76902 = 11:  85459c65ca repack: mark more strings for translation
12:  afafe6771c ! 12:  21916a8fb4 parse-options: replace opterror() with optname()
    @@ -2,6 +2,11 @@
     
         parse-options: replace opterror() with optname()
     
    +    Introduce optname() that does the early half of original opterror() to
    +    come up with the name of the option reported back to the user, and use
    +    it to kill opterror().  The callers of opterror() now directly call
    +    error() using the string returned by opterror() instead.
    +
         There are a few issues with opterror()
     
         - it tries to assemble an English sentence from pieces. This is not
    @@ -14,8 +19,7 @@
         - Since it takes a string instead of printf format, one call site has
           to assemble the string manually before passing to it.
     
    -    Kill it and produce the option name with optname(). The user will use
    -    error() directly. This solves the second and third problems.
    +    Using error() directly solves the second and third problems.
     
         It kind helps the first problem as well because "%s does foo" does
         give a translator a full sentence in a sense and let them reorder if
13:  e8b4af8fac = 13:  8c9d2985b5 parse-options.c: turn some die() to BUG()
14:  c3530e162e = 14:  b81cdeda46 parse-options.c: mark more strings for translation
15:  644c56780c ! 15:  dd872fc39b fsck: reduce word legos to help i18n
    @@ -19,7 +19,7 @@
     -	static struct strbuf buf = STRBUF_INIT;
     -	char *name = name_objects ?
     -		lookup_decoration(fsck_walk_options.object_names, obj) : NULL;
    -+	static struct strbuf bufs[4] = {
    ++	static struct strbuf bufs[] = {
     +		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
     +	};
     +	static int b = 0;
    @@ -69,15 +69,18 @@
      {
     -	objreport(obj, (type == FSCK_WARN) ? "warning" : "error", message);
     -	return (type == FSCK_WARN) ? 0 : 1;
    -+	if (type == FSCK_WARN) {
    ++	switch (type) {
    ++	case FSCK_WARN:
     +		fprintf_ln(stderr, "warning in %s %s: %s",
     +			   printable_type(obj), describe_object(obj), message);
     +		return 0;
    ++	case FSCK_ERROR:
    ++		fprintf_ln(stderr, "error in %s %s: %s",
    ++			   printable_type(obj), describe_object(obj), message);
    ++		return 1;
    ++	default:
    ++		BUG("%d (FSCK_IGNORE?) should never trigger this callback", type);
     +	}
    -+
    -+	fprintf_ln(stderr, "error in %s %s: %s",
    -+		   printable_type(obj), describe_object(obj), message);
    -+	return 1;
      }
      
      static struct object_array pending;
16:  61af36567b ! 16:  8f1bbd1c65 fsck: mark strings for translation
    @@ -28,22 +28,21 @@
      	return -1;
      }
     @@
    - 	struct object *obj, int type, const char *message)
      {
    - 	if (type == FSCK_WARN) {
    + 	switch (type) {
    + 	case FSCK_WARN:
     -		fprintf_ln(stderr, "warning in %s %s: %s",
     +		/* TRANSLATORS: e.g. warning in tree 01bfda: <more explanation> */
     +		fprintf_ln(stderr, _("warning in %s %s: %s"),
      			   printable_type(obj), describe_object(obj), message);
      		return 0;
    - 	}
    - 
    --	fprintf_ln(stderr, "error in %s %s: %s",
    -+	/* TRANSLATORS: e.g. error in tree 01bfda: <more explanation> */
    -+	fprintf_ln(stderr, _("error in %s %s: %s"),
    - 		   printable_type(obj), describe_object(obj), message);
    - 	return 1;
    - }
    + 	case FSCK_ERROR:
    +-		fprintf_ln(stderr, "error in %s %s: %s",
    ++		/* TRANSLATORS: e.g. error in tree 01bfda: <more explanation> */
    ++		fprintf_ln(stderr, _("error in %s %s: %s"),
    + 			   printable_type(obj), describe_object(obj), message);
    + 		return 1;
    + 	default:
     @@
      	 */
      	if (!obj) {

Nguyễn Thái Ngọc Duy (16):
  git.c: mark more strings for translation
  alias.c: mark split_cmdline_strerror() strings for translation
  archive.c: mark more strings for translation
  attr.c: mark more string for translation
  read-cache.c: turn die("internal error") to BUG()
  read-cache.c: mark more strings for translation
  read-cache.c: add missing colon separators
  reflog: mark strings for translation
  remote.c: turn some error() or die() to BUG()
  remote.c: mark messages for translation
  repack: mark more strings for translation
  parse-options: replace opterror() with optname()
  parse-options.c: turn some die() to BUG()
  parse-options.c: mark more strings for translation
  fsck: reduce word legos to help i18n
  fsck: mark strings for translation

 alias.c                    |   4 +-
 archive.c                  |   8 +-
 attr.c                     |   4 +-
 builtin/fsck.c             | 159 +++++++++++++++++++++----------------
 builtin/merge.c            |   4 +-
 builtin/reflog.c           |  34 ++++----
 builtin/repack.c           |  26 +++---
 builtin/revert.c           |   3 +-
 git.c                      |  32 ++++----
 parse-options-cb.c         |   7 +-
 parse-options.c            |  64 ++++++++-------
 parse-options.h            |   5 +-
 read-cache.c               |  73 ++++++++---------
 ref-filter.c               |   8 +-
 remote.c                   |  49 ++++++------
 t/t0040-parse-options.sh   |   4 +-
 t/t1410-reflog.sh          |   6 +-
 t/t1450-fsck.sh            |  52 ++++++------
 t/t4211-line-log.sh        |   2 +-
 t/t6050-replace.sh         |   4 +-
 t/t7415-submodule-names.sh |   6 +-
 21 files changed, 295 insertions(+), 259 deletions(-)

-- 
2.19.1.1231.g84aef82467

