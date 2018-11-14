Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCA881F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 07:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbeKNRCv (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 12:02:51 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55979 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbeKNRCu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 12:02:50 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EA690198EE;
        Wed, 14 Nov 2018 02:00:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=97QL2b6n1GaZW7A/4/y6MxQsvlg=; b=vu0APm
        ryK3hlXz6PTt6YTnaIwnftvA43vnVs5qbCACgIWA55X7nA5VpziqxA9MihORO7UG
        ju9jOFrooY0LW/yCWA5XJPLf4pjNe6gtjaeQIhuPAWC9K3ZJGA2MTU1kZc3WCtxX
        01GiJub57wxC7ed7qB0BI9ZvU5+4wIEyrJ0nA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mQKVDHzYRNQTJpie1JerfSamNNusa52N
        QSmuN4mwfoyVOkS0mQxckyYTJWNxwWw9EALG8YDahkxwc/6hTRNNn9rMRdBU9sjf
        8TzqOkxlSz2J2wyagWJUbDGm+oi8T6pbFVerD6ObXxWtYDSmTxJ3OpVRl3bKuk08
        cqHy/P1EPNM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D8F2D198ED;
        Wed, 14 Nov 2018 02:00:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D185E198EC;
        Wed, 14 Nov 2018 02:00:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 0/7] fixes for unqualified <dst> push
References: <20181026230741.23321-1-avarab@gmail.com>
        <20181113195245.14296-1-avarab@gmail.com>
Date:   Wed, 14 Nov 2018 16:00:47 +0900
In-Reply-To: <20181113195245.14296-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 13 Nov 2018 19:52:38 +0000")
Message-ID: <xmqqk1lgnnxc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04C6206C-E7DB-11E8-B143-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for an update; will replace.
