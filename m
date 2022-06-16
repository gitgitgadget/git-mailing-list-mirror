Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBE7C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 13:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377253AbiFPNrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377251AbiFPNrr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 09:47:47 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA30E00B
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:47:43 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14804127BF3;
        Thu, 16 Jun 2022 09:47:43 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=UcK4NHKqki+s8
        k/jizcKWGWMEL9OcPm6oLAGM33uMss=; b=QdTGe8+U39Jfy0M87VFXPS74rPxje
        W4h60iTuUKDyiykORHNAJc1L9gimmHaBBVlEP0qBiMYCP3sN9iJqbrPY6NUj9+R5
        A1TGJk5Deq/Ek8RbGEZccKNfNkBcp8Hg0RP3AdSruCgFGptpMLS4rNqG8ga8ZDVm
        I8Yz2/ni9hOFPA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0AD15127BF1;
        Thu, 16 Jun 2022 09:47:43 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.78])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 74594127BE9;
        Thu, 16 Jun 2022 09:47:42 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Thu, 16 Jun 2022 09:47:40 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] add -i tests: mark "TODO" depending on
 GIT_TEST_ADD_I_USE_BUILTIN
Message-ID: <Yqs0fA7FOA3WuaiR@pobox.com>
References: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu>
 <patch-v2-1.1-13c26e546f6-20220614T153746Z-avarab@gmail.com>
 <YqlIRveupj6tOO4P@pobox.com>
 <220616.86sfo4x5zw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <220616.86sfo4x5zw.gmgdl@evledraar.gmail.com>
X-Pobox-Relay-ID: E4FF0E84-ED7A-11EC-97B6-CB998F0A682E-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C6var Arnfj=F6r=F0 Bjarmason wrote:
>=20
> On Tue, Jun 14 2022, Todd Zullinger wrote:
>> Nice catch.  FWIW, I tested w/GIT_TEST_ADD_I_USE_BUILTIN=3D0
>> and without.
>=20
> My patch landed on "master" as 7ccbea564e8 (add -i tests: mark "TODO"
> depending on GIT_TEST_ADD_I_USE_BUILTIN, 2022-06-14) so this is water
> under the bridge.
>=20
> But just to tie this loose knot I think something went wrong in your
> testing.
>=20
> If I:
>=20
>     git checkout v2.37.0-rc0
>     # Apply your patch from <20220614185218.1091413-1-tmz@pobox.com>
>=20
> I'll consistently get a failure from:
>=20
>     GIT_TEST_ADD_I_USE_BUILTIN=3Dfalse ./t3701-add-interactive.sh
>=20

Sorry for being unclear.  I meant that I tested your patch.
The patch I sent didn't handle that case. :)

--=20
Todd
