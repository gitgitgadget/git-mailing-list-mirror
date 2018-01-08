Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 645A31FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 20:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757146AbeAHUY2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 15:24:28 -0500
Received: from mout.gmx.net ([212.227.15.18]:62963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757304AbeAHUY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 15:24:26 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LsTDk-1f14wO3YMa-011zUj; Mon, 08
 Jan 2018 21:24:20 +0100
Date:   Mon, 8 Jan 2018 21:24:20 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Dan Jacques <dnj@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v5 2/3] Makefile: add Perl runtime prefix support
In-Reply-To: <87inccbscj.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801081558580.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180108030239.92036-1-dnj@google.com> <20180108030239.92036-3-dnj@google.com> <87inccbscj.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1148295154-1515423735=:31"
Content-ID: <nycvar.QRO.7.76.6.1801082122370.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
X-Provags-ID: V03:K0:QdXuASvRC6LVEmNHIpTZAdtI5QUC0MbQwjBip+yJRFRsPP8ae0r
 RknXg73byhI5z8UB1xc/GqQxD7g2N7zG5AD1tVbIOka3ZZ8/fSkuYDVNsF9/mCwsrRWtngz
 he3USkjgxxZWs49Db50RkQpYqBzRxbF+XINwrMrKgfZKe374f6qMoHjkHX64klg+htOzW4Q
 zfPg3VMYM7rm+2LiVHXVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jspkoBx5ugk=:F/f6BHwllwWRgun66jJrfL
 X0j6x0MUYz3pkDtnSf0yT32bVE6MnBHR2wx9FO7raZVtH1mK2jHUqpS6Z5kvdnu3YADltniU8
 wbGU7KI7BV+FBIRewVS+RkQG38AAgKFe/Crl1/CCAQJUkZ33WiJ5V6z4r3YLReB8z5tBdOpym
 gGTg9sdQY4F5AXJzC/vGUCoN/39Uz2UG0qo/K5tnhVeX/4jBs8ELY4lYlwwesxVX6int57XBs
 Yc8bKAHw2dJkbc3rHcMiHV8Xz7IyJjziu4kl7JMX28yaVfOd6ZzCkrLegnRhYDZIE4jdrutlE
 TL/x8vjsjG3YsNyNRwRwPscCLNkHduGMKMr48mbM0dT5uUwpI5hG/9a2xs3/OekNr5ey/uKL5
 K4zuSEHOAaL+Ez572IDXeTbngRcTp7BXTnkRa1pSMm2jhg7zWa+TlxFDIod+JQrG72XjNx2dK
 3xSfq28J5TXrY5MY+a89SyE1telCNtPhW6rHF81zWhW4p2lfbrovCDs/Vfvp9opMfJznPE0nH
 XmzWMAA4PtCcL/HjwjF5JGXi+smwMZv3P4BBFOFQFsDlKYm20zzjXA/hQdF5avqD/4hWGDcnc
 SbhIo5tofQEGzkmGaHNxF4FE12tRIVbYwm1h4HwMC2U43aCleiNlV6g7JSIRk+tyyVRrmB46m
 Vm6D8DNyPEcp5P0cuONTZjotVyxRIqZ9lSXUXmHctI4gqwBTbNLVpgbw1ep2FI0vXxnnhQnrm
 zp44eX535IhWPUTEYIQjeL9kIVpJ/PNpXIAISfZFKM1eZ4LgIOCEEvD1vJbnAdgJ7Z7qONl+Z
 mBpx5QWPkVBe0nF5jN5/tFSehpgzcKvNR6oQixRriN3D1VeKLOW3tjRxPtVhwnLfjC8AHJ8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1148295154-1515423735=:31
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <nycvar.QRO.7.76.6.1801082122371.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>

Hi,

On Mon, 8 Jan 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>=20
> On Mon, Jan 08 2018, Dan Jacques jotted:
>=20
> From 3/3 (not not send 2 e-mails):
>=20
> >+# it. This is intentionally separate from RUNTIME_PREFIX so that notabl=
y Windows
> >+# can hard-code Perl library paths while still enabling RUNTIME_PREFIX
> >+# resolution.
>=20
> Maybe we covered this in previous submissions, but refresh my memory,
> why is the *_PERL define still needed? Reading this explanation doesn't
> make sense to me, but I'm probably missing something.

If the reason is to accommodate Windows, I think it'd make more sense to
change the way Git for Windows handles this, and use the same relative
paths (if possible, that is, see the GITPERLLIB problems I mentioned
elsewhere and which necessitated
https://github.com/git-for-windows/git/commit/3b2f716bd8).

BTW I managed to run your `runtime-prefix` branch through VSTS builds on
Windows, macOS and Linux and they all pass the test suite. (Including the
RUNTIME_PREFIX_PERL=3DYesPlease setting you added for Travis CI testing.)

What do you think? Should we just fold the RUNTIME_PREFIX_PERL handling
into RUNTIME_PREFIX and be done with that part?

Ciao,
Johannes
--8323329-1148295154-1515423735=:31--
