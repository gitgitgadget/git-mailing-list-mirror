Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EE4B20899
	for <e@80x24.org>; Tue,  8 Aug 2017 17:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbdHHRZ3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 13:25:29 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:36744 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752120AbdHHRZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 13:25:28 -0400
Received: by mail-wr0-f176.google.com with SMTP id y43so15356168wrd.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 10:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lBt6w9CNl13HIoBZzhVjfwVgwH9kFdXqWje57kjC9no=;
        b=pmCRZd/7fooI2n4YGdPm18XfG0fOjB18j5fYWdQUajHAzLYwbS7gvhB1OkIn6L7UHl
         ad12ZFbuS/NeotbCkzklicA5HxiE2iBbdoZIbJvY+FWnbyZGrhgEubRI9RgC+Qruon0B
         L2duFiNy28CAhPfxp3ZO9CscK0GeS8u42hqb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lBt6w9CNl13HIoBZzhVjfwVgwH9kFdXqWje57kjC9no=;
        b=lrjFICZndl3mqwk/Rm4+kkL/gFavp1L5uNzsMN/sIVan/0cBBCgUK6tpGR+cbo8UBN
         rlDAe8D0rn+mBmSvcWcbdgShlKH4P1x1jwvGmQPPAE4l45Peuq/yuBnO8E1gpAPmS64r
         OtSyXcbVlsPIn0HKG3+heC7xOTlD/Y8NsFR807klOdKgQ5yX6AxRBCCEv12j96O8qONw
         zMrq9TVSE49LubEnyzyEJvmnA/M7Rq0l9rBTYfghMfXmsvj1B5c1U9aQcoRiHkpoDBRq
         Z+VMvs4mSYLetH9EHThHbbMWehgi/TrwQF4dyLmBXCMfY4FebKSU4s+SzaRPtV9hazb0
         AFVA==
X-Gm-Message-State: AHYfb5gHSMm7X16NXixyAfzOY09lT4m6t3buHFNcL7sBRYXluxHl4Tw3
        U/SCuJCXshlQZXJH
X-Received: by 10.223.161.133 with SMTP id u5mr3877402wru.191.1502213127169;
        Tue, 08 Aug 2017 10:25:27 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id p45sm2469307wrb.75.2017.08.08.10.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2017 10:25:26 -0700 (PDT)
Date:   Tue, 8 Aug 2017 18:25:24 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Xie <emilyxxie@gmail.com>
Subject: Re: t3700 broken on pu on Cygwin
Message-ID: <20170808172524.GC32640@dinwoodie.org>
References: <20170808151808.GA32640@dinwoodie.org>
 <25c23536-50a3-5a59-756f-e5c48ac1a342@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25c23536-50a3-5a59-756f-e5c48ac1a342@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2017 at 05:32:21PM +0200, René Scharfe wrote:
