Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17D6F2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 19:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbdHGTsw (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 15:48:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54694 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751826AbdHGTsv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 15:48:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D45BFA3794;
        Mon,  7 Aug 2017 15:48:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yu1Rq4p9M3auzBT08Liz39X3Bqw=; b=FoPgum
        1sFqVyXvjWJU1jQAUzI7YPST2lPQQZBn5eseHpbo2zAiCi/qvyuvWZ8S9e1QIAMg
        JlgQYaWuvzUNsR3jpsXS6OaheJasjK3spqLzU9HK1n+ve0MXbTeuzz8xiqtbP56g
        yhT/mnxp1pCooD7nmF3rr4jXBbHJ9McSfnecE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TVPpMBrrPE/FTojgmV170iFCWjj8uz2z
        EdMMLLh9XtlEalUtTyX7ZllL23EgSKEdyZfrwsRqqrljfyjjGE282XdeLi13kV1X
        CjQsEWsxg6FeVC2cWl24t7F8JGmUjpDDDgrqJzxc+3Q013OfYECsJX6n8yisyvrk
        X10GQRMYvDY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC739A3793;
        Mon,  7 Aug 2017 15:48:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37B87A3792;
        Mon,  7 Aug 2017 15:48:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Michael Forney <mforney@mforney.org>, git@vger.kernel.org
Subject: Re: [PATCH] Drop some dashes from built-in invocations in scripts
References: <20170805064905.5948-1-mforney@mforney.org>
        <xmqqshh3qqs4.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1708072113570.4271@virtualbox>
Date:   Mon, 07 Aug 2017 12:48:44 -0700
In-Reply-To: <alpine.DEB.2.21.1.1708072113570.4271@virtualbox> (Johannes
        Schindelin's message of "Mon, 7 Aug 2017 21:22:57 +0200 (CEST)")
Message-ID: <xmqqo9rrp3ab.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C2972BC-7BA9-11E7-BEAD-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So I would love to hear the arguments for keeping the dashed forms of
> builtins, even if the only surviving argument may be "I dig in my feet
> because I always said we'd keep them".

I think I already did ;-)
