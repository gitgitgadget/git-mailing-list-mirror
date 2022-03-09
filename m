Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D93DC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 19:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbiCITPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237387AbiCITPw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 14:15:52 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954BC10EC63
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 11:14:53 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1437123603;
        Wed,  9 Mar 2022 14:14:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zxECVdB10eoF
        WfWf7h+bbzCT39b5QqtI7UP09zSZ9I4=; b=wyfHw8kesQte1dqUIe2ZmaajB5rO
        xgEddyzWjinLxoDumfXHspcz/kTxXE30ry0pS/0F2i2TIrrOtpTuhiDkL5fznt44
        v2SpYJn+9tW4Xz+5WRW4bEU5cLbSXwVDg+IVjH3SmXHU90GjQ727k4Hpgk7BvCe+
        45K6+i55/hxFjYM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7302123602;
        Wed,  9 Mar 2022 14:14:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F0E5123600;
        Wed,  9 Mar 2022 14:14:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: What's cooking in git.git (Mar 2022, #02; Mon, 7)
References: <xmqqilspp5yg.fsf@gitster.g>
        <20220308080551.18538-1-dyroneteng@gmail.com>
Date:   Wed, 09 Mar 2022 11:14:51 -0800
In-Reply-To: <20220308080551.18538-1-dyroneteng@gmail.com> (Teng Long's
        message of "Tue, 8 Mar 2022 16:05:51 +0800")
Message-ID: <xmqqbkyfkkes.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3256AF70-9FDD-11EC-88B8-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

>>[Stalled]
>>
>>* tl/ls-tree-oid-only (2022-03-04) 12 commits
>> - ls-tree: support --object-only option for "git-ls-tree"
>> - ls-tree: introduce "--format" option
>> - cocci: allow padding with `strbuf_addf()`
>> - ls-tree: introduce struct "show_tree_data"
>> - ls-tree: slightly refactor `show_tree()`
>> - ls-tree: fix "--name-only" and "--long" combined use bug
>> - ls-tree: simplify nesting if/else logic in "show_tree()"
>> - ls-tree: rename "retval" to "recurse" in "show_tree()"
>> - ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
>> - ls-tree: use "enum object_type", not {blob,tree,commit}_type
>> - ls-tree: add missing braces to "else" arms
>> - ls-tree: remove commented-out code
>>
>> "git ls-tree" learns "--oid-only" option, similar to "--name-only",
>> and more generalized "--format" option.
>> source: <cover.1646390152.git.dyroneteng@gmail.com>
>
>
> Sorry for the late reply.
>
> I posted a updated patchset last week, we already had a private review =
on that,
> but maybe string need =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason for taking=
 a look.

I should at least take it out of the Stalled bin.  An "all issues
from previous reviews addressed and a final eyeballing tells us it
looks good to go" would indeed be appreciated.

Thanks.