> Am 08.08.2017 um 17:18 schrieb Adam Dinwoodie:
> > The t3700-add.sh test is currently failing on the pu branch on Cygwin.
> > To my surprise, the problem appears to have been introduced by a merge,
> > 867fa1d6a.  Both parents of that merge have the test succeeding, but
> > it's failing on that merge commit.
> > 
> > Failing test output below:
> 
> >      expecting success:
> >      		git reset --hard &&
> >      		echo foo >foo3 &&
> >      		git add foo3 &&
> >      		git add --chmod=+x foo3 &&
> >      		test_mode_in_index 100755 foo3 &&
> >      		echo foo >xfoo3 &&
> >      		chmod 755 xfoo3 &&
> >      		git add xfoo3 &&
> >      		git add --chmod=-x xfoo3 &&
> >      		test_mode_in_index 100644 xfoo3
> > 
> >      ++ git reset --hard
> >      HEAD is now at d12df1f commit all
> >      ++ echo foo
> >      ++ git add foo3
> >      ++ git add --chmod=+x foo3
> >      ++ test_mode_in_index 100755 foo3
> >      ++ case "$(git ls-files -s "$2")" in
> >      +++ git ls-files -s foo3
> >      ++ echo pass
> >      pass
> >      ++ echo foo
> >      ++ chmod 755 xfoo3
> >      ++ git add xfoo3
> >      ++ git add --chmod=-x xfoo3
> >      cannot chmod 'xfoo3'++ test_mode_in_index 100644 xfoo3
> >      ++ case "$(git ls-files -s "$2")" in
> >      +++ git ls-files -s xfoo3
> >      ++ echo fail
> >      fail
> >      ++ git ls-files -s xfoo3
> >      120000 c5c4ca97a3a080c32920941b665e94a997901491 0       xfoo3
> >      ++ return 1
> >      + test_eval_ret_=1
> >      + want_trace
> >      + test t = t
> >      + test t = t
> >      + set +x
> >      error: last command exited with $?=1
> >      not ok 41 - git add --chmod=[+-]x changes index with already added file
> >      #
> >      #               git reset --hard &&
> >      #               echo foo >foo3 &&
> >      #               git add foo3 &&
> >      #               git add --chmod=+x foo3 &&
> >      #               test_mode_in_index 100755 foo3 &&
> >      #               echo foo >xfoo3 &&
> >      #               chmod 755 xfoo3 &&
> >      #               git add xfoo3 &&
> >      #               git add --chmod=-x xfoo3 &&
> >      #               test_mode_in_index 100644 xfoo3
> >      #
> > 
> 
> That's strange.  The two changes don't seem to be related at all:
> 
>   diff --git a/t/t3700-add.sh b/t/t3700-add.sh
>   index f3a4b4a913..06e3835efb 100755
>   --- a/t/t3700-add.sh
>   +++ b/t/t3700-add.sh
>   @@ -331,9 +331,8 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
>           test_i18ncmp expect.err actual.err
>    '
>   
>   -test_expect_success 'git add empty string should invoke warning' '
>   -       git add "" 2>output &&
>   -       test_i18ngrep "warning: empty strings" output
>   +test_expect_success 'git add empty string should fail' '
>   +       test_must_fail git add ""
>    '
>   
>    test_expect_success 'git add --chmod=[+-]x stages correctly' '
>   @@ -355,7 +354,7 @@ test_expect_success POSIXPERM,SYMLINKS 'git add --chmod=+x with symlinks' '
>    '
>   
>    test_expect_success 'git add --chmod=[+-]x changes index with already added file' '
>   -       rm -f foo3 xfoo3 &&
>   +       git reset --hard &&
>           echo foo >foo3 &&
>           git add foo3 &&
>           git add --chmod=+x foo3 &&
> 
> The only difference I can see being introduced with the first change
> is that the file "output" is gone now.

Yep!  I thought it was strange too.  I spent some time undoing and
redoing the changes to check the problem was reproducible.

> Does it help to add the "rm -f foo3 xfoo3 &&" back, in addition to
> the "git reset --hard"?

Apparently so.  Including only the output from that test:

    expecting success:
            rm -f foo3 xfoo3 &&
            git reset --hard &&
            echo foo >foo3 &&
            git add foo3 &&
            git add --chmod=+x foo3 &&
            test_mode_in_index 100755 foo3 &&
            echo foo >xfoo3 &&
            chmod 755 xfoo3 &&
            git add xfoo3 &&
            git add --chmod=-x xfoo3 &&
            test_mode_in_index 100644 xfoo3
    
    ++ rm -f foo3 xfoo3
    ++ git reset --hard
    HEAD is now at 02bfd98 commit all
    ++ echo foo
    ++ git add foo3
    ++ git add --chmod=+x foo3
    ++ test_mode_in_index 100755 foo3
    ++ case "$(git ls-files -s "$2")" in
    +++ git ls-files -s foo3
    ++ echo pass
    pass
    ++ echo foo
    ++ chmod 755 xfoo3
    ++ git add xfoo3
    ++ git add --chmod=-x xfoo3
    ++ test_mode_in_index 100644 xfoo3
    ++ case "$(git ls-files -s "$2")" in
    +++ git ls-files -s xfoo3
    ++ echo pass
    pass
    + test_eval_ret_=0
    + want_trace
    + test t = t
    + test t = t
    + set +x
    ok 41 - git add --chmod=[+-]x changes index with already added file

I'm running a bisect overnight to try to isolate the commit on the left
merge parent that seems to be interacting badly with the commit on the
right, and will send in the results from that when I have them.
