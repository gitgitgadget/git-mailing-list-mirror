Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7A791F407
	for <e@80x24.org>; Fri, 15 Dec 2017 19:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756090AbdLOTJV (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 14:09:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60059 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755824AbdLOTJU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 14:09:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8A74BA14B;
        Fri, 15 Dec 2017 14:09:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tXhccNEMQY0vBb67JMMl1BlKe5U=; b=iCDCjU
        oRidmKSBLZqvDPVXbE3wPPasBVyR/MZssPxbLafurrqXsL5Uv+GCPF1WmXhmpOpJ
        tLYiUXK2YeI/b/oRe3RAJdO16xmecZWQcbmFHRI77wI2ThED/k4QAmNYFYG/ivvB
        58kguqau7ZJlv6VAFiuN9ulslhLivkrc+cQRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FYZBErKe32F4cIh9kjpbmo69jc59YtFl
        9Zkaf9rNU2VlZTGJ2noIlzcfvR/w/4IiCmCvaC38FpwIFDEuX37c7u960o0Pi2df
        UrQ8+Yvxyk6iHH/DoCSXQV8BSyChjAuYuRL/FubWABWHxLrjA9K/O8gXHSUNafc8
        P7UfL1pIl+Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0248BA14A;
        Fri, 15 Dec 2017 14:09:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 05620BA149;
        Fri, 15 Dec 2017 14:09:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Subject: Re: Need help migrating workflow from svn to git.
References: <20171214130933.GA18542@raven.inka.de>
        <xmqqvah8q7cg.fsf@gitster.mtv.corp.google.com>
        <19d67f01-5e7d-3792-52f4-52da86bca5e5@gmail.com>
Date:   Fri, 15 Dec 2017 11:09:17 -0800
In-Reply-To: <19d67f01-5e7d-3792-52f4-52da86bca5e5@gmail.com> (Igor
        Djordjevic's message of "Fri, 15 Dec 2017 19:58:14 +0100")
Message-ID: <xmqq1sjvreoy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 737EA73E-E1CB-11E7-9645-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> Junio, what about consecutive runs, while merge conflicts are still 
> unresolved?

The impression I got was that the original running with svn does not
deal with conflicting situation anyway, so I did not think about it
at all, and I personally do not care ;-)
