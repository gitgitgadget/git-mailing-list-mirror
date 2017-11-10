Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75B161F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 19:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753579AbdKJTDc (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 14:03:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65456 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753546AbdKJTDb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 14:03:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0F8B9F40B;
        Fri, 10 Nov 2017 14:03:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9eE+K/j5u2I2S5+I8tLVm+Mckz0=; b=T1O4yE
        /1M29pDOfoFCRdQ4ZCbgW+q4dXqgfF6na929rS8KDWPywNoUXEmI7xTN4FvjDtOL
        y9Pow7ovIhozrEtodohbF2vr3y9yQLK5CayZVM/4mE5RFN5ze2U1gDpueAFfMi9d
        E4kC4XlxuRmnCUWa1xYCoLAUzCPDlSX0PINbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kIj7GcR1+zn3uyCK/vBPSCXI7Ovahovc
        n7SaizckNUgKw1s6DEA17QZlGVqc9HEB7CA6i7rR9yNJQvG7BJWNY2JIpKI4JV9V
        sHC+Yx0qYsJuyCRiEGeJ4de65/V01jo6OvoaV3ElFJV7VwFIORV9oWoOrCAfvUB/
        1BL3q5/RY5w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E71AB9F40A;
        Fri, 10 Nov 2017 14:03:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 522C69F405;
        Fri, 10 Nov 2017 14:03:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 0/8] Create Git/Packet.pm
References: <20171110132200.7871-1-chriscool@tuxfamily.org>
Date:   Sat, 11 Nov 2017 04:03:24 +0900
In-Reply-To: <20171110132200.7871-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Fri, 10 Nov 2017 14:21:52 +0100")
Message-ID: <xmqqvaiidkhv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D44339C4-C649-11E7-87C9-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> There are only a few small changes compared to v2:

Please go incremental as v2 is already in 'next', and small changes
are easier to reiew and understand when given as follow-up "polish
this minor glitch in the initial effort" patches.

Thanks.
