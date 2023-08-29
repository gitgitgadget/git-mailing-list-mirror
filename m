Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D644AC83F12
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 16:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjH2QTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 12:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbjH2QSx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 12:18:53 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E303C9
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 09:18:47 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38873190A53;
        Tue, 29 Aug 2023 12:18:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WvqVFPfoaZwMBIrmwQJyI2vdMdQDat7xpzgtuE
        5IQ9c=; b=rsKqGx0PiUkLLOEfObb7zIsZSOCkjFkdj4u08nvTeiHWE/G5Z53hpY
        Dr/N8HAat9Rf9gBEyHA8ql44WpY/39VWCwfNcCy2kftTVDApuwNHlytmBYtAY/T2
        sTomC877fTvJ94EoyZFnnZmW2gL/COmspfvQhF5KhhGmN2n30a6dg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FC4A190A51;
        Tue, 29 Aug 2023 12:18:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97383190A4E;
        Tue, 29 Aug 2023 12:18:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mark Levedahl <mlevedahl@gmail.com>
Cc:     git@vger.kernel.org, adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com
Subject: Re: [PATCH v1 0/4] Remove obsolete Cygwin support from git-gui
References: <20230624212347.179656-1-mlevedahl@gmail.com>
        <20230626165305.37488-1-mlevedahl@gmail.com>
        <xmqq4jmsiyhw.fsf@gitster.g>
        <a1e256cd-072d-a3a0-cdbe-ed65ed21bfd3@gmail.com>
Date:   Tue, 29 Aug 2023 09:18:44 -0700
In-Reply-To: <a1e256cd-072d-a3a0-cdbe-ed65ed21bfd3@gmail.com> (Mark Levedahl's
        message of "Tue, 29 Aug 2023 12:03:35 -0400")
Message-ID: <xmqq8r9tg6u3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA5E8936-4687-11EE-A124-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark Levedahl <mlevedahl@gmail.com> writes:

> On 6/27/23 13:52, Junio C Hamano wrote:
>> OK, Dscho says v1 looks good, and I have no further comments.
>>
>> Pratyush, can I expect that you take further comments and usher
>> these patches to your tree, and eventually tell me to pull from your
>> repository?
>>
>> Thanks, all.
>
> Junio,
>
> I see you merged latest git-gui from Pratyush onto next. As git-gui
> has no test facility I merged your py/git-gui-updates (a7935203) into
> your master (5dc72c0f), built on both Linux and Cygwin. git-gui works
> as expected on both. Looks good to me.

Thanks!
