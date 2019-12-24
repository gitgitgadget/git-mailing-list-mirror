Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C704C2D0CF
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 14:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592C0206B7
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 14:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfLXOUK convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 24 Dec 2019 09:20:10 -0500
Received: from elephants.elehost.com ([216.66.27.132]:12439 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfLXOUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 09:20:09 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id xBOEK6XT082389
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 24 Dec 2019 09:20:06 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Hans Jerry Illikainen'" <hji@dyntopia.com>,
        "=?UTF-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>
Cc:     <git@vger.kernel.org>
References: <20191216153204.8906-1-hji@dyntopia.com> <20191216153204.8906-2-hji@dyntopia.com> <20191220225746.GF8609@szeder.dev> <87y2v54i9v.hji@dyntopia.com> <011401d5b9a0$58604df0$0920e9d0$@nexbridge.com> <877e2mq7t9.hji@dyntopia.com>
In-Reply-To: <877e2mq7t9.hji@dyntopia.com>
Subject: RE: [PATCH 1/1] gpg-interface: add minTrustLevel as a configuration option
Date:   Tue, 24 Dec 2019 09:20:00 -0500
Message-ID: <016c01d5ba65$3d8690f0$b893b2d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH/oBb3ftzF/OFyCWbLkK6Mvt6t6gKRyqzRAmGGTpICW2zphwHB0rAnAhUIgR+nHFzZEA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 24, 2019 6:31 AM, Hans Jerry Illikainen wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>; 'SZEDER Gábor'
> <szeder.dev@gmail.com>
> Cc: git@vger.kernel.org
> Subject: RE: [PATCH 1/1] gpg-interface: add minTrustLevel as a configuration
> option
> 
> On Mon, Dec 23 2019, Randall S. Becker wrote:
> > Side question: are there any tests running with alternate GPG
> > packages? I have a platform where the official GPG itself is not
> > available, so am looking for alternatives for that community.
> 
> Do you mean non-standard builds or forks of GnuPG, or alternative
> implementations of PGP?

I am specially looking for alterative implementations of PGP, not forks of GnuPG. GnuPG v2 introduced some dependencies that are not available on a few platforms that I support.

> As it stands, the test suite is hardcoded to use gpg and gpgsm (see e.g.
> t/lib-gpg.sh).  For normal use, the gpg.program and gpg.<format>.program
> config options can be used to override the programs to use.  However, any
> alternative implementation would have to mimic the behavior of GnuPG (see
> gpg-interface.c -- a number of hardcoded arguments are passed in
> verify_signed_buffer() and sign_buffer(), and the output from various
> operations are GnuPG-specific.)

Thanks,
Randall

