Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40CCA1F461
	for <e@80x24.org>; Mon,  8 Jul 2019 21:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbfGHV5g (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 17:57:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51282 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732609AbfGHV5g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 17:57:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2231415B2BD;
        Mon,  8 Jul 2019 17:57:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZLgPRKhAEo7u
        U/rG54xtDJrb9ms=; b=phOO9uhXEpxIWT0bmXo6ZPR98BHF7gO4OHBuS6lgMdTz
        WR/FMgA0W2Mhm1Hay7IO33i6uMNivl+r+kHUMWkqhxP3lFdGFA2nxTr6aWtKLTIF
        GeY61oNoKyyxdypH8M8YW8h3KsHTqAjonTbiHMleUQmlRmAw2IwF6MhMDpFbQH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fqYhyB
        vCasLPgjW0DjpymfI5/6sR6Q+P4Ashphsm3chV6PHATnZS3h9UNC71/aszMHN9JY
        m8QQOmvoKCgzgeRz/KslYepgmBkYeDBRDDOtpZLPnK7jq9sXnLPaQuvNcFq6Vaa/
        25Uf5//cy3vDvDTHU1M0GC24nb9xPGPmqZhgU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18EDF15B2BC;
        Mon,  8 Jul 2019 17:57:34 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B7BE15B2BB;
        Mon,  8 Jul 2019 17:57:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: kb/windows-force-utf8, was Re: What's cooking in git.git (Jul 2019, #01; Wed, 3)
References: <xmqqpnmqzrbg.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907041125410.44@tvgsbejvaqbjf.bet>
Date:   Mon, 08 Jul 2019 14:57:32 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907041125410.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 4 Jul 2019 11:26:45 +0200 (CEST)")
Message-ID: <xmqq4l3wxk8j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 63BBAD58-A1CB-11E9-83C9-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 3 Jul 2019, Junio C Hamano wrote:
>
>> * kb/windows-force-utf8 (2019-06-27) 1 commit
>>  - gettext: always use UTF-8 on native Windows
>>
>>  Windows update.
>>
>>  On hold.
>>  cf. <nycvar.QRO.7.76.6.1907031321270.44@tvgsbejvaqbjf.bet>
>
> I submitted v2 in
> https://public-inbox.org/git/pull.217.v2.git.gitgitgadget@gmail.com whi=
ch
> should address the issue.

OK.  I didn't follow the exchange between you and =C3=86var too closely,
though.

