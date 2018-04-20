Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BA151F404
	for <e@80x24.org>; Fri, 20 Apr 2018 21:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeDTVGF (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 17:06:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:41745 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752144AbeDTVGE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 17:06:04 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MT74k-1f1LEn26cg-00S8in; Fri, 20
 Apr 2018 23:05:59 +0200
Date:   Fri, 20 Apr 2018 23:05:42 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] rebase -i: demonstrate bug with fixup!/squash! commit
 messages
In-Reply-To: <CAGZ79kbQCQPx01uFacxMWLdfJurn4jVcc+nvdnWHNVJNE3resw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804202304210.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524226637.git.johannes.schindelin@gmx.de> <ad2a1b2c60341d692e94b1cb997df05dd7cded88.1524226637.git.johannes.schindelin@gmx.de> <CAGZ79kZONQ_xuDYJ5Z8cUnF0odwz3+Sh+ST6g+5Tefav-QXEBw@mail.gmail.com> <nycvar.QRO.7.76.6.1804202149260.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CAGZ79kbQCQPx01uFacxMWLdfJurn4jVcc+nvdnWHNVJNE3resw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pMc2xUn1/5U3V2ny+52VE/uEl55hU9qt4w1d5I6/GjTA/FjSxJy
 YOr8PvGmy5Gy5pVvUjvrAzkb9FyyQMnZ6kz62psztFVPNldScCRWSWgX9NINvk7blGg/PGc
 QRioeNh6Ah8izT1ssaY7Hd6Bx0yQqcQW+fMxWRI/hAciXhWUTyfPi2opxaQXSyXKuCuGrYN
 rBSrJhP41mvtGoJsIqhtw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6R8s+t1Jl7c=:dvH3SlWoG4ObxKhBgvFwcK
 F/IUfwDhP1Lq6GH0pgAmtphJwb2bpKdHMOJeL2dNHsIo12rXrHErjSeqnDKEB7AM5Xw7ZNN2e
 nmz0vvo4f3GfjiiWJs02eOL2bo0jl4xWhfSG0C8qMz4TIki8sSlrEPCL2Y0ats7Ir5xW5Gktr
 VjvjzfUmRd7Mi4kyPdewLPEfqmV2fTjO9TmTat9lbOgMZ2rxZy188j3v3krfV4yUioJ9IbCEi
 VPHgEIg98WNqNYCQ4dfgjjywGOtXD6qnpOOsCW/Vo4RYPEi2qaDnB/TpXYF6vqzkMkU0f5HD0
 c6ggzvI3gQPwR3tRwg7H3t/m/UoU1NunvQpku+Yq6Ke/hAHcHMjoblOXqj/Cn7bLSVrbD1G+P
 O/de3NBednR4NNeaqO9ehxZfoS42JwQ8V/8EWQwcwzjYFN09jH+TP3METDUsAcigzlYOH1Lgl
 WkPHEHqMZaLsolgCoUOABCENsPYFcCDGJRa/tg4tRsCM1bsTSxF60FFwoGrRSLHGO9h78HkFJ
 n/9ekts7x4XiVv7+Sm3WdUZPCU6FGUm4s6F/xb2thdsExDIyXER1j+7cGOjUudMwQ7EJwDQ/J
 cs6mfF3ymYSAGk2FYRCCXiBCWbU4VA6sH2kGfmZipqSlYgWngFaHoqnLYQwiQcaJu3QaE3/Kt
 6a+GMt+C6K4qNAkpPLp32yoaLV8ZX0UbkwMO1vmCjpaiSeffsRleZT/VC0LcmnO117FFjccU5
 ljpBI35Gne+YEGahjijqBOL9M4FBbVqzbqKXjfwUITSMS/d/CEOzV+q2VrMsuo71GiPxAR8sO
 zu6uKEno/DQQ3Jytf0/c5CfDPsiMLhlyMvqkcfNseDVto/4C8s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 20 Apr 2018, Stefan Beller wrote:

> > Funny thing is: I tested this with GETTEXT_POISON=1, and it succeeded.
> 
> I actually wanted to review the code leading to this commit, and to find
> where to start reviewing I had 'git grep "This is a combination of"' which
> lead me to the translation files.

Heh...

> s/grep/test_i18ngrep/ doesn't work as the syntax is slightly off,
> s/ ! grep/ test_i18n_grep !/ would work, just pointing out the obvious.

Yes, I actually knew that, but my usage of a s/// as a shorthand for the
idea to replace `grep` with `test_i18ngrep` was indeed misleading. Sorry
about that, and thank you for helping me getting this right.

Ciao,
Dscho
