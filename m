Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFD851F462
	for <e@80x24.org>; Mon, 17 Jun 2019 18:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfFQSGt (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 14:06:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:55259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbfFQSGs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 14:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560794800;
        bh=VwoKobJTPos32uRGgYehUOBl1vj/qqxXl6en86k01kw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EdXJJOkzDQaf3+flyBgy/Ef5GhCdb7MD7p8/9qQfO70BKe/RoyL243yxuLOeMrWRY
         ILqELoQZstb43aJprs1gw35klzmBNOzTVtJD+an3SS1Rz8siQTyI9ZHkTHcttgQGEo
         3GjHwayVxWcsOf8bwFlyEF4fUpSuhjPY74ZbIvbo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXtY-1i3IbA35E0-00QUth; Mon, 17
 Jun 2019 20:06:40 +0200
Date:   Mon, 17 Jun 2019 20:06:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     git@vger.kernel.org
Subject: pw/rebase-abort-clean-rewritten, was Re: What's cooking in git.git
 (Jun 2019, #04; Fri, 14)
In-Reply-To: <xmqqh88ruc1b.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1906172001490.44@tvgsbejvaqbjf.bet>
References: <xmqqh88ruc1b.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:O4OxveWjjW9d+p7FQsLANQbJ199C4HJ98leqAmFjnTaXsTJofsj
 KbjbGJU2UWMXO7SMCpKlAB1mDpWDpjq/gtXTJVKl9Xmacdr8tX7sb/RtC3Q6UQNPW1eMycS
 GdlVzu3uwb7yZZX85WavENWOLWxoqWNF5UnJD4UCmJe9zzKOIF642nSyA8e+AeUMVeZVG4a
 lo5U1Q2G0WBdBbV22+O8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cPGL2XvikpY=:UEAwyqyYFMaUGwW7vd64nK
 D+Ml+345Zm4GXuFy+ln/BjrwupiXZDNp4pv8lqyPIdqrz48DNSHMZuI77ywiCyC73VQv2P30g
 aHPqL0qYRH/EN5p7nFejTIwOPRR2/vjQnOv1d8jJpaWcY4onN/VgtD4zkSjtKi9u3bksOy48m
 2T9X/7t5Nf5NTCOcSgme13oiJba4V0RIrVa/2jSjj8mZ4Weist2TJZWT51XRa2QL07Lz7YWnu
 M2SA2HUcqAO649FvJaZLuTS2yLL8PqrWnrSVnlJ1dQPgH3cXyed25hQR8XMfCBIbW6DaeOrrk
 jX62R8EjCNhnlZV5LcEvAfFnhTIG9+7B9MM8HA1bzM1ojQA7kMtbp0y7oRAp5UBdJuItzcBe0
 wCLOP0qMPvS5an2cPr6kR1x0/0OR58dtVEA23PmGCBnapgPdAVBq2wxlWuy6DkqryOiwppwGD
 vaJ8i5tPubiKkRL+5YC6DKdgRxzeTfPDHxkjSQFbFhz6mol0ELbtgsuI9wchurW7lEFs4KG+l
 niZzklUzXchgJnnjVyOl0UTrsJuGNJByEjngEgjMtUC8EkL9LKp6n/6UB7HbdJOIxwuiM06Pe
 TYHpoJw2rghcqJmJu8r6wYlnbZxCliA4dSrIC7RKF6E2XsR2+yYQGwK2ZIjCOGsHxmos9fLgq
 w2/7AvON3+Ctbh3WzCRPQYiPgnCZhT3X7lagxMRltwSFAQEKJXTZRcHsvLQ3gh3zhbiaZuJSG
 R+lrRftoA2uDmn3+1EKOqao0InlLVEQsENovL31cZfe1sjp+rj2ZalzEjL9OifkDXZ5Ta3pQY
 lG45KCOlyIuy7sI9Mj5vP1MLaXbSb0dU2ta61mnqROk71mIPkIig951ajtWU+soHZVoYxaRqv
 GRV2HdRgexKMQfRzuzfVdmYyLmHWPCGlkDHKqAPaUALBdCJnbv2eNZWLrAd67UB34q4Ckl3hJ
 1xDnwFMeH+Rea+oH3TAIgi4HQ4ObeHEgueJLcjAZpwAwCCIHA94Gy
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Phillip,

On Fri, 14 Jun 2019, Junio C Hamano wrote:

> * pw/rebase-abort-clean-rewritten (2019-05-15) 4 commits
>  - rebase --abort/--quit: cleanup refs/rewritten
>  - sequencer: return errors from sequencer_remove_state()
>  - rebase: warn if state directory cannot be removed
>  - rebase: fix a memory leak
>
>  "git rebase --abort" used to leave refs/rewritten/ when concluding
>  "git rebase -r", which has been corrected.
>
>  On hold.
>  cf. <20190514180349.17245-1-phillip.wood123@gmail.com>

This is just the cover letter of the latest iteration, claiming that
Phillip would be offline for a couple days (but I am certain that that
period passed).

Phillip, I was under the impression that all reviewer comments had been
resolved. Does that match your impression?

Ciao,
Dscho
