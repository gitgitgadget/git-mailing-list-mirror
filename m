Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F7031F453
	for <e@80x24.org>; Wed,  7 Nov 2018 10:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeKGUNd (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 15:13:33 -0500
Received: from mout.gmx.net ([212.227.17.22]:38127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeKGUNd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 15:13:33 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPZuP-1gP28N48XJ-004jF4; Wed, 07
 Nov 2018 11:43:35 +0100
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPZuP-1gP28N48XJ-004jF4; Wed, 07
 Nov 2018 11:43:35 +0100
Date:   Wed, 7 Nov 2018 11:43:32 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, lucas.demarchi@intel.com,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] range-diff: add a --no-patch option to show a summary
In-Reply-To: <nycvar.QRO.7.76.6.1811071130570.39@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1811071142100.39@tvgsbejvaqbjf.bet>
References: <20181105200650.31177-1-avarab@gmail.com> <CAPig+cThS8959jW9+X7bJHy5RG9Uoj4=V8ahjf2zGetTNw03SA@mail.gmail.com> <87efbz6xys.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1811061140560.45@tvgsbejvaqbjf.bet> <874lcu6vr4.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1811071130570.39@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1318860992-1541587415=:39"
X-Provags-ID: V03:K1:exuDpDHcjgwqRlvaXtTefashmcW5a3shIc1aMfDyUVWVP1jwUcu
 HB/kYwJ5xC89e6NOnBm1uCN6arYyng4UjslP/vtmL2H4bjdIJhaTAOv+/7HSoAicJx8UFS3
 h80DmfBEBjR0Qvq8JxicwUJ9zhCcnA9Jfn9l23/uzoFzSdMwOhUVD+h5DRJr7brMhoR/Zoj
 MFS7xANJAKS6I/Ox7IvbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5LzwtMpoqyc=:PslO6xr1Ndap5YDuSkPfEF
 vxOJdWXmM2D4gUW1u4T864qv61iZWGG40fgc5OpyQ3lWwUTc8Se26/6Xf0lZpJpkWGY5qfW35
 +SBJ0mdGXRnspaSqVDZnVaJpLc0XHyJeQ0ow36o3IvTxzXoXRc3fq3IyIxcoYS14coIuH6osf
 tBiGtgo4iR6KpZButzEBAqpaBb4NqlLsd+hlUO6z7RdX+1dkgDonjMXoYs+PE3aVRWbz54jHT
 U6xoVvAjbarx8/a69G+TcQCDcz8+FXj8DlJtxWvhryFusl+vGH+BP7EpVWk/NNs83gH/c6zEZ
 qHvfDFbLM7f46esgnVEMrCz7cL0lxGiliG/jtQS0fYluU1q64Dh7/9jTERhDxutqAJybe/gJi
 1ZL64YB6dR7gAK0b7J116GCrcyJMgqzMM3ovw94w1ImI2KOAFgxXli+W0YkPw4gNKqgmlTx+z
 rJ571rqMHC+lVrZEB2qzCzH6rjFS/7ySFCypGQy+TuvRkDg5U+OpaRHAwzm2kqiLdBdjMVQ4M
 jBIumu15vKfpjvNU1wOC02B33xFWuNN0fXRy5c8sp6TT2Fgt7EvY7yn4WcERb6sOKpd9fyFkA
 zjz3YvL/YY8Wivpy3x1VteoWhc0lvit0ZADDKJZ3s4HgmvsZHQa0QbyohUzAY1SWIU9Ztn40h
 yjufibHPhVt4bccZKtSFTLG0iQP78FiNit172njHJyshryFuMgcUrYbSLMf3to0JeqEDCau43
 s8A11ZKwBSW8tWhDthH65UDyeNJhnewhMJSLb99C8NZC7DNgAH/5sWIWnjjWHZIqnL8WSVRKD
 UKgr54IBBSyC9r765KBzaykL4s5hQMpvD9StceKK8N36Lnpbfw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1318860992-1541587415=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Wed, 7 Nov 2018, Johannes Schindelin wrote:

> On Tue, 6 Nov 2018, Ævar Arnfjörð Bjarmason wrote:
> 
> > On Tue, Nov 06 2018, Johannes Schindelin wrote:
> > 
> > > On Mon, 5 Nov 2018, Ævar Arnfjörð Bjarmason wrote:
> > >
> > >> On Mon, Nov 05 2018, Eric Sunshine wrote:
> > >>
> > >> > On Mon, Nov 5, 2018 at 3:07 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> > >> >> Add a --no-patch option which shows which changes got removed, added
> > >> >> or moved etc., without showing the diff associated with them.
> > >> >
> > >> > This option existed in the very first version[1] of range-diff (then
> > >> > called branch-diff) implemented by Dscho, although it was called
> > >> > --no-patches (with an "es"), which it inherited from tbdiff. I think
> > >> > someone (possibly me) pointed out that --no-patch (sans "es") would be
> > >> > more consistent with existing Git options. I don't recall why Dscho
> > >> > removed the option during the re-rolls, but the explanation may be in
> > >> > that thread.
> > >>
> > >> Thanks for digging. Big thread, not going to re-read it now. I'd just
> > >> like to have this.
> > >
> > > In my hands, the well-documented `-s` option works (see e.g.
> > > https://git-scm.com/docs/git-diff#git-diff--s), although I have to admit
> > > that the `git-range-diff` manual does not talk about the diff-options.
> > >
> > > And for the record, for me, `git range-diff A...B --no-patch` *already*
> > > works.
> > 
> > Neither of those works for me without my patch. E.g.
> > 
> >     ./git-range-diff -s 711aaa392f...a5ba8f2101
> >     ./git-range-diff --no-patch 711aaa392f...a5ba8f2101
> >
> > This is on current next, 2.19.1.1182.g4ecb1133ce. What version are you
> > on?
> 
> I tried it with git version 2.19.0.windows.1.
> 
> To verify, I repeated this with `next` (git version
> 2.19.1.1215.g8438c0b2453a):
> 
> ./git range-diff -s 711aaa392f...a5ba8f2101
> fatal: unrecognized argument: --output-indicator-new=>
> error: could not parse log for 'a5ba8f2101..711aaa392f'
> 
> Which means that something broke rather dramatically between
> v2.19.0.windows.1 and 8438c0b2453a.

Nevermind, this was solved by passing `--exec-path=$PWD`. And *now* I can
reproduce your finding.

Ciao,
Dscho
--8323328-1318860992-1541587415=:39--
