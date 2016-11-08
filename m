Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C09672035F
	for <e@80x24.org>; Wed,  9 Nov 2016 05:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbcKIF4T (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 00:56:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52093 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751725AbcKIF4S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 00:56:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C878D4EEE4;
        Wed,  9 Nov 2016 00:56:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=h9adRjFwqaZdYB77LGQoMS9rlNQ=; b=hFBsXXIEajCPjF17yAkY
        zHrep6WChj4pp0yz2VbSizHtGv7nd1eLVKWFssVrznp00F2DkrdH7mm+/emgNCzy
        TIsyFie4DFJLcqDO8CUWvHzWqvdVL0aop63iNTso8aNPDceK/EWYQ9y5iw3iJZc4
        T1EhSam5P6QQZr/ENe/rYt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=cw68gqmBjsu9fSld8HhZv+jSMMk6gv0DEPS1/1+NeGyCXN
        zmW5FYfuKlPfFEDFC7f+lFWfJgZkZ/HFOIOTnSekbPuIHiBQxJ4p8TMN854JPOn3
        R+L61nAIXli6WBJxpy8IIchmQCRRIFeCojibucHlWbZLHNzabeGN5XhNri1NQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE0524EEE3;
        Wed,  9 Nov 2016 00:56:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2B8F74EEE2;
        Wed,  9 Nov 2016 00:56:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bburky@bburky.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 1/2] lib-proto-disable: variable name fix
Date:   Tue, 08 Nov 2016 12:52:54 -0800
References: <1478292933-7873-1-git-send-email-bmwill@google.com>
        <1478547323-47332-1-git-send-email-bmwill@google.com>
        <20161107202637.ooaddlkfntw37xg3@sigill.intra.peff.net>
        <20161107204028.GC143723@google.com>
        <20161107204838.xm463zdimiw7fx77@sigill.intra.peff.net>
        <CA+P7+xohFeWb1hsOg1_T1kWenc=AKrt1TNcx=TrVYQ+w3+c63Q@mail.gmail.com>
Message-ID: <xmqq4m3hb3i8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A4D0CD8-A641-11E6-9829-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Mon, Nov 7, 2016 at 12:48 PM, Jeff King <peff@peff.net> wrote:
>> It's possible that I'm overly picky about my commit messages, but that
>> does not stop me from trying to train an army of picky-commit-message
>> clones. :)
>>
>> -Peff
>
> You're not the only one ;)

Somebody seems to have trained y'all very well ;-)

