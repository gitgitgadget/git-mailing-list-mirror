Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EE4C4332B
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 17:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC2964F50
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 17:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbhBBRM3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 12:12:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51104 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhBBRKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 12:10:16 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 066B8938A1;
        Tue,  2 Feb 2021 12:09:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cMKoX4vwL199RUBJx0aBi3pqzTw=; b=HSXwwJ
        sLsePMkuGiiyUx8YHj4ff2yP97WVa9oMJRkpZSTCveeFmF5Oe3GsWQAdFbRUKKt0
        KvDJuz/s5dyxf3M7GfW8uGygp9iNPcELzzqULB3au/M9e044y0G+jvzCrJpn/TcW
        6woztJWhU/TOXAvLerpildvrX0MVIBAqdu6Oo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j7lFfop5FTIwUoHJgBlPtvfIcGbpXtqy
        +aJ4OOYUY8Z/Xat8z5PT8psoRsRxHzcq1A49eBKjmc6uFdCFS43Auiyf2zyvIPge
        zKzRYepneNIRiRdHvBRJpHnC5/BRV0p5n6IFyD7DxN+voDI52mM2Ssbwsi7dDF5J
        m8LVuhRqGjo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1E47938A0;
        Tue,  2 Feb 2021 12:09:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6FA869389F;
        Tue,  2 Feb 2021 12:09:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git List <git@vger.kernel.org>
Cc:     Hongyi Zhao <hongyi.zhao@gmail.com>
Subject: Re: Only receive the topics I participated in or initiated on this
 mailing list.
References: <CAGP6POK1s5fdzY74HyE9=0CV_B+HpbM9gU2qKuYtQAaPuc7XgQ@mail.gmail.com>
        <CAPc5daUtOMQB9YqOTQL4mrHpfyATe=FM01cW9Ngd1iy8aWwMmg@mail.gmail.com>
        <CAGP6POJeg4EB1Lx8NN0+PP-nxystKtLT_FH2UdQhoF13TjWvXg@mail.gmail.com>
Date:   Tue, 02 Feb 2021 09:09:24 -0800
In-Reply-To: <CAGP6POJeg4EB1Lx8NN0+PP-nxystKtLT_FH2UdQhoF13TjWvXg@mail.gmail.com>
        (Hongyi Zhao's message of "Tue, 2 Feb 2021 16:59:21 +0800")
Message-ID: <xmqqv9bagzwb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66C7FA6A-6579-11EB-8F4B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hongyi Zhao <hongyi.zhao@gmail.com> writes:

> On Tue, Feb 2, 2021 at 1:41 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> You can,  on _your_ end, filter incoming messages that are sent via
>> vger.kernel.org and do not have your address on To or Cc.
>
> Thank you very much for your comment. It seems that the following
> Gmail filter will do the trick:
>
> From: *@vger.kernel.org
> To or Cc: -hongyi.zhao@gmail.com
>
> But I can't find the Cc field on the filter panel.

Here is what I use to process messages that are sent to me without
being sent to the mailing list:

    (to:gitster@pobox.com -(to:git@vger.kernel.org))

The rule is set to skip the inbox and throw it in dustbin ;-).

I'd imagine something like

    (-(to:hongyi.zhao@gmail.com) (to:git@vger.kernel.org))

would hit what you want to filter out.  Let me swap To/Cc of this
message so that you would appear on Cc so that you can experiment; I
think to: would work for such a message just fine as well.
