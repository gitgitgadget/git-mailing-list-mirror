Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A97F1FBB0
	for <e@80x24.org>; Sun, 23 Oct 2016 17:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755519AbcJWRlG (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 13:41:06 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36155 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754891AbcJWRlG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 13:41:06 -0400
Received: by mail-wm0-f45.google.com with SMTP id b80so66900585wme.1
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 10:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=E8aO4aXJHXbLczOJp28zUGrdJIiOtdg1GxHipCjZqkc=;
        b=OevuX2a6F1aQfZLlN6XInoigpRwIaYw2A55Kg7GqytWJcmiPED18bR30tAPLoW9ygr
         4JzHvsKSGeNGbqqxQ2TE3q/lCHS5HOmoYW3veNp9YxqIp2tAmD5OCbOf3uWj2m3F+HdV
         +E9draGfva8nMX9W9KcuXgQ82zX+SzrYJb4XWYSLCAyjtMlCkoLgQ4ntgC55Xrz0/Rpt
         KIG2gUaMZTh62iEoTe4RzmiilivRzgnFD7OKuSarkxoEnbilvMn5EToNJdyxPvUwjSqX
         WApE+8DrJI3w8Wr5zKfklcCmF0RgQmlpJ98AssoqpUgxt+7Zjs0Dsn6AozrL5OaK3qXw
         PdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=E8aO4aXJHXbLczOJp28zUGrdJIiOtdg1GxHipCjZqkc=;
        b=e71GmiBk4H0540kLiQLZgPhxW70Ew2zp02z+V0KHVlRkk9zMfYP8puCLU/mo5NvEat
         bwAkKiTk6sNb3/6Qi20Tbc1Atvf58OesYr/o2I4I9Bw4brb1kYMTJvFR97J6s+azyBCT
         DsU5Yf9Q5TEB+BGz7NyPx230Z+OR+NrzmF7SanYHpxp2XoZjvPoXHOd3z4WzuijEnHXE
         KPsCqUSADHV0jrcYv1w005jIzthW6aT8LUk9f3vNviKhQkGCCWqmCUa81duQXLpWZHH5
         2F8uRn6TQBJ4rEQ2tpdRe7JX+osXLEh/u+HdEYXoYz7sEfW3CqPVn5N0WsA0Ityi2v9X
         WI0Q==
X-Gm-Message-State: AA6/9Rnr6rKk+2X04yvXrlIxGK8lTLGovrVsmVLCR457e/5ozYAM3yPci3py1qNiOFUFYg==
X-Received: by 10.28.203.5 with SMTP id b5mr11298304wmg.9.1477244464541;
        Sun, 23 Oct 2016 10:41:04 -0700 (PDT)
Received: from [192.168.1.26] (afq251.neoplus.adsl.tpnet.pl. [83.25.146.251])
        by smtp.googlemail.com with ESMTPSA id rv12sm14841190wjb.29.2016.10.23.10.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Oct 2016 10:41:03 -0700 (PDT)
Subject: Re: RFC Failover url for fetches?
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <CAGZ79kaPdSfY_DXL6BDQ9pAma8p61r4m1n81VTxPHYi8zQuZfA@mail.gmail.com>
 <xmqqeg39bk40.fsf@gitster.mtv.corp.google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <7fdaa160-9262-5d52-7035-8362ca94beea@gmail.com>
Date:   Sun, 23 Oct 2016 19:40:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqeg39bk40.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 21.10.2016 o 21:03, Junio C Hamano pisze:
> Stefan Beller <sbeller@google.com> writes:
> 
>> So when pushing it is possible to have multiple urls
>> (remote.<name>.url) configured.
>>
>> When fetching only the first configured url is considered.
>> Would it make sense to allow multiple urls and
>> try them one by one until one works?
> 
> I do not think the two are related.  Pushing to multiple is not "I
> want to update at least one of them" in the first place.

Push is/should be 'update all', fetch is/should be 'fetch any'.
I thought that multiple remote.<name>.url values provide this
fallback for fetch, but it looks like it isn't so...

> 
> As to fetching from two or more places as "fallback", I am
> moderately negative to add it as a dumb feature that does nothing
> more than "My fetch from A failed, so let's blindly try it from B".
> I'd prefer to keep the "My fetch from A is failing" knowledge near
> the surface of end user's consciousness as a mechanism to pressure A
> to fix it--that way everybody who is fetching from A benefits.
> After all, doing "git remote add B" once (you'd need to tell the URL
> for B anyway to Git) and issuing "git fetch B" after seeing your
> regular "git fetch" fails once in a blue moon is not all that
> cumbersome, I would think.

One would need to configure fallback B remote to use the same
remote-branch namespace as remote A, if it is to be used as fallback,
I would think.

> 
> Some people _may_ have objection based on A and B going out of sync,
> especially B may fall behind even yourself and cause non-ff errors,
> but I personally am not worried about that, because when somebody
> configures B as a fallback for A, there is an expectation that B is
> kept reasonably up to date.  It would be a problem if some refs are
> expected to be constantly rewound at A (e.g. 'pu' in my tree) and
> configured to always force-fetch, though.  A stale B would silently
> set such a branch in your repository back without failing.

Nb. there is also http-alternates mechanism... which nowadays doesn't
matter anyway, I would think.

-- 
Jakub Narębski

