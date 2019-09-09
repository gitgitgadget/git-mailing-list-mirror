Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD6DC1F463
	for <e@80x24.org>; Mon,  9 Sep 2019 18:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732594AbfIIS6t (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 14:58:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:56153 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732524AbfIIS6t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 14:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568055527;
        bh=O7jAuCxElHg0XibVH63X4TwCC5OuY0bhulS4wEDP350=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SL0EJQZxrcEWK5Soi6+UP2xr5oSqzfrfafOP8I3cDkp7ko0lIod8Hyw/lL5CAQz/w
         bybavDjrY+HSR9Z59Pb/2wN/VApgu9+1dlwvnhUU42GLH14fQA5GMFuYHDbGo3F3Yj
         wU7IAPndsDotmSs39gtVpv5OPWPzSa/ycKvjpWu4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MplXp-1iUdGk2uWj-00q71e; Mon, 09
 Sep 2019 20:58:47 +0200
Date:   Mon, 9 Sep 2019 20:58:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] compat/*.[ch]: remove extern from function declarations
 using spatch
In-Reply-To: <20190905032317.GA1381@archbookpro.localdomain>
Message-ID: <nycvar.QRO.7.76.6.1909092058020.5377@tvgsbejvaqbjf.bet>
References: <cover.1567595331.git.liu.denton@gmail.com> <3c08556231576d8dfe496b87ae8cdcb87c00df24.1567595331.git.liu.denton@gmail.com> <nycvar.QRO.7.76.6.1909042342220.5377@tvgsbejvaqbjf.bet> <20190905032317.GA1381@archbookpro.localdomain>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dmtwX/qcDdonMqkKpK0s9cK9svsrqjeiVpGFjoKUmNCmTCuKJyY
 b38PgsqGD0gg0cw5XpI44DFTY41rzc5DhCk/qydtNsAAarpR5d2/aUtWtEIfZJ8q0+9lHRT
 u6z0L92cmAJpjE/ayweJtRe409U8+7Eyc5jKcm2rY+FWEmH2rekpw9fx7hE/88Ej288MZ4K
 AJmtMiuwLfv2EQYBEjp8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QHk05HpnFhU=:ti1kA2T4RRUc5Kgal28a2N
 43JKcl9g4Z516Z/59VJ4QAZcbc3Kn+SLfqby0SoujQ/smX2xkLSZjwTVNOmYRc3ZXUSk1ezEF
 e9Mk741HnoiE8KPj86Yh0FSecw+p+TkziGYW7SNbuwgPlydxtnTZpDlQdP/AVwOulbk3gpxs8
 MeG6ZAwrl/EitBGWK72ndJlQR4VwHVtOFbYzXk2dT2HligVmkrgbKtwREgNL/PembscNsqNma
 repQ8+l0BBSdqRjJlyZU2OBHX6UBO+kIebDyja+syKLiAYPKER6eX0QYV3peFIofZk6byIKR9
 TZT1tuo6JRmWb7OV+bTaLAIODm4RJQ7wUNQYwbFvRQnbkqfJPSZw0LbYsbISO6EHHXkdDou+6
 Kbdq87ebYqYwQ+fJw2k6hTcv3HQG0KTA8lAZjMPptNOzjcS023aQfYEnqNyWMlSH7TxTWe/E5
 9DPP1wlfixjBk6m8Q/JH6wtEOH4Bv8NMQC/xFPHDY+umYa7Eyrnn9O6gQ1u9sTmfe0sZV23RH
 g1tqMKiMO7BBImp3SCfRR5CN6JvoaydBuM0DxAAZrOvTlbiUey1wGvrcOAXwDa6mI7mvEoDrS
 I71Y94Q1uyVB1MJodEK9tm80oCkfe/g/PiTeZROKNAGWinZiULOS8Rk6bLcSzCYYTyitz31bH
 mpgwXKL0xRLrW2RAP+wKNlMyKEk10yqFlQ8ffEnWyUvtHiV+qy2DirR1Bgu6MqqoBIZCKJAas
 706PSqKMapyf/OtLiA0oMuoelxNn3Z67kEe5MEvFj1uLypDb7brBZmeK5USH5KL5TMzuvhoIl
 XI7s9kXHjC0bJ4QDCe7gl//TLp7WONmjEFk1OoTMXZ3B/la9uqoZFrFy7LomRrCcjfn3T8ogv
 IEXEUTAexKXm9tkM1O24in7y5EWsFF5SmJat0NZWJZMPGYhIY40FkXktu541jyxiK+1/R6mpx
 CqCCE5Q7IEpvw0zmYxVe9h8Iqe4jSxvtEq5BHR7SZYX/i+K/PjZQCf8DRtn9rF7Vvtm1uBdmU
 RCRCg6V1fFGn/nDxvBkReMfLKOdZmLq9OOURHAqYoSKdN4Xr+Q/47WW2IRkU63AxSx93pI6OQ
 faQ+eMwJDTVuovx80c1AwZs+yteIAgq2UoMCIhnL1y75RfxJGoPU1nz/AnjddPZOGm2VjXmcp
 +44JpcPFkCBUjGsZtmfd1QPv8QtdUTEz99BZJH3pTvvWTeSuoOoutQt+fM3g5Y72gnOyRETho
 +ATL35PQDAQiGOk7j
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Wed, 4 Sep 2019, Denton Liu wrote:

> On Wed, Sep 04, 2019 at 11:43:06PM +0200, Johannes Schindelin wrote:
> >
> > On Wed, 4 Sep 2019, Denton Liu wrote:
> >
> > > In 554544276a (*.[ch]: remove extern from function declarations usin=
g
> > > spatch, 2019-04-29), we removed externs from function declarations u=
sing
> > > spatch but we intentionally excluded files under compat/ since some =
are
> > > directly copied from an upstream and we should avoid churning them s=
o
> > > that manually merging future updates will be simpler.
> > >
> > > In the last commit, we determined the files which taken from an upst=
ream
> > > so we can exclude them and run spatch on the remainder.
> > >
> > > This was the Coccinelle patch used:
> > >
> > > 	@@
> > > 	type T;
> > > 	identifier f;
> > > 	@@
> > > 	- extern
> > > 	  T f(...);
> > >
> > > and it was run with:
> > >
> > > 	$ git ls-files compat/\*\*.{c,h} |
> > > 		xargs spatch --sp-file contrib/coccinelle/noextern.cocci --in-plac=
e
> > > 	$ git checkout -- \
> > > 		compat/regex/ \
> > > 		compat/inet_ntop.c \
> > > 		compat/inet_pton.c \
> > > 		compat/nedmalloc/ \
> > > 		compat/obstack.{c,h} \
> > > 		compat/poll/
> > >
> > > Coccinelle has some trouble dealing with `__attribute__` and varargs=
 so
> > > we ran the following to ensure that no remaining changes were left
> > > behind:
> > >
> > > 	$ git ls-files compat/\*\*.{c,h} |
> > > 		xargs sed -i'' -e 's/^\(\s*\)extern \([^(]*([^*]\)/\1\2/'
> > > 	$ git checkout -- \
> > > 		compat/regex/ \
> > > 		compat/inet_ntop.c \
> > > 		compat/inet_pton.c \
> > > 		compat/nedmalloc/ \
> > > 		compat/obstack.{c,h} \
> > > 		compat/poll/
> >
> > I wonder whether we want to make this part of the (slightly misnamed)
> > "Static Analysis" job in our CI.
>
> Do you mean running cocci on all of our source files as opposed to just
> the files we compile? These two patches are part of an experimental (and
> unsubmitted) patchset that does exactly that. Seeing that there's
> interest, I'll try to send it in soon.

I look forward to it!
Dscho
