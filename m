Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78A3D202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 04:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbdJQEB0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 00:01:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62794 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751643AbdJQEBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 00:01:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 067A5B81ED;
        Tue, 17 Oct 2017 00:01:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vErQYWwWA4LFnAareF+MVIBL03w=; b=nMJcgg
        1QbYto05amuOok6jbkMm+j77sENG2FBNEzbjiN27CgDcDx3XXaG7MSLJ+M9KVEZ9
        9AuZvDoS/P9B17mj+MSMrFaDw094qkKjgeSdJPjqDjoCD5rcs1BQYc1FacFLqW0P
        XGuCiNbnurY+aNXKXLT5v9Sh+j7UJTM8IpNOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FnP7RuUNeqtHwOHDptZWjEZPJdGA3D3t
        EwX1eTsXhxiHrHjptX1kQ8y60fSblIuwmV3Pv3IYy2cO96z+gg7B+0yNqxbCr1Bs
        AXBDK70odk4dq9VoOZc20J+06R+Ws4Z4jm920a/cm1gutNa/1u1PnN2sWqT8ok8K
        M4CxdJJgIFk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1398B81EC;
        Tue, 17 Oct 2017 00:01:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C926B81EB;
        Tue, 17 Oct 2017 00:01:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thais Diniz <thais.dinizbraz@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        marius.paliga@gmail.com, peff@peff.net, sbeller@google.com
Subject: Re: [PATCH] patch reply
References: <xmqqmv4x11y9.fsf@gitster.mtv.corp.google.com>
        <20171017034743.8418-1-thais.dinizbraz@gmail.com>
Date:   Tue, 17 Oct 2017 13:01:23 +0900
In-Reply-To: <20171017034743.8418-1-thais.dinizbraz@gmail.com> (Thais Diniz's
        message of "Tue, 17 Oct 2017 01:47:43 -0200")
Message-ID: <xmqqd15mpgmk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7BE1EEC-B2EF-11E7-9D27-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thais Diniz <thais.dinizbraz@gmail.com> writes:

> +Just to clarify I did not see Marius patch.
> +Did see Marius' comment saying he would look it in the leftoverbits list,
> +but since i didn't see any patch i thought i could work on it and did so based on Stephan's comment 
> +(which i suppose Mario also did and that is why the code resulted to be similar).

In any case, both versions share exactly the same "don't call
get_multi() to grab the same configuration values from inside the
callback of git_config()" issue, so whoever works on it to complete
the topic, it needs further work.
