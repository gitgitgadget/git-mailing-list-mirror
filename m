Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4ABA1F4DD
	for <e@80x24.org>; Sun, 27 Aug 2017 05:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750866AbdH0Fjm (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Aug 2017 01:39:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55212 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750750AbdH0Fjl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Aug 2017 01:39:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5754FA3D42;
        Sun, 27 Aug 2017 01:39:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KpgSv8r3S8go2IzOhfz6v9VRB8o=; b=B+tDnu
        /KWtgWYpCUwm6ZDpXgx5f1m/CYmZieNTQJXtQsHO4GytN+Q6WLHtUjxtgVzlLtNN
        llVs5B9Xvyty4MfNnBc16UyaeKCm+WNnTGUExO+qs3/8jJbi35wqGfGxOataIMp8
        X/nlfLC41f+5qmwDsVDCIGX0dZW/sIh9amW1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IXL1GQ6noIVYHomzBEnJWeKXe0TLXaIE
        EPOvgdzst4TlHaiN9sS2UVNm+t5EZprngL20D7wpTCmtIao6lW/JUhtkCgNwTZyl
        s8UaCGPvGH2r1R0fgMDwztBQqjK0wCXiUS3iyjY1pk4SyprxtfDMIDxB7qj/y4/C
        1sF/LZ5thpw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 505F8A3D41;
        Sun, 27 Aug 2017 01:39:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B28EFA3D40;
        Sun, 27 Aug 2017 01:39:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, nish.aravamudan@canonical.com, me@ikke.info
Subject: Re: [PATCH] Fix branch renaming not updating HEADs correctly
References: <20170823201334.bz42s6t5ti4jdaqm@pitfall>
        <20170824104124.6263-1-pclouds@gmail.com>
Date:   Sat, 26 Aug 2017 22:39:36 -0700
In-Reply-To: <20170824104124.6263-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Thu, 24 Aug 2017 17:41:24 +0700")
Message-ID: <xmqqd17hr2lj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D5914C6-8AEA-11E7-9E3E-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.  I'll merge this down to at least 'next' before I go
offline for a week.

