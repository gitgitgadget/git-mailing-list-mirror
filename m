Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F079C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 23:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbiBYX2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 18:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbiBYX2D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 18:28:03 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D0C2716E
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 15:27:29 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C1AF18088F;
        Fri, 25 Feb 2022 18:27:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9p3DI1IfOM6w
        Rq4+sRPZOOdC4b6/clHKgqNT3nWHf1s=; b=R2CWvyoB1c4ZhMvzYnm3FKEGgPBv
        j58b5ebRrOSd3zdnoMKLjnzmCplt5RD+L4y027toNJrTFz0GzXpKcoNfcDwRxvC/
        z0ElUT+bbo8C0Mro7V0mhqhmFh8ryEE8wACD5Zv8B2fAkgdiuv2GiBZVPw+gjzsx
        V/uEeXl2pgjN6Bo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 71C3418088E;
        Fri, 25 Feb 2022 18:27:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D883F18088D;
        Fri, 25 Feb 2022 18:27:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 7/9] Makefile: add "$(QUIET)" boilerplate to shared.mak
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
        <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
        <patch-v3-7.9-471067deefc-20220225T090127Z-avarab@gmail.com>
Date:   Fri, 25 Feb 2022 15:27:25 -0800
In-Reply-To: <patch-v3-7.9-471067deefc-20220225T090127Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 25 Feb
 2022 10:04:33
        +0100")
Message-ID: <xmqq7d9i8r36.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7E3E6A9E-9692-11EC-9F67-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The $(QUIET) variables we define are largely duplicated between our
> various Makefiles, let's define them in the new "shared.mak" instead.

Thank you thank you thank you.

It has been disturbing me a lot to see these copied-and-pasted
duplication across Makefiles.

