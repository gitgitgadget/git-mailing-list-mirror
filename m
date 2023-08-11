Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B8AC0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 21:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbjHKVvd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 17:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbjHKVvc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 17:51:32 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48DB2D70
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 14:51:28 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 37BLnDDI885183
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 21:49:13 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Mun Johl'" <Mun.Johl@wdc.com>, <git@vger.kernel.org>
References: <SJ0PR04MB8289FF1D6BAC59833D922BA89C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>        <034501d9cc91$069bd360$13d37a20$@nexbridge.com>        <xmqqr0o9qpon.fsf@gitster.g>        <034d01d9cc94$df9db0e0$9ed912a0$@nexbridge.com>        <SJ0PR04MB82892A7EB350531DBE4701BA9C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>        <035b01d9cc9d$4c2168d0$e4643a70$@nexbridge.com> <xmqqr0o9p7vj.fsf@gitster.g>
In-Reply-To: <xmqqr0o9p7vj.fsf@gitster.g>
Subject: RE: "fatal: Not a git repository" issued during 'make' from source code
Date:   Fri, 11 Aug 2023 17:51:20 -0400
Organization: Nexbridge Inc.
Message-ID: <036801d9cc9d$fa5c3920$ef14ab60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGYfaIzxiLvNNliA6NGPhsdV5ubsQMKIH4jAmvty4sCHttM2gLYUX00Ai/ucqYBzg0XNK/05rbQ
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



>-----Original Message-----
>From: Junio C Hamano <gitster@pobox.com>
On Friday, August 11, 2023 5:49 PM, Junio C Hamano wrote:
>To: rsbecker@nexbridge.com
>Cc: 'Mun Johl' <Mun.Johl@wdc.com>; git@vger.kernel.org
>Subject: Re: "fatal: Not a git repository" issued during 'make' from source
code
>
><rsbecker@nexbridge.com> writes:
>
>> Did you run 'make configure' before using 'make prefix=/usr/local all
doc' ?
>
>A tarball release ships with configure (built out of configure.in)
included, so that
>should not be necessary.

Thanks. I don't usually build from a tarball. However, the OP did not
indicate that configure was run either.

