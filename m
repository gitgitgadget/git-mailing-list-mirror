Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1B7120281
	for <e@80x24.org>; Tue, 31 Oct 2017 02:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753408AbdJaCkJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 22:40:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52821 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751974AbdJaCkH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 22:40:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C83B8A7163;
        Mon, 30 Oct 2017 22:40:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=itUnPhA/KJIhSvXSdnJuBYtW/xU=; b=DvRIKL
        LUlskiURqn4UL91yNbZw9AbHE/1+k+tDIbp7tG1SEhmgP3hp/lzT4K+tTGsYOrB+
        S4taaP6qFoGBgVrrer0p1Uk0KZ+bxlB23qXOOoYqjFnQAzOfm0WXZWYKlZsdarDd
        j1G8SsefSEKwNgZHS5xJm6fiDYgVaJITMTfT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZxXRuKBHZB9US0EuxzGsfYmzJRDKM1P6
        B67J4rE3aXppvxN+LHPDnnzfgc9DFnmq/j9ToOdnU+FYgm4tMH+xcdV18W2yJsfw
        rAHFSzC7Vfr9H55W+kBLAatQ8SJm45UP2o5GR/xAjvxJrDlYo+wbXxWc2vZUSst4
        3mlDZqlwW1A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C0D77A7162;
        Mon, 30 Oct 2017 22:40:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F9BEA7161;
        Mon, 30 Oct 2017 22:40:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2017, #07; Mon, 30)
References: <xmqqr2tl40pl.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1710301830210.6482@virtualbox>
        <f12353b6-cfed-722b-1386-d55700f21915@jeffhostetler.com>
Date:   Tue, 31 Oct 2017 11:40:05 +0900
In-Reply-To: <f12353b6-cfed-722b-1386-d55700f21915@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 30 Oct 2017 15:54:14 -0400")
Message-ID: <xmqqtvyg2g6y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDE7648C-BDE4-11E7-848B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> I've been assuming that the jt/partial-clone-lazy-fetch is a
> placeholder for our next combined patch series.

Yes, that, together with the expectation that I will hear from both
you and JTan once the result of combined effort becomes ready to
replace this placeholder, matches my assumption.

Is that happening now?
