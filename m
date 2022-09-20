Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF82C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 17:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiITRwS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 13:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiITRwR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 13:52:17 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C9ADFB0
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 10:52:16 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A9DCD1A87AA;
        Tue, 20 Sep 2022 13:52:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=y4Q3MdvL8DgU
        1xgIP0x2p8JwnNUbErrbdXrMIdTn680=; b=CUEo4MRm85kywOfmILx8IWO32VDE
        11fGMhaju7fOn2jDgemOgmnT2kCCwELx//wjJK6Wuae5bqKfALQbl3cWMXqpUaa2
        suqfkUf9z2RIihRet2lnyxrLfY010LCejZX8oRF3QabY6s2dANouoa112OWQF6U7
        jl0LPCJhnjwX7/0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2A671A87A7;
        Tue, 20 Sep 2022 13:52:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D6F281A87A6;
        Tue, 20 Sep 2022 13:52:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] allow grep -E, and remove egrep
In-Reply-To: <cover.1663688697.git.congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Tue, 20 Sep 2022 22:49:12 +0700")
References: <cover.1663688697.git.congdanhqx@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
Date:   Tue, 20 Sep 2022 10:52:10 -0700
Message-ID: <xmqqa66u6iid.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F4455794-390C-11ED-835C-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Despite our CodingGuidelines dictates that grep -E and or grep \{m,n\}
> are forbidden. Our code bases uses them all over place.

That makes it sounds like rules dictating and coders resisting, but
that is not what is happening.

Portability guidelines need updating as tools on different platforms
change over time.  An effort like this series is very much
appreciated from time to time.
