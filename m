Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23B781F454
	for <e@80x24.org>; Wed,  6 Nov 2019 02:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387457AbfKFCBq (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 21:01:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58207 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbfKFCBq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 21:01:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3E492AB9D;
        Tue,  5 Nov 2019 21:01:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TupB/DGNisYguxwxKh29mdOXP4c=; b=hJmRpi
        M39QriQ1Yysij01ovNS6aDRrZvcCbeY/rm0/ENGdQBWq9q+GuEynQNlrGM/qDv/r
        aQf20p4+HATCYDho+L4A6XewGTWSQ6dKiRkyvr9pffqsU/BsNno5Q459nVR2lrEO
        e/hsx2mO2bWDOM06XugAnwnTz5fQHlsUwaLbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l8UiTErJ0gkdlpL0PPeFnvehUgMD3wP/
        VfxuTaN+7usjcwjlsA2ptM0aej7anTVkma2ZjBZrOh5+/qMuUPbrkA0wdJhe7dn9
        Dbv46KXnv6qp/x+ICKZINYf5FcFm+zHCLmZFtDDBt2UJRULC95kboOKHOSWwnOoW
        4QCbmQI3XLY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BD952AB9B;
        Tue,  5 Nov 2019 21:01:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EEBD12AB99;
        Tue,  5 Nov 2019 21:01:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Nov 2019, #01; Mon, 4)
References: <xmqqzhhcxkvx.fsf@gitster-ct.c.googlers.com>
        <CABPp-BFgnAS6E-jAjGB0iowBDaEc9+3B__THMWymVMS0AUPocw@mail.gmail.com>
Date:   Wed, 06 Nov 2019 11:01:43 +0900
In-Reply-To: <CABPp-BFgnAS6E-jAjGB0iowBDaEc9+3B__THMWymVMS0AUPocw@mail.gmail.com>
        (Elijah Newren's message of "Mon, 4 Nov 2019 17:20:50 -0800")
Message-ID: <xmqqftj1wyns.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6243C696-0039-11EA-B7B0-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Please go ahead and eject en/doc-typofix from next; I'll send a
> re-roll with a lot more typofixes.  :-)

Thanks ;-)
