Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB4A41F404
	for <e@80x24.org>; Mon, 26 Mar 2018 14:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbeCZOLm (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 10:11:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:50757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbeCZOLm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 10:11:42 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MC4y8-1erd9q0gd6-008ony; Mon, 26
 Mar 2018 16:11:34 +0200
Date:   Mon, 26 Mar 2018 16:11:33 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     Sergey Organov <sorganov@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        phillip.wood@dunelm.org.uk, Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
In-Reply-To: <3dbf86bc-cae9-8d6c-a206-cac685938f3d@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803261602360.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com> <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com> <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net> <877eqgardi.fsf@javad.com> <3f2209e0-c560-5384-c589-3aa83615d688@gmail.com> <87efkn6s1h.fsf@javad.com> <de063fba-2882-6194-a889-ad3e9b6b02b9@gmail.com>
 <87lget7p2g.fsf@javad.com> <3dbf86bc-cae9-8d6c-a206-cac685938f3d@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cjm5emA3H5Xc3sLqlW67ckeaLAzlD95BVwxTxTE+zaS0e9XqurR
 Iw5fsc9cFNLDP5GixDX52ZLC7RaBSAjd8so5IE1C3WYFO+UfPUng4B+oAfFSubVGzUYj1p2
 yKWGCDFnTPNzX3C0RPQIU/viTk8FCxPEZgR0VYextIf4CvmxrMHiLB2q8tf35E16wLKvp4e
 X4XbnkDvIOaKIzgZGi3aw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pNOqBZacgCU=:ZFAsgnW/QRrK0oABARmd89
 /MKfrsDzpGppo6UOXKIL+LXsgjTfmOsU31jprAsmPG9FHKhmqglWr767RXB2s5bOIY6whgjYc
 UaPjkfChKfU811bMQQNTWWbeRIwPNCR9t4yETEEpLgyWPvMbWu5IzakpHcyYv2ND8eXlxEomw
 73zkvQOUcUrKaC2Y7hp8GP0sEw/RKDeC8fQ6RVPLJyUyZ5LggLtxEfirMqvBxIMMUnEsAIyHk
 shacmWBFUtfkJPtDhIJ1YYkQtwJxmIOiFnwByTfRJrLTDyymOt6CQxJ1bKSQVjHnpRu5xN0h+
 49lqczSzwr4s8FFat+CDixKnCwDAY0bfNU8KK/x7RmQNlc1xTn0cwzvRJuoUp0ISdLIxkvGFf
 8OzkSf30Nxyutt8EzRIeAktgCuR5kvt2iwdvX2phaQ427k4W9ilK6SIjRTRB36PPXpGiINMh6
 d3h+zjrgzrXD+qcUnIU86z9a1QAXQ8Wuf8eKHlqs+1bnu2GTQL6vbtHp8WBcfoAUpwmVLB+Oa
 H7rTsdxDkVDOv9zLS50KINPG/Qujnf1AMJvvg5r+/6xOrWqhFlQvkIOEzcs87L2Hec4um1Cex
 ZtpxUExg0jIoc7IEiE2zq0vKfhysVlF8D5+VvXbKpDrvHCUfV+2nl094VPOBih7zPoNCJxH2N
 FHs5KoKvQmkKSjh5EBx2WviRkGRPpDiIwGInqbTu5YoMJJ2FGWufV8Il+N5MwDf9lzKhiIZF5
 /mXWXg+F6w+bo850jHxADwGqOMRBOnT6llnBKsn10v5PRw01mWx/dcnuQEvuTBWFcrkBR4yrD
 44twJGLZLaHFQ8M9FSj3hhAl91p5yBOP9fZmsshNL9n2NlaDEEk+YRzJQv2UGfEAZyFvo38
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Fri, 16 Mar 2018, Igor Djordjevic wrote:

> [...]
>
> Yes, having more steps would mean more power/options to the user, but
> more complexity to explain to and guide him through as well, not really
> sure where the line should be drawn - for the first time, at least.

If you want to avoid having a huge discussion with me about bias, male
privilege and how unaware most men are of it, and how it excludes half the
potential usership/talented developers, and how representation matters --
and believe me, you do want to avoid this discussion -- you will want to
avoid referring to the user as a "he".

It might be true in your case. But it is also true in your case that you
are Russian. Yet you write English here, probably to avoid excluding
people from the discussion. And you should demonstrate the same courtesy
to people who do not happen to identify with the same gender as you do.

In short: every time you think of a user or a developer as "he", take a
step back and reflect how excluded *you* would feel if someone forced you
to change that to "she". That is exactly how much you exclude non-males if
you think of them as "he". Just don't.

The remedy is easy: use the gender-neutral "they". Which is, by the way,
not a modern invention as of late (in contrast to the "he" you use):
https://en.wikipedia.org/wiki/Singular_they#Older_usage

Ciao,
Dscho
