Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DD3C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 17:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376826AbiBDRQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 12:16:06 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53016 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbiBDRQG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 12:16:06 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C28C216B5D9;
        Fri,  4 Feb 2022 12:16:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jEQLcvcD8tNYMp9fyl4Vhba87I9ai/O5C2Icgn
        aC7wk=; b=aHhKBxkC6DkXvN5iHaX8h1/GCnB9WkeegsM7mSMMQN4QEBgQhmYkyY
        LDPl/exGcxrJXFpik2BZI2gqGA6JtBcwfv2Noll9lPAnfeWIArM1yrpAAQVHjOBp
        KGCV/0IaPHS3nGiB8vpbXCL8mmnA67QLfT4AY7sqEEHyQmldSZa1o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA7E816B5D8;
        Fri,  4 Feb 2022 12:16:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 28A8C16B5D5;
        Fri,  4 Feb 2022 12:16:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: Re: [PATCH v3 00/21] git-p4: Various code tidy-ups
References: <20220116160550.514637-1-jholdsworth@nvidia.com>
        <xmqqr197xi0b.fsf@gitster.g>
        <BL0PR12MB4849847CD8385F0FABD9AE95C8289@BL0PR12MB4849.namprd12.prod.outlook.com>
        <xmqq8rurskmw.fsf@gitster.g>
        <BL0PR12MB4849C71DFC2628C00EF79196C8299@BL0PR12MB4849.namprd12.prod.outlook.com>
Date:   Fri, 04 Feb 2022 09:16:01 -0800
In-Reply-To: <BL0PR12MB4849C71DFC2628C00EF79196C8299@BL0PR12MB4849.namprd12.prod.outlook.com>
        (Joel Holdsworth's message of "Fri, 4 Feb 2022 12:27:50 +0000")
Message-ID: <xmqqiltumu26.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 216F9EBA-85DE-11EC-BE16-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Holdsworth <jholdsworth@nvidia.com> writes:

> Makes sense. And I suppose the cover letter would have to list out
> the dependencies? - because otherwise you won't see any merge
> commits in the emails.

Yes, more importantly, I wouldn't know unless you tell me where to
apply your patches (well, I usually can guess correctly, but I do
not want to guess and be incorrect, which would waste everybody's
time).

Thanks.
