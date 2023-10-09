Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2BACD6105
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 16:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377245AbjJIQfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 12:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377235AbjJIQfR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 12:35:17 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11E099
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 09:35:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E39B529496;
        Mon,  9 Oct 2023 12:35:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KEO7mVgF2j7D
        xeqJo8W4H1uoowXolFlD9zo4Wb7IOMM=; b=b/mjEBBDJ8kRxoXNPnUusyZdbABp
        qFamILFKECJL4IGtIgydUmcCDDUPrhMcqe6JAYS2u+a93FAaatainAm6B0O8zf3B
        6rO3bFDHWE8B8PVKnVKUZZ/PzUnmmklYiCDxTTj6+FSZhpghhfPKxAa2nKik2fQs
        56U0NGaKNHJzuY0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DCDB829495;
        Mon,  9 Oct 2023 12:35:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1FD3529494;
        Mon,  9 Oct 2023 12:35:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2023, #03; Fri, 6)
In-Reply-To: <4014e490-c6c1-453d-b0ed-645220e3e614@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 8 Oct 2023 19:34:45 +0200")
References: <xmqqh6n24zf1.fsf@gitster.g>
        <4014e490-c6c1-453d-b0ed-645220e3e614@web.de>
Date:   Mon, 09 Oct 2023 09:35:07 -0700
Message-ID: <xmqqcyxn3gas.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CF86050A-66C1-11EE-A0BC-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 07.10.23 um 10:20 schrieb Junio C Hamano:
>> * rs/parse-options-value-int (2023-09-18) 2 commits
>>  - parse-options: use and require int pointer for OPT_CMDMODE
>>  - parse-options: add int value pointer to struct option
>> ...
> I don't mind removing this topic from seen for now; it's not ready, yet=
.

After seeing the discussion moved to giving a more type safe enum
support and then somehow convesation seemed to have petered out, I
was wondering if we figured out the problem space enough to see an
updated version with well defined scope and good problem
description.  I do not mind keeping it on 'seen', especially if
these two early steps are not expected to change.  It is not like
they are causing any maintenance burden.

Thanks.

