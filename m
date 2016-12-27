Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38E61200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 21:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754148AbcL0VSW (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 16:18:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63076 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752636AbcL0VSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 16:18:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 603E059715;
        Tue, 27 Dec 2016 16:17:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=gJBOJQvkCBbawzV9+O4HtBF+RTs=; b=CAyjC1gGTDCS9eGs+240
        HKZ1B1L9PKuIA749cmnBG3hh+8xVeZf78itwmbWvur+OYS5QAmJGo75wDYq/3cYq
        MXlPBpGees4eI9abiV6NkykCJGsoxghnhwnzjdAK5wN8w7zY/cg005Wt/sGHWx96
        +ohamV8dMOMzI9ADLO0vOJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=PfDvihlhghF4u71np4yM93uUxJw10smmJS09/YFDWtZm1m
        rA2ouKr778JY/wDSDKPMP4RkNtOILzGyH05+pPCXfc445mA6je7t6ym0BzHbvD2O
        p4qYJiyF8j6mzgRP908Y95VA/AcJDcRzFHDy93SMxJtrsKelgmKH7VwBummOI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5787359714;
        Tue, 27 Dec 2016 16:17:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C989859713;
        Tue, 27 Dec 2016 16:17:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v9 03/20] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
Date:   Tue, 27 Dec 2016 13:00:26 -0800
References: <20161227162357.28212-1-Karthik.188@gmail.com>
        <20161227162357.28212-4-Karthik.188@gmail.com>
Message-ID: <xmqqzijh6phz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFC0118E-CC79-11E6-9F65-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> This is done by introducing 'if_atom_parser()' which parses the given
> %(if) atom and then stores the data in used_atom which is later passed
> on to the used_atom of the %(then) atom, so that it can do the required
> comparisons.
>
> Add tests and Documentation for the same.

s/Documentation/documentation/
