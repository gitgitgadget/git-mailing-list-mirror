Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BB8C433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 18:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241534AbiERShF convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 18 May 2022 14:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241296AbiERShE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 14:37:04 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6671DB586
        for <git@vger.kernel.org>; Wed, 18 May 2022 11:37:03 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 24IIau9j059546
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 18 May 2022 14:36:56 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Plato Kiorpelidis'" <kioplato@gmail.com>,
        <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>,
        <avarab@gmail.com>
References: <20220509175159.2948802-1-kioplato@gmail.com>       <20220509175159.2948802-14-kioplato@gmail.com>  <88421b18-0fa0-236a-b74b-c5ee3ef53279@gmail.com>        <20220518173947.4qabalu6mjmzumen@compass>       <016201d86adf$5a4e1eb0$0eea5c10$@nexbridge.com> <xmqq35h6ww55.fsf@gitster.g>
In-Reply-To: <xmqq35h6ww55.fsf@gitster.g>
Subject: RE: [PATCH v2 13/15] dir-iterator: option to iterate dirs in pre-order
Date:   Wed, 18 May 2022 14:36:50 -0400
Organization: Nexbridge Inc.
Message-ID: <016b01d86ae6$40b2ed80$c218c880$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEtoa9KICtof6G0d82GO44tkWkaaAFac/2+AdFePPMCFShFEwG1hhefASaFcyeuOaChAA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 18, 2022 2:09 PM Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> Could this be a fallback position where nftw() is not available? I am
>> not how broadly nftw() is supported but it appears to do what you are
>> looking for.
>
>Yeah, nftw() sounds like a better approach than what we have been doing for the
>past decade by writing our own iterator.

Not to mention being blindingly faster and lower resource usage on some "exotic" platforms 😊

