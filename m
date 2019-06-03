Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4245B1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 18:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfFCSKK (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 14:10:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58241 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfFCSKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 14:10:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46A001552A0;
        Mon,  3 Jun 2019 14:10:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xh9HnZdGTykEoYZOyasD+kEkdzg=; b=sjhAo0
        R/6Jn6skNHrD7ABZuQ6m8VrWMQ8yKkylgH6MppBirLuiUHd/BsgxGXW+fuVk4bRy
        /4Zn0IiY0Qnv2P6EYulXgy/wWbNxVbPzstCVDj+AILmK6sNv/JmKWEAAPzrC+tTd
        ye0f0vWSJ6tKF874wgdgOXSHKgfz4/WqC2AXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W23+/yeybtLeugCuDlrSW03c15w1a/Y+
        F20i/rYqFbTafiSsgwZ8HPpDpt5HXkI2bPPtUNFQLV0tJx6upjCaC9t3N2YQXfvr
        YtGJQXJ9KOd+qEFifE2CDGBoijRr9xRtt2D0vHP0MAPVM7nbl2kAis4D/vHajwl1
        IW3eWBAlJlk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39DCC15529F;
        Mon,  3 Jun 2019 14:10:07 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3BFF015529E;
        Mon,  3 Jun 2019 14:10:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] i18n: fix typos found during l10n for git 2.22.0
References: <20190602151122.7512-1-worldhello.net@gmail.com>
        <nycvar.QRO.7.76.6.1906031543190.48@tvgsbejvaqbjf.bet>
Date:   Mon, 03 Jun 2019 11:10:03 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1906031543190.48@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 3 Jun 2019 15:43:44 +0200 (CEST)")
Message-ID: <xmqqftoqv8uc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0EB0908-862A-11E9-9B83-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Jian Xin,
>
> On Sun, 2 Jun 2019, Jiang Xin wrote:
>
>> + ed8b4132c8 (remote-curl: mark all error messages for translation,
>>   2019-03-05)
>
> Urgh. Sorry for that, and thank you for cleaning up my mess...
>
> Ciao,
> Dscho

Thanks for a fix and a quick ack.  Very much appreciated during the
rc freeze period.
