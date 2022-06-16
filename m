Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA5CC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 18:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiFPSN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 14:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377849AbiFPSNv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 14:13:51 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BC24C432
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 11:13:50 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E516A129ADA;
        Thu, 16 Jun 2022 14:13:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2rNIrJwYG2WHPw1qumX7C10eZc+kUEpAtMhZHG
        krT4k=; b=XvImmIVAlWcKKLPB0c6KXg1JOfoxSlYXp3ZsvffOv+loY8Lr1vXZMH
        /tKmOeb211kr+1T8RDF+h8OufEdP4fE4JGHylZ075CKo4PcdyhfCXNiWfIfmQIKs
        U2uH900OOgRHp8mQTrGITTp1uOzhClUUaUqC9f7sSLwJ0c4frm/Rk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DCE6E129AD9;
        Thu, 16 Jun 2022 14:13:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 40729129AD8;
        Thu, 16 Jun 2022 14:13:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew John Cheetham <mjcheetham@outlook.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.37.0-rc0
References: <xmqqwndk10gg.fsf@gitster.g>
        <AS8PR03MB86896658C0807DF7F03ABBFAC0AC9@AS8PR03MB8689.eurprd03.prod.outlook.com>
Date:   Thu, 16 Jun 2022 11:13:48 -0700
In-Reply-To: <AS8PR03MB86896658C0807DF7F03ABBFAC0AC9@AS8PR03MB8689.eurprd03.prod.outlook.com>
        (Matthew John Cheetham's message of "Thu, 16 Jun 2022 15:05:27 +0100")
Message-ID: <xmqqbkustr1f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11EB919A-EDA0-11EC-93C0-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham <mjcheetham@outlook.com> writes:

> On 2022-06-14 02:46, Junio C Hamano wrote:
>
>> An early preview release Git v2.37.0-rc0 is now available for
>> testing at the usual places.
>
> I notice that GIT-VERSION-GEN doesn't seem to have been updated to
> reflect "v2.37.0-rc0" as the version number like in previous rc0
> releases. Is this just an oversight?

Indeed it is.  Thanks for spotting and reporting.
