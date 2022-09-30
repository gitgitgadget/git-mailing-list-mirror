Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25C6C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 21:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiI3VBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 17:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiI3VBj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 17:01:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5E8149083
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 14:01:36 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F4AB1C9536;
        Fri, 30 Sep 2022 17:01:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=oXcU0J9g21ICufwaOp2ey2ysO
        6+XKtnEeh2ne4yA+QE=; b=Bj77M+H8eyj69FQ+wf4eIiciM2dA1dHgQ7Yq4w2RM
        YK//lcN04alCx0BK6HKi/Cv0j7lGH17n8MbRU7cGENKtTJgF7/wWyVMCD23znmVG
        AQKZ97Q0M5ioU8815LhKbqkBP31pU9PbbuD+ZlyRdY5UJmi+8XSvZjeijXbkDTke
        1A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8765F1C9534;
        Fri, 30 Sep 2022 17:01:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BB8A51C9531;
        Fri, 30 Sep 2022 17:01:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 01/36] CodingGuidelines: update and clarify
 command-line conventions
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-01.36-1611913e321-20220930T180415Z-avarab@gmail.com>
Date:   Fri, 30 Sep 2022 14:01:31 -0700
Message-ID: <xmqqa66ga85w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 100541F8-4103-11ED-8CD4-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Having a space around " | " for flags, but not for flag values is
> inconsistent, but this style guide codifies existing
> patterns. Grepping shows that we don't have any instance matching the
> second "Don't" example:
>
> 	git grep -E -h -o '=3D\([^)]+\)' -- builtin Documentation/

Makes sense.  Thanks.
