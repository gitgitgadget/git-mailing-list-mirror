Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7F921F406
	for <e@80x24.org>; Tue, 12 Dec 2017 18:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbdLLS4Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 13:56:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53400 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751609AbdLLS4P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 13:56:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D73EC76C0;
        Tue, 12 Dec 2017 13:56:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QSsh65rNS4MehRvg0RHDETZ98hA=; b=SvpCkI
        8Uo8AnkdPe2P6Ce0yq19Gk3e9dGDA4SmC4mfg7hqW0ZSHKhCfpIstkzY+YU+x+BC
        DmHiXo52SCIeMkFLb2N65GzjKlGfE2mI+/y95z4i65gD8qEJ9w0UcXK6CcJF7Bwj
        XD2hFgyMBy028zk++wh5ggSk9GuS3fYTzOVKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rA6v0+5oHTDn0gHhPO17Vli6ZYGiwjfV
        R+rJG73b04//SEMKvGwPq8itF7m8O5bHC+I2O2eaL5x7Nef0rT6CLtlsdPPvrLym
        2kTec1YljLaeCVohyJ3M46sn8t+rCfwSK5b68LgKy6jp/N+dMrQ+KTWZssEqDDou
        6JjyOMMqM9E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 048E1C76BE;
        Tue, 12 Dec 2017 13:56:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 646E2C76BD;
        Tue, 12 Dec 2017 13:56:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] merge: add config option for verifySignatures
References: <20171209090530.6747-1-hji@dyntopia.com>
        <20171209120537.GA6006@alpha.vpn.ikke.info>
Date:   Tue, 12 Dec 2017 10:56:13 -0800
In-Reply-To: <20171209120537.GA6006@alpha.vpn.ikke.info> (Kevin Daudt's
        message of "Sat, 9 Dec 2017 13:05:37 +0100")
Message-ID: <xmqqh8sv3hde.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2097F516-DF6E-11E7-BED6-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> Hello Hans Jerry,
>
> Thank you for your contribution. I have soem remarks below.
> ...

Thanks for a detailed review.  I agree with all the things you
pointed out, and I see they are reflected in v2 of the series.

Very much appreciated; thanks, both.
