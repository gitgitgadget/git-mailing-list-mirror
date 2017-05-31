Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9E31FD09
	for <e@80x24.org>; Wed, 31 May 2017 18:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751172AbdEaS7o (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 14:59:44 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:35010 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbdEaS7m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 14:59:42 -0400
Received: by mail-it0-f50.google.com with SMTP id f72so18573079ite.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 11:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uOHOHP85K/PNr7fjwLGKa/B1PNPB0xosxZQnxZxsB5Q=;
        b=PZTfH6uOyYoS+V+60q54YIdVb6Od6v0KQ8fLUfHw5QthD4hWbEJS6zt4anL/aD8//3
         LQBRlcq0HUK3cVwYl0snoxlg0IxFhSuW1xcfMqbmfRpli33t7TfLQUdBDOsqJ4FmXq5D
         3f5/qsDb5slxiQwAlQIwLw67+jX+eUPgLpWSpq3++EtKCohNSL/hMgbuu/zP1lC5RW98
         Sy4B4nZ0OmviCa/ZRZdklZF/B6lO230QenwwYcTebZIFwxsfMpaJAcG7CVP6s/hWAeFr
         asZzd23oVH/fLwn1G0ctW0CoDFYWT17qRhP1F9Ev6eovnHuvQmjgU5yj00yATNC+GW0k
         x7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uOHOHP85K/PNr7fjwLGKa/B1PNPB0xosxZQnxZxsB5Q=;
        b=AjoQJdcKSgZJw+vNeVGpS+7hYQNKzSjuaUtnLB00FzV5CcpwY95GmEuImh2efberMA
         +awgYErc73YIsBa4pjSS1Z8jsAea0iw1awrGAXaMBlbK7w7yKq/5/RnjZ8ogCUKgb0DG
         rzFCTEHtbGghZEtDpEyAxOs7UbBCDfQvIMh6Rk5g26vphTPY4d77nQG5/uU2YxCUgx5R
         Vxsebzkwxx4iUyRij2IeH8Y8US/JjEKAyNRATQDeY889k/zYnm3qZfm/EIDyZMNIELej
         o4pGP45g6LZszV2wI9SsIs/jlpATO+4sl6Vt2IGIOrAAE1hL+TB0Nvma/RJtIsib/BbC
         AdXw==
X-Gm-Message-State: AODbwcDb274J95l0MDpQ+RkRhL2VePGnZv7Kt0GWBNY7YHER78b62if6
        bzzD8WAlzgOC+aURv49RfDh3S+2Hlw==
X-Received: by 10.36.138.131 with SMTP id v125mr8748990itd.66.1496257167006;
 Wed, 31 May 2017 11:59:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Wed, 31 May 2017 11:59:06 -0700 (PDT)
In-Reply-To: <xmqq1sr889lb.fsf@gitster.mtv.corp.google.com>
References: <xmqq1sr889lb.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 31 May 2017 20:59:06 +0200
Message-ID: <CACBZZX6YFKTLKxep2oW0_HrX+kNJ2PX5G4UCboB+4yosmLqr5g@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #08; Mon, 29)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 8:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * ab/pcre-v2 (2017-05-26) 7 commits
>  - grep: add support for PCRE v2
>  - grep: un-break building with PCRE < 8.20
>  - grep: un-break building with PCRE < 8.32
>  - grep: add support for the PCRE v1 JIT API
>  - log: add -P as a synonym for --perl-regexp
>  - grep: skip pthreads overhead when using one thread
>  - grep: don't redundantly compile throwaway patterns under threading
>  (this branch uses ab/grep-preparatory-cleanup.)
>
>  Update "perl-compatible regular expression" support to enable JIT
>  and also allow linking with the newer PCRE v2 library.
>
>  Will merge to 'next'.

First a general question: When you say "will merge" in these E-Mails,
that means "before the next what's cooking in ~7 days, right? I.e. if
there's no issues in a given series does the pu->next->master cycle
take 3wks?

Anyway, the PCRE v1 set of JIT patches break builds on PCRE compiled
with --disable-jit, which is apparently Johannes's Windows
configuration.

This on top fixes it:

diff --git a/grep.h b/grep.h
index 246f6695c1..6cb21a3544 100644
--- a/grep.h
+++ b/grep.h
@@ -3,7 +3,7 @@
 #include "color.h"
 #ifdef USE_LIBPCRE1
 #include <pcre.h>
-#ifdef PCRE_CONFIG_JIT
+#ifdef SLJIT_CONFIG_AUTO
 #if PCRE_MAJOR >= 8 && PCRE_MINOR >= 32
 #define GIT_PCRE1_USE_JIT
 #endif

But I'm waiting on the pcre-dev list to answer my "is this use of an
internal macro really the least insane way to check for this, because
there seems to be no other way?" question:
https://lists.exim.org/lurker/message/20170531.184405.9d7b128f.en.html

I'm also going to fix this up:

diff --git a/grep.c b/grep.c
index e4c1ead104..d0bf37858a 100644
--- a/grep.c
+++ b/grep.c
@@ -502,9 +502,7 @@ static void compile_pcre2_pattern(struct grep_pat
*p, const struct grep_opt *opt
        pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
        if (p->pcre2_jit_on == 1) {
                jitret = pcre2_jit_compile(p->pcre2_pattern,
PCRE2_JIT_COMPLETE);
-               if (!jitret)
-                       p->pcre2_jit_on = 1;
-               else
+               if (jitret)
                        die("Couldn't JIT the PCRE2 pattern '%s', got
'%d'\n", p->pattern, jitret);
                p->pcre2_jit_stack = pcre2_jit_stack_create(1, 1024 *
1024, NULL);
                if (!p->pcre2_jit_stack)


And a perf test in a commit message that makes no sense since I split
up the PCRE v1 patch.
