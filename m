Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FA5D20954
	for <e@80x24.org>; Mon,  4 Dec 2017 14:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753092AbdLDOSc (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 09:18:32 -0500
Received: from mout.gmx.net ([212.227.15.18]:54678 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752861AbdLDOS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 09:18:29 -0500
Received: from virtualbox ([95.208.58.62]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MOfcU-1ePhae2cha-0065m8; Mon, 04
 Dec 2017 15:18:26 +0100
Date:   Mon, 4 Dec 2017 15:18:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Robert Abel <rabel@robertabel.eu>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] git-prompt: fix reading files with windows line
 endings
In-Reply-To: <20171201233133.30011-2-rabel@robertabel.eu>
Message-ID: <alpine.DEB.2.21.1.1712041516280.98586@virtualbox>
References: <alpine.DEB.2.21.1.1712011143320.98586@virtualbox> <20171201233133.30011-1-rabel@robertabel.eu> <20171201233133.30011-2-rabel@robertabel.eu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-577289559-1512397106=:98586"
X-Provags-ID: V03:K0:4JVs5iWvhRqaq+SOXYeG1ix/F7fYsw13DAbZfcyUO2FbZJwT2p6
 rcCud6zUs7AhrE+qcrhbpLY5tV0VU65ADgK33+//3f5HVLz9i53r9nB5NV1RJquu9STtfhh
 o33cLzZ3+oAZfEdrqNCjL5VIlgD639ME6ByXzI+wv4fc2JIc/DtRnQ5n6UUK6I0tUBJVWx4
 u0RNVF3x1wS+SIme/2KAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5/v+e76Xl+k=:ROoHjr57cZRvEKs8WNNfbr
 vJBQ9QKU5B+sfwv5TdF0OTBpiy1U8RNX/ZdYNx9Wjem/roGKjFTNUDcSdjM2lCYgx7KMn5Jhm
 iEae6VXHD8TRYO6KLYPrz/dAlQjODceDcbpLvEkk1ewxDVzPm9SznzuMC+afyjDXy/N3TsoO8
 MIXZdHYNWDlbRUVWEblP+gv8bRdTOVtrD9rFffhoti242VYfO54OwioaGNFu/SuVxHwPfcJKt
 dT1s96ldZLY87V6sHfJKPOKzn7OJpgQUyvrTvyUo/4NGpGuSLNbk+WBhkFmdmEGssEl/6Y8bV
 p+j2JYmWuBlwfrAtQqMy52TRte5SYvu/4+DeJmOfIYIQJJMaSiETINDd0x8CE045FQUCY0l94
 jlonWFfSSsSAWxmgpkhjNDN711CxcPLek0z95jImIg+7VvLmIxw3t/0k86CFhlXNfKHg0QGcP
 nXA0qz9cLzEaZM8THSyUDBfw8qF3x+GS3WgDxemMQIWCrmkxkTltxLcwn9QdNKiFE67hBVhfR
 6CkGTBBhb0Wq4+jfEf07l4n5MAw3do+8ZvAwALK5z3j6LzR5/aeZAkQLSv8B7R2Xgg99TBUpl
 Au6g8jYa6EF5ydJxnq6hgYFhfNG5qlDFDYXcQ30SyzcQI57Ov2D2oYt2AglUA/C01feBGSbCO
 Z716pZZbIFLHpGzcyYE7NC4i3RwLZAdikmLzxaeNFcWxgtcxIOOJI2lMd4vjq0uAPll1sU44r
 GLJzMCBgguJdf4lJHvLCq5uxPb7xoAmvNo9h+2AU4mmGaROmVJjjwVmtiFPy1BMHS/xoVS1y7
 7vaoi4xrYCNmYkrMZTnjvWLMz4iS4H3Iy06orDZB93xKdv8tkk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-577289559-1512397106=:98586
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Robert,

1/2 looks very good.

On Sat, 2 Dec 2017, Robert Abel wrote:

> If any of the files read by __git_eread have \r\n line endings, read
> will only strip \n, leaving \r. This results in an ugly prompt, where
> instead of
>=20
>     user@pc MINGW64 /path/to/repo (BARE:master)
>=20
> the last parenthesis is printed over the beginning of the prompt like
>=20
>     )ser@pc MINGW64 /path/to/repo (BARE:master

Maybe mention explicitly what Gab=C3=B3r said about $'...' being supported =
by
Bash and zsh, the only two intended users of git-prompt.sh (and there
being precedent of that construct being used already e.g. in __git_ps1)?

Other than that, this looks very good to me.

Thanks,
Johannes
--8323329-577289559-1512397106=:98586--
