Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36FE202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 15:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754748AbdKAPdi (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 11:33:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:58784 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754266AbdKAPdg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 11:33:36 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lj4xG-1da22G3Igo-00dHc6; Wed, 01
 Nov 2017 16:33:30 +0100
Date:   Wed, 1 Nov 2017 16:33:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: factor out rewrite_file()
In-Reply-To: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
Message-ID: <alpine.DEB.2.21.1.1711011631490.6482@virtualbox>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-938305533-1509550410=:6482"
X-Provags-ID: V03:K0:3+ts9pnC82uSjvbhvMu13bJ6+gkGZdnlMqDeMlrVBn/89NODlBs
 7MwXHU4Cs8qDFUA9358nJolHx8lC/kfaOFFlBXSOJb9C3CaUeI51NCQu3Itfqv0JMJ22Qh8
 g+TOwEMNsc10L6GHOIfom2WD2ItTXCP14tmp+A0BpokL8pU9nDsLNLnJPNYSV2sso9TDZOw
 QBUkFwr+8AAYxjmjeaUvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WLvwrf/IunQ=:1/y+7HulvND7D/hTIif3sQ
 xaKgfRe8yhncoPoEz5zNfkyFWOEUS4i9bomr+B9yPyqQSHJMoYsbwHELv6GPZ2zMWuEnmMSeC
 2Uwh/P7DkmNlDoW3NBYtCeNGDVN2ox7qe/qNFiITS1ELo6sYbgWuDgTGHaPqsqqpi4GmaK/N+
 32dqQVZpaFes+TSDn6Kqwc85goAk3JrLQx/6Z3jICsWbGrghCB81bpLZ/+E4hRbjVltVwps7Z
 g+3eAlNwStJyDjtvQ8lsqkk2B6k2luHTljSkso43Xkf0JylVd4SK1qiuc+VcxyoFk4ROgr03D
 ptS1KhuxB02nc3cDQHdhGMm4kb45qPcoFu98u/RQoOQ0axoxxFqj9LvmBAqDuqxr5SeUrw/hu
 ChHLJ8NLCeyYBB2PPBomvLBA3cxl/HHpL5kYbJEXhGAw+4eDKPyEZySZEnKArTMB/cYw8yktm
 b586zkfw/RWgcYL5hQ1omNKihRG7vM4OPUK/uXMdzc0yMrQle9kwjZwyFDL2dYmOsy26X4psr
 1yfCc3jX/rAfkkBT0lK2X6hg7fxJfPaKtciayhlkVKC56Xr+s425Fs5rqee3ObqnbMH8x5dOx
 mxk6KTywtyaod2YjoodddPbYdWUBD2rh0M9FkV1lY6nLm/VSQgGfIaHL7GEGHr3jTBb+pJOA0
 /EfftG2Wh8nfk5rpGC+udy/OxHXqxK7Ym51r1OnJ2yDt7jthlV8ewVdBzBzVmwzmwmO2TV4DB
 v/eQFI0AiNhjkMNqRaymVk5xkvH1wcAxGScU6a3X1HMsSZL1rRbo8vPXwKJY8nO4ATU24ohNR
 iBI4Dx4t6FQOONRhTuy1jxSH2ftv1jocnjskX5QKQGSSl1v8OkbjTYi7cB05enaRDwm3q5C
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-938305533-1509550410=:6482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Tue, 31 Oct 2017, Ren=C3=A9 Scharfe wrote:

> Reduce code duplication by extracting a function for rewriting an
> existing file.

Fine by me. Thanks,
Dscho
--8323329-938305533-1509550410=:6482--
