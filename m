Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F4471F461
	for <e@80x24.org>; Mon, 13 May 2019 05:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEMFvl (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 01:51:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50138 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfEMFvl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 01:51:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D22EB14EC25;
        Mon, 13 May 2019 01:51:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=54JFXtYgE7wJ
        giAKfQbrqobY/kE=; b=uEGPkAyMsTVEY5B+BfM/n4rauFhegNBAmA0thC8a/RcR
        y/2phvuynf8vZWn/uydX+j+w51rytJZNw/dHhfRmmIZ1zOaWnRwuCPaMg04VZDZ1
        thF8rBfF3/eZKuMm3GW+k7EjgOhxw9R7O++FkxD4fqnzGnQpXVWqxhhkDxBrluk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rfq60D
        iEuwutee6cHuvm96y+4duBIPTA5+tBSE/sUcH+CJljKh5MGwOhaJ3/bHSvlcFtd6
        fD/OP5vDEfVDF/CxaU0z9uWWTJhPZhz1ZbB2y9h7kGm6LgCQQlAFOpMUkrdaONgf
        KgKYUnwn/5dfRCQGEfftYcC5jRRvy6cwm6tCw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C744A14EC24;
        Mon, 13 May 2019 01:51:38 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 37B8A14EC23;
        Mon, 13 May 2019 01:51:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] status: add an empty line when there is no hint
References: <20190430060210.79610-1-johnlinp@gmail.com>
        <ae1332b8-a227-e83a-8862-8811b6a81251@gmail.com>
        <20190501234512.GD202237@genre.crustytoothpaste.net>
        <CAKO26MvXmOMHgqWSoVrmdwyDFyqDrChkMOHq6iuJAX8pvHzZoA@mail.gmail.com>
        <20190502231537.GE202237@genre.crustytoothpaste.net>
        <CAKO26MuisScMPp0SxRo896y7waEgR3HjU3A8+VM73eS0xgU8RQ@mail.gmail.com>
        <CAKO26Mtn+KDnkHWsKf8mAyTmeaCYK0gjdNad5bxJe-qxjKs=xw@mail.gmail.com>
Date:   Mon, 13 May 2019 14:51:37 +0900
In-Reply-To: <CAKO26Mtn+KDnkHWsKf8mAyTmeaCYK0gjdNad5bxJe-qxjKs=xw@mail.gmail.com>
        (=?utf-8?B?Iuael+iHquWdhyIncw==?= message of "Fri, 10 May 2019 08:56:00
 +0800")
Message-ID: <xmqqh89ydhqu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2C912CEA-7543-11E9-B845-E828E74BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E6=9E=97=E8=87=AA=E5=9D=87 <johnlinp@gmail.com> writes:

> Hi Junio,
>> ...
> Could you please give me some advice on my patch? Thank you.

I tend to agree with what Phillip said in
<ae1332b8-a227-e83a-8862-8811b6a81251@gmail.com>.

If the difference between "status" and "commit" bothers you so much,
i.e.

    When typing "git status", there is an empty line between the
    "Changes not staged for commit:" block and the list of changed
    files. However, when typing "git commit" with no files added,
    there are no empty lines between them.

it may not be a bad idea to try making them consistent by removing
the blank line that is given after the advice messages, perhaps?
