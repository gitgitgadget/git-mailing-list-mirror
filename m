Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A19A207B3
	for <e@80x24.org>; Fri,  5 May 2017 21:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbdEEV2j (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 17:28:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:59653 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751454AbdEEV2i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 17:28:38 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbJTE-1dNBCO2sdA-00Img9; Fri, 05
 May 2017 23:28:32 +0200
Date:   Fri, 5 May 2017 23:28:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Daniel Ferreira <bnmvco@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 1/3] diff: export diffstat interface
In-Reply-To: <1494009820-2090-2-git-send-email-bnmvco@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705052326520.146734@virtualbox>
References: <1494009820-2090-1-git-send-email-bnmvco@gmail.com> <1494009820-2090-2-git-send-email-bnmvco@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-751308592-1494019712=:146734"
X-Provags-ID: V03:K0:0TkxJWv7TrmuVdlpK+dpizWCyQogEfziLotoJyKVau1DKPgLMXw
 e3SocxT3GcrtPBm59eN6M2p8bHM7QHjXHd7MCmS+nfmJTABoVt4V8nLYHRy/7tTRspvy/Rk
 E0exaLjU2wdgCaq4fkIVutUnWZfG1QCYeBXYYPVhOp3cO2aqGFPf+5cwZO/etz9r3fSApwL
 7MEs+uf0E2+ocLLCqyyIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AOkAs/2NBIA=:5r3pVFx3jCko/d8UUDnSAX
 KzBhJKaQyH0kaF0GRSDOpuobD2YGSKqhlA1IQdoBf4XPtd7uAnnhzBZTiXu6VF1Eyj0GMk6O8
 5l9QK3QnjZcPDr+0O5sL+97ALXcxmX7KVhAKkhCFmFL8rcOy2say6/I8oGCq2ndU1KfeZ4+ab
 R7UJKRBFB1x8Qip2FD+o/V+SGzgbWydJ/BvKuUhrE5kO9XFdG68tox3AZKmZiwciUj3wjG3nJ
 ocAqh/E4S9Kt3MToEMsnSF5gp4gdLoIBzqGBQpMNszfz0F2F050npBzF59aDiTjP1Z6eLR7mZ
 TfMGgk522fjB6q5SFwdr3p2QVOLmxHFmlYzoN0HTppkIZG0+kXETibzpAcAyoPlokPFPyhe5N
 4NwPyAAIQpdsL7CXuvGvvNrHAqOPTehEEbflo/XuCG9wUWtCJxi8NThT6RMwaUeup6aoPJEZT
 dfldOB3D63EbJwhmXs2AK4W36PP8TeYzCBHXNMuZI4Bhk+c5Rb6p0QkVywNTmtcHKld8iflDv
 I1VuG1DbKVXpNTlIXL5+G0XO3j6qVB5uyYc8pEopHIZEIee3oXlKqs562FBqjFIJAPE92EBWP
 YNO/EOBXKX12Yt5DbahGYQd3itKfiQ0NNsgjMld5pNNOPzPsFKhv6kR0CeMQEcyPy652M82Gy
 SjaHU1c1p3N889y3PK6OVej+Iirjs0L3Qp+NcWhF1m71/gHy31wDJlMovZhcua+MGn9+Gu2Cc
 6msbDxzVCO9btV++PE5wB6t4SuN5Iog/QmjmUR+dl4OSZa2+bwTMJiOWVQDxQIgmp2t2SALkE
 MFlzvwL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-751308592-1494019712=:146734
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Daniel,

On Fri, 5 May 2017, Daniel Ferreira wrote:

> Make the diffstat interface (namely, the diffstat_t struct and
> diff_flush_stat) no longer be internal to diff.c and allow it to be used
> by other parts of git.
>=20
> This is helpful for code that may want to easily extract information
> from files using the diff machinery, while flushing it differently from
> how the show_* functions used by diff_flush() do it.
>=20
> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>

Maybe add one more paragraph with the motivation, i.e. the conversion of
add -i into a builtin?

The patch is straight-forward, and I do not even see any names that may
need to be adjusted for a more visible API than a file-local function.

> --=20
> 2.7.4 (Apple Git-66)

I guess I take my comment about =C3=86var's Git version back ;-)

Ciao,
Johannes
--8323329-751308592-1494019712=:146734--
