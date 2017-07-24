Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BDCA203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 20:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755500AbdGXUmv (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 16:42:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58413 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755088AbdGXUmt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 16:42:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7AAA9AD33;
        Mon, 24 Jul 2017 16:42:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ae7yKET52pw9
        oTqs7JMQXhNEAnU=; b=SDh4nNd9Q8zvkqdjy6TUGxLU4k6Cv33wuy3THCchjZhv
        KU5vXdUBbStp+rx6Rj652ZsKpY+rrYzwVvMy+SsFdQ9hlygIHq/MLh1Hm2s9RH7z
        /1Vqmuo8ecQkaoeM/FAQZN4iu9vNL6mIRR45IPJiXyBVo3vSOTYaAdHgOqn9Vro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NPHK1b
        mswRATDKgs95ovuQ6IlfCYKseOOlt+MXkc7IELcOfgLyXXEe1RzJdLkh6Kc1zzec
        P0yKUjUFrww7ejW0LjZmXjHjXeA+M6aY19VgvLSRaGRZNNZLcXtynBdAnvf1YoQx
        /nMJDk2ndDPpz2Dsdx4n5czYUn08onDsHC6C8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C02A79AD32;
        Mon, 24 Jul 2017 16:42:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 222449AD31;
        Mon, 24 Jul 2017 16:42:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     lukaszgryglicki <lukaszgryglicki@o2.pl>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] merge: add a --signoff flag.
References: <0102015d0c41db74-34ff8613-05e2-44bb-a05b-2624108c36c8-000000@eu-west-1.amazonses.com>
        <0102015d0cf235f7-9be8e1fc-a926-4e6f-8180-c131da1c4161-000000@eu-west-1.amazonses.com>
        <FE86ED74-D646-4CA8-B931-26BC12B030CB@o2.pl>
        <xmqqk22ye2rh.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 24 Jul 2017 13:42:46 -0700
In-Reply-To: <xmqqk22ye2rh.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 24 Jul 2017 00:02:26 -0700")
Message-ID: <xmqqr2x5d0s9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A74D7D2E-70B0-11E7-A403-EFB41968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> lukaszgryglicki <lukaszgryglicki@o2.pl> writes:
>
>> Hi, what is the state of this patch?
>
> I was expecting you to respond to =C3=86var's <87tw2sbnyl.fsf@gmail.com=
>
> to explain how your new version addresses his concerns, or him to
> respond to your new patch to say that it addresses his concerns
> adequately.  I think neither has happened, so the topic is still in
> limbo, I guess...

Sorry, =C3=86var's message I meant was <87fueferd4.fsf@gmail.com>.
