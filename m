Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9621A1F462
	for <e@80x24.org>; Wed, 29 May 2019 12:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfE2M1D (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 08:27:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:49733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbfE2M1D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 08:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559132815;
        bh=xBS4mL4UF+fmx6+5293AkyyUiviuenNwMMY07NeMpig=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SFPPQ4hO1rXMmGFWcxra5wN3qT5E+S+Mc8YV9s2s4cc6o0Rs7DoRPHR23rYV2UvEp
         uycLHTvLDJqkfnA9NgrXxN51n+pQDnnx5ewZ/4Dpfk1UuHw/h9jTgE5HM9yDfDMsTk
         UvCgd4JGyTs7xdpS1OM/ap9EeBiamYpwEkhUGBew=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1Ee8-1gd1b532zI-00tASw; Wed, 29
 May 2019 14:26:55 +0200
Date:   Wed, 29 May 2019 14:26:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: ab/send-email-transferencoding-fix, was Re: What's cooking in git.git
 (May 2019, #04; Tue, 28)
In-Reply-To: <xmqqtvdez0yo.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905291424140.44@tvgsbejvaqbjf.bet>
References: <xmqqtvdez0yo.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1184330680-1559132815=:44"
X-Provags-ID: V03:K1:x6CmjQaifIQAD5mzkSGYmEIm5atJPsErfGGg2DTnyZPFlN+IIfh
 g+TvrO5p8vi1aW/XHBGFsoOLBvuCNB9l98mN8uAHrr8NCHK98d+cMlbAcwDnmT+1GbZtlPt
 Zec24g1T9bLkiOlVPVc3IzXE16tLwp77dob2K97nGF0LUMPs6vdAjbk65DSjouX1GHBVjsi
 H3pkO7giqRLR0A+WRdUQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kc+6AIfUE6c=:D15FLWtEH5PYaEPxANVIKh
 Onw7wGvXRM+xgc0AQSqgoQIFUIjHcfBvXQkQYuGqKfqBKZAczSObFoDz2FYcE8u4ip/qmTwMl
 O7ZQXFWgnz3HjUru90B7G6h+/Ew7tUOpc6UGE+eVscZBOr720up+DS37Fa2RRFCsONsrKVxRj
 ktpg3987bLt8e+cSLyFvRQe9WZS4GSr3nXKwnTTGxksR6hw0A5nolR3chLg3GuPDJYeYmsYTg
 ijYC1tbeUV8bqQdRII8PuII4D9EpvZKCqfKOSbWDt5wXYIP3H6J5YbQ7caahGSBkKlkFLDdBd
 IdLRcVoZSEvZUakkuhFI2bK2SEiks37L/DIenzeKt2Zi/twX2lhy1NYoy7racbZnHJ+Vmc3V5
 TpTHV0yfCkV3zo/4aIDcuWUfL24qHCVS34JWk+IhB0XEqD/8sM2XkLn0MpjvyT804YDnCr8z5
 qquUpAaO0aBJgWYmwuzzgqAMI7Fopbvh/SEyXXJYfCHenMXYiiy1CkrZ/cI1l1Xe+FOyYM6wr
 0p7E0qeAMzCUcrgDrrcnQvfUvM7siEzWnkbC3bbgQvSTSIB3mVGcX/mW6+TCeUc+YUC1+zO3o
 65IzrigwuhcNHDgc8XSCZkP1rXuLJVAVgj0m3AW9c9ZHxpAIoBqQLhoCOYtWUtG2CXC6OpEpY
 UVXGeHaHzIAXODF65TFg0XtLFEClaqH2gQ+BswYXWH23cYR2CHwD6jjuJ21O6RT/H4qUrXUka
 j4eDcvsX7E5HcE6QvNUrL4n0FQuTKP+E1GYzgz5LclXEFFlPmahVmme3DUjZIF03QZSuiZY38
 0domWhGqCdgHQkEyKy+iXKOjqVgo0xlcvMS2OFR0qMie31EDGh52/89453UyOGWPCCDqjqsL7
 p7Uk2dl7GFh2rPLcnpCHydyKLCjdnkZzuJ8yP5Ni8GyNZiHJ16brfcUZUx0nT6vInybsfnh36
 exbdVm39Bi1SU1Xy1HV53g0kZHQci9khH95OEaHr6SlXJufWT9DXA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1184330680-1559132815=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio & =C3=86var,

On Tue, 28 May 2019, Junio C Hamano wrote:

> * ab/send-email-transferencoding-fix (2019-05-19) 7 commits
>  - send-email: fix regression in sendemail.identity parsing
>  - send-email: document --no-[to|cc|bcc]
>  - send-email: fix broken transferEncoding tests
>  - send-email: remove cargo-culted multi-patch pattern in tests
>   (merged to 'next' on 2019-05-13 at 38c6a1e7e0)
>  + send-email: do defaults -> config -> getopt in that order
>  + send-email: rename the @bcclist variable for consistency
>  + send-email: move the read_config() function above getopts
>
>  Since "git send-email" learned to take 'auto' as the value for the
>  transfer-encoding, it by mistake stopped honoring the values given
>  to the configuration variables sendemail.transferencoding and/or
>  sendemail.<ident>.transferencoding.  This has been corrected to
>  (finally) redoing the order of setting the default, reading the
>  configuration and command line options.
>
>  Will merge to 'next'.

I just sent a reminder that the tip commit is broken under NO_PERL, and
accompanied the report with a diff that could be squashed in. =C3=86var, p=
lease
have a look and say yay or nay, and please let's only let this enter
`next` once it is fixed (because otherwise the Azure Pipeline will spam me
every tim `next` is psuhed -- thanks, Emily, now I mistype this every
single time).

Ciao,
Dscho

--8323328-1184330680-1559132815=:44--
