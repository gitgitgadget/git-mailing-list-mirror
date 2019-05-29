Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8A2E1F462
	for <e@80x24.org>; Wed, 29 May 2019 11:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfE2Lvn (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 07:51:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:58307 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfE2Lvl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 07:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559130695;
        bh=L3+jVsu/tw4Mi8UW/g+wc6Wsf1AVVsZSnK715Y8B0Ps=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SW9PhSJEYNlJfmIOFnk3azZrRTAW545NZ0NDn19IztO9ZC0WbLUFQYQ5nnWKBSLYz
         ezKeGer2y2gv3biWLq7s8w3PQV0N4O8VV19+VXfBjctdmMflAxoYkRliDFbxzwdznY
         JM3Vt1D0oVJx83OZ6NbMzacaGU3pFOygECHaCvNs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MACmL-1hLCgg32c5-00BNLI; Wed, 29
 May 2019 13:51:35 +0200
Date:   Wed, 29 May 2019 13:51:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        John Lin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: Re: [PATCH 1/1] status: remove the empty line after hints
In-Reply-To: <CAKO26Ms6_rJfq6knh14H1O-V2_6v8YxYdjah0vTdvpJTc7hdXw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905291349360.44@tvgsbejvaqbjf.bet>
References: <pull.196.git.gitgitgadget@gmail.com> <468be8f85426ccf588ad558fab3c8927ef58627f.1557917642.git.gitgitgadget@gmail.com> <CAKO26MsGpEcK74CSdgNGjFdKAMDP5Knm+0_vtcnrBBJjBfjcQA@mail.gmail.com> <xmqq36ky1fe8.fsf@gitster-ct.c.googlers.com>
 <CAKO26Ms6_rJfq6knh14H1O-V2_6v8YxYdjah0vTdvpJTc7hdXw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2065383305-1559130695=:44"
X-Provags-ID: V03:K1:0bYl61xp5lHsJV5CrhG4q2D2ahRCTbCkK+W5jjKP2iI1sdAAVxe
 fvV6jNyF+cgMAWWMuLqWLllper7h0GHzcInaH7ygVvXKZDqHzldLTC1aBk6iw5oRc/hG+Eg
 92jGPAzPSIJOp6EgM6H/7Ba804nuESS/4yie7u9zA2X0cGEKs4wrIiG6+Kjxlp+2gbMAlr1
 ucZDSQb+AXZ7BSUXJOiuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BN0uMKRHmUE=:wW4jdrQPzxXds5t0lj5fwT
 6MnL3DZhxB+N/Wea7oFm+AFsCjm47M8B6UJHUlvLOI8Y04jHZNohUjTjQIoug+37uvqcHKCxV
 uBxFCQVI3ugblA1eL45R1J55yp/H1JNrXU+Z6FqNHc7S8WuL1tRFfy8pDIWSELnm/lhV6hX3u
 nA8fdXedpN1jjDDPAhkP2VL87IZW3T8FIg4zq1kezRbPpHEfxMZ2TWIpbwaH/mtanCcpYcv4V
 GQv+yBdTj10jN5ueTMsfx4yk9M9q2mojOzzE6l+SLGkm+VIfn3bw7EqCTbOvgMJgMueq0GMfw
 7n778PLwyqgTPLCo8Kal1mkKRRNBnRFZa73KBPRI+wVGawXhRCqAzaC5/8FyYhglVInaHq055
 aIGhF1BrIQbD+suxRFsVBtAkF1z66Fq2EcOs/w3SJGZtXqQXWCqSNRRFbNtQjzRnwmvfkqjIi
 db4RgxWPhH4s/91rHebqj0M9ARvmbdVF3jgPNN7tBa9OiY8CYEDQM5Gq/8L2w8u/gW72jymoS
 cBXY8qvPrWShimI6KYpDiKxf9IS7teqg0sOVS0/9jdTJkMsqzSovb4xDEOrplBT5e4/4UTBk3
 Fp7Wixhuegb1OAlBUCYbOnBnTKlxDjsyov/ubAWX317EbCMiEotSf1t1NKCZ3NeUR/DBZi+zy
 iJIRGxr6kPMB1rGJYfxJDsgfWjWVEtHENviSoUz4QAHmIC9JmEs01Fve4jCBVLj+ZV62TkUAl
 N/Iy+enudH1xGJqnC0XU3hOt2YH6lFMZySQFz3vDDMlBBNifofTJIZ/Z00T5NnN8q1LfijLLP
 F1+P70IMLAbW3t5pshIf1khqwx+skGd1c1boJj5RyP2ukRtildDIlF+N34OdDFPEMzMdvnqvd
 /1pEtorJq/0O+Ic49/dkFbse29ImTH7BEknDKFKPPNNhGGtGqR3rNoe+7TSrJK5NLQE4GeR6z
 gOt4m21iuiFSX7wrTdh1OscudOlTPk+fwHngSoXC7Czsczuzn6lQz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2065383305-1559130695=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi John Lin,

On Wed, 29 May 2019, =E6=9E=97=E8=87=AA=E5=9D=87 wrote:

> Junio C Hamano <gitster@pobox.com> =E6=96=BC 2019=E5=B9=B45=E6=9C=8829=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=884:41=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> > =E6=9E=97=E8=87=AA=E5=9D=87 <johnlinp@gmail.com> writes:
> >
> > > John Lin via GitGitGadget <gitgitgadget@gmail.com> =E6=96=BC 2019=E5=
=B9=B45=E6=9C=8815=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:54=E5=
=AF=AB=E9=81=93=EF=BC=9A
> > >>
> > >> From: John Lin <johnlinp@gmail.com>
> > >>
> > >> Before this patch, there is inconsistency between the status
> > >> messages with hints and the ones without hints: there is an
> > >> empty line between the title and the file list if hints are
> > >> presented, but there isn't one if there are no hints.
> > >>
> > >> This patch remove the inconsistency by removing the empty
> > >> lines even if hints are presented.
> > >
> > > I would like to ask for the final decision on this patch. Thank you.
> >
> > If I recall correctly, the test part of this patch conflicts badly
> > with a topic in flight that splits 'checkout' into 'restore' and
> > 'switch', which is a more important topic between the two.  So if I
> > must give _the final_ decision, then we need to drop this patch, but
> > I'd rather not ;-)
> >
> > Doing this change on top of the switch/restore topic, once it
> > stabilized more and graduated to 'master', would be the best course
> > of action, I would think.
> >
> > Thanks.
>
> I see. Thanks for your kind explanation. I'll wait for the
> switch/restore topic to merge into master.

You could already rebase it on top of
https://github.com/gitgitgadget/git/tree/nd/switch-and-restore, say so in
your cover letter, and send a new iteration.

Ciao,
Johannes

--8323328-2065383305-1559130695=:44--
