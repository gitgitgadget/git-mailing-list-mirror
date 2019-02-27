Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C977E20248
	for <e@80x24.org>; Wed, 27 Feb 2019 05:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfB0Fp4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 00:45:56 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36570 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfB0Fp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 00:45:56 -0500
Received: by mail-qk1-f196.google.com with SMTP id c2so8458172qkb.3
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 21:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yPhnVPm60Q31SRVASQlkfKqH1lYBlmUGts7owibtsvg=;
        b=GDJ5r4z5qZaY20ovEE9+rggrF6sCpEYdxIncBDgqko2Nb0jjmXG38cWAmj5AG0rhZr
         Tx4M72zIsvxV5eEkKlBVoWOFW67B6s3CXnGJt0L41CHqFqK9Rc8uLHOHbfy5eHnrMdgK
         h1KVceAJC4BQfkHPlqSm9u4KDAFNqIwowCX1taX/2bRC8FuLnO/1HW2+nSdNGOQTA47g
         dBwt/FGmY3IqfK6hsvJoALs96vxz1OSpEts9LwmE7nGJDlWEUOvZ8ICuqqyBbyxI/YBz
         UkZybc9Mqc0J4IzOjtr+8djwOIoHr/EpxWGfUA/v8JSaBUmAHWJO7nveIUYF0sLeFMRR
         S+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yPhnVPm60Q31SRVASQlkfKqH1lYBlmUGts7owibtsvg=;
        b=MpulkUd+csF3zQ7261vNSvLseGpA6zrG8eaNqdqEQk4iaBRu+6GE6b3W9h45LXc6E8
         xiXrb4MLapm0VGSaZ4F9F+0K+NpBOHSqMqzs4Hl3/EnTwe7OG1/Bwf6hHhZN2i254yh/
         LUOv6pU0Pk9i10FQVHmop4qJqutrAlxqSScc8kuYEf/OeDxK9djmluiT92PoAh2HTqRF
         vEwsoz5yZQGBc2WWqIPVc4v6aO0P7QQ1q+MpVjMWsqwwcKuRnZCosM4imHL2vVfICGhc
         Et7TH854uGooSw4wgAL7DzCyw2H6tqdlwY7EU3xCKu2+wnGu2QcytI//sAX4YGLtriFr
         vUPg==
X-Gm-Message-State: AHQUAuYkXeqZr+uqiEfxHnDNySdx6kCIdnpfdt+WmNNlL49raG/R/lF6
        C9547sBy04qGwrD7/Jwfekyn7plEYI8qbnBIFA==
X-Google-Smtp-Source: APXvYqzysRZu8ZPxdIOFKvAlXjHywLqr1Hb8ztTcLsOluywnqos8J2Zh1GLaiAFr8f1DaySoQ4KbEwWaF66w8mc8Yq4=
X-Received: by 2002:a37:9cd1:: with SMTP id f200mr939728qke.176.1551246354706;
 Tue, 26 Feb 2019 21:45:54 -0800 (PST)
MIME-Version: 1.0
References: <CA+h-Bnuf6u=hkPBcxhMm06FbfkS+jtrozu+inqqmUY1cNkXrWQ@mail.gmail.com>
 <87va2zavu1.fsf@igel.home> <CA+h-BnvN7+ETU-vFxAGDvs0gvXUjAAhMkvTPUxoRTt2Gb4b2ow@mail.gmail.com>
 <CA+P7+xq++4W32JT9WcasXn=Oj9W-U1eteFgpLZn8GVqeO0foog@mail.gmail.com> <nycvar.QRO.7.76.6.1901091501320.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1901091501320.41@tvgsbejvaqbjf.bet>
From:   Nazri Ramliy <ayiehere@gmail.com>
Date:   Wed, 27 Feb 2019 13:45:43 +0800
Message-ID: <CAEY4ZpPQxCVY5dZ_K9NRqF=YB0=s1nnJhnuDzL+ZytJ5uO2N7g@mail.gmail.com>
Subject: Re: git rebase: retain original head?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Markus Wiederkehr <markus.wiederkehr@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 9, 2019 at 10:08 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Having said that, it is an unintended regression in the built-in rebase.
> Markus, could you come up with a minimal test case, preferably in the form
> of a patch to t/t3415-rebase-autosquash.sh?

Something like this, perhaps? ("gmail converts tabs to spaces" caveat
applies to the diff formatting):

--8<--
diff --git t/t3400-rebase.sh t/t3400-rebase.sh
index 3e73f7584c..cb55597a8b 100755
--- t/t3400-rebase.sh
+++ t/t3400-rebase.sh
@@ -59,6 +59,13 @@ test_expect_success 'rebase against master' '
  git rebase master
 '

+test_expect_success 'rebase sets ORIG_HEAD' '
+ echo Add B. > expect &&
+ echo Modify A. >> expect &&
+ git log --oneline --format=%s ORIG_HEAD.. > actual &&
+ test_cmp expect actual
+'
+
 test_expect_success 'rebase, with <onto> and <upstream> specified as
:/quuxery' '
  test_when_finished "git branch -D torebase" &&
  git checkout -b torebase my-topic-branch^ &&
-->8--

Bisect shows that the first bad commit is this one:

commit 21853626eac565dd42572d90724b29863f61eb3b
Author: Johannes Schindelin <johannes.schindelin@gmx.de>
Date:   Fri Jan 18 07:09:27 2019 -0800

    built-in rebase: call `git am` directly

I verified that by undoing the crux of that commit, and that fixes the
failing test:

-->8--
diff --git builtin/rebase.c builtin/rebase.c
index 7c7bc13e91..848f6740a0 100644
--- builtin/rebase.c
+++ builtin/rebase.c
@@ -728,11 +728,6 @@ static int run_specific_rebase(struct rebase_options *opts)
  goto finished_rebase;
  }

- if (opts->type == REBASE_AM) {
- status = run_am(opts);
- goto finished_rebase;
- }
-
  add_var(&script_snippet, "GIT_DIR", absolute_path(get_git_dir()));
  add_var(&script_snippet, "state_dir", opts->state_dir);

--8<--

But something seems off by my bisection in that the "bad" commit
happens about 10 days after this email thread :/

nazri
