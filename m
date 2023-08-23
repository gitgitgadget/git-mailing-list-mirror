Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB6CEE4993
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 16:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbjHWQCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 12:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjHWQCS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 12:02:18 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73411702
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 09:02:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7614E19EB4D;
        Wed, 23 Aug 2023 12:02:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kFyHgQwHwtnA
        LjCAxxE7CNd/c60ViXeWtiZBp2msT5Y=; b=sn73D5SYR9V0630taujEKxVc7LJ8
        jsJyeFwcnO8dcKwx5BOqsqZB84+Dj6HUx7OvLeS4akzXi/kCauEUsy3jN3Drw3E2
        9fCwY2QN4IvDiEVHYhRrnmwT3OfGY1m8InoSV4Nak5pew40bhCC7tnRi5HS2k8bv
        0vp3cWVEON7JNNQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF05719EB4C;
        Wed, 23 Aug 2023 12:02:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E005F19EB4A;
        Wed, 23 Aug 2023 12:02:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Christian Hesse <list@eworm.de>,
        Git Mailing List <git@vger.kernel.org>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 2/2] t/t6300: drop magic filtering
References: <20230822150149.541ccb35@leda.eworm.net>
        <20230822130315.71259-1-list@eworm.de>
        <20230822130315.71259-2-list@eworm.de>
        <CAPig+cTFrroZGo=KOXu0aCxeJvNz7eaHAK++HXELZ0ZheJhw9w@mail.gmail.com>
Date:   Wed, 23 Aug 2023 09:02:00 -0700
In-Reply-To: <CAPig+cTFrroZGo=KOXu0aCxeJvNz7eaHAK++HXELZ0ZheJhw9w@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 22 Aug 2023 12:43:22 -0400")
Message-ID: <xmqq8ra1hhmv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 663C9DE2-41CE-11EE-9DA7-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Aug 22, 2023 at 9:03=E2=80=AFAM Christian Hesse <list@eworm.de>=
 wrote:
>> Now that we ran a trustdb check forcibly it does no longer pullute the
>> output. Filtering is no longer required...
>
> s/pullute/pollute/
>
>> Signed-off-by: Christian Hesse <mail@eworm.de>

Thanks.  Applied the typofix (with removal of the extra double-dots)
while queuing.
