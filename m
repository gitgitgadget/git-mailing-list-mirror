Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11851C433E6
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 19:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E0222B2C
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 19:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgL1TUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 14:20:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60806 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgL1TUf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 14:20:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81277AF904;
        Mon, 28 Dec 2020 14:19:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=xCDiv8TLygbgYsjr6FEXugjFc+4=; b=rohGKoKHMdIJa/pQA/fb
        ebok50kOnZuSw81xfHEPGxyFRl3SHfAcgZxugD8LRiq4utXquBYK88sdajTd8JDR
        1XMYjiXza6yzR1YOBno57WxbUBZkh3CNPxkFa2h+nVcGr6EGNtJCsgerZ6YA3d02
        pP0+pqHDgO7jILL3pbkT1ow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=A8KhmSx7wW2izc+ETLs4ot3MnxdrUe4Y4UKlsdA4RVS09c
        nKtJWWK+UXWVz5hXDTkBVSvJmmdSdziJYb+pQI3RPZZmwPaNBPZi1jaHgLboBrnp
        kjx+FViI2RycRTYYhrRSl+BAWfClxvcAoGzc6NmhL1r/FFDaoQxkbG5x79dac=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A0B0AF903;
        Mon, 28 Dec 2020 14:19:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0BEB1AF902;
        Mon, 28 Dec 2020 14:19:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] SubmittingPatches: tighten wording on "sign-off" procedure
References: <xmqqh7o6jjt1.fsf@gitster.c.googlers.com>
        <5fe9e731de0e5_209d20845@natae.notmuch>
Date:   Mon, 28 Dec 2020 11:19:53 -0800
Message-ID: <xmqq35zpg2li.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA1C8596-4941-11EB-B3E0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> -If you can certify the below D-C-O:
>> +If (and only if) you can certify the below D-C-O:
>
> If you certify the bellow D-C-O:

Yes, dropping "can" would be a good clarification, I would think, too.

>
>>  [[dco]]
>>  .Developer's Certificate of Origin 1.1
>>  ____
