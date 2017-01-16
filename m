Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C17F320756
	for <e@80x24.org>; Mon, 16 Jan 2017 07:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbdAPHsH (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 02:48:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56212 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750981AbdAPHsG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 02:48:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42F6852C52;
        Mon, 16 Jan 2017 02:48:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xH/L4XouTvK2CT63DVCTwB/rOqw=; b=Hfq6Jl
        Eji1Uo32IdYzbtKnlPBJOPdocxG2kf9Rhs4YS8HWN4GkmI6SNZwu6EGTv6DXBpdU
        5ZMyt+ZkiUP/UxlksXW2m0hQeY4u0tUxvPoM6fpFlNSwXnbuAAhhi2A6s3TeaEJa
        U+/ssuuMSU4hdVDp241KulEIE8wkakrH3yeD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DmkI8g8bP8FseAFhFMYSe+GBT9WfQtC8
        T0v5paa32HzvVdZaheU33WUOJMDYWq7a5laWGyCWGqCjAxInY7kEBvsKQouyOQ8K
        fSD+pXReDSmiJTuXae4lt0SppgS4HTsPeFBM9L51ukSOx+4IuHZv6zOjAXbWVpz8
        KR0/m3PHEyg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A42052C51;
        Mon, 16 Jan 2017 02:48:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99B6252C50;
        Mon, 16 Jan 2017 02:48:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     David Aguilar <davvid@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Andrew Janke <floss@apjanke.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: gitk pull request // was: Re: gitk: "lime" color incompatible with older Tk versions
References: <03babaa1-9011-0010-c4b3-6cad8109d3ab@apjanke.net>
        <CAGZ79kaO9T+Qc=M6s_ZdpAfLZCVQEYNF=zNxDWArDmsA7jjCWg@mail.gmail.com>
        <20170113112043.j7nowdilolswyk2k@gmail.com>
        <20170114084825.lcecrbtxny3ntulf@gmail.com>
        <xmqq37gldp8g.fsf@gitster.mtv.corp.google.com>
        <20170116031706.GA3322@fergus.ozlabs.ibm.com>
Date:   Sun, 15 Jan 2017 23:48:03 -0800
In-Reply-To: <20170116031706.GA3322@fergus.ozlabs.ibm.com> (Paul Mackerras's
        message of "Mon, 16 Jan 2017 14:17:06 +1100")
Message-ID: <xmqqy3yba1jg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CE650AA-DBC0-11E6-A4EC-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Mackerras <paulus@ozlabs.org> writes:

>> Paul, is it a good time to pull, or do you still have something not
>> published yet that should go together with what you have already
>> queued?
>
> I recently pushed out one more commit to update the Russian
> translation from Dimitriy Ryazantcev.  The head is now 8fef3f36b779.
> I have a couple more series that I am currently reviewing, but nothing
> immediately ready to publish.  It would be a good time for you to do a
> pull, since the "lime" color fix and the memory consumption fixes
> should be helpful for a lot of people.

Thanks.  I did want to get the memory consumption fix sooner rather
than later, and this is very much appreciated.

Pulled.
