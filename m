Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49DBD20706
	for <e@80x24.org>; Tue,  5 Jul 2016 13:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948AbcGEN51 (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 09:57:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:58413 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754431AbcGEN4P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 09:56:15 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MS1g6-1arJLq2066-00TAz0; Tue, 05 Jul 2016 15:55:51
 +0200
Date:	Tue, 5 Jul 2016 15:38:31 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 02/17] Report bugs consistently
In-Reply-To: <577BB09E.5070801@gmail.com>
Message-ID: <alpine.DEB.2.20.1607051535550.8378@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de> <fdb0efbeb0b41c0d9976b2d66df90d2366f81ca1.1467717729.git.johannes.schindelin@gmx.de> <577BB09E.5070801@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-639834285-1467725914=:8378"
X-Provags-ID: V03:K0:wzsOMFC2VrEBBfPTszRGwF/Tt6rdGgmup3zttTafAdwzBAPOd+W
 GRAMdfeh6+mfBffOZTLenp6JjbaD8gPF8DNyn0CwihigRTYMat5A3N4qcWdDeWLQoKxrz6g
 /CUuO8/P9mQXcwCD487ciryV9RV80j72ZW9MdSEZBElj1aVV1K4EU+6aupQ2zwIjyzMsnh4
 7bDlJ9t5CNf6YQIWnTeBg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:nxV2HxsVenE=:zoZ40V3f3AY9RZIjNxXV5+
 gBCAWY8iwIMi1/SkH+ePz7RYWbvNsZ9kdnTscF51D+NH1ze7v85pQPMLRhdjODubWrvW/Wylg
 Urr8D5LKMxMv2SMaZlO4Upv7CltozbLtBRJwRdqR3eHGM5pLhLytI3OTpm/j0ayB5sH8AXVDb
 eFZYyiPGetcwG9+2jBTF/tqQvwSU+0sXIKTy8SIP6STC2pv5mmfKYsbWdLLrwkzfNrH8y+khe
 KboPTPw0hBUIY59eikAYhTkABn6ANU4TzA4ApVb+rUqDY5buanFVc2Ks9n9bmqiqyAzRCnqkx
 MPYkk/kESB0iCDo4vCzvR16v6dnlCahtRhF6RlI84Uo7L1w67owCJClE7b+Bi+m8Q7uQ0Otxy
 9b+sdqP1BHk6J9xAieEFgfAthfcSNQOHWJTmb++uIL5kDeOq9aCXzY7+ejIAzk3I4Q4BvgWox
 AoI15fnC9rV0FAt4w6NHTZLE7ASkYXg5LhYU/9CNi5hGNHhoCLOIMb50vBYuPD04bDWunq9jl
 tkbjKGMWZxz+aK5x+nKfiilMiTzX7Oz19Hyo6fJmnBsaC8dDxC1SHng12EpywxVS30g00oB01
 M9iueovUpfPL+//FWVrlSNdej6Or+H51gBhNcqk0oIpAmjck2rY4Zh5Wm5NgUDhE3J5vFRmyI
 OFQsDnpM11zWj+lri/qY+Z/kCTD3TPu+1vjzdIxQu9a3c/clZRRBm2nZSzlPq9txfNtRBYPcs
 lay1yXucmutCotHOUp+fBa/mnG022jgWAmJpZEMsYwxYAo2lJ2EhP35QfMqd90Myw/2/wDkgU
 plW5LTp
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-639834285-1467725914=:8378
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Tue, 5 Jul 2016, Jakub Nar=C4=99bski wrote:

> W dniu 2016-07-05 o 13:23, Johannes Schindelin pisze:
> > diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> > index f02e3d2..00ea91a 100644
> > --- a/builtin/ls-files.c
> > +++ b/builtin/ls-files.c
> > @@ -118,7 +118,8 @@ static void show_killed_files(struct dir_struct *di=
r)
> >  =09=09=09=09 */
> >  =09=09=09=09pos =3D cache_name_pos(ent->name, ent->len);
> >  =09=09=09=09if (0 <=3D pos)
> > -=09=09=09=09=09die("bug in show-killed-files");
> > +=09=09=09=09=09die("BUG: killed-file %.*s not found",
> > +=09=09=09=09=09=09ent->len, ent->name);
> >  =09=09=09=09pos =3D -pos - 1;
> >  =09=09=09=09while (pos < active_nr &&
> >  =09=09=09=09       ce_stage(active_cache[pos]))
>=20
> This has an additional improvement (not mentioned in the commit
> message, but probably not worth it) in that it shows which file
> was not found, not only that there was some bug, isn't it?

Sure, it improves that report. In the unlikely event that a bug is
encountered :-)

Is it really worth mentioning in the commit message?

Looking at it again, however, I think there is a bug in my patch. It says
that the file was not found, but pos was non-negative, so it was found
unexpectedly. So I think I should strike the "not" part. Would you concur?

Ciao,
Dscho
--8323329-639834285-1467725914=:8378--
