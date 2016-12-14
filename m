Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 122B31FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 23:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933420AbcLNXZx (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 18:25:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54287 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933079AbcLNXZw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 18:25:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 94C8559947;
        Wed, 14 Dec 2016 18:25:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6TYMEgf/vci0TNMy6GEcT09dtA4=; b=nYPPXm
        TrV8VfJCI0zEh+8wTHFtxUDVimRwLo9FUa2g+i+HhxIToZhLmYEJAC9hRaJnJqn/
        VzbwuDX6RDssHpjz1ec5DCLFuHVIfHEXHnwZsN27Plho7un+o8d64fIU6M4Zw/zB
        7wIyjcLgb2W9R3Dw8/szECZgZlXXOG+CGB9Mk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cEcpopfSTXxhzebW4og8TCeftSj1J95U
        OBPh0rrvD6kbd9nKwVgULICvLGAvOBVJWvrQZBxHprq6Qdelm3ERXkCdxJEg8w2g
        hhA5I7SDkjri2eMo1tdvFE+BFPOUkbIBD2+0UkWPwultyG5aFNAxmrXZ2VjEe/F+
        9outR59kdn4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B1AA59946;
        Wed, 14 Dec 2016 18:25:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D852E59945;
        Wed, 14 Dec 2016 18:25:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH v10 0/6] transport protocol policy configuration
References: <1481679637-133137-1-git-send-email-bmwill@google.com>
        <1481755195-174539-1-git-send-email-bmwill@google.com>
Date:   Wed, 14 Dec 2016 15:25:49 -0800
In-Reply-To: <1481755195-174539-1-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Wed, 14 Dec 2016 14:39:49 -0800")
Message-ID: <xmqqtwa6w0si.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A69BC364-C254-11E6-B059-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> v10 of this series fixes the following:
> * A few updates to the commit messages in order to better convey the reasoning
>   behind the a few of the patches.
> * Additional test to verify that curl redirects respect configured protocol
>   policies.
> * Patch added by Jeff King to make http alternates respect configured
>   protocol policies.

Thanks.  Will replace the previous one.
