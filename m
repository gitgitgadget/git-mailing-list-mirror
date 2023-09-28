Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C758E732D0
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 14:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjI1OKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 10:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjI1OKW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 10:10:22 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E44136
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 07:10:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F6381A46EE;
        Thu, 28 Sep 2023 10:10:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ymBYlvKwSx+d
        DE57anuXVwDKBF0/TI9jHCAGaUR/QsM=; b=HlJ31H5nds90kwVAhHDLFyVym9wU
        fLMqKqY/h4O5bwZAhJ8GGtY9q11lqNmNFwWOPj5Ooujy3M4ImWLBgQawg2YiKsJ2
        fkJKNFpxly5wxFFMfyDiwfwt0u+4hpF9AdWBiDBFG+AXNm5fc7x/lF7LsVYNHuYt
        RYVrwAsHVkxxhBI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 866AD1A46EB;
        Thu, 28 Sep 2023 10:10:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE6C81A46EA;
        Thu, 28 Sep 2023 10:10:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=E8=AC=9D=E8=87=B4=E9=82=A6_=28XIE_Zhibang=29_via_GitGitGadg?=
         =?utf-8?Q?et?= <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?6Kyd6Ie06YKmIChYSUUgWmhpYmFuZyk=?= <Yeking@Red54.com>
Subject: Re: [PATCH] doc: correct the 50 characters soft limit
In-Reply-To: <pull.1580.git.git.1695895155985.gitgitgadget@gmail.com>
 (=?utf-8?B?IuisneiHtOmCpg==?=
        (XIE Zhibang) via GitGitGadget"'s message of "Thu, 28 Sep 2023
        09:59:15 +0000")
References: <pull.1580.git.git.1695895155985.gitgitgadget@gmail.com>
Date:   Thu, 28 Sep 2023 07:10:18 -0700
Message-ID: <xmqq7coal779.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C1D73A3A-5E08-11EE-84AB-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"=E8=AC=9D=E8=87=B4=E9=82=A6 (XIE Zhibang) via GitGitGadget"  <gitgitgadg=
et@gmail.com>
writes:

> The soft limit of the first line of the commit message should be
> "no more than 50 characters" or "50 characters or less", but not
> "less than 50 character".

The limit being "soft", I highly doubt that anybody would wonder if
a title that is exactly 50 columns wide is or is not acceptable.

The updated one is more grammatically correct than the original, so
the patch is not without merit, though ;-)

Thanks.

> ...
>  Though not required, it's a good idea to begin the commit message
> -with a single short (less than 50 character) line summarizing the
> +with a single short (no more than 50 characters) line summarizing the
>  change, followed by a blank line and then a more thorough description.
>  The text up to the first blank line in a commit message is treated
>  as the commit title, and that title is used throughout Git.
>
> base-commit: bcb6cae2966cc407ca1afc77413b3ef11103c175
