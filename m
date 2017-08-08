Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D4EF20899
	for <e@80x24.org>; Tue,  8 Aug 2017 15:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbdHHPc3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 11:32:29 -0400
Received: from mout.web.de ([212.227.15.14]:60413 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752014AbdHHPc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 11:32:28 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MOj14-1dl8u92au6-0069UZ; Tue, 08
 Aug 2017 17:32:23 +0200
Subject: Re: t3700 broken on pu on Cygwin
To:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Emily Xie <emilyxxie@gmail.com>
References: <20170808151808.GA32640@dinwoodie.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <25c23536-50a3-5a59-756f-e5c48ac1a342@web.de>
Date:   Tue, 8 Aug 2017 17:32:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170808151808.GA32640@dinwoodie.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:6nvBVvLUAFNl02uRrCXh5rADfMPVkovHtWetO1J8yC18uCwQlzb
 wHUzLlxgsOXWlsquoGKgwjShY5YoliNNsih9LZocmTtLzaCBQwm6DtLL8FRvYdZQ+17aLaf
 gabUz0LajUiZMUuGnrdIsAjuIKmLcUY4eC2AsWFufAzJYW6Wczf83fpR9wP31GsHUR5ITKf
 49gd0QCI90HqIvnmjRBtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LL2P+fG0dWs=:dI/1ZIIlqyBgyHq8WzQRwM
 AIh+0ZuCQf3UgG1aWwjYwB+PdH3RnCb4kfWWCJW2KKgFs7DG6cF8l6qXJxOx35khKIHq8EUt4
 WMHfc6rygEJmdJouPbGz6Q4vp6DzNLM1BqHJPlLQfb/V4buk3jlwj5P8waF50+b9E++wvpLtS
 Fd3MJBH0i4XM4IWxQ/MQGiyAHuPrRiXU02XtLYeR2cjRShr6rhTXi7Wh0BuAKBnpvaEklCR8q
 271i0iBcKm5rYsRpzdjJtZWhvXo3raKmQgd0z/JqpDgbMswuFNZRG7kTEIQoLhJo1mImjgVE7
 84hvEb1oea6ZMn5oLDEJStTdZnZ5FgOQETDtjZso99JZOGx3P93ZfkZASNo3hOxeQVMrcOxNo
 xbNgIoHlmYU3+muHRZKPAVS0fM9U8xWyNH9NFJ0fv+cWGTwgh+TzxTEMdD5LHawbzJc0tPgX9
 IvKQaEnslgPGd91TRZSF/kWA+1saaN3C3o+HW+d/Q+BypwvB9eyvyOGDzQRdDN56uu7IK9bPk
 sY5JPUrWPs/HdxSwdyRrMqtogijeeWxMaGXHhY15/mvRPtQE2yVWMAOvoVMZogQENDZpJbcLS
 d76qMpzPM2EUQA9fVg9wtLiNiGb1Chce1QG87ED1YU+kk0Wgf/996O8dbDqJZVQFjkDprBD3O
 TjhIo0X42cCOQDAGvzQo611H/dc0mKeTyYGH1Wq2yNNnuGHxKoqZe3XCiWkcGoN+EDsN8EW+v
 8G74hZQhk3VLl9kJ9IMR57w42vISmgUX9Qa3H+aI5r7en10YKf1QR7X6+l6wWHaBsVadjEh7z
 +89LFyqPGX9c1YQRhaFPwLA2Q4+UwkWDY3oaUEnuGAkctwHJW4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.08.2017 um 17:18 schrieb Adam Dinwoodie:
> The t3700-add.sh test is currently failing on the pu branch on Cygwin.
> To my surprise, the problem appears to have been introduced by a merge,
> 867fa1d6a.  Both parents of that merge have the test succeeding, but
> it's failing on that merge commit.
> 
> Failing test output below:

>      expecting success:
>      		git reset --hard &&
>      		echo foo >foo3 &&
>      		git add foo3 &&
>      		git add --chmod=+x foo3 &&
>      		test_mode_in_index 100755 foo3 &&
>      		echo foo >xfoo3 &&
>      		chmod 755 xfoo3 &&
>      		git add xfoo3 &&
>      		git add --chmod=-x xfoo3 &&
>      		test_mode_in_index 100644 xfoo3
> 
>      ++ git reset --hard
>      HEAD is now at d12df1f commit all
>      ++ echo foo
>      ++ git add foo3
>      ++ git add --chmod=+x foo3
>      ++ test_mode_in_index 100755 foo3
>      ++ case "$(git ls-files -s "$2")" in
>      +++ git ls-files -s foo3
>      ++ echo pass
>      pass
>      ++ echo foo
>      ++ chmod 755 xfoo3
>      ++ git add xfoo3
>      ++ git add --chmod=-x xfoo3
>      cannot chmod 'xfoo3'++ test_mode_in_index 100644 xfoo3
>      ++ case "$(git ls-files -s "$2")" in
>      +++ git ls-files -s xfoo3
>      ++ echo fail
>      fail
>      ++ git ls-files -s xfoo3
>      120000 c5c4ca97a3a080c32920941b665e94a997901491 0       xfoo3
>      ++ return 1
>      + test_eval_ret_=1
>      + want_trace
>      + test t = t
>      + test t = t
>      + set +x
>      error: last command exited with $?=1
>      not ok 41 - git add --chmod=[+-]x changes index with already added file
>      #
>      #               git reset --hard &&
>      #               echo foo >foo3 &&
>      #               git add foo3 &&
>      #               git add --chmod=+x foo3 &&
>      #               test_mode_in_index 100755 foo3 &&
>      #               echo foo >xfoo3 &&
>      #               chmod 755 xfoo3 &&
>      #               git add xfoo3 &&
>      #               git add --chmod=-x xfoo3 &&
>      #               test_mode_in_index 100644 xfoo3
>      #
> 

That's strange.  The two changes don't seem to be related at all:

  diff --git a/t/t3700-add.sh b/t/t3700-add.sh
  index f3a4b4a913..06e3835efb 100755
  --- a/t/t3700-add.sh
  +++ b/t/t3700-add.sh
  @@ -331,9 +331,8 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
          test_i18ncmp expect.err actual.err
   '
  
  -test_expect_success 'git add empty string should invoke warning' '
  -       git add "" 2>output &&
  -       test_i18ngrep "warning: empty strings" output
  +test_expect_success 'git add empty string should fail' '
  +       test_must_fail git add ""
   '
  
   test_expect_success 'git add --chmod=[+-]x stages correctly' '
  @@ -355,7 +354,7 @@ test_expect_success POSIXPERM,SYMLINKS 'git add --chmod=+x with symlinks' '
   '
  
   test_expect_success 'git add --chmod=[+-]x changes index with already added file' '
  -       rm -f foo3 xfoo3 &&
  +       git reset --hard &&
          echo foo >foo3 &&
          git add foo3 &&
          git add --chmod=+x foo3 &&

The only difference I can see being introduced with the first change
is that the file "output" is gone now.

Does it help to add the "rm -f foo3 xfoo3 &&" back, in addition to
the "git reset --hard"?

Thanks,
René
