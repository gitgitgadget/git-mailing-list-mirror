Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D5DD1F461
	for <e@80x24.org>; Wed,  3 Jul 2019 18:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfGCSbq (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 14:31:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55053 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCSbq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 14:31:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E17D15B2D9;
        Wed,  3 Jul 2019 14:31:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T+sYB0e8Un+yfRFg4rKYBtDMuD8=; b=tjjOfk
        KQYFYzd8zTeNsOwmpxSUKbej//T26sn7Tk/Y56XmYPNCLPr2nk6gwmIWowNakU/N
        Ju+VeMMNKlHeTvUYzTYfiqrBtJJuZ0FAoRPMPgdVeIySjje49lXg79OrxFH7Pr3Z
        SOux7mO1OQGKwbheW16cmaLuZBZCvkgt7sspE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MlbYJPuKCyJzVkPMeYKiAO1Nqw5BMxN3
        8JV1i2VgXb0TdoIeuyffNhJVTYPz/V6agflCsyuhxES9KJ7hp6L6YEn3+K7VcM+0
        4JDpX78LV3GHvrKWOSMha8rpZV7bJBbsz8jaygDsXz159rLU3dbLC/rt49XpBqYP
        UAkPwkKz+Aw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2674015B2D8;
        Wed,  3 Jul 2019 14:31:44 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8AE1915B2D7;
        Wed,  3 Jul 2019 14:31:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH 1/1] gettext: always use UTF-8 on native Windows
References: <pull.217.git.gitgitgadget@gmail.com>
        <ff37a2646a848e3eca8d02a001844986a3fa366b.1561625060.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1907031321270.44@tvgsbejvaqbjf.bet>
Date:   Wed, 03 Jul 2019 11:31:42 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907031321270.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 3 Jul 2019 13:26:16 +0200 (CEST)")
Message-ID: <xmqq36jn0y29.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE88717A-9DC0-11E9-BC2A-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Junio, please hold off from advancing `kb/windows-force-utf8` until this
> is resolved.

OK, will do.
