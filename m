Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2047120437
	for <e@80x24.org>; Tue, 31 Oct 2017 05:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753229AbdJaFsG (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 01:48:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51181 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752996AbdJaFsF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 01:48:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 924CCA9375;
        Tue, 31 Oct 2017 01:48:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZWHXfKqjR+ztjzXjWlSh2kieo6s=; b=i+13hP
        QoTqSMfdVOrFeYMrK5ep4lgtRW1kNwqxAPwcyEfGSnVCA6uzUbavEkFTA3HrfZWz
        +w+6Fy2h1DR1s69uT7/ws1rBh8BW+pT5BbFa86xvdaluh5bzyuVFVex00mWiqNCs
        /J0s1AOdie26+Bf7RmDBC+x1rqqte+41ZyzCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mxqy1yNTyX1EoD4Lpl0v4FWn+S4f8D9S
        QMCUFIcpUBCrz29XbxL2ttYudSD2ipRKbiASHfbMIqIMZ03LRVgAH7YikKWZJvop
        f9BIJLuBTaaz9HqZFCeRKB6uX0efpDUsfSgC22kzLBkpZzXHrhy74B9ppK6h4uc9
        +Q2wcv4U70Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B1BDA9372;
        Tue, 31 Oct 2017 01:48:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D98BA9370;
        Tue, 31 Oct 2017 01:48:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/3] mingw: introduce a way to avoid std handle inheritance
References: <cover.1509382976.git.johannes.schindelin@gmx.de>
        <20171030205522.hur26cumwusk7wwa@aiede.mtv.corp.google.com>
Date:   Tue, 31 Oct 2017 14:48:02 +0900
In-Reply-To: <20171030205522.hur26cumwusk7wwa@aiede.mtv.corp.google.com>
        (Jonathan Nieder's message of "Mon, 30 Oct 2017 13:55:22 -0700")
Message-ID: <xmqqy3nrzx4d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FFDF100-BDFF-11E7-A1F3-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> This feature was introduced as an experimental feature into Git for
>> Windows v2.11.0(2) and has been tested ever since. I feel it is
>> well-tested enough that it can be integrated into core Git.
>
> Can this rationale go in the commit messages?
>
> Actually I wouldn't mind if this were all a single patch, with such a
> rationale in the commit message.
>
> The patches' concept seems sane.  I haven't looked closely at the
> implementation.

+1.
