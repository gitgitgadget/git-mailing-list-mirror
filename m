Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F09C433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 18:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349121AbiDKSSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 14:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349119AbiDKSSP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 14:18:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D671EC47
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 11:16:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1781C1F38D;
        Mon, 11 Apr 2022 18:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649700959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ocEQDM4qyQ+vQw+/CazlhNhoFkTtc9e6REVpRkHkWcQ=;
        b=zQ9elhr35DA6RD8mJ62pbwR3Y8kfDDfEG9/Y7YtNCfkxA9q/AQ0ng5br3BvXSCAfF4aFGI
        NvUspH4ZrljaAUFEgmY9PRY7UT43L0Ixh8fUnwubg4xd2k7Ul+AfdCi8EaolmSkIJsK4A2
        suQHbl9SNLmtlaL1A2neob9/D0RC/c4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649700959;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ocEQDM4qyQ+vQw+/CazlhNhoFkTtc9e6REVpRkHkWcQ=;
        b=vZFtRilwb+9AF/eQT3wkNXm8tiX6ThacOrAwHuAOarf4qjg1PedArDZn05Brg7Ny6+aUWJ
        kPQykk+9kOZKciDQ==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C593AA3B92;
        Mon, 11 Apr 2022 18:15:58 +0000 (UTC)
Date:   Mon, 11 Apr 2022 20:15:57 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks <tao@klerks.biz>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        rsbecker@nexbridge.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        jurgen_gjoncari@icloud.com, git@vger.kernel.org
Subject: Re: Make commit messages optional
Message-ID: <20220411181557.GE163591@kunlun.suse.cz>
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
 <YlC3devsgmv17PnQ@camp.crustytoothpaste.net>
 <00ca01d84ba0$dd7ee0c0$987ca240$@nexbridge.com>
 <20220409113244.GX163591@kunlun.suse.cz>
 <CAPMMpoi50j7MzrsokQAcBWBgj8qGPN=j68PuEsppv629Oh7GHg@mail.gmail.com>
 <220411.861qy3khkk.gmgdl@evledraar.gmail.com>
 <CAPMMpohNYizpbqerAuFZnSY9mFsTJEJbfFWNGY41GcHxdwGrew@mail.gmail.com>
 <xmqqzgkrijb0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzgkrijb0.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 11, 2022 at 11:09:07AM -0700, Junio C Hamano wrote:
> Tao Klerks <tao@klerks.biz> writes:
> 
> > Several discussion participants noted they use garbage rather
> > than empty just to avoid typing so much...
> 
> It is a positive thing, isn't it?
> 
> If they consistently use greppable garbage, that may serve as even
> better reminders that they need to revisit and clean them up later.

Uhh, that'e very contrived argument.

Was that meant as a joke?

Maybe you forgot your smiley faces.

Thanks

Michal
