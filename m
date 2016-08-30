Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4886D1F859
	for <e@80x24.org>; Tue, 30 Aug 2016 07:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752803AbcH3HbH (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 03:31:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:62579 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751598AbcH3HbF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 03:31:05 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M4B71-1aoJvr0yeZ-00rqnD; Tue, 30 Aug 2016 09:30:36
 +0200
Date:   Tue, 30 Aug 2016 09:30:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/22] sequencer: allow the sequencer to take custody of
 malloc()ed data
In-Reply-To: <e0a00df7-d4e7-3809-ae93-b29b1f1c7ea4@kdbg.org>
Message-ID: <alpine.DEB.2.20.1608300929420.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <e4e7eab3d0610faa9d3173a585902e50128d8e15.1472457609.git.johannes.schindelin@gmx.de> <733a899a-470b-79b3-b059-b38313a7057d@gmail.com> <e0a00df7-d4e7-3809-ae93-b29b1f1c7ea4@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-317533294-1472542236=:129229"
X-Provags-ID: V03:K0:fXs24sgYb22CSZic0gNfGp2bZ9ZBJUD+zw80f8MKUMn9mu1VTks
 OO561eiDEQeYS8anH3Ebu4lRC/6rN5VQUvaMGTiEKBkHufBNgXwU1UwsL335zQV7y9E/Bkc
 I8jhfRoG+LO8PX/UySK5vKrUynnPX4bX0I7c6V/WWMh9xNJLLx6KT7yAhsaviWyc/96D1/V
 rxBCtDCO4mUM/eZWYtIFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:odseY+TcO1E=:yTircc45/v+x1R0nZrFL4M
 Flb3n6pP65DeXPplnqMK6QXMJKwGLKW6Z3hLQ3A3kj3Es8tq7D7kg/EAZgnnvrB+zZLTXNc+v
 1H3jyo6sbvjs8g7onXv4WBBtspLai9lhiL3F73JA47f2uu8jRKxFI5U47FYdR2OR6FKT24juv
 vW/qkaqD0BeYNEItpmGZh8Y96ukyUmZjtAb1WS2sKk5bLoo9RipLVWPFhWYSSkrjJns2Oynd9
 4nFoVqrBx1qv7mnw8H/cBhQwtiR1ezU4VyzZT/cZyANkIWUFcNjAM6YSOWMze8sipbF+FZRyB
 YnY00sEOxuSFDQSgF3sjUeSjGxsJhWQEag5AdBDR/1F6Elkt94682eKstCDNG1XYCHOvdY/0f
 6m+GA1qej2paQHqAKze/0j/RF6cgUvJlu7mjjWq1Ofd2VyLhXdLRuAPRpTDguCKQI7vqwARp1
 oGGjF+mCa6IODuj4PetR75adJI8HgVoT3A78xKBPT6IzVw7rgajNdAghMfOGWtU09wz74KS7l
 1JNOUAcCx7uTaSR6M9skoc8/i+u2WP3yUyI0Z8C1y/JXT3PEkoHfQRZurxdhnSTGzaP4pZkI5
 r1sHabP+ee4QqNXN24ibfLqmOidHyj20BtSZXE+WoU87Oc9jJrbLroiGpMy/fdGnh1GwRh0B/
 dt33S90B78JFlvUb2PqXUCoD7tlUTbhEwenHpuPjk2A50jKx/4zJwOq87mV30mMY8mosqpA8m
 CC6WStLdGuUZS+9LAn9UWLY32ZY0G0BF0K8pvYNJykimvSrUVVp1Pk2fWTAdLdVXAymICVaGz
 vQPiC6J
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-317533294-1472542236=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Hannes,

On Tue, 30 Aug 2016, Johannes Sixt wrote:

> Am 29.08.2016 um 23:59 schrieb Jakub Nar=C4=99bski:
> > W dniu 29.08.2016 o 10:04, Johannes Schindelin pisze:
> > > -#define REPLAY_OPTS_INIT { -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NUL=
L,
> > > NULL, NULL, 0, 0, NULL }
> > > +#define REPLAY_OPTS_INIT { -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NUL=
L,
> > > NULL, NULL, 0, 0, NULL, NULL, 0, 0 }
> >
> > Nb. it is a pity that we cannot use named initializers for structs,
> > so called designated inits.  It would make this macro more readable.
>=20
> It is actually pointless to add the 0's and NULL's here. This should  be
> sufficient:
>=20
> #define REPLAY_OPTS_INIT { -1, -1 }
>=20
> because initialization with 0 (or NULL) is the default for any omitted
> members.

D'oh. You're right. The same applies to TODO_LIST_INIT, of course.

Fixed,
Johannes
--8323329-317533294-1472542236=:129229--
