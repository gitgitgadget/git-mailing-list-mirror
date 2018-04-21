Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB881F424
	for <e@80x24.org>; Sat, 21 Apr 2018 07:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbeDUHVG (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 03:21:06 -0400
Received: from mout.gmx.net ([212.227.17.21]:39173 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751366AbeDUHVF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 03:21:05 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHXd2-1f8gti1Ne8-003NyN; Sat, 21
 Apr 2018 09:20:58 +0200
Date:   Sat, 21 Apr 2018 09:20:56 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/4] rebase -i: Handle "combination of <n> commits"
 with GETTEXT_POISON
In-Reply-To: <CAGZ79kZM3Q-HnPAqMUZM_NtfCumsWBtwrFT2HPkU_d95iJdzOQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804210920390.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com> <cover.1524258351.git.johannes.schindelin@gmx.de> <6fe8b38c7097c826f17e5f45e39ffbc35a529849.1524258351.git.johannes.schindelin@gmx.de>
 <CAGZ79kZM3Q-HnPAqMUZM_NtfCumsWBtwrFT2HPkU_d95iJdzOQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3eXwxzAgNzOBp1Ew1jIg+bpTpKDg+ycXnt4iQ0AM69AArpp2+I9
 ucSKVtoutBzmP8LCqgnMYX7DytnA16JC77sIGGeUtTOlL1A5vqbMHfjUZzSR493dYUtO00G
 xv3qUrOwniTZQkpA51cfZXsPtWIpWuWauDXmt6qm40MrPD9N6na5SVD1d3ZNT6QyFknB4IH
 DXvN8NlU/14DjkdMUKJ3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7MfzduavnCM=:XPbULsfizAjlezgrnYKksz
 Vhg7tgF8UAoVXaMv4rhP5ydmyEArzwFTl0qIkCuzH5019E6UzPK8fimbwebSqUHedAut3TeMn
 xVc1/zt2zSqgPnsgjg2ogy18LJrfCqxTlwZbg7V4U7bhuiYNstWtJ779hgehINzQ9sD/gSWtg
 +VlUUwNfjoV7NdFAuuMxZHoiHxp+gziHfAyKHuoqgqYngQJjieyI4DY2uvvXyKUf1yLiKlbkH
 3DTqWF4+2lFivF9xk6GtEmOSIbJC6XCyDUD9X3W3QGVbcJNr34r9pkZwJhq5GuPa0VQGkloLb
 /QdgiRiGdjVu04XtGrRcdZvh++gt7Arc8tq4PXyrDURm/4FD27VuWPBHAuZJa/WOy+I55Leum
 vXi/zp7lY17os69srMjRhVptleF2MbhACJCKXFjMngBjJxdPxzcB0qoikoCSAYaMYR+YUu0+6
 diMcuTfpx8wm2NZ6nr/4Co4t1d0Un+V9lWYmmN1HZ1pnqTjCU1Y4NNMJjIRp31dsoa11arI0f
 BaMYo7V3zCLzRS68faSPhmtMU/bLM8AEZXH26YXendgAwZZAbxveNHW4rO8pzGXG/JWOdiael
 7yDEcbtgAPgzDhX/21/zyuaZ6diVRUu2+si2ebttN5wzA8Bj+UuR1oOYjUa+C7Tk9Kc5eGn8Z
 M0cO9TnPVjoBa67SUeX41UsCf5cvXTFcfRF+tB3K+1ArAY+f5HNRuCatZ0Tif4If5WeH6/AUy
 OOlMKZGCGJ9K3LyQhrdiNwd/Lnk0IP5gq6xFnVnTMq6FoT4lS2igYb1FDNJTeoBG7gBhVFYpB
 t4Kzr23z/gI2mi4/lv1nkGq9dm2/vdzhehy3SbOJayggWV0ql0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 20 Apr 2018, Stefan Beller wrote:

> On Fri, Apr 20, 2018 at 2:07 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > We previously relied on the localized versions of
> >
> >         # This is a combination of <N> commits
> >
> > (which we write into the commit messages during fixup/squash chains)
> > to contain <N> as ASCII.
> >
> > Thisis not true in general, and certainly not in GETTEXT_POISON, as
> 
> This is
> 
> Apart from this typo, this patch looks good.

Ouch. Fixed, locally.

Ciao,
Dscho
