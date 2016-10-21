Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55C21F4F8
	for <e@80x24.org>; Fri, 21 Oct 2016 00:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754964AbcJUA1t (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 20:27:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65424 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754941AbcJUA1s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 20:27:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B3E948F59;
        Thu, 20 Oct 2016 20:27:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6NvrRaiBwvL4oij9FpKPsNLQdX4=; b=GrlD/T
        PNHU42t1MUKAauZOWO6iXSVfwH53oj84F88Gj0WXBzIoa2wmoM/w5MDYTsUFb2s1
        ZfSLgh2DmAYzpQih4zTRljuerYKxZHeAR1/KkjWppzj8zJYyzI15MGdjfAtaMUIu
        hNiRyRcAfdjyDB/PSSYzrMC32Ju+l6XD1gPZo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k/XPI7SBfc2JAf53hC0TtsDywuSgPv/u
        8geXBxXCQW5jvkZTQc2y1opCcP3KC/0K7OLaHRDhYBPUAlrjmrcZkjwZX7Og8Dwo
        H7EG7FZFi6ijzd90coZ/RfvHsYXXoHRmnjEXmwoF5b6R63zJNmfQEtXVL//2zfNq
        WvM5iGhGB0g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 223EF48F58;
        Thu, 20 Oct 2016 20:27:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99EC248F57;
        Thu, 20 Oct 2016 20:27:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     GitList <git@vger.kernel.org>
Subject: Re: [PATCH] doc: fix merge-base ASCII art tab spacing
References: <20161020234009.1768-1-philipoakley@iee.org>
Date:   Thu, 20 Oct 2016 17:27:44 -0700
In-Reply-To: <20161020234009.1768-1-philipoakley@iee.org> (Philip Oakley's
        message of "Fri, 21 Oct 2016 00:40:09 +0100")
Message-ID: <xmqqa8dyeebj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 309B8514-9725-11E6-AD23-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> The doc-tool stack does not always respect the 'tab = 8 spaces' rule,
> particularly the git-scm doc pages https://git-scm.com/docs/git-merge-base
> and the Git generated html pages.

Sorry, but I do not understand this change.

https://git.github.io/htmldocs/git-merge-base.html is "Git generated
HTML page" and I do not see any breakage around the drawings this
patch touches, and the fp-path series does not touch these drawings,
either.

If a broken "doc-tool stack" breaks the formatting, I'd prefer to
see that "doc-tool stack" fixed, instead of working around by
updating the source they work on.  Otherwise, the broken "doc-tool
stack" will keep producing broken output next time a source that
respects "tab is to skip to the next multiple of 8" rule is fed to
it, no?

