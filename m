Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78B4B206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 18:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753803AbcLLSAn (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 13:00:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62606 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752809AbcLLSAm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 13:00:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D38658A40;
        Mon, 12 Dec 2016 13:00:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o9JeWDH023kk99gHbyTB1CwGc+g=; b=S8yT3p
        f9JmT2cYXMXnolSUpchMcAgtoF4LLrGbaDXvNVFBS4Wmv7RTspifySaUzAAVlDob
        NxyoUvfklt7uqEV9APzDDRoPzQAEO6WoTeSLYUribq2kr/hF/mpswRVp+V61gAfb
        6qeHt7zqVVRl/f70jvXj4dBZfgz6me/ab65U4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oSVGG8Rwi/l/ga0klbTHscLpxiuR9ABi
        mJ+3T2DYkfc6p5BbRDIIakLHogSfOamtiD0j9GztMS+qqa9s01mRkRqKG/5xeAfh
        e44mQQL2pDPmMYjRdPQdoVAwA644ISuN10bghZVm9ry21j1iOOY+mPYh1pp7iCvR
        7AKYeY6w2CQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 140E158A3F;
        Mon, 12 Dec 2016 13:00:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7ED5158A3E;
        Mon, 12 Dec 2016 13:00:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     vi0oss <vi0oss@gmail.com>, Stefan Beller <stefanbeller@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] submodule--helper: set alternateLocation for cloned submodules
References: <20161208013814.4943-1-vi0oss@gmail.com>
        <12000496-2191-2915-8a9e-fe7c314c5676@gmail.com>
        <CAGZ79kYUbsy2TQ1noqS-9zLVUkQaeJbv6vwxykS+A_HHcxGnCw@mail.gmail.com>
Date:   Mon, 12 Dec 2016 10:00:38 -0800
In-Reply-To: <CAGZ79kYUbsy2TQ1noqS-9zLVUkQaeJbv6vwxykS+A_HHcxGnCw@mail.gmail.com>
        (Stefan Beller's message of "Sun, 11 Dec 2016 21:35:26 -0800")
Message-ID: <xmqqzik1m3i1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4A9200A-C094-11E6-BACE-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Sat, Dec 10, 2016 at 5:41 AM, vi0oss <vi0oss@gmail.com> wrote:
>> On 12/08/2016 04:38 AM, vi0oss@gmail.com wrote:
>>>
>>>      Third review: missing && in test fixed.
>>>
>>
>> Shall something more be done about this or just wait until the patch gets
>> reviewed and integrated?
>
> I have no further comments and think the most recent version you sent
> to the list
> is fine. However others are invited to comment as well. :)

I'll take that as a reviewed-by from you and queue it.

Thanks, both.
