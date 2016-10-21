Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30BDB1F4F8
	for <e@80x24.org>; Fri, 21 Oct 2016 00:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753986AbcJUAsm (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 20:48:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55682 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751226AbcJUAsl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 20:48:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2091E494B9;
        Thu, 20 Oct 2016 20:48:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tboea3Zo2e+62+IUncWPIJlQo2A=; b=SFykhD
        cwgmIrCAwJX6g6qoS6gcnDmWp9NTE4Exq1JvhMslwPMogX6o5Y8XirLWFdK3z+nD
        5XH8pcYLhiFr2/0sp8zHCWCI7WZ1y0KqYJfcsQqIag7c6uxriHshJ5/1Nr5uMKdx
        Lzqk3UmO21jIHCqHkrF+ZwQsinvFcawariyrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mhXcZXQc+ZY/LtUbh9Ugrh61GSOhFyqJ
        c9F/bxaqGwfWRE8cRY8fwl8rcoSdRSwONGtE9jz1ZWIQy7Lg3Zap9ihHcr+03WRr
        QPShJRt3tgXBJrQms20DIZVFs/o8CaNemeMsztm9qHYTfSdoNX6Fjln+EljJvEm2
        ca7JYXKCkcI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 184F2494B7;
        Thu, 20 Oct 2016 20:48:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BF10494B5;
        Thu, 20 Oct 2016 20:48:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.org>, GitList <git@vger.kernel.org>
Subject: Re: [PATCH] doc: fix merge-base ASCII art tab spacing
References: <20161020234009.1768-1-philipoakley@iee.org>
        <20161021002252.u5v3mwjopvsdcexg@sigill.intra.peff.net>
Date:   Thu, 20 Oct 2016 17:48:36 -0700
In-Reply-To: <20161021002252.u5v3mwjopvsdcexg@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 20 Oct 2016 20:22:52 -0400")
Message-ID: <xmqq60omedcr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B617A16-9728-11E6-8D4F-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Oct 21, 2016 at 12:40:09AM +0100, Philip Oakley wrote:
>
>> The doc-tool stack does not always respect the 'tab = 8 spaces' rule,
>> particularly the git-scm doc pages https://git-scm.com/docs/git-merge-base
>> and the Git generated html pages.
>
> Hmm, I thought git-scm.com was fixed by:
>
>   https://github.com/git/git-scm.com/commit/1e13397edccdecd0e06ff851cffaa1c44e140bf3
>
> Not that I mind using spaces consistently here on principle. I just
> didn't think it was a problem anymore (my asciidoc seems to get it
> right, too).

I do not terribly mind it, either, and I'd prefer to apply Philip's
patch eventually. But I'd rather want to do so _after_ known broken
sites, if there are any, are fixed by correcting their tools.

