Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97F931F404
	for <e@80x24.org>; Thu, 30 Aug 2018 14:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbeH3SLH (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 14:11:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:57541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbeH3SLH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 14:11:07 -0400
Received: from MININT-6BKU6QN.europe.corp.microsoft.com ([167.220.196.38]) by
 mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MKKaI-1ftjSn2L38-001mP0; Thu, 30 Aug 2018 16:08:35 +0200
Date:   Thu, 30 Aug 2018 16:08:33 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>,
        git@vger.kernel.org
Subject: Re: Trivial enhancement: All commands which require an author should
 accept --author
In-Reply-To: <87r2igca0s.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808301607030.71@tvgsbejvaqbjf.bet>
References: <201808282305.29407.ulrich.gemkow@ikr.uni-stuttgart.de> <nycvar.QRO.7.76.6.1808291653190.71@tvgsbejvaqbjf.bet> <xmqqpny1at28.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1808301350340.71@tvgsbejvaqbjf.bet>
 <87r2igca0s.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-924061781-1535638115=:71"
X-Provags-ID: V03:K1:qBG6d5DV0l33NcYyDhK3qHXz2GrSs1eMuEQifvIvQdfG7NTU5x+
 J+Ax88FRHnbzgxBJjV3yylsGODCQ2kId/XjZT8n/e/QtNtCCboTwZyZubOoNiurKZMK5Jqj
 vBd2Bs/KNOV+iDZo81EMNBX3qHJCD06p0Y8ZGEe3H7i77iQM8kvX8hlQ7CgvOqUbsd4498e
 7Z0Nex6g7zvk/Ar2gw6Sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Hi1OZrqfHoM=:8pMD9X1RDS+iGfs6Xu3yj5
 YYDH/LfNI9VQLe/yg04PfGDLRFaojrGRULXHzSldvJ37vsQQA7tkXOWEAiHE0UoFoaHN/n+ev
 QOiYxfWV2St6CJnxopnZUBn4Lq09XHliDFEKZI3GBxilrbceTSV5diQlgvtBJrftM8rMFFBqz
 SbJCxcgbY7zemydf4RGeN/cJS3A3rItTQDBA0F9UvIV/Z3TOPb2diizdIMuKo20rcbtp+BqIY
 KtZJZUyKeZq41qYQHZcS0alf1rpoV3asNtNoNIg1ZB20arVWhxIfD2lkKtT7s0RelkQvosS1s
 qUE9cf5LeP4xmnmw1vgDwopeG5SizqF20wudzZ2rXCIL2kCYpoEqQmedEjJG+C5bLwMDVBXrQ
 zNplxLiFvYLhBRznbi1PZTqBo0kDvuTsmPbicKY/91Q/Rau0efJK40BkR9PNr8p+juaLHAV9j
 o9RLkBqgna0/LAIgFmispjC45IRS6ErNEzYcKkQsXJPkcgA6fdVKNX9Irc6/prgj9EuPyAcc2
 rYXj0bzzFWMuNsuK3vkWW+QrDkaNYNpkcHYICTf0zchnKdHtEZrlGA2IiQUlg5XNdFBoPXRb0
 EbFirBadXtU70YQWsjv8swaQTQEfmyYVUm33NT9GPoRT8zAkmdxbgBF9GkGGA1EeA0an7kZrZ
 ihceSwVmkbM0u4WJdj1YonKo3L1lLqy7XCj0Ufm+K0bUqVGkARzYAdFAuea86Y2bRlWkn/bvG
 v/b15kOPTwyVNc1Icv5WVPMheZrKA7C2Uz76fTqMkFjCzHbaNFNnZeQC9bmFOD2W9lIoJKr5J
 T99MpX8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-924061781-1535638115=:71
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Thu, 30 Aug 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Aug 30 2018, Johannes Schindelin wrote:
>=20
> > On Wed, 29 Aug 2018, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>
> >> > The `stash` command only incidentally requires that the author is se=
t, as
> >> > it calls `git commit` internally (which records the author). As stas=
hes
> >> > are intended to be local only, that author information was never mea=
nt to
> >> > be a vital part of the `stash`.
> >> >
> >> > I could imagine that an even better enhancement request would ask fo=
r `git
> >> > stash` to work even if `user.name` is not configured.
> >>
> >> This would make a good bite-sized microproject, worth marking it as
> >> #leftoverbits unless somebody is already working on it ;-)
> >
> > Right.
> >
> > What is our currently-favored approach to this, again? Do we have a
> > favorite wiki page to list those, or do we have a bug tracker for such
> > mini-projects?
> >
> > Once I know, I will add this, with enough information to get anybody
> > interested started.
>=20
> I believe the "official" way, such as it is, is you just put
> #leftoverbits in your E-Mail, then search the list archives,
> e.g. https://public-inbox.org/git/?q=3D%23leftoverbits
>=20
> So e.g. I've taken to putting this in my own E-Mails where I spot
> something I'd like to note as a TODO that I (or someone else) could work
> on later:
> https://public-inbox.org/git/?q=3D%23leftoverbits+f%3Aavarab%40gmail.com

That is a poor way to list the current micro-projects, as it is totally
non-obvious to the casual interested person which projects are still
relevant, and which ones have been addressed already.

In a bug tracker, you can at least add a comment stating that something
has been addressed, or made a lot easier by another topic.

In a mailing list archive, those mails are immutable, and you cannot
update squat.

Ciao,
Johannes
--8323328-924061781-1535638115=:71--
