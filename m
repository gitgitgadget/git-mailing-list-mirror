Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB8BC1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 12:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeDFMNu (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 08:13:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:50385 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751974AbeDFMNt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 08:13:49 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVvi4-1f292F0sm0-00X320; Fri, 06
 Apr 2018 14:13:43 +0200
Date:   Fri, 6 Apr 2018 14:13:26 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] Add a test to verify that push errors are
 colorful
In-Reply-To: <CAPig+cRL1t78W+58HnN3bFJhZa7b9iu=vQxfAq=rF79p1NgeHw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804061410100.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1518783709.git.johannes.schindelin@gmx.de> <cover.1522968472.git.johannes.schindelin@gmx.de> <021133cae0d27359a5e3ee520fc26f58b7030f59.1522968472.git.johannes.schindelin@gmx.de>
 <CAPig+cRL1t78W+58HnN3bFJhZa7b9iu=vQxfAq=rF79p1NgeHw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ujg6GUaphlk3HgOKqtoPRReiFq/r9t1r925viBMI/FaSQS4DM17
 TyXsdEX/vHZb896/7K1BaP/TT+LNfA/59n/OI11pCSOfLWL/HoirGSDDh+Y5pFwKSFqb1Um
 zlHuQOYFejMmLCFVuRXe01rYDBbptsnItEIqjBoPTe7smgKT+qlDNB9+MQye8EdPjWaxHp5
 w0hkW60pVGKjrCiycFu8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O6/nQo+W2Gw=:jEtisvzWVohUqHOq8R3/8f
 HPcKgfRrPO00Jx/uvn9llig4ubq3pfzM77rXjnuGFKJy7ixQhS/eXNGcf8nM+JQ7BojHECvbc
 AGo/6NWb9QZeNzbrLQXnEGZjnvTWdm53Z6jLQGTvXj8rH9pQ3pZqnSM0kiO83Vl+SfX4H4MRa
 U8AU8gLGEC/WQujBJ9MkgIF3kJB0WtMidtKt5GfA46Id/vinYm4LNwLaZlge9gxH6Kc8RTv2Q
 4RiNzMIXJhWoqR1ZUe7xlaYhDtlibRFsv/ApixwtGshlavqX1zwX1aTl0xo1O1SzUyRm+SO1E
 cdzTNngM8blOD3FGbPcmA8DlXzpg3COTUFDF0oeKjQz0erK7ZywBTUxsPFrZdX+//1pzAMhBj
 i4goGcm1OdymQJczet9rQGUUq6tj0NKPDgdK58ZUBhetOqtihesSGPTXjJ3i3jVfNWcX4tCT2
 MPhSMvUAABH4iwbp4abMw7F2vY+V0aSJJ80csphtxbygWW3Y3GEbFF+oTmZgzj+lZMMhd6Q5Q
 UHdvuTnICLRlq29jSB2P6NfjK1nI03fhcBufYSs54cPwzL9qljEEx2SBXXOoGJHBDYRAMoZnU
 akfiUlR0fMThA86q8zkLQ3/XDNFzNmJd7MoDfDYU8hrKJMd74Nl056Tsx3OTNkgPXgQddF9Qs
 QzrFXZ5oGPhD8BQJe5nRmfg2rjhDLQCvALsVdNjEUF1S9+D1lGF5+6HR3LCFWwZ6l5+YXkeq+
 I7T6lY6bTLwGv5sYGqd2CV5d61WTGQJqt4f80cFaPJ7tauncsn4I691Tmww7h8EPM35zQOHfV
 JvC97WZAqi+X6P7uBLO7ON7FE4PhB/RasXnEwYQfITjqPvziKhegFqI00yej6Hh+041HE/h
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,


On Fri, 6 Apr 2018, Eric Sunshine wrote:

> On Thu, Apr 5, 2018 at 6:48 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > This actually only tests whether the push errors/hints are colored if
> > the respective color.* config settings are `always`, but in the regular
> > case they default to `auto` (in which case we color the messages when
> > stderr is connected to an interactive terminal), therefore these tests
> > should suffice.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
> > @@ -377,5 +377,23 @@ test_expect_success 'push status output scrubs password' '
> > +test_expect_success 'colorize errors/hints' '
> > +       cd "$ROOT_PATH"/test_repo_clone &&
> > +       cat >exp <<-EOF &&
> > +       To http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git
> > +        <RED>! [rejected]       <RESET> origin/master^ -> master (non-fast-forward)
> > +       error: failed to push some refs to '\''http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git'\''
> > +       EOF
> 
> This "exp" file is not used by the test.

Indeed! I was *so* sure I had removed it, but a `git stash` must have made
that change go away before I could commit it.

Will be fixed in v3.

Ciao,
Dscho
