Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BED5E20899
	for <e@80x24.org>; Tue,  8 Aug 2017 14:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbdHHOuI (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 10:50:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:61335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbdHHOuH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 10:50:07 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LhwLy-1dJYWg2akE-00n7zR; Tue, 08
 Aug 2017 16:50:00 +0200
Date:   Tue, 8 Aug 2017 16:49:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, David Coppa <dcoppa@openbsd.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] t4062: stop using repetition in regex
In-Reply-To: <861dc875-7300-fe5a-1360-0ed546c8c2bb@web.de>
Message-ID: <alpine.DEB.2.21.1.1708081648130.11175@virtualbox>
References: <861dc875-7300-fe5a-1360-0ed546c8c2bb@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1406963667-1502203800=:11175"
X-Provags-ID: V03:K0:xysRm0bpE8fTikbBVgeMXU+hQOlppS29ptHCkAWMDh6L1fXlI1a
 iYt7+HqoTh0LQ89ufW2JgbF/HYLbRLLd24pnLHQiKNI2woplmfHhlCpxKpCUda+eLOlHkZm
 EgDV49BB0BCTcbsH54sZeK6hpD2C1zre9INWEQNYAeldiV+BiU1eAsq6KqK+eRQrqBFjV/h
 qK9LKDrXwiQ3QHibJJiag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AAQ7ZLY7v08=:HJWcdnwhYm/daYGw0fd1yj
 aNLHH62RV+jcqEXqI2gkcQKnUB01514Aki0hZxPm5LPgGQVkMdd3WwjYJocDRuL+8PpE2TmEr
 ZuSHNRXcAB/Eo41T7UkJiKA1vxmNmceEmELtiygQ/vItMpm//jCBWg0+1nPYBGUHEpttwDXEH
 4g2GLad5VYYLcjJzzxtXl/+S5CKOL8BFZii7YEjh8gf4jbDx1rER0H9yX0qbKrawvh9A55QpI
 YBjya5/26+bcVW2LO3P6IXzo2IvRT+WvMQEuT/VDM7ixfrXFyhFQdtR8GVrhJ/813wf4Wj02E
 95sHJHfwDTnj4OtFk48M0avif7mcNsIVvnhvcqudpR+orsRtzoNUXqIFTv6YGqM1yewAtQzdK
 GrBM8+m/a6hXLn/+vi42iGgJ9SAEziYQ3lw8VfYftJp8i71w3BU5et2QWyctPT5VPBhgj1DXk
 ZDlT80sB35CPdhSL5B22DhHO1grTk/yJhQ/jLAEufUJXC9iNtT5+N9m4jPMDdBQcfBge3redN
 y2xySKFULf0O0MVD68BVn5y+a6pZlQudRuHJ4uifMCqY5sSGbJBxN2bVSHCmImVt61LQaMjHU
 wofBe4ZWhdlQ7vJykOLbvoCjMEzyt6yMXoFNSfkh53Hjfl3Dwd+PTH7PGdBcYb5RG4DClJE1u
 Dp3pyuxbu3YpfgBBBv2bEtR56YM0xSDRNXtNWRrg1CiSvEFYoaj6mjMGYMCNinZAIKDRf4bkD
 I0774oF0drnxpwuBINY38+tLEWuW45o7w49OY7O1iIeuNdUYjzTjQwgaLFcQjCk/wr+RgUpYS
 DpA6XThObjcAm0psu/pAYNq67fYkQ7WenkxZk6+psodYCuWA38=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1406963667-1502203800=:11175
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Tue, 8 Aug 2017, Ren=C3=A9 Scharfe wrote:

> OpenBSD's regex library has a repetition limit (RE_DUP_MAX) of 255.
> That's the minimum acceptable value according to POSIX.  In t4062 we use
> 4096 repetitions in the test "-G matches", though, causing it to fail.
>=20
> Do the same as the test "-S --pickaxe-regex" in the same file and search
> for a single zero instead.  That still suffices to trigger the buffer
> overrun in older versions (checked with b7d36ffca02^ and --valgrind on
> Linux), simplifies the test a bit, and avoids exceeding OpenBSD's limit.

I am afraid not. The 4096 is precisely the page size required to trigger
the bug on Windows against which this regression test tries to safeguard.

Maybe simply disable the test on OpenBSD instead? Or guard the {4096}
behind the MINGW prereq.

Ciao,
Dscho
--8323329-1406963667-1502203800=:11175--
