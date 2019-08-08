Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52D4B1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 22:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404517AbfHHWJD (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 18:09:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57001 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404029AbfHHWJC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 18:09:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A058156A64;
        Thu,  8 Aug 2019 18:09:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7z2zP36QImg7
        emOUeMz1ftsPVWY=; b=Oin4IoaLc+QiPdaTFTeKwvq9sOaOoOwG8jifEC4Hb/Hw
        M+J3CNE4AB5TMT34UwwVQci5CnFPySYfDmJpDM4jafuAJL9Zn6mPC61n+zsLcpPn
        JRX/UCatcWtUvxLA6VAzfT0IqbJJ8NJhBi3RnEe3Ip3gW5kWkQ9R2tQaR5lCRGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PQT2Sh
        An9BXpbCuVJEhPnzUvhSzdy91BthOfAyZLhhrLTJEw3I5qaxqQEnEFyX0nlfgt+o
        Q/yeb5E/mzN1I4N+i0JY/I2qG8S+U1MTTgq1X4dR9K9aL3edCHWhr6h5iXjAbelB
        h8DVZYvnQX1Y2W6rfd268uQL0LkCibJQD9qX8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70EF4156A63;
        Thu,  8 Aug 2019 18:09:02 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4BD6156A62;
        Thu,  8 Aug 2019 18:09:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] tests: show the test name and number at the start of verbose output
References: <20190803080126.29488-1-szeder.dev@gmail.com>
        <20190805210447.7169-1-szeder.dev@gmail.com>
        <nycvar.QRO.7.76.6.1908082211550.46@tvgsbejvaqbjf.bet>
Date:   Thu, 08 Aug 2019 15:09:00 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1908082211550.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 8 Aug 2019 22:12:23 +0200 (CEST)")
Message-ID: <xmqqk1bne2df.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 20D6871C-BA29-11E9-B235-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 5 Aug 2019, SZEDER G=C3=A1bor wrote:
>
>> Include the test script number, test number, and the test name at the
>> start of the verbose output of each test, to help navigating the
>> tests' logs.
>> ...
>
> Looks good to me!

Thanks, both.
