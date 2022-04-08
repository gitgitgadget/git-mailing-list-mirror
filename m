Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BA5C433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 18:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiDHSSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 14:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiDHSST (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 14:18:19 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C257F18B21
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 11:16:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5139E1885FD;
        Fri,  8 Apr 2022 14:16:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i4Ib5Ye7D+qe5M79rRYaN4wrEC0Jju9NXvD3yB
        mhL0o=; b=J7+j23O09moRlTMRpzHYbn5Ep9Sof9zzS7wLoiRICeGZp6HYiFB4O2
        PnKE7TeQ8Q2LjueiGBAvTVPmN/3rqhrKiMu+aS39A5vPm4+DqguDoU0VW4IW2sRd
        rolsPkFodpDznNU03vTett+am/RJtgf27++VP6WHHNXAaT8IeNbzY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 49D411885FC;
        Fri,  8 Apr 2022 14:16:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 450AA1885FB;
        Fri,  8 Apr 2022 14:16:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        whydoubt@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v2] blame: report correct number of lines in progress
 when using ranges
References: <20220404182129.33992-1-eantoranz@gmail.com>
        <b2f5d6af-8da1-3a3a-cc21-848c14a8fb98@gmail.com>
        <8622e48c-9f34-c644-4016-02c3795ac1e9@iee.email>
        <xmqqsfqq1bx9.fsf@gitster.g>
        <9920b355-9003-e7c7-77ab-3432651674e9@iee.email>
Date:   Fri, 08 Apr 2022 11:16:11 -0700
In-Reply-To: <9920b355-9003-e7c7-77ab-3432651674e9@iee.email> (Philip Oakley's
        message of "Fri, 8 Apr 2022 09:03:55 +0100")
Message-ID: <xmqqy20fmoes.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8A91E96-B767-11EC-B013-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

>> But I do not object to being more explicit.
>
> The core point though was that it can be misunderstood, thus avoiding
> the indirection, as you say, makes it more explicit for the reader.

Yup.  FWIW, I was saying that what the author wrote was not _wrong_
per-se.  I agree that being explicit here (instead of hiding behind
a pronoun) is an improvement.

Thanks.
