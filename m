Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65BDF202A0
	for <e@80x24.org>; Fri, 17 Nov 2017 06:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933575AbdKQGTp (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 01:19:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57828 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756982AbdKQGTn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 01:19:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A9D4A6EF2;
        Fri, 17 Nov 2017 01:19:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NoSIh+fXk2x+WpIQL7rXkX3G+sw=; b=cNDYI+
        28vPuLSExADkQKZYlwZf8Rn0pd+YVd8/T9Cwyz5DGsGBpK+g3oY+OmYw5SNa2F1j
        fDpSilkmlaUXbfzj6yb9klA6Gcd5I1KKkKGF92xAaQ8s4Vb/gnEpYqe2fJ+wIRBw
        VYW/fdxMBIE/MwjvpMPwzybu24kmOycNO2ans=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QYtkALtyT71LumwXHQLwhIROZFKg/4QS
        KPakdJeH/woVL1Ky2FLjvyFIn30swq/+1nVE23KXEa/g79Fon6u14xYHW4Ogd3rn
        p9ufaJvT6FQcJgOxHSaxcPT1XjCA4m2NlD5Wlbu5c8hieprfaAxE8zVaXfTIIuOn
        ePM+I/d5O0Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 611F4A6EF1;
        Fri, 17 Nov 2017 01:19:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD44BA6EEE;
        Fri, 17 Nov 2017 01:19:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 00/15] Parial clone part 3: clone, fetch, fetch-pack, upload-pack, and tests
References: <20171116181723.62033-1-git@jeffhostetler.com>
Date:   Fri, 17 Nov 2017 15:19:40 +0900
In-Reply-To: <20171116181723.62033-1-git@jeffhostetler.com> (Jeff Hostetler's
        message of "Thu, 16 Nov 2017 18:17:08 +0000")
Message-ID: <xmqq7eups9z7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C2EAFD0-CB5F-11E7-A494-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> This part 3 of a 3 part sequence partial clone.  It assumes
> that part 1 and part 2 are in place.

I couldn't figure out why 'pu' fails with this topic at t5500 (and
others) so I dropped a merge of this before pushing the result out.

Thanks.
