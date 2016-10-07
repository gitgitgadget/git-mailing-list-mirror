Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B2D20986
	for <e@80x24.org>; Fri,  7 Oct 2016 14:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756588AbcJGONZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 10:13:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:61711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756557AbcJGONV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 10:13:21 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MSdNs-1bR2qc2JHA-00RVZ0; Fri, 07 Oct 2016 16:13:14
 +0200
Date:   Fri, 7 Oct 2016 16:12:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
In-Reply-To: <vpqmvig5ns6.fsf@anie.imag.fr>
Message-ID: <alpine.DEB.2.20.1610071611550.35196@virtualbox>
References: <20161006114124.4966-1-pclouds@gmail.com> <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610071319520.35196@virtualbox> <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com> <vpqmvig5ns6.fsf@anie.imag.fr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1588503969-1475849594=:35196"
X-Provags-ID: V03:K0:pl4puk3D1WqXmod6asRl1CJGgv+zQbJfNX+VMyfAYRAJUXP+wet
 OC+Iuo2rff1T9ijyWMTCIX7dFGZQp0GpV0jlVyiozw2X3XWHdwIJmPAUTIC1U7jChu+iyCQ
 uID5jgyVTfwEIfpi/+kanuiWWlpuTQtWVh5+TBnoZEjo+qcFancoB3fUg2MimsMaEpnBTan
 Jr7onEWQm09AHM98YcwPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ISVIrml3NfY=:0fLseEBqkbC97jPztQnnuW
 TPWTUnxzGDGIWydNDxuwXIZsIOzhlAuZ+curfL7ZHtf4KBAQDZHvhHmQ7gv50lwgqtw2vOKrl
 QXWeE66PGOGsUIfYE9Yv/n7W7x1cOXekFS9e2EelyVBiInxMDcGieecbw+b/mDVcJADIq66OZ
 51V6NYy+h0uv24INUeBFP8X7ZlovXHL0jLMT1LOOPHnZ2ZYEVvij9irpLwJ2Dxi5Ck7mryZc1
 EAdWqN2ybdYhukfyCz2fIHs1KJUMNLg4B+V9cXVD9zNARliSFXWKSMUSwyEnFwyiiytbAFnRB
 M0yFl4uVxME7cCj3r8/bkG4IwbyFCcq0DLtoJsvTMKh4TR/h9IhiY4vhi3j59CyB2f3DZvCJH
 PfyQbX2g/v/kaOoZ1g3qeAKrsNiZaJvknEv2Ob6WfBbF7LAie6EH01p7LiQgwMUkVDO+ZoYhG
 kLYJzYoODLo9QucjvuQ61LBgRL+Ap+/58e1k9Na3iN+eP9kHUBrNtcmjBMNOHFtTQL49wrw/S
 PbfzVz0F81dFHCUMUQCUiUugMgfBcShmeF3YAVhOx1ICpt/BkFmGeRgcx40viWxgRbqWmQsyA
 Ml8Ca3JQk46HSNo87gDKBMNBIRILfwuCu/G/NYD75pxa6Kc9kBx7MaMUTv72604gmQLeEKQvm
 H/mK7YxDrWSh8xBU+i+cYhx/pyqLSncB566JGNVYn42A2l/3/HggxCdH4eWylChG6NTrclg7z
 Li2LpJ4V1qIKqYG2dHCOns6q1/3VvPW9aKDYMOudjp5aDHZOCUwK5N2Zdkk/XilPY9D5sdDTS
 +gwfQaV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1588503969-1475849594=:35196
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Matthieu,

On Fri, 7 Oct 2016, Matthieu Moy wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
>=20
> > On Fri, Oct 7, 2016 at 6:20 PM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> >> Hi Junio,
> >>
> >> On Thu, 6 Oct 2016, Junio C Hamano wrote:
> >>
> >>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
> >>>
> >>> > Throwing something at the mailing list to see if anybody is
> >>> > interested.
> >>> >
> >>> > Current '!' aliases move cwd to $GIT_WORK_TREE first, which could
> >>> > make
> >>> > handling path arguments hard because they are relative to the
> >>> > original
> >>> > cwd. We set GIT_PREFIX to work around it, but I still think it's
> >>> > more
> >>> > natural to keep cwd where it is.
> >>> >
> >>> > We have a way to do that now after 441981b (git: simplify
> >>> > environment
> >>> > save/restore logic - 2016-01-26). It's just a matter of choosing
> >>> > the
> >>> > right syntax. I'm going with '!!'. I'm not very happy with it.
> >>> > But I
> >>> > do like this type of alias.
> >>>
> >>> I do not know why you are not happy with the syntax, but I
> >>> personally think it brilliant, both the idea and the preliminary
> >>> clean-up that made this possible with a simple patch like this.
> >>
> >> I guess he is not happy with it because "!!" is quite unintuitive a
> >> construct. I know that *I* would have been puzzled by it, asking
> >> "What the
> >> heck does this do?".
> >
> > Yep. And I wouldn't want to set a tradition for the next alias type
> > '!!!'. There's no good choice to represent a new alias type with a
> > leading symbol. This just occurred to me, however, what do you think
> > about a new config group for it? With can have something like
> > externalAlias.* (or some other name) that lives in parallel with
> > alias.*. Then we don't need '!' (or '!!') at all.
>=20
> Another possibility: !(nocd), which leaves room
> for !(keyword1,keyword2,...) if needed later. Also, it is consistent
> with the :(word) syntax of pathspecs.

But is this backwards-compatible? Don't we execute everything that comes
after the exclamation mark as a command-line via shell, where the
parentheses mean "open a subshell"?

Ciao,
Dscho
--8323329-1588503969-1475849594=:35196--
