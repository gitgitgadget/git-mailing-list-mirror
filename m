Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2A3C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 00:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347886AbiCYAxU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 20:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240383AbiCYAxS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 20:53:18 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E87ABB912
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 17:51:45 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 04AF81895ED;
        Thu, 24 Mar 2022 20:51:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6lI9KyDSGGdn
        M7u27+50jgKexYOTNOgo03E3u1+6Yfw=; b=NV1dg6xnvZTRXnD4Nr5D1oNRM4bh
        BKPNwlyRcrle5g8occ7Qd+OKevLTYEzrkJP2H0/z1TruWOfqNQ+Twku0Fv3owGax
        iM06Ls5quMq2N9kDVVn9YS8EMpm3sq7JTJcuxv7PFuV+4SM/wLg8LETbwUtkg5u7
        sJzmf8fBiJWxbdA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F250A1895EC;
        Thu, 24 Mar 2022 20:51:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 659831895EB;
        Thu, 24 Mar 2022 20:51:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 09/27] stash: always have the owner of "stash_info"
 free it
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        <patch-v2-09.27-88289157533-20220323T203149Z-avarab@gmail.com>
Date:   Thu, 24 Mar 2022 17:51:41 -0700
In-Reply-To: <patch-v2-09.27-88289157533-20220323T203149Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 23 Mar
 2022 21:31:59
        +0100")
Message-ID: <xmqqlewyetwi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BCB974A0-ABD5-11EC-BD7B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the initialization of the "revision" member of "struct
> stash_info" to be initialized vi a macro, and more importantly that

"vi a" "via a"

