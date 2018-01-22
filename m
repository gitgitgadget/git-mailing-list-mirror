Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4357C1F404
	for <e@80x24.org>; Mon, 22 Jan 2018 22:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbeAVWlW (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 17:41:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52844 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeAVWlV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 17:41:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75D28CB28A;
        Mon, 22 Jan 2018 17:41:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JPIpYyO6jw5H5sJhmabA8WNFsZI=; b=hkvtme
        zogZoMlcnSRIp+CoU4uvCcyZ2XG3VDqCc2Hf/Pckz3Rv0XQuwArDeSw/oCkS9Ee3
        iO65ybCJL9Pza6YhG6YAVPHxW5jhk7J6CIVSO9E/VWA4r/KHVwLY01dKbaJVFMkE
        maExayWHNEa5UmQp5xG54/hlvJTc15uyQWEic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VM/5fv8ysiP0WbLVf9FEMBeqL+iROJdx
        yQ3MYqkDJ4c0aVOZn5h2AgqEWWhF5HjoVkVS/V8HWReutUOgpsnxafZM/WvzMa3o
        5QqvdRrak8s1fDhz+A9fRq4zu1Qru2o61r4hKVoXB7ujAr+qOMwofbxDYOuLlv/H
        4J3/6nA49cM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C521CB289;
        Mon, 22 Jan 2018 17:41:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D4AFCCB287;
        Mon, 22 Jan 2018 17:41:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [Nit] Lots of enumerated type warnings
References: <001601d3917b$c1ade3c0$4509ab40$@nexbridge.com>
Date:   Mon, 22 Jan 2018 14:41:18 -0800
In-Reply-To: <001601d3917b$c1ade3c0$4509ab40$@nexbridge.com> (Randall
        S. Becker's message of "Fri, 19 Jan 2018 18:17:58 -0500")
Message-ID: <xmqqo9lljz3l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D68C1BA-FFC5-11E7-901D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> I'm seeing an increase in the enumerated type warnings
> coming from my use of the c99 compiler for compiling git over time (loads
> more for 2.16.0 compared to 2.3.7 when I took it on).

What exactly do these "warnings" complain about?  Without knowing
that, the remainder of your question cannot be answered.

Does it complain against enum FOO {A,B,C,} saying that the comma
after C is not kosher in older C standard, for example?

