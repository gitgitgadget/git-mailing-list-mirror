Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE37A20954
	for <e@80x24.org>; Thu, 23 Nov 2017 02:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbdKWCWV (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 21:22:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64345 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752231AbdKWCWU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 21:22:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D9D7A0369;
        Wed, 22 Nov 2017 21:22:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=09p+BuFa8M+S9rJIzSgy76fs5G4=; b=Nfe+M/
        4QjSxh7ED0Qhk7KvjqjqB4I85XR/aLxJX53b+DRltJ8zPqzXOsaGB9qvqorpf2Hc
        OH61D+3CWroX8XQxGNqxtBYnzJjM7vlDfz5yhgXQuMeIQJ7hAmGbkM2NoedInZpS
        fwM2KoG1PVBiSl+dcraH/QvV0vHTuFhuL/Ehk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tUpU8npi+ZXdmE00xdFaQD962QYOHuJc
        Zf/1izWO1vJMeeOWtFcWeDVa1PEK9RWU3ajXSXoAokDQOtPF7rKIIU7/j6dY8FY9
        VpUZtwBsmQAwerdC1GQ0Gydj0YpyfF8n+Bo1LcyY3uwtFap0glPrtJr9sugsHJ4H
        2FVPUEzx5h0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6375FA0368;
        Wed, 22 Nov 2017 21:22:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D9237A0364;
        Wed, 22 Nov 2017 21:22:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kevin Daudt <me@ikke.info>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] gitcli: tweak "man gitcli" for clarity
References: <alpine.LFD.2.21.1711211626460.26166@localhost.localdomain>
        <20171121214552.GB16418@alpha.vpn.ikke.info>
        <20171123000346.GA8718@sigill>
Date:   Thu, 23 Nov 2017 11:22:18 +0900
In-Reply-To: <20171123000346.GA8718@sigill> (Jeff King's message of "Wed, 22
        Nov 2017 19:03:46 -0500")
Message-ID: <xmqqtvxlraxx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21CC0252-CFF5-11E7-B5F4-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I read the rest of the thread, and I think the question here is not
> about Git's behavior, but about parsing this sentence.
>
> Without a "--" Git can sometimes do what you want. Or it may error out,
> if what you asked for is ambiguous. And that sentence is trying to cover
> those cases separately, and the "can" only applies to the ambiguous
> case.
>
> It's pretty clear to me as it is, but maybe we can write it differently.
> Like:
>
>   Without a disambiguating `--`, Git makes a reasonable guess. If it
>   cannot guess (because your request is ambiguous), then it will error
>   out.

Splitting it into two sentences like you did makes it even clearer,
I would think.

