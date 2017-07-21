Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A65E20288
	for <e@80x24.org>; Fri, 21 Jul 2017 17:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752811AbdGURgD (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 13:36:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:56224 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751996AbdGURfD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 13:35:03 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M1RHp-1dssbU3Ku1-00tQeA for <git@vger.kernel.org>; Fri, 21 Jul 2017 19:35:02
 +0200
Received: by mail-oi0-f53.google.com with SMTP id q4so57554581oif.1
        for <git@vger.kernel.org>; Fri, 21 Jul 2017 10:35:01 -0700 (PDT)
X-Gm-Message-State: AIVw1122HygYicXbFbgx5R5D6ylppzYA7a95Z7/Cu5QVMyiNp3/kV4C2
        YY6EJwgWd2mX+JCb/x6rxl9v/4GWbw==
X-Received: by 10.202.239.131 with SMTP id n125mr2685175oih.98.1500658500505;
 Fri, 21 Jul 2017 10:35:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.20.238 with HTTP; Fri, 21 Jul 2017 10:35:00 -0700 (PDT)
In-Reply-To: <xmqqfudpj1vo.fsf@gitster.mtv.corp.google.com>
References: <CAHNyMp8xeye8EvtOdrX34QVCDsBCu3aLQVdyGRTVqyHXjZ4FFQ@mail.gmail.com>
 <xmqqfudpj1vo.fsf@gitster.mtv.corp.google.com>
From:   Uwe Hausbrand <uwe.hausbrand@gmx.de>
Date:   Fri, 21 Jul 2017 19:35:00 +0200
X-Gmail-Original-Message-ID: <CAHNyMp-oXPDjQ1960mKiSdvvDZc5b85z2Cc9pRvs8QQSfprp=A@mail.gmail.com>
Message-ID: <CAHNyMp-oXPDjQ1960mKiSdvvDZc5b85z2Cc9pRvs8QQSfprp=A@mail.gmail.com>
Subject: Re: fatal: bad numeric config value '60 days' for 'gc.rerereresolved':
 invalid unit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K0:gdHLYlXS1ERJ3QiuxKZpJAxto0q+L4MA1lzfzskN+S1QAaZKYBF
 XMNJaOKz8zO+l+lgBI1R3FvTP8Jfw2XnfKJHm8yz2YaCPqwmO/2MQZU7oCNNqYpoQ7sx5bT
 v1IbnaYNhvF/Sq4k6GNelaSiE15MCyZ6ghwF0RoN1yLb37kbHJGLt6J90jWPM03mu0s6UWT
 HcsfgRwRgZKaZIIpCd7eg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sf9n8CbCW08=:nq5QjKM72KK+JSmCko/zcZ
 f9+fOgj03D/iTo9ExLv1wHDnB1JaEhUWyKZJttw6SvMO4ylsDhZIe943A4MZSr5FoDPFAP2/I
 DRMM+ACIwT3h5DEtt/vU56zn2xW2vg/VsFz2s+LRKCOqJu/dMRvP7AJBi7mP+eWVJsWpFSAoR
 6zGtTbtKwclzgEcokVsSPv0BpvKxgwwCgl6eXWVDnFqjluuL3NCZIc2zhiZugvWxbidU0b6wM
 yVcx1qIJm8JYuWyKRYp3jqKDxM0Cs4adoQbi4Svri0MasTnXofKS05FVsZqKD886A6TexWMj9
 8Q+RVy/Sluw0wTmnne7Bt2Fu9DPmsT0rMr6s6vjy1hWXECr64vlSIOabWXFsAJT0ZDWeE2Nk4
 d1Sthw9Fd9G0hbW7BI1qGMvnGyTJBktNcDhyvn/kz2Kux231IGIco1z+fO0TdIXFLK2tiCPJK
 2ygnEHsqJZc55rRmhy6Xt5jsdmpjc0lPJXQg31u8XKRRqo0H9O9IRrzSy7g8/nUQXR5he0cTM
 1P6NBDCJ5eE2d/oTQ+kioQfVVZZBMAb8gka8ZbN8rK8VGW2bYP7pLpsuEAauPw1EpjKN9bb2a
 fWLIxBn5Km4xWktVsvzFCFuHilCJjzXqhLH64228VTOYhM79X6iuphQ0h0AtCwgkQoOud1ame
 V2gNYyOkjGtid5rmFHt8EgLma2w+yFa9M9Tf5ok4BaVWbOazF8WEdhemr0eHI36Zi08xrZh3c
 4sePyb6MILP5/9BdzUUF4+eFkaLfW3BQLQYrbXpCHw2suOMoSRC97CAFYaJdcwfFd5r6rssWB
 BjysI4gDfMOWvR325/8X8ebXkjjlPvtNWM+CmN9x8oj1dfPJ90=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yeah, after I checked the code I saw that this is interpreted as
integer and fixed my configuration

2017-07-21 16:33 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Uwe Hausbrand <uwe.hausbrand@gmx.de> writes:
>
>> seems like there is a bug with "git rerere gc" not understanding grace
>> periods like "60 days" defined in the config.
>>
>> What I did:
>>
>> git config gc.rerereresolved "60 days"
>
> Let's see how the variable is explained in the documentation.
>
>     gc.rerereResolved::
>             Records of conflicted merge you resolved earlier are
>             kept for this many days when 'git rerere gc' is run.
>             The default is 60 days.  See linkgit:git-rerere[1].
>
> Notice that "for this many days" tries to (and probably
> unsuccessfully) tell you that this variable is expected to be set to
> an integer [*1*], counted in "days".  IOW, you'd want "60" instead.
>
> Having said that, it may not be a bad idea to enumerate these
> "expected to be an integer that counts in some unit" variables that
> are described in a similar way (i.e. look for "this many" in
> Documentation/config.txt), and then for each of them that could be
> counted in different unit (e.g. it is not outrageously wrong to
> expect that you could specify that rerere records that are older
> than 3 months are expired):
>
>  - decide what kind of quantity the variable specifies (e.g. "this
>    many days" and "this many seconds" variables are giving a
>    "timeperiod").
>
>  - keep the code that reacts to an integer without any unit to
>    behave the same (e.g. "[gc] rerereresolved = 30" will keep
>    meaning "30 days");
>
>  - extend the code so that when the value given is not an integer,
>    it tries to parse it as a specification for the expected quantity
>    (e.g. "this many days" and "this many seconds" variables would
>    understand if you said "60 days" or "2 months")
>
>
> [Footnote]
>
>  *1* I think we actually expect a scaled integer whenever we expect
>      an integral value, so you probably could say "6k" to specify
>      "6,000 days"; "days" not being any of the recognised unit
>      suffix like k, M, G, etc. is where "invalid unit" comes from.
