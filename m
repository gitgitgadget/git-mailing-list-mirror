Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34FDEE498D
	for <git@archiver.kernel.org>; Fri, 18 Aug 2023 19:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379563AbjHRTJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 15:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379538AbjHRTJS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 15:09:18 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5A43A9A
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 12:09:17 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 392B5283E2;
        Fri, 18 Aug 2023 15:09:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gDU+s0GxmYiIFB/r4zN4V2g/HozubWm4dIMoHi
        Px8J0=; b=Z9VAhVzC0F+Uot4zM/py9vE33rbGyCete5etz101rmhNgu1lmTJkWM
        21Gtsj4rzSNN47udOd30Cx2+yaihk/BQvf2K0bksG6ZurUU29S8UaZje29qLURuF
        kYJD4e5szykU5fYnGpDSnWjUCfm91FpE9vexhfVoNSTk7xI5IohGw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 31ACC283E1;
        Fri, 18 Aug 2023 15:09:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DB301283DE;
        Fri, 18 Aug 2023 15:09:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] update-index doc: v4 is OK with JGit and libgit2
References: <xmqqil9cusfn.fsf@gitster.g> <ZN+/vJysYcri/iBz@ugly>
Date:   Fri, 18 Aug 2023 12:09:12 -0700
In-Reply-To: <ZN+/vJysYcri/iBz@ugly> (Oswald Buddenhagen's message of "Fri, 18
        Aug 2023 21:00:12 +0200")
Message-ID: <xmqqa5uouq07.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B85ADF4E-3DFA-11EE-8515-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Fri, Aug 18, 2023 at 11:16:44AM -0700, Junio C Hamano wrote:
>>+time. The first version to support it was Git 1.8.0 released in
>>+October 2012,
>
> "Git supports it since version 1.8.0[, which was] released in October
> 2012, and ..." would be probably easier to read.
>
>>and support for it was added to libgit2 in 2016 and
>
> +to
>
>>+JGit in 2020,
>
>>respectively.
>>
> this use of "respectively" is bogus; just leave it off.

All good corrections.  Thanks.
