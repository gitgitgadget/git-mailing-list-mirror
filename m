Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7512920281
	for <e@80x24.org>; Tue, 19 Sep 2017 01:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751024AbdISBSp (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 21:18:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56242 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750893AbdISBSo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 21:18:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 49E7A962C2;
        Mon, 18 Sep 2017 21:18:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nMV4iAqh5fRROz1v/UX1RZRFX1w=; b=Kwi4xO
        n+RPn3Ej/gRiT+yKIt34U02cSvj2wybJhdqAWEqIXEu34lIM3Oe+epRbYgY7Bzs/
        LS88ojoyp+NsnT6AP8GeMw5M8tCq7SnVhlmG2aCvabn55OQ99Zx0XV3tugEjXtzc
        U1P/3TFC3SnCNu3DUxIPGQcE5vupOOYVKsEnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cnp4BvposIoey26lxuupS4W2vUDSEGVt
        qK6sc406sJCgNePfyILsF4qMEgEPTq6wmALr1Nvi5fM33xEDzSNYxidEgKyoNiSJ
        PwC/8xB8NYfkx+uaoSc9m9S+cGi0VGmTcyM2hICfFlUZnPAS0ya/XQVezskaY7eB
        hf4pwnqB6Yo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41CBD962C1;
        Mon, 18 Sep 2017 21:18:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A3E8B962C0;
        Mon, 18 Sep 2017 21:18:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2017, #03; Fri, 15)
References: <xmqq8thgy03t.fsf@gitster.mtv.corp.google.com>
        <44574AF3-D215-4486-B7AE-72F83CC934C5@gmail.com>
Date:   Tue, 19 Sep 2017 10:18:42 +0900
In-Reply-To: <44574AF3-D215-4486-B7AE-72F83CC934C5@gmail.com> (Lars
        Schneider's message of "Fri, 15 Sep 2017 09:50:48 +0200")
Message-ID: <xmqqfubjscy5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A4DE0A8-9CD8-11E7-8CA0-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> SZEDER noticing a bug in this series that I was about to fix:
> https://public-inbox.org/git/3B175D35-5B1C-43CD-A7E9-85693335B10A@gmail.com/
>
> I assume at this point a new patch is better than a re-roll, right?

Thanks, yes indeed.
