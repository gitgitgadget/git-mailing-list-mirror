Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251E0202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 04:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbdIVEvH (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 00:51:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57362 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751358AbdIVEvH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 00:51:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6152FA826B;
        Fri, 22 Sep 2017 00:51:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=u/z2ruuTWjxJ
        hvMSWS9drz33v7o=; b=rUQV5LufoMisFfeh8v+sAJpKryKjf7IjVm4pJ7zyYR84
        v9Z+PJ2uubj/EsAfv9giWZg5asi2yOV7/evf5FHCHYoJsvCxp136yKMDLAZWWRZJ
        nn3BU83erLbL7Rn0sd9gq3uQ/yXUyihGsMGXgb2M2J9LfZwPXHkYbeGAF0D/iBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VhUfU+
        GZfjEMiUTtyoi809ZIkoFncIhNv67i6Y3d6DiBZacbr0eyWcHyzb94+gK3kG/xlS
        rjZlEZaisDaiL1ESAd2V28bM1S5e8fes56ZDKkyHvB76ipWh+x6iNfxt5DkABYTR
        HawcMmxziEYpfC3WRhhEQnzLIwqfCSteP4/vQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5612BA826A;
        Fri, 22 Sep 2017 00:51:06 -0400 (EDT)
Received: from [192.168.1.4] (unknown [76.215.41.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D020A8267;
        Fri, 22 Sep 2017 00:51:05 -0400 (EDT)
Subject: Re: KDevelop developers obviously don't use git :(
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
References: <1469bc42-0a21-8cc4-f9bb-000c3737fe19@pobox.com>
 <xmqq4lrvl559.fsf@gitster.mtv.corp.google.com>
From:   Daniel Santos <daniel.santos@pobox.com>
Message-ID: <4cc9d76c-e4bc-54a7-e62c-25e2659e6954@pobox.com>
Date:   Thu, 21 Sep 2017 23:57:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq4lrvl559.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Pobox-Relay-ID: A46DE54C-9F51-11E7-B11F-FE4B1A68708C-06139138!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/21/2017 11:38 PM, Junio C Hamano wrote:
> Daniel Santos <daniel.santos@pobox.com> writes:
>
>> So first I need to inquire if there is a current mechanism to say "git
>> status, but please fail if you're busy with a non-atomic operation".
> Reading this list sometimes makes me wonder if there is some higher
> intelligence telling independent souls to come up with the same wish
> at the same time.
>
> https://public-inbox.org/git/20170921050835.mrbgx2zryy3jusdk@sigill.int=
ra.peff.net/

LMAO! This has been irritating me for some time, but I had to abort a
somewhat complex interactive rebase earlier and it finally drove me to
action.=C2=A0 I'm juggling so many projects right now that I really don't
want to fix this myself, but..... grrr! and raaarh!, etc.

Daniel
