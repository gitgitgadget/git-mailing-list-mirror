Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2904EC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 21:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C926128C
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 21:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbhFPVFB convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 16 Jun 2021 17:05:01 -0400
Received: from elephants.elehost.com ([216.66.27.132]:37275 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbhFPVFB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 17:05:01 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 15GL2pJD069645
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 16 Jun 2021 17:02:51 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Felipe Contreras'" <felipe.contreras@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     <git@vger.kernel.org>, "'Derrick Stolee'" <stolee@gmail.com>,
        "'Jeff King'" <peff@peff.net>,
        "'Bagas Sanjaya'" <bagasdotme@gmail.com>,
        "'Robert Karszniewicz'" <avoidr@posteo.de>,
        "'Emily Shaffer'" <emilyshaffer@google.com>
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com> <xmqqfsxitw2n.fsf@gitster.g> <60ca66304a0a0_6027208c8@natae.notmuch>
In-Reply-To: <60ca66304a0a0_6027208c8@natae.notmuch>
Subject: RE: [PATCH 0/6] doc: replace "alice" and "bob" examples
Date:   Wed, 16 Jun 2021 17:02:45 -0400
Message-ID: <011201d762f2$f82522f0$e86f68d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKQdLJNuDdAxnnS9qG6xGti+zIwfwImV/ffAVqPygOpiPSZ0A==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>From: Felipe Contreras <felipe.contreras@gmail.com>
>Sent: June 16, 2021 4:59 PM
>To: Junio C Hamano <gitster@pobox.com>; Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>Cc: git@vger.kernel.org; Derrick Stolee <stolee@gmail.com>; Jeff King <peff@peff.net>; Felipe Contreras <felipe.contreras@gmail.com>;
>Bagas Sanjaya <bagasdotme@gmail.com>; Robert Karszniewicz <avoidr@posteo.de>; Emily Shaffer <emilyshaffer@google.com>
>Subject: Re: [PATCH 0/6] doc: replace "alice" and "bob" examples
>
>Junio C Hamano wrote:
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>> > I suggested in [1] that the "alice" and "bob" examples in our
>> > documentation would be better written without a reference to such
>> > fictional characters, for reasons that have nothing to do with
>> > trying to bend over backwards to avoid any reference to people's
>> > gender. It just makes for better documentation.
>>
>> I actually do not mind cast of characters with concrete names,
>> especially when there are more than three parties involved and having
>> names for them help clarify the description.  But I agree with you
>> that Alice and Bob should be reserved for situations where appearance
>> of Eve would reasonably be anticipated, or the use of these two names
>> become distracting to those who happen to be aware how these
>> characters are often used in CS literature.
>>
>> Perhaps s/Alice/Tabby/ and s/Bob/Fido/ or something like that ;-)?
>
>I don't know anybody named Tabby or Fido (or at least any human).
>
>Maybe Mary and John, or Linda and James.

Stevie, Jan, Pat, Chris, Randy, and Sue (if you're a Johnny Cash fan)

I have used some of those in docs.

