Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 199CA2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 18:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbdHGSSj (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 14:18:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62503 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751426AbdHGSSj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 14:18:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DC129CD08;
        Mon,  7 Aug 2017 14:18:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lK3d4KLHvbmKJGOMbCbYNQUBAHk=; b=BLFTVu
        +Yya5JzhD6lqiZ62Au8AwJndYXXgvGhhnMi+lYf2Su706CIafmEpPJL3tHCHXHFG
        YMrgI+UL3pYhech/kYGMudMZg4sV7GK7B2U31TH4shr+w2Mv3BS3VBJknQ8T+X5N
        aZogZfMB6zvMpKuigURuntMkDH4gbk/D8I1hg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gP7fR4jtLloQrZqHgF8OZVNAGMDfB295
        KNl7H7kthzJtZoJhvpOp+l9q3FKoyc9IWlzj8H3BfoZAPfUDAswcmwPIPffCx7yR
        Lwn/ykAdtA42SOw6MkKj5YREjlwvfTJm7Ao7T90+AxXMHhI2raNeHVj37ThwJChg
        xOW+5//nBe4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75FBF9CD07;
        Mon,  7 Aug 2017 14:18:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DCDF09CD06;
        Mon,  7 Aug 2017 14:18:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Forney <mforney@mforney.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Drop some dashes from built-in invocations in scripts
References: <20170805064905.5948-1-mforney@mforney.org>
        <xmqqshh3qqs4.fsf@gitster.mtv.corp.google.com>
        <xmqqo9rrqp3l.fsf@gitster.mtv.corp.google.com>
        <CAGw6cBvE-OJW0gSRCYOS5VT+Ff+eiCMdJg2A2rBi_HXFObdJRw@mail.gmail.com>
Date:   Mon, 07 Aug 2017 11:18:36 -0700
In-Reply-To: <CAGw6cBvE-OJW0gSRCYOS5VT+Ff+eiCMdJg2A2rBi_HXFObdJRw@mail.gmail.com>
        (Michael Forney's message of "Mon, 7 Aug 2017 10:58:34 -0700")
Message-ID: <xmqq60dzqm0z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D524ED80-7B9C-11E7-9CA9-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Forney <mforney@mforney.org> writes:

> However, I still think the patch should be applied for
> self-consistency at least (git-submodule.sh currently calls both `git
> rev-parse` and `git-rev-parse`).

Oh, there is no question about the changes in the patch being good,
as I already said.  We want to make sure that people who copy &
paste code would see fewer instances of "git-foo".

I was commenting on the justification in your proposed log message,
which I realized was a bit misleading, after deciding that the patch
text itself is good and I need to apply it.

Thanks for the clean-up.
