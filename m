Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A04C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 23:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbiHBXIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 19:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbiHBXI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 19:08:29 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA45550A6
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 16:08:19 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 99B531B09AA;
        Tue,  2 Aug 2022 19:08:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CMzS/KTsgTlf
        4eodK9A7ZDWz8fz2LC0M/3KWysmgqm4=; b=XEt/Wn6rDT89+4A8WnYB6J9wuJw5
        cGhVZ6ctB46W2wsECwMAAcYZ6J9yw+wpa2nDpsLQWN7m3CuZkRianzfp357lYx33
        0YYDbSv5oGogB8jb8HcpOoOP2M34LQOkEPfjhkzgRJIkrASKTd2Avu2288rt7nHC
        M0p7MT4NsVhUS1U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91F891B09A9;
        Tue,  2 Aug 2022 19:08:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4416A1B09A8;
        Tue,  2 Aug 2022 19:08:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v7 05/10] git docs: add a category for file formats,
 protocols and interfaces
References: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
        <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
        <patch-v7-05.10-4367c1e7f50-20220802T125258Z-avarab@gmail.com>
Date:   Tue, 02 Aug 2022 16:08:04 -0700
In-Reply-To: <patch-v7-05.10-4367c1e7f50-20220802T125258Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 2 Aug
 2022 14:56:54
        +0200")
Message-ID: <xmqqk07qdz1n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F72331DC-12B7-11ED-84E9-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> So let's start moving those over, starting with just the
> "bundle-format.txt" documentation added in 7378ec90e1c (doc: describe
> Git bundle format, 2020-02-07). We'll now have a new
> gitformat-bundle(5) man page. Subsequent commits will move more git
> internal format documentation over.

Up to this point I think I didn't see anything objectionable (one
paragraph in the proposed log message of an early step was suspect,
though).  I'll leave the rest to another sitting, as my
concentration is running out.

Thanks.

