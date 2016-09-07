Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93D5B1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 18:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbcIGS0E (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 14:26:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50263 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751147AbcIGS0D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 14:26:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 305C337C65;
        Wed,  7 Sep 2016 14:26:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yq5wRGtUEexBms7uGYd33mwlzCo=; b=Lo6lE/
        vM+0R9/lBi8u28y1LIrLXgjvOdimTvqiSNZcbfTauS2Qb7JL1gQtc8VspwxVa0bL
        V0SphBGa1mOhiXmxV5QUbbgDyZF1S7KoA2rM6YYlm6HFYWdpFr3lZjALUF0wLETc
        +NWw+7XYYXEA4Cooo/AeOLHEjJVw9x7NfVUvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Aw0qYZdh2dfw+Li3AvHAbFegcjZUhyrn
        Gixigv3iKIkXjXfd3EW41PqLLNfL4EEgpMfDVSqWovgOtA5KQaEMMAy3colr6NoF
        970W4WSm03fq2QGHD+Y0y8FzVuJPZ10T0bEkB9IN2F5I6sc7vuEPQ1PdFexHIhc1
        4WPoilHLJOo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 032E237C64;
        Wed,  7 Sep 2016 14:26:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E22D337C62;
        Wed,  7 Sep 2016 14:26:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] t5550-http-fetch-dumb.sh: use the GIT_TRACE_CURL environment var
References: <20160905102444.3586-1-gitter.spiros@gmail.com>
        <20160905102444.3586-4-gitter.spiros@gmail.com>
        <CAPig+cTsCDpCQ9j82OEa13YBYswDKfYd_dc1QbxRSRk3wiOhHw@mail.gmail.com>
        <CA+EOSBki1E8HJ1DMuAuQaB6sBcUjvQLA5xUWdF9G+6+HRQUD7g@mail.gmail.com>
Date:   Wed, 07 Sep 2016 11:25:57 -0700
In-Reply-To: <CA+EOSBki1E8HJ1DMuAuQaB6sBcUjvQLA5xUWdF9G+6+HRQUD7g@mail.gmail.com>
        (Elia Pinto's message of "Mon, 5 Sep 2016 21:09:23 +0200")
Message-ID: <xmqqpoofmuru.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 873CFDAE-7528-11E6-B94C-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

>>> +       cp expect expect.$$ &&
>>> +       cp actual actual.$$ &&
>>> +       cp output output.$$ &&
>>
>> What are these three cp's about? They don't seem to be related to the
>> stated changes. Are they leftover debugging gunk?
> Yes, i am very sorry. My bad. I will repost. Thanks

Nevertheless, thanks for these clean-ups.  Will discard this round
waiting for a reroll.
