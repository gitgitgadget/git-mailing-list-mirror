Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D13C433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 22:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbiDFWe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 18:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiDFWez (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 18:34:55 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AD133C
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 15:32:57 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.251.39] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 236MWsnS057878
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 6 Apr 2022 18:32:55 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Git Mailing List'" <git@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <034101d84873$993f96f0$cbbec4d0$@nexbridge.com>        <CAPc5daWSDYSexkSeUUpfYDyT-M_F8d-rSMko5pqw140iLwBc_w@mail.gmail.com>        <034701d84875$030bfb40$0923f1c0$@nexbridge.com>        <xmqqv8vmyysp.fsf@gitster.g>        <046001d849d2$9daf2290$d90d67b0$@nexbridge.com> <xmqqsfqqxat4.fsf@gitster.g>
In-Reply-To: <xmqqsfqqxat4.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
Date:   Wed, 6 Apr 2022 18:32:48 -0400
Organization: Nexbridge Inc.
Message-ID: <048601d84a06$416fe120$c44fa360$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE87yXqDmaysdJkpyH6/spM26GbOgJ005kMAt5RIzwBs7vytQKANYWoAhiW5G2tvTBagA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



>-----Original Message-----
On April 6, 2022 3:38 PM, Junio C Hamano wrote
><rsbecker@nexbridge.com> writes:
>
>> I have no explanation on why this and the PATH issue showed up at
>> 2.36.0-rc0 and not at 2.35.1. 2.35.0. Our build/test cycles are
>> thorough but only on the releases and rc* ...
>
>Ah, OK, so I had a wrong impression, which explains my puzzlement.
>
>I somehow thought that you caught us soon after stuff got merged to
'master',
>and sometimes even to 'next', for a few times before.

I am working on getting a much faster system. Once that happens, I hope we
can increase the cadence of my test cycle.

Regards,
Randall

