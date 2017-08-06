Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01C9120899
	for <e@80x24.org>; Sun,  6 Aug 2017 05:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbdHFFfu (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Aug 2017 01:35:50 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34596 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbdHFFft (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2017 01:35:49 -0400
Received: by mail-oi0-f42.google.com with SMTP id x3so43849253oia.1
        for <git@vger.kernel.org>; Sat, 05 Aug 2017 22:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DhLIZC8kinAgavs1121R5n44VQf7YP9AAW2eaRsotsw=;
        b=0q+3KQ8EbNKnhAJ2AQF9wesMhDFQ1n5uOGmbCtfD8yq0Km5mXUv4dymMrS2wfO4vW3
         AFPDv/agzRwadOSON9Is+YpG8ltJyV0fVtBR4ViacV4VZspo7htFCt/tGU6NUtpzFe/K
         Clv6FDCimjn//v41LPjt0ULLWvNfmwmwrSxfdVslfWi1iPgLFprZb23bk58jIa/wGFjV
         nwyG1acI6UfjiW5pmcoAOROpKkb4D4YAaeKtLmC37qDDN6MCdcAvwYE/l4QVdOedhL5Z
         SQtUQkO17c/3B8wAndS84niam09YdnKkf2KYPKnrDWaUgbdGRIzwIB2cVdtoADUmrjWb
         LZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DhLIZC8kinAgavs1121R5n44VQf7YP9AAW2eaRsotsw=;
        b=V+o3ebVEcgamGpIfHBzjQ4Kl69uBlfkDxYEFjK0FB6CREVntJeDiBhrXbO0wKDmkbx
         NT/jpEjUye+MqpewKDhclQ3/QYvOn0nwc/eQnN+apISGgXhiARKkS+juD+Ap0Chvjsnt
         6RLPhxJx4PWycjHcEmS9dF1KDxK7/Jn/n9e5sshW8flwIRl0FZEvZrSV1fojK88VGpfm
         Umgqq80d38EjQf1909zuPLXX2LbEp/dXeKyVDYZ8fYMW9V3bCuaNXm+vEqWXgIF9vk67
         N1Dtuc+FCNm21w2tVeCHOhXXQSNirGbP16WNLFMBulaVJNjUej+goKoc6zp81TWcBJK2
         tXYw==
X-Gm-Message-State: AHYfb5hrSvz+6fOYd1t/XK+TAbySGgZeHIdS2noUi4l82jHHoz38pmdB
        xjYaZTGPRjmxSfkNDVdjJh/HCzplMura
X-Received: by 10.202.225.67 with SMTP id y64mr5508578oig.159.1501997748273;
 Sat, 05 Aug 2017 22:35:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.139.81 with HTTP; Sat, 5 Aug 2017 22:35:47 -0700 (PDT)
X-Originating-IP: [2601:647:5100:4a0:8a6:e1ff:fe64:a87d]
In-Reply-To: <xmqqh8xlsiaq.fsf@gitster.mtv.corp.google.com>
References: <20170805064905.5948-1-mforney@mforney.org> <xmqqlgmxskm6.fsf@gitster.mtv.corp.google.com>
 <CAGw6cBtKF-Xt4z3m4gBDQvaSnurbtHURe737s8XMX78ca_RTcA@mail.gmail.com> <xmqqh8xlsiaq.fsf@gitster.mtv.corp.google.com>
From:   Michael Forney <mforney@mforney.org>
Date:   Sat, 5 Aug 2017 22:35:47 -0700
Message-ID: <CAGw6cBsYiGH1h8C8qFp-yX3arzkaRi_vghpjbErxjoYHXxpu+Q@mail.gmail.com>
Subject: Re: [PATCH] Drop some dashes from built-in invocations in scripts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/5/17, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Forney <mforney@mforney.org> writes:
>> On 8/5/17, Junio C Hamano <gitster@pobox.com> wrote:
>>> Have you made sure that all of these scripts, before calling
>>> 'git-foo' in the current code, update their PATH so that these found
>>> in the bog standard place (i.e. GIT_EXEC_PATH)?
>>>
>>> The reason I ask is because we can rest assured these changes will
>>> be a no-regression improvement if you did so.  I do not offhand
>>> think of a reason why these scripts wouldn't be doing so, but it
>>> never hurts to make sure.
>>
>> I just checked and all the scripts make some other call to a built-in
>> with `git foo`, so I think it should be safe.
>
> As long as they are the same "foo"'s, then the check you did is
> perfectly fine.  The (unlikely I would think) case that can lead to
> a regression is if these script deliberately used `git-foo` to find
> them on $PATH, which can be different from 'git foo' that is found
> by 'git' in its own binary (as all of them are built-ins), and that
> is why I asked.

Ah. Well, it looks like all but git-merge-resolve.sh run `.
git-sh-setup`, so we know that GIT_EXEC_PATH must in their PATH (and
at the front unless the script was invoked directly).

git-merge-resolve.sh does not do this, so I suppose if the user ran
$GIT_EXEC_PATH/git-merge-resolve directly, and also had a custom
git-merge-index executable in their PATH, that would switch to running
the git merge-index built-in instead.
