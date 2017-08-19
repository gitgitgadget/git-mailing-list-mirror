Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBEC3208CD
	for <e@80x24.org>; Sat, 19 Aug 2017 06:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750947AbdHSGR2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 02:17:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62487 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750832AbdHSGR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 02:17:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A59A09C907;
        Sat, 19 Aug 2017 02:17:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NG9p3J3AM+Il5Dwq5vnBvvN6tew=; b=d6IHpZ
        n3BAds0oX+JPZZzZ3+XpYpDoEHxloGK+oMKDvnb4Wzm2xCJ3Uqi8O6HQDGul1Y0i
        AK8kb+9d/8Jo9JraUWH57EXWXazSVQaDrPjzpluH6bMDRQaeffYmTLClOC/XImrA
        6C+kqfzyM3rMT8atBBf4mAGqg3UaH80PGoKCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b1yn+d2bR8I66079gNkMQgrQFkXBImPn
        hxnoT/MOqRvngv1X1i9Cy1PrLN8GLcHcO4XkFQ6kFFSXaa4f1wK25NwO5Vmh+/HB
        OySHcZ14VKWEujk8Z9VWnR7PIuzP0mNRrFT4jkSzGtYavv2UJ2Mt2SCFahMkPj+S
        NI5OLJIIP7w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DAB89C906;
        Sat, 19 Aug 2017 02:17:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F16D99C904;
        Sat, 19 Aug 2017 02:17:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] pull: respect submodule update configuration
References: <xmqqpobsbsk1.fsf@gitster.mtv.corp.google.com>
        <20170818220431.22157-1-sbeller@google.com>
        <CAGZ79kbQP8mR9Y5Yo7e4uDwQLP9NQjduuErx4YcTo=NpLCCn3A@mail.gmail.com>
Date:   Fri, 18 Aug 2017 23:17:17 -0700
In-Reply-To: <CAGZ79kbQP8mR9Y5Yo7e4uDwQLP9NQjduuErx4YcTo=NpLCCn3A@mail.gmail.com>
        (Stefan Beller's message of "Fri, 18 Aug 2017 15:05:29 -0700")
Message-ID: <xmqq1so8axoy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DDBE342-84A6-11E7-A1BD-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Aug 18, 2017 at 3:04 PM, Stefan Beller <sbeller@google.com> wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>
> eh, that is what I get for amending to Lars patch.

Sorry, I do not understand this remark.  

If you started from a patch by Lars (I do not recall seeing it but
the list is high volume so it is entirely plausible that I may have
missed it) and tweaked it, it is more than OK to keep the original
author and record it in an in-body From: header like you did,
instead of taking authorship over.


