Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935FF1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 22:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfJ3WDM (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 18:03:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:48903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfJ3WDM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 18:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572472985;
        bh=QOl4UssdArOE0OGA5ejoTILcUFsOOkRJmgtGuYK3rAw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NxL0aj4ZtSs+CcFxWru+U4XCyu+D4LRyacBylh0zwBcIDnzLubQysQPM357mr4Bwb
         12aRuaNL5b9KgIgOfTu4izahiaXokiHB5oJVwPhVD74No5zVW3vxThljmbXIwx2KIW
         jdfsOifRkhDCQujcljqJzzhsWcy7yiaMmsrWZRTU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQv8n-1ie3MF3bvD-00NyhA; Wed, 30
 Oct 2019 23:03:04 +0100
Date:   Wed, 30 Oct 2019 23:02:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-diff.txt: document return code of `--no-index`
In-Reply-To: <4548d037-3fc5-b625-b7f9-646392392d0c@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910302302060.46@tvgsbejvaqbjf.bet>
References: <3f6d132663cacde01df68bfe88c6ef108cf6cf74.1572337045.git.liu.denton@gmail.com> <ed9f16c30a0f3852abaf0053d8c2b4a0ecd12f01.1572367897.git.liu.denton@gmail.com> <4548d037-3fc5-b625-b7f9-646392392d0c@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:z1n9mv/ie6Dl0XKUScUQbscoTo3CK6RGXr4h+aifrHUPFUK2sFY
 D9EThk1Eue777nd6n8nm50sdoL1bZ53P0stpClaTQfM3y63wdKrpqB2tjxvV19kidD5FwYq
 JyCbxa7pSyuaAAvEAxBwSDQCTahxGp/6FkRkTDSWSjJfsu427Gl4lN2x21tYB3XR1uenRMx
 yivuWIs+PMzMW4HVIbEJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N3RXXOFUTD0=:Gz1/wSPJAC9nhZXWvLKjGk
 Ajurn2gV3FzGYO5CWSbeUtVfCH8cGIgArlOkSvN/y+PXBmaEwBChCA2kKNinfVRNE0LcH+18y
 ipyx8p5D0WNVnmW6FFHl/Xelgvx290FZ+q712c7V07NTUxK/bSOOyW/bJDPEnIyIDw6/G+2GY
 ZXrc1JBYbrXRMTsJSVLd1rk4E9uKtdcHOstWVoRlMBnQqya6DTp79YzfscbtkdXhd4ZqX5knp
 5Eytr1kRsvAaC+VCznIQq3Uc7MOgnwvMer5jAxHUc3lzmVsnRLbakOYfKtMIRDoran9EReuFw
 7alDUL3KbRZPhgakfsoAx+tPnUAnE8vOMx9pk7x181H7JfzUklw7kwe594oUecQX52ZrdvyiE
 iPCEt48jVAgydmMJJgm0gQVXFWopK+vvZZPSjs3FW8TMOzNP8C2pR0KHz8ZX4v7dgW76AatYR
 15w6xVnglFy/YPDSuiWKWIB7HX5zO+Og7KG+DqSG+oP0BtqnwmhcbIA2RjBo975UP3fwJ/S6Q
 gi0Xc51fLX3mmfPyNq4uzh/HZQfZG5JpdK8tmFyh/fuyuJu8Klvf+zlwDMEciIiIaPxexat8k
 bC5uydi4zs4Z+mBvt2RNv2b6bwbi7dJcTxz1rxvt9QYVkhCVQAPHy7pu1sW5SZtLxu8J+8yiW
 i99pwYWF/Oxb2RlKp1l2YuIZrkSl9lhd+1arK54iv3xAiq/QnvITTCqNMqkrZXSNfuaXiQi+t
 dHiimPZS8oXRosvY0ekX3vp2GR4Lk0xpQ87mPSzOLHLLQLs9GyDsE3U4uS818kt//jSgd5lgg
 iggAIjf3rHVBiSosR89mRFVJ28p/jV7EkEpSQbyS7PQvdlGZM/WqW08r4S/pFohWVuiQmPHOz
 F7Ci6f0W5QzmUbiKuUG1wmY2cmCbL3u+22OiAA1rJRw7e10f6SwGglO9wohbppaET9wcnZLwj
 kzYMi/AR7GcJ2a5bFD+wsWUGoAeTgxIV08ReKGo79MQggLecHGf7bNeDaiVfQ5QVm3stzmzuA
 zX2kV9PjdWNdJ5aRmK2/E736HjD1lQ3UYKqvegPDzGcYHIUlARUL6XBveXloYah/TjPI1h9uf
 XOL53BtSC8A8IfqH8IoZBzSXKT6gu1Vyf5y9F29xyQO8Sa8vRppL/ceh2bjd22fnUKx5Aep59
 g05oae+J6SZVhJGtJWbQ496LHQGPijHPChfnJnwJhDaUj4SA8s2V0fPy5TH68naBWvljsT9nB
 dQMHPL+JJYiSXNYUOCbjbc4TY12vh9UOo3c/XCmHNN7e+R3kyU4CJrtfLrRM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 30 Oct 2019, Phillip Wood wrote:

> Hi Denton
>
> The description is good, but the patch has a typo
>
> On 29/10/2019 16:54, Denton Liu wrote:
> > Within diff_no_index(), we have the following:
> >
> >  revs->diffopt.flags.exit_with_status =3D 1;
> >
> >  ...
> >
> >  /*
> >   * The return code for --no-index imitates diff(1):
> >   * 0 =3D no changes, 1 =3D changes, else error
> >   */
> >  return diff_result_code(&revs->diffopt, 0);
> >
> > Which means when `git diff` is run in `--no-index` mode, `--exit-code`
> > is implied. However, the documentation for this is missing in
> > git-diff.txt.
> >
> > Add a note about how `--exit-code` is implied in the `--no-index`
> > documentation to cover this documentation blindspot.
> >
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> > Thanks for the review, Dscho. I guess it slipped my mind that we could
> > write it this way too. Oops!
> >
> >   Documentation/git-diff.txt | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> > index 72179d993c..56b396ef81 100644
> > --- a/Documentation/git-diff.txt
> > +++ b/Documentation/git-diff.txt
> > @@ -36,7 +36,7 @@ two blob objects, or changes between two files on di=
sk.
> >    running the command in a working tree controlled by Git and
> >    at least one of the paths points outside the working tree,
> >    or when running the command outside a working tree
> > -	controlled by Git.
> > +	controlled by Git. This form implies `--no-exit`.
>
> s/--no-exit/--exit-code/

Oh wow. Did I really type `--no-exit` when I meant `--exit-code`? I
guess I did. What a serious Freudian.

Thanks for pointing it out.

Ciao,
Dscho

>
> Best Wishes
>
> Phillip
>
> >
> >   'git diff' [<options>] --cached [<commit>] [--] [<path>...]::
> >
> >
>
