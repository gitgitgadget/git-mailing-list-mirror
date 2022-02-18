Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9FEC433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 16:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiBRQvk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 11:51:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbiBRQve (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 11:51:34 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C064D166A49
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 08:51:16 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 66FB7181798;
        Fri, 18 Feb 2022 11:51:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kzvz62nsDaTs/LPFmNXLptNoOqeOIpdT5GaIyE
        GbJHc=; b=wWqwaXTyygcEfA9n5xaH3LFUmgxB28dHXGe+lACOgNUh1iXqZRZK6f
        lNzZGfWYyHMEHtg1YNjZlK45alpeTlJqNkJaMAQBSaECZwsdhYv8h0Xih7DUiRdW
        x0ElL3vZ7b1dL81lKUmHduMuSRM+rSlExKvLG7NEXUCb1ERICa86c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5F579181797;
        Fri, 18 Feb 2022 11:51:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C5026181796;
        Fri, 18 Feb 2022 11:51:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: gc/recursive-fetch-with-unused-submodules (was Re: What's
 cooking in git.git (Feb 2022, #05; Thu, 17))
References: <xmqqley93rkw.fsf@gitster.g>
        <kl6lv8xc51ox.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Fri, 18 Feb 2022 08:51:12 -0800
In-Reply-To: <kl6lv8xc51ox.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Fri, 18 Feb 2022 10:49:18 +0800")
Message-ID: <xmqq7d9s3ypr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB7D989E-90DA-11EC-B244-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * gc/recursive-fetch-with-unused-submodules (2022-02-10) 8 commits
>
> I'm working on another version that should hopefully address some
> reviewer feedback on v2. I'd prefer to hold off until that version is
> reviewed :)

Thanks, will expect a reroll.
