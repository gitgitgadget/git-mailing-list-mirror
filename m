Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40E8D2023D
	for <e@80x24.org>; Wed,  1 Mar 2017 21:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753327AbdCAVes (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 16:34:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62982 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751055AbdCAVeq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 16:34:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D7EB77F6E;
        Wed,  1 Mar 2017 16:29:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZVKc7SPcdmf/ew2CgWnt47SpGn4=; b=cez2HK
        ANK8U4pLURoTlqYGzFPkBhaNGWE6iIW+oT2YLbEiHWWbfS8iWB/WDl8q7jNqoNr5
        evSTGhk8/ugNGF99SvKHGWhQE+5poCju4LHI9zQyZ9BkmD38zaUY66zO5laCUQWp
        hOb9fQ+cjRpvLxT4twm44Q4rIrbX4ItnUouNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WOlSbxEBlINQVDd6+PW1aJc+w8X7tuzX
        ZfKtclr7qPqgoovjBDls+IbhTNkwXnnh+DXa6rFguvPP2FD9xtHROnVZoHvmdrin
        eM0BSJEy7BKjaZ/Ipaw0mJS2HbL6w4b8b4x7PjLZXXJNLD+JaunCj72YzaprVjUO
        9sC5uK8f2v0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1569277F6D;
        Wed,  1 Mar 2017 16:29:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D48A77F6C;
        Wed,  1 Mar 2017 16:29:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 00/22] Add configuration options for split-index
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
Date:   Wed, 01 Mar 2017 13:29:52 -0800
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Mon, 27 Feb 2017 18:59:57 +0100")
Message-ID: <xmqqmvd4fzxr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3574F95E-FEC6-11E6-96FE-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Highlevel view of the patches in the series
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Except for patch 1/22 and 1/22, there are 3 big steps, one for each
> new configuration variable introduced.
>
> There only small differences between this patch series and the v3
> patch series sent a few months ago.
>
>     - Patch 1/22 marks a message for translation. It is not new and
>       can be applied separately.
>
>     - Patch 2/22 improves the existing indentation style of t1700 by
>       using different here document style. It is a new preparatory
>       patch suggested by Junio.

OK.  I read interdiff against the previous round carefully, and
skimmed all patches less carefully.  

I may have comments on individual patches later, but this round
looked mostly sensible.

Thanks for following it through.

