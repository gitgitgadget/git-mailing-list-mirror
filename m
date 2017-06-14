Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D31420401
	for <e@80x24.org>; Wed, 14 Jun 2017 10:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbdFNK5T (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 06:57:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:58584 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752271AbdFNK5S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 06:57:18 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvzF3-1dt9BO1GFZ-017q9x; Wed, 14
 Jun 2017 12:57:07 +0200
Date:   Wed, 14 Jun 2017 12:57:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Subject: rs/strbuf-addftime-zZ, was Re: What's cooking in git.git (Jun 2017,
 #04; Tue, 13)
In-Reply-To: <xmqqshj34ldr.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1706141245520.171564@virtualbox>
References: <xmqqshj34ldr.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1987298872-1497437827=:171564"
X-Provags-ID: V03:K0:RNEad23m4hmVFN3bksj+qn7OvGOUiQm4u7esZHkxOqs2dnefx2h
 PyUyQxPGqo2BMG3B+wuKiXZeU1gW4F+2VlHHo6C7s5dgOXNfmBXS9/z3kdL+xKdGq+DlGGH
 w8K31xGyMukd2whKMvAwPViJIzRFUTbaAfs5hvv49Ow+7Fw/MpxtSjkdEkRpNqJ/YKuiaCk
 89E7L3nJPf2BA+llY8MlQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v2u5r9slu5U=:OJromJqCljB23/ZDTdAnk3
 nX3u2GqAaS+PxEYGvmdeDXxDgYjqzWyy4JseXjznQxybCmMNG2QSieXXZvVO6WCs7pwIfrMjw
 Cb5o2JCxgBmagPiKNV4s2yUQVedIK+EUIf5xn56ZGPRISUfnFJ+5dB6iTZ58MAdb4qPu/y51u
 jD/+TwHI9p7qPC/aouRV0PHlHd5SN2FLB3slEPPVjAD0AawEa3RwzpzHno8tGni9Pq7Cypsox
 pF0d+m0AKEFWtC6laHA8ggRoyu7tKRtwRGG8qGlXSosZGSkwIhBj2Vc4fuEcdG3IoidI5u9vQ
 pdQMAUg40EnjaCzOjoj9L4WZg3pxtULIk/FHvq5qNihdI5RwDrLb61oRQe+lk1qENkikXYvPu
 AbwGj6wCQ7JuIVJ7xFxjeRnBpzR+cg51T0uz1TXoUDF+xQxk+0zjibjFZ8oAba0K2+i9zmlix
 yrpPuLVayp98DHxFH6v4cGIlnzsJ/a600A+p44vrCM3jhh34UllVGzoYb9XJ7mMTIgEvpDByA
 jUsssAnSJ362etrmLkWJQ5DThpwdLlXxL6ozMNYnie/3L13Iteulc8V31Oo89Xh0o7a3Xwicn
 6amPdidYm/fJel0VJk72FYLSfKp0GL1KgVg2g1YgPlrJColwKSasropuY+s9fZD2iQCWw2A49
 KQtUkQfqSe8+mDWX1g06DdG5+CHVBl1cTxIiKlcg9idltkUn6x7Bdp8CAYFZ2TuJXLCNvJiOz
 5I+PDyD7LNxnMKHR9gKa+k0axy+nqAzDJTbJlvai6PvTXa8v6eV040YBaWY0TMp5cezCJ/vpJ
 2jw833v
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1987298872-1497437827=:171564
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Tue, 13 Jun 2017, Junio C Hamano wrote:

> * rs/strbuf-addftime-zZ (2017-06-10) 2 commits
>  - date: use localtime() for "-local" time formats
>  - strbuf: let strbuf_addftime handle %z and %Z itself
>=20
>  As there is no portable way to pass timezone information to
>  strftime, some output format from "git log" and friends are
>  impossible to produce.  Teach our own strbuf_addftime to replace %z
>  and %Z with caller-supplied values to help working around this.
>=20
>  Will merge to 'next'.

Hold on. Have you tried to build this branch?

-- snip --
    CC date.o
date.c:63:36: error: unknown type name =E2=80=98timestamp_t=E2=80=99
 static struct tm *time_to_tm_local(timestamp_t time)
                                    ^
date.c: In function =E2=80=98show_date=E2=80=99:
date.c:211:8: error: implicit declaration of function =E2=80=98time_to_tm_l=
ocal=E2=80=99
[-Werror=3Dimplicit-function-declaration]
   tm =3D time_to_tm_local(time);
        ^
date.c:211:6: error: assignment makes pointer from integer without a cast
[-Werror=3Dint-conversion]
   tm =3D time_to_tm_local(time);
      ^
cc1: all warnings being treated as errors
-- snap --

I would expect this to be rebased *at least* to dddbad728c9 (timestamp_t:
a new data type for timestamps, 2017-04-26).

But even then, it fails in t0006 on Windows with this error:

-- snip --
++ eval 'diff -u "$@" '
+++ diff -u expect actual
--- expect      2017-06-14 10:53:40.126136900 +0000
+++ actual      2017-06-14 10:53:40.171146800 +0000
@@ -1 +1 @@
-1466000000 +0200 -> 2016-06-15 14:13:20 +0000 (UTC)
+1466000000 +0200 -> 2016-06-15 14:13:20 UTC (UTC)
+ test_eval_ret_=3D1
+ want_trace
+ test t =3D t
+ test t =3D t
+ set +x
error: last command exited with $?=3D1
not ok 23 - show date (format-local:%Y-%m-%d %H:%M:%S %z (%Z):1466000000 +0=
200)
#
#                       echo "$time -> $expect" >expect &&
#                       (
#                               if test -n "$zone"
#                               then
#                                       TZ=3D$zone
#                                       export $TZ
#                               fi &&
#                               test-date show:"$format" "$time" >actual
#                       ) &&
#                       test_cmp expect actual
-- snap --

What gives?

Ciao,
Dscho
--8323329-1987298872-1497437827=:171564--
