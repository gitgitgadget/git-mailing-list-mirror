Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FCFC43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 15:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiFXPfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 11:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiFXPfx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 11:35:53 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA9C46B26
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 08:35:52 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 648C51AF6DC;
        Fri, 24 Jun 2022 11:35:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=U/UrTkIAxkAg
        N+MJ1wMdCedKDVePIvn5hqRXRV+PIiA=; b=bwoha77sGnkI1GaVuxiBT8vIE6P9
        nJhLmZw3Q51xhLE3HBvKXMpQWM2TG0J0jbDSOSnuN215mgHPZL2R0fo4g8sCnBLZ
        UcO436rSOr57Ozb1dL4UqTEivWfR805rKbeW4PiHVaI2F3iEZj9EypEZ80W3+46c
        BaopYPeZ8In9L4c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D9B81AF6DB;
        Fri, 24 Jun 2022 11:35:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E0E7F1AF6D9;
        Fri, 24 Jun 2022 11:35:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: gc/submodule-update (was Re: What's cooking in git.git (Jun
 2022, #07; Wed, 22))
References: <xmqq7d584hqb.fsf@gitster.g>
        <kl6lk096iwk3.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Fri, 24 Jun 2022 08:35:47 -0700
In-Reply-To: <kl6lk096iwk3.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 23 Jun 2022 20:12:44 -0700")
Message-ID: <xmqqo7yivzu4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 527F20D0-F3D3-11EC-A520-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> I think this is worth renaming since 1. =C3=86var has taken over this a=
nd 2.
> it is no longer primarily about "git submodule update".
>
> Maybe "ab/submodule-cleanup" and "Preparation to turn git-submodule.sh
> into a builtin"?

Thanks.  Greatly appreciated.
