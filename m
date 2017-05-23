Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0283A20281
	for <e@80x24.org>; Tue, 23 May 2017 19:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965874AbdEWTiH (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:38:07 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33051 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965180AbdEWTiG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:38:06 -0400
Received: by mail-pf0-f179.google.com with SMTP id e193so124051749pfh.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=isWP/sCaGjP9tAFS3KH0G7sudMZy/yqVTVU1f5KeY30=;
        b=elBJBexSZsL87gMmJraTSWCknrxc4gDSco8+gfFNK/8VeCMhK0qeXsU3+hDl4bwCM+
         6woMeSz2NTYJH6gmhwGqcntQb+8BfWBdJj8gzI2oVcrVmTlaGSdmQo/qwzFYOAEKjFIp
         Qo04etx82HlYnjgF7dwWt51R00WOcAfMhGLGUDQou89JmWqJ6fLCZVN34RsppzSdWL3e
         XLg5rbhm3pjJ4h/NjaenGwaNjEG8LUZvepwzs8eQX6EAgFyybZ7F7IRbry49j75QNn67
         peTIt8AxiU00HlX/4ng17ItMgu0eZQYh8hTTNQ6vZ9IM4HmeMD+0lDEwacT23cy2aFcE
         PTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=isWP/sCaGjP9tAFS3KH0G7sudMZy/yqVTVU1f5KeY30=;
        b=nzOuZxehjCZW0E0lRJXnKpogWPLKdHikImbFwEVVkrLCmOWDhlViA6xHFWUtS2+FC2
         1nI+IdR3uagzMuUhw+SxX7/mXcBm88OPKcuRrF93J8gr+m1h0dUJfKLeZJMNVj55h7+V
         ef8d1OHCe3W++DouRGLtMQnQQcSy0iTY3POrUZN8VhgpUGxFI5Cy7L7L+A8LbUxBxiZV
         Hi1ia9Iolsk03db1C67sC00iJTNuqDcsA/lSP5KgA/XC1f5WlZ8kx4M/XkpQw0UK3F2P
         aa7GkSp62j2MvNaJGQ89fJToTwdrr/xUAZka/ijmocD3HYBUADjwWD7/tF6ekG4jwqV8
         Buzw==
X-Gm-Message-State: AODbwcDdKZKHWSP+WPF2XMYj58iMwuS180Vh9oQtp7W2wTTc82wHZYYi
        02XsNvshQku+BurtK/e/X8hDMFr8Iksx
X-Received: by 10.98.205.65 with SMTP id o62mr33400784pfg.105.1495568285189;
 Tue, 23 May 2017 12:38:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 23 May 2017 12:38:04 -0700 (PDT)
In-Reply-To: <CAGZ79kZMJP7K5MU0UujuEatZ2MOrSnFpfD707aSGa64mKyCZbw@mail.gmail.com>
References: <xmqqwp98j8q2.fsf@gitster.mtv.corp.google.com> <CAGZ79kZMJP7K5MU0UujuEatZ2MOrSnFpfD707aSGa64mKyCZbw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 23 May 2017 12:38:04 -0700
Message-ID: <CAGZ79kYoHYz6hi5kDjQBcN-35c0kXE6mf6NNV_Z_F6-UqZ=3cw@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #07; Tue, 23)
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2017 at 12:08 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, May 23, 2017 at 1:08 AM, Junio C Hamano <gitster@pobox.com> wrote=
:
>
>> * sb/submodule-blanket-recursive (2017-05-23) 6 commits
>>  . builtin/push.c: respect 'submodule.recurse' option
>>  . builtin/grep.c: respect 'submodule.recurse' option
>>  . builtin/fetch.c: respect 'submodule.recurse' option
>>  . Introduce submodule.recurse option for worktree manipulators
>>  . submodule test invocation: only pass additional arguments
>>  . submodule.c: add has_submodules to check if we have any submodules
>>  (this branch uses sb/reset-recurse-submodules.)
>>
>>  A new configuration variable "submodule.recurse" can be set to true
>>  to force various commands run at the top-level superproject to
>>  behave as if they were invoked with the "--recurse-submodules"
>>  option.
>>
>>  Seems to break t7814 when merged to 'pu'.
>
> I will investigate! (It passes on its own, so I guess it is some
> interference with a recent grep series)

And the winner is 5d52a30eda (grep: amend submodule recursion
test for regex engine testing, 2017-05-20, by =C3=86var)

The tests added by grep rely on the old content of
test 2 'grep correctly finds patterns in a submodule'.

The (whitespace broken) diff below fixes it.
I think the best way forward is that my series relies on
that series as a foundation then, and writes correct tests based
on the file contents at that version.

---8<---
diff --git a/t/t7814-grep-recurse-submodules.sh
b/t/t7814-grep-recurse-submodules.sh
index 14eeb54b4b..ce9fbbc1f6 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -36,18 +36,18 @@ test_expect_success 'grep correctly finds patterns
in a submodule' '
 test_expect_success 'grep finds patterns in a submodule via config' '
        test_config submodule.recurse true &&
        # expect from previous test
-       git grep -e "bar" >actual &&
+       git grep -e3 >actual &&
        test_cmp expect actual
 '

 test_expect_success 'grep --no-recurse-submodules overrides config' '
        test_config submodule.recurse true &&
        cat >expect <<-\EOF &&
-       a:foobar
-       b/b:bar
+       a:(1|2)d(3|4)
+       b/b:(3|4)
        EOF

-       git grep -e "bar" --no-recurse-submodules >actual &&
+       git grep -e4 --no-recurse-submodules >actual &&
        test_cmp expect actual
 '

---8<---

Thanks,
Stefan
