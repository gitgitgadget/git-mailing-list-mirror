Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537DC1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 17:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfGKR2P (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 13:28:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58890 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfGKR2P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 13:28:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 013686ADC3;
        Thu, 11 Jul 2019 13:28:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dGJmI2E47KlwvLwkWjdZPh2uphM=; b=K+z2CJ
        qGmQGum9oWp/de80tt2ADR7q871zJDgl9YAiZFpVnZLl63GVXs5et91dfcUe4NbZ
        V2C5B/zloMZWECCYEH34l+EbvXcfebneIji8nL38B5QC7i+E2p88ydylxFmARQCC
        ETpT6OhaiWyYj3LgI8B4QqVcX+GH5EGrB/c5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nCGeYWC0jxqgEtLRmAGAeNJhyfDMqOec
        hWmDcksfnsGh6akFSd7waxeCg8tG0jx8vrSmETwmelM6uyY1zAASfpyZOncgInOo
        ycfkX6w6YPi87IzH+YcJoXJN0qQNGKatxcE2rkdLvZqoBU8JMdDeGd5RJ6CT6Yo2
        H1CsV37oIn4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EC7F06ADC2;
        Thu, 11 Jul 2019 13:28:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 219716ADC1;
        Thu, 11 Jul 2019 13:28:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2019, #02; Tue, 9)
References: <xmqq36jeva9e.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907102050100.46@tvgsbejvaqbjf.bet>
        <xmqq5zo9u36m.fsf@gitster-ct.c.googlers.com>
        <CAHd-oW4-+XE_etXbDCvOX2Cdx1PcW-0oQWeq+jr=VPsf=EpgTg@mail.gmail.com>
Date:   Thu, 11 Jul 2019 10:28:06 -0700
In-Reply-To: <CAHd-oW4-+XE_etXbDCvOX2Cdx1PcW-0oQWeq+jr=VPsf=EpgTg@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Wed, 10 Jul 2019 21:02:08
        -0300")
Message-ID: <xmqqbly0scpl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40DB58C8-A401-11E9-B44D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> Sorry for the delay. I just sent v8[1] with Dscho's suggestions, which
> should fix all those test failures on Windows.

Thanks.

