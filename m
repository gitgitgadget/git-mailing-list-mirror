Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27B4120281
	for <e@80x24.org>; Tue,  3 Oct 2017 00:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbdJCAeL (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 20:34:11 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37799 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750986AbdJCAeK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 20:34:10 -0400
Received: by mail-pg0-f65.google.com with SMTP id o1so6420435pga.4
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 17:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fgzXTP0v94qxVj+oJgRCb/UipyfddfuKwXor2b0MnpY=;
        b=orL3SW/v3TRBv9ehSc2Kb0YZl3SxoTCKpQH4VpsYeycU4XowEY313R776UX6eHmBrI
         wVGXwICG3ahIxFhcdlu1jXJ2PP1+84semYvKUN0r2e/unEinvz5JMY8Iu36VW4MhLRUu
         392bOyC16HLBr29xrbFD91D/pu5D+CcRJruuxpkcYeS3R0RyPhihhzOTtu6KBBYUt1K2
         sUHttzwtNKf1J79PM6EobZJM7JYsxOnec4LSBU3a6wMfiY4kDVdFGW228BdF6yU1VpZ2
         Xn0P88iS2yi1JWEjmLfbULE246oSB7S08rvUaRnQTR9V2EAcPzZcp7ZprRrrvU11YgkZ
         1mJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fgzXTP0v94qxVj+oJgRCb/UipyfddfuKwXor2b0MnpY=;
        b=RJEQhV4UV8dy+0L2TQ2oe+NAOVOpCOHdjuaoJBKEXRmJaNMMQZ61S+7Xxb1twXuiAa
         WAnDcsVE/IMZCvC/4A95FRlRkv6cyJhLQt7AYOWLk4WTGjOGIbmSe2EdQjlYALzePeNh
         Nk1fnu9aBhPLOMWeeGj7eZxcaOFWBb9xwkF5HK9DN9sjGP0xgbuzFyEsWWk5CFsMGgpG
         w2h9V2SwZxlzdLxtcMo/hTin2HRN041tSNXduarVRTv/dNwaAopQtQ5EyvUJwb4acIv3
         SC5BUpVTfM/zzfODLoX3Y4LZ/mqPg43Qxg8+/RdC3YEXvp5FARnIi9AzyTDVmisLCf+V
         5bUg==
X-Gm-Message-State: AMCzsaWFsCPX8J597F5VAKJM6wPGvdr4ze2hWlLEbjWwY0rNcZ3//lxh
        MdZljLXQ+/Leq7gC+3BS42c=
X-Google-Smtp-Source: AOwi7QDyZci8W1SgfyKD25o3mzeg0EBCHOiv0FzIc6ITf33un4OWxeeKofXPgiFP8lvdI+hTBLjTJg==
X-Received: by 10.159.252.137 with SMTP id bb9mr3707561plb.48.1506990849839;
        Mon, 02 Oct 2017 17:34:09 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:3463:ab6b:5863:927c])
        by smtp.gmail.com with ESMTPSA id u66sm19217350pfd.33.2017.10.02.17.34.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 02 Oct 2017 17:34:09 -0700 (PDT)
Date:   Mon, 2 Oct 2017 17:34:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ann T Ropea <bedhanger@gmx.de>
Cc:     git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] request-pull: capitalise "Git" to make it a proper
 noun
Message-ID: <20171003003407.GW19555@aiede.mtv.corp.google.com>
References: <20171002225636.Horde.mXj_gBTKz-CxnFKzUqiNDA1@bedhanger.strangled.net>
 <20171002230959.GU19555@aiede.mtv.corp.google.com>
 <20171003000838.Horde.GkejIyyuKI5nlVernhZ1XQ1@bedhanger.strangled.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171003000838.Horde.GkejIyyuKI5nlVernhZ1XQ1@bedhanger.strangled.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ann T Ropea wrote:

> Of the many ways to spell the three-letter word, the variant "Git"
> should be used when referring to a repository in a description; or, in
> general, when it is used as a proper noun.
>
> We thus change the pull-request template message so that it reads
>
>    "...in the Git repository at:"
>
> Besides, this brings us in line with the documentation, see
> Documentation/howto/using-signed-tag-in-pull-request.txt
>
> Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> v2: rename patch, correct Signed-off-by line, add Acked-by line
>  git-request-pull.sh     | 2 +-
>  t/t5150-request-pull.sh | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for the quick turnaround.

Sincerely,
Jonathan
