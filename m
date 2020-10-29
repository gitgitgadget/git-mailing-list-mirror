Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB33FC4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 19:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE702075E
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 19:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G4Jg4VN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgJ2TKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 15:10:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61607 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgJ2TKG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 15:10:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A47310280A;
        Thu, 29 Oct 2020 15:10:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=omVFIGrr1QTOmNHmrOtCcU1H09Q=; b=G4Jg4V
        N/K9zJH8eG6mM8M+Px7dCtT2jg1lwmDhWi18ypA6hOAxztgh8C5sjDtZG4ZMFplE
        XTBDF4qzEMvFL07iYKSdK+LVGYRQII1fSZ3g0julACDXOpo+8PUUVUKbkOwe0t+3
        GI4xRjEBv+FpEH/7M5aSN8U24QVomDJf6WfT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UtNd53+4SGgm5o9upj2KcdDFHN/zFWoL
        9E2Y0PeqkJPBpOZ6alOaxdxFbO5InRmuVb4IeU7ic5GymtsNHO7MZdh1zRVOhig0
        ou471DQ/O5KZfxjJbHzef6uXlYnweLLAhpNxUK+eExlmmKXIzdMbKUJJxtF6HaRZ
        E94Y7NG6D2w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 83155102809;
        Thu, 29 Oct 2020 15:10:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7E5BD102805;
        Thu, 29 Oct 2020 15:10:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?0JvRkdGI0LAg0J7Qs9C+0L3RjNC60L7Qsg==?= 
        <lesha.ogonkov@gmail.com>, Stefan Haller <lists@haller-berlin.de>,
        Alexey via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: [PATCH] Fix zsh installation instructions
References: <pull.814.git.git.1593687080695.gitgitgadget@gmail.com>
        <xmqqr1to8dv9.fsf@gitster.c.googlers.com>
        <abc4ab95-ed65-1d6b-e964-73734c08cda9@haller-berlin.de>
        <CAMP44s3=CUmx_7DCExK7L4trZvQTxO67Qk20eexsP3su-3RyKQ@mail.gmail.com>
        <abc34ced-0c0f-4024-a50c-30e4ca31b325@haller-berlin.de>
        <CAKU+SVKad4q-2tTrYXa+DJBz5UJOtndEe3-4Uvnd5GZ92543ng@mail.gmail.com>
        <xmqqwnzbbfsi.fsf@gitster.c.googlers.com>
        <CAMP44s2DR=pV3frOePMbSyikA-KonZ5XWD7o5SqKhUbzohAFtQ@mail.gmail.com>
        <xmqqtuuc7wgu.fsf@gitster.c.googlers.com>
Date:   Thu, 29 Oct 2020 12:09:59 -0700
In-Reply-To: <xmqqtuuc7wgu.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 29 Oct 2020 10:50:25 -0700")
Message-ID: <xmqqpn507ss8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5826C7FC-1A1A-11EB-A4F4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> I would rather leave it out.
>
> Makes sense.  Instead of adjusting my rerere database for that,
> ejecting lo/zsh-completion topic would be easier---what the other
> half of that patch does is already in your 29-patch series.

Actually, I already have an entry in my rerere database to resolve
the merge of these topics to drop the "autoload" suggestion, so I
won't have to do anything other than just queuing the v3 of your
29-patch series.

