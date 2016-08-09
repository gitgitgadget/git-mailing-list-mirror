Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97F121FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 11:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbcHILZW (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 07:25:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:57269 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932203AbcHILZV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 07:25:21 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MhRUQ-1btgVj2sMs-00McNO; Tue, 09 Aug 2016 13:25:17
 +0200
Date:	Tue, 9 Aug 2016 13:25:16 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:	git@vger.kernel.org
Subject: Re: t0027 racy?
In-Reply-To: <05fafffb-1065-d240-51dc-a0872fd83c48@web.de>
Message-ID: <alpine.DEB.2.20.1608091319100.5786@virtualbox>
References: <alpine.DEB.2.20.1608081556280.5786@virtualbox> <05fafffb-1065-d240-51dc-a0872fd83c48@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1370359421-1470741917=:5786"
X-Provags-ID: V03:K0:+1PgacqGqrVRm/OG615LXPNip0uip1XXrp36t45S5lkqiJ/tWWP
 6p4cr7JQg4+qCLdx8Y+JAi2qfzH8tTDbMRpXf0/9LvZ3vdBq996bST4l3ccklOgzkzJ9vdA
 ukYJz/gJ9LJI5+H61u5tZzE8XGbaUYQRTiuKIIQ+oSqoxmoWBxrSPuqAXOSaNK4ZDK8EdAn
 E0ci/zAZjGd5gRISvTaWg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:kMwTXxLPr40=:EBlHfbxyYUL1rxkj4rukKN
 L9Z6rSeFUZ3fvShfjy3SkShggqBTS6dNANqfTFlig0DVk8XI17qJazdKZXERDxsj4UUkiuyR4
 DUb3fg0RIH/iW8i42CCrsYLLItuQeGesMYkjDIAmvuxdjwWpcBknjJ084V6hQtzNo6jQ7IQzV
 aOK5bDUBevKHBtkQsdDa46gZ5XnhdFBaMZQPQbz+cUFW8R+KXoVotOWJn81SazblnVJdEu327
 6TL4Fo/dRELqs+OTLr1XZLLlL5Z/bT1KBGRTI63R8lZxUam8ya6j2R90a62HnoPEY3JXBxcCH
 l7w9lQDT3+wq9TAN6r1l8e/HCggsMocIF7BC24nwi4XClR7P8hDet/yLmbFxXsggleZfgsefB
 qxKU/Vk2sMJjx1Z9crhNw9uU4XLOzztW/FIwaI3K5F4boUIkWdJWIT0z7OIdqKW4TE+7FSGD4
 TAabn0eNL0/KSuTQH6XCYG3WzAZ00HcxsRRM/S//tBJYkndTdlOI+Bv31eBbd/Gg4zs5Fgl8B
 R0KbOPsvny/eiMGSsSoSlqAsuls/motwGrmgFn7RndMzVnc4vhvyEPawNNcyY2gkJ+4yBVZ/o
 d5mtDOLQnIQfdgOk471bSgRaR4K4BtoWKu0GcJQkLfQUz+2b0xOUK60LAw3c0eR6ZM12DIQSi
 Br+iDMoWU88iaLV780ly02PvHIkBBfWOi/DpyzZQ9h2ynw8x9BShhhj9/axIAIS4sa/zOEljT
 HYJUsevrbHPcb88y3d4j3hiKpoM+eHui3VzeX18qrP/IN2dO/EzRcPPpI7lwmQjSRFp6VBJpc
 XZc6KzY
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1370359421-1470741917=:5786
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Mon, 8 Aug 2016, Torsten B=C3=B6gershausen wrote:

> On 2016-08-08 17.05, Johannes Schindelin wrote:
> >=20
> > I remember that you did a ton of work on t0027. Now I see problems,
> > and not only that the entire script now takes a whopping 4 minutes 20
> > seconds to run on my high-end Windows machine.
> >=20
> > It appears that t0027 fails randomly for me, in seemingly random
> > places.  Sometimes all 1388 cases pass. Sometimes "29 - commit NNO
> > files crlf=3Dtrue attr=3Dauto LF" fails. Sometimes it is "24 - commit N=
NO
> > files crlf=3Dfalse attr=3Dauto LF". Sometimes it is "114 - commit NNO
> > files crlf=3Dfalse attr=3Dauto LF", and sometimes "111 - commit NNO fil=
es
> > attr=3Dauto aeol=3Dlf crlf=3Dfalse CRLF_mix_LF".
> >=20
> > When I run it with -i -v -x --tee, it passes every single time (taking
> > over 5 minutes, just to make things worse)...
> >=20
> > Any idea about any possible races?
>
> Just to double-check: I assume that you have this
> commit ded2444ad8ab8128cae2b91b8efa57ea2dd8c7a5
> Author: Torsten B=C3=B6gershausen <tboegi@web.de>
> Date:   Mon Apr 25 18:56:27 2016 +0200
>=20
>     t0027: make commit_chk_wrnNNO() reliable
> in your tree ?

I tested this with multiple branches, but yes, the one I tested most was
the shears/pu branch of git-for-windows/git (which has all
Windows-specific patches of our master branch rebased on top of pu). I
also tested with the pu branch as of yesterday.

> Is there a special pattern ?

No. Just "make -j15 DEVELOPER=3D1 -k test".

> Did you
> a) Update the machine ?

Yep, it's up-to-date. Windows 10 Anniversary Update.

> b) Update Git code base ?

As I said, several.

> Is it only the NNO tests that fail ?

As I said, the failures are random, I just picked the 4 most recent ones.

> Did they ever pass ?

As I said, if I run with -i -v -x --tee, everything passes.

> I see only "commit NNO files...." in you report, they belong to
> check_warning(), which is called around line 126 in t0027.

I believe this is true. Some race, probably, leading to the commit *not*
refreshing the files. Or some such, this is just a guess on my side.

> How reproducible is the problem ?

Not very. That is, about half of the time t0027 passes even *without* -i
-v -x --tee. And when it fails, it is anybody's guess which case fails.

> If you add
> exit 0
> After the last "commit_chk_wrnNNO" line (line 418),
> does
> ls -l crlf*.err
> give you any hint ?

No. It simply does not contain that warning that is expected.

Ciao,
Dscho
--8323329-1370359421-1470741917=:5786--
