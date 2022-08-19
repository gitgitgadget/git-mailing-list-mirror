Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3772DC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 11:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348664AbiHSLG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 07:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348653AbiHSLG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 07:06:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A89FAC5A
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 04:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660907168;
        bh=04o+3RUMs9he0tyOqMuM9fnVhjHJE1i2pe/rwg/cb7M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GroIf/q/c6F9TrUoVajJhXFXunjQzeGMaJjJV/qVqzEqazHsprFs/Aw1ym9PGOLju
         qjyhH/FciasrqZhpo7hMBNZ+wPNv1tVS/+18QEujcxmFgugzy8+zQOnz/SbS/xd3d8
         vX0uWBszP1s5ZunmmBRIX1p5MJE4bxXoBwrJLSOk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.212.11]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVNB1-1nwZ4Z1bOB-00SQqO; Fri, 19
 Aug 2022 13:06:08 +0200
Date:   Fri, 19 Aug 2022 13:06:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Subject: Re: js/bisect-in-c (was: What's cooking in git.git (Aug 2022, #06;
 Wed, 17))
In-Reply-To: <220818.86czcxafew.gmgdl@evledraar.gmail.com>
Message-ID: <285nq583-p3p0-q9q3-90s9-q2po503rsp0n@tzk.qr>
References: <xmqq7d36s31e.fsf@gitster.g> <220818.86czcxafew.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-725568224-1660907176=:241"
X-Provags-ID: V03:K1:ZTwv5FAHpxbIJWx4AqvqRFYyEKWNKeBCcq0HALQwQGZ10ZI/9N0
 Oxn6ajJcyAAi3u6QmZLVSAplnPxkNggOupjbeOiO+PeFrsxYGSJ+GiV8Db43ndZhKnzBIzE
 tZ08xn2L2YCj7c9s2j/TYRBXRG4nFNPI2U8B8hxXie80bi1iCRPu9F1GRoSlUIOPB3ybVQe
 K4kqhfv3cJ5tKlimvUxfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gmhQbofsYjU=:WE6E5eGou/3hUjRFPinR3q
 cV89BYEdgWT91NU96zdA/v+eW281Y4ckQmY2xicMa+AEF9S2/kdV68S0GqordOpL2IW41ubEb
 nic8yQXsYZ5yCpzstp17fwKn51mnDO3hQS/Gj83jZY0vb9oN5Ea9R+B3ZYVhXNMyHMEYABV+C
 DPbzlJ6rE6Tyq3DdYxdSf0UL0GyybsqjyCBVdtQ32BFkBgDKup8HSkdap8wRI4uu3NlN9M0/C
 WCi0j6d7lAyEg+5/ZDw/vu3bBBROXoinlSXkTd5YZRvMsv6R2H277fOIJsQV/S7pFW5jMkNmG
 GYSLvWF0DI6SCuBk8qVR+hrkuc8l41B2z6JqyuDSfMt4dN6z8RmL2uiQtUzFZ/FtxgtWDyZkh
 Q3YbMsFOsop+JrOTkI0d7DZI7VTL4PUOT7SOg57+bFvAiTbekt+sBDssSrHw4dRumjdNZri5Y
 N+4CYOx9ahtxZnvjmFYlT3bz5fJ8cwHznlqw1lTG8AiLoSnIoCEAWfWoCHuSqfCo1GevsA/wT
 i5h63fuFkWtyJJnEF9Qmk31uRS2KoeDVUmOsfv52UjMa22gRSXJgrefAEn7z8SHZP0Npu1iMf
 /fRlogp3uEm/EdPntZvRcxBKLG0O/IlGIDfFDL5N9TjXkKnpM+gl9dmlTG9bNdtFc40WHIeD7
 eoa0y5SLcml0SDpB7NtbCXkdIn/gps+NhnOgrrPREFMTMZN3FIbjF+matDAaf//YJkGdKq99h
 H1ownkhyXvnYi+89s4lyq/ncM+eFgitLzueyOibM/KGbI+0XQ21waOM4/qdKZ9+zKi5RozzVb
 nKQNNyA/4IdaaDJBWdy6zUG0BUOA1oFHhLKiYWXexG7Im1Q+13H1Twul4jqPr1MSirZYYgR3G
 YIuNVEi1mwb9SwJooNUG3iDwv8ndjaeczI54qQ2PMwGu/ypL9R98dXXRgel+5vvp+e3d4EzMW
 tqpK1QxwAWXFKZRzd20jMSiYJtDx1txquK0GBcwvfD1BvDpG9+EMH3BHLkvXgA0oecHdz39jJ
 1V5QI5SeEeoIFrrgl4rdCcjdtcC/aeYqVeF80WwFpvALr4qUfoYGBUPiLgJKM5CUUG87678ej
 k9zJU1REPobtN6y+8asevti0LUvalJZMDqgTmjc/yJKWAGr3FP9WJj+mA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-725568224-1660907176=:241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 18 Aug 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Aug 17 2022, Junio C Hamano wrote:
>
> > * js/bisect-in-c (2022-06-27) 16 commits
> >  - bisect: no longer try to clean up left-over `.git/head-name` files
> >  - bisect: remove Cogito-related code
> >  - Turn `git bisect` into a full built-in
> >  - bisect: move even the command-line parsing to `bisect--helper`
> >  - bisect: teach the `bisect--helper` command to show the correct usag=
e strings
> >  - bisect--helper: return only correct exit codes in `cmd_*()`
> >  - bisect--helper: move the `BISECT_STATE` case to the end
> >  - bisect--helper: make `--bisect-state` optional
> >  - bisect--helper: align the sub-command order with git-bisect.sh
> >  - bisect--helper: using `--bisect-state` without an argument is a bug
> >  - bisect--helper: really retire `--bisect-autostart`
> >  - bisect--helper: really retire --bisect-next-check
> >  - bisect--helper: retire the --no-log option
> >  - bisect: avoid double-quoting when printing the failed command
> >  - bisect run: fix the error message
> >  - bisect: verify that a bogus option won't try to start a bisection
> >
> >  Final bits of "git bisect.sh" have been rewritten in C.
> >
> >  Expecting a (hopefully final) reroll.
> >  cf. <20627.86ilolhnnn.gmgdl@evledraar.gmail.com>
>
> The msgid here is typo'd, the correct one is
> https://lore.kernel.org/git/220627.86ilolhnnn.gmgdl@evledraar.gmail.com/
> (i.e. a "2" is missing from the front).
>
> The more recent
> https://lore.kernel.org/git/220817.86pmgzabv0.gmgdl@evledraar.gmail.com/
> also has some more follow-up, and a proposed fix-up for one of the
> issues I noted with the series (the completion helper interaction with
> the new "bisect").

So now we should also include changes for the completion into this patch
series? Are you serious?

Ciao,
Johannes

--8323328-725568224-1660907176=:241--
