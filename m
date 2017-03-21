Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 905252095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933017AbdCUSYg (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:24:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53980 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758078AbdCUSXO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:23:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2EC96EB38;
        Tue, 21 Mar 2017 14:22:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HMqMeNZFoA1JyNAPBpVIUvYA5ww=; b=JyEByX
        uHdN107CxgsdImHinu6PfMSx6aeQdLwffxJanSsXlMouioHr0p51lu2UiBs+DUPL
        POrQzi+eI5HNbmebsPaCJ4NI77IC9IRfJAxm6hTXNsPHpp35sbT5YA17AYw3DsAI
        PrSddzhbafAdW8B5AB31btvlO46sYnj9Bkr9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vlSB3xkzXNNHmIn4bh5L5y9pa6vF35sV
        KFWM8Kjy1XNZI4En2tswGaxAjcf2zgT/OfJoftdf1KC7DSBVDR0a3kFUiNI1ljDn
        +2izg0xAvjjQxrKIwJfScIoF1PIvSezH2S665UoxE5bCOckO63rGuhKUd4KjYjYi
        qvD3DUwJUp0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAB9A6EB37;
        Tue, 21 Mar 2017 14:22:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 38DCD6EB36;
        Tue, 21 Mar 2017 14:22:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 01/16] tag doc: move the description of --[no-]merged earlier
References: <20170321125901.10652-1-avarab@gmail.com>
        <20170321125901.10652-2-avarab@gmail.com>
Date:   Tue, 21 Mar 2017 11:22:40 -0700
In-Reply-To: <20170321125901.10652-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 21 Mar 2017 12:58:46 +0000")
Message-ID: <xmqqa88eqykv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EC3782E-0E63-11E7-BC95-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Makes sense.
