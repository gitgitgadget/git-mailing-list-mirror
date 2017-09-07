Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F8ED20281
	for <e@80x24.org>; Thu,  7 Sep 2017 00:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbdIGAs7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 20:48:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57754 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751543AbdIGAs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 20:48:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E61D9CA1A;
        Wed,  6 Sep 2017 20:48:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tihVHKiu9HAD
        5fOOUCf8GCIuqKk=; b=amrxFfoXwnY6z2dJFjODBbmGT9GQ2GMw+iqzU3lpIL/a
        B2km5m5vjMoZTmHV3WQ8CSmCp8mT4bDCwneRfYIEJsO/PlEaOY7rcG/u+NGGUeNW
        efJ+m4EHMIe+Vgid/4ZjUyvCnUYawT0qnwoYeyko21gpEEVuFiub7TuOHqlipHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=lCocv+
        nryeJNj47SXW/u0vNBw84ulYcGHsGi5EOGBp25fhdm+yLBtSc2AP5npa5FufWwqm
        TsfveFsqboMmbgct1lODFgPePHuj8Hp6wuts+KCVQnNk/F5LUk2Jcauu4SkG2Xhe
        NovkZnN9PnBfzBrAPH3GJJIJAxKQG9Bc7F58A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 875CD9CA19;
        Wed,  6 Sep 2017 20:48:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E07DA9CA18;
        Wed,  6 Sep 2017 20:48:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] config: remove git_config_maybe_bool
References: <20170905183959.22454-1-martin.agren@gmail.com>
Date:   Thu, 07 Sep 2017 09:48:55 +0900
In-Reply-To: <20170905183959.22454-1-martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Tue, 5 Sep 2017 20:39:59 +0200")
Message-ID: <xmqqfubz2v0o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 545BCF52-9366-11E7-AF43-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> The function was deprecated in commit 89576613 ("treewide: deprecate
> git_config_maybe_bool, use git_parse_maybe_bool", 2017-08-07) and has n=
o
> users.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---

Thanks.  Will queue.
