Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B860C203F3
	for <e@80x24.org>; Sat, 22 Jul 2017 00:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753509AbdGVAnV (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 20:43:21 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:33750 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbdGVAnT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 20:43:19 -0400
Received: by mail-qt0-f175.google.com with SMTP id n42so48601448qtn.0
        for <git@vger.kernel.org>; Fri, 21 Jul 2017 17:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JqqB3QipHYv1JD0n0YmNhySasMZ7F36HuXc5qNcH/uA=;
        b=LlejDhq+UXUcyaIS024lT+zZlDWX2/0FlcmxOKF1Rf5cPUsq27aUw1a6+c8mXD/IrK
         cCFkzzZiwgJMyHpSXx6btc9Z8ZWIWWz+7XPOBCwQt48WvwTv7Zd5JaIfucQL92A4P1Nq
         BdksvU1/x4RQ0GHV/Sqaap0AdraY2OmhuUkJx0rvyN/I0JsT6ZmiXMLGiIqG9Jv3Z75a
         TZK6n4mknD1lKolMWnatXjzrY3TP2kY3rP8VfatbfOQjkrAB0Oj79zIB+qSUxDgJ1/Hw
         JXL2Tep7XkjyWRFD3gIN/H2NJViwMHZkB5wApvnniq8gWMwAqjSD/bqouDj+2K3xLQ0S
         Ymyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JqqB3QipHYv1JD0n0YmNhySasMZ7F36HuXc5qNcH/uA=;
        b=VHXtzIL46u2lfM8QP3k2DmkFMNBWANZx8eaXkJ7gYgRCoJl6/ISTy3FzRYnfuwBhY2
         OnKDIkskhkf8AfxODrJ6IacfgOdEimpMz3tjMdYybUgIr3reZy4mMciOqEK8Pt17ELGY
         JcmpYPEb9HO7S2Lj5cuT3Sb12prjQu+hGuM8+NHbOU3rxiHENVJh18Z6Wr03ZhT2zIyA
         IVk/47R3CU/dHFivgCBRZDHya/GAI7X5QEPzyl5rT8D+XbrNdXxjv5CLhN50grYVtb+M
         cfaBKfyx/ryahFyxYZ63SZCtic92JYp+6SCBMgIbx9AIeB3nY9de+a92wOVLnpmUCiAH
         fWUw==
X-Gm-Message-State: AIVw110iYhxFnr2+vHb7JCw8mQgXG0h5bmBB4iL8luzFEDq0r3aUxDOR
        duf7JkegvalN5jwUyikJhNtMyUACdg==
X-Received: by 10.237.56.135 with SMTP id k7mr11634633qte.134.1500684198950;
 Fri, 21 Jul 2017 17:43:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.193.38 with HTTP; Fri, 21 Jul 2017 17:43:18 -0700 (PDT)
In-Reply-To: <xmqqr2x9fjpi.fsf@gitster.mtv.corp.google.com>
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr> <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
 <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com> <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
 <xmqq60epfy27.fsf@gitster.mtv.corp.google.com> <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1707191456010.4193@virtualbox> <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com>
 <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com> <CANYiYbGSaaFOq7iw=ON1Oo87bSA96o=zyzym5RDT32kMae7bsw@mail.gmail.com>
 <xmqqvamlfm6s.fsf@gitster.mtv.corp.google.com> <CANYiYbF+XDANNbpZJ-jL7y81QhggW_snBuWeONSCUc4CPn2zMw@mail.gmail.com>
 <xmqqr2x9fjpi.fsf@gitster.mtv.corp.google.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 22 Jul 2017 08:43:18 +0800
Message-ID: <CANYiYbGkuGNNYn4OF5w=1+Pqn9hEHWcD+DYVB6AXRs0vFEsY2Q@mail.gmail.com>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-07-22 7:34 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> A very small hack on gettext.  When extract l10n messages to pot file
>> with `xgettext`, will grep "PRItime", and do "sed s/PRItime/PRIuMAX"
>> inside `xgettext`.
>>
>> See this patch:
>> https://github.com/jiangxin/gettext/commit/b0a726431c93b5a1ca0fe749de376b0752e75fb0
>> ...
>>      gettext-tools/src/x-c.c      | 17 ++++++++++++++++-
>>      gettext-tools/src/xgettext.c |  2 +-
>>      2 files changed, 17 insertions(+), 2 deletions(-)
>
> I do not think the size of the "hack" is much of an issue.  There is
> no way you can sell this patch to the upstream, which would mean
> that we would have to be relying on our own private edition of the
> external tool, and that is what I feel very uncomfortable about.

I never think about that, and I won't sell it to the upstream. ;)

> You are not passing %<PRItime> through the toolchain and instead
> turning it into %<PRIuMAX>, which is less risky than the obvious
> alternative, but when we switch to a signed timestamp_t type and
> need to change it something else (e.g.  PRIdMAX), you'd need to make
> sure you update that private edition that matches the source being
> compiled.

That's why I grep "PRItime to PRIuMAX" from `xgettext --version`.
When we need something else, we can tweak the "check-xgettext" task
again in Makefile, to match with a grep-"PRItime to PRIdMAX" version
of `xgettext`.

>  You might even be asked to do the po/git.pot thing for
> both 'maint' and 'master' at the same time, when the former still
> uses unsigned timestamp_t while the latter switched to signed one,
> which would mean you'd need two hacked versions of gettext handy and
> choose the "right" one.

But it is rare to maintain po/git.pot file for 'maint' branch.  And if
I need, I will switch to a different version of gettext.  Makefile
will throw a error message, if I use a wrong version of gettext.

> Compared to that, Dscho's "hack" at least ties what PRItime is
> replaced with and what the source code says by being in the
> Makefile, which is tracked alongside the rest of the source.  So I
> somehow feel that the approach has smaller chance of going wrong.

Benefit of using the tweak version of gettext:

1. `make pot` can be run in a tar extract directory (without git controlled).
2. do not need to run `git reset --hard`.
3.  it's quick (nobody cares).

-- 
Jiang Xin
