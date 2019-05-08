Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21241F45F
	for <e@80x24.org>; Wed,  8 May 2019 19:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfEHTXH (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 15:23:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45655 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfEHTXH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 15:23:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id t1so4375298qtc.12
        for <git@vger.kernel.org>; Wed, 08 May 2019 12:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9FaP4lTO9Q74s57SprXkfUso4nuAsmpjur1fpuUqris=;
        b=cZnx6IdoZpPgsi1Ep4zHwsJviFCM3aLc01yPtLIG8qS/64ZS3E/oMwMpvvqeqx95MB
         GMNmNjMnyzkPBb692P08Y1e4kbeHZNnPmqj9mCIJCHyjim4WKAGK4b3o9AWFiBYV5tMk
         ibBwJy4iKDYPf/BHFCNcNlspy1Sg8eiUBiz6z3GtZNMYLD3rEkEP34Ib72byeUQ9yuMT
         L0+s1IGK2cKIte69G7WqXxkLYOSVdc3Xb9gJdvICX3CHbEEd+5ew1cZDZadT8JieOgrF
         P0C1iM3R/bvuve/w+uf3B8wBc3KRJry2DnSkgnjhQRU1lAmAwOdbJJKAuj5yb64PzpJj
         of5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9FaP4lTO9Q74s57SprXkfUso4nuAsmpjur1fpuUqris=;
        b=uR2F2WcwVrq5BnqYADM278K6Gq88MiRcXYgJXjHe3mZI/uiTUOG30qKUXzt+7ZVhNr
         A+JB0IK2Kuyb0blW6I9/s77bF8DXI5N31wTLgbvEbMVAXoZ2S/osRVVYe/6+3PUxUMwb
         fakQ7kuyzK/c+eCzppALFhwZv4BniiAotJbb+u9ehyD+u9ztGVk22xZ7MX+INXNmo16f
         Hm9t4CTWD++6X8h5q+ISqPLN4+alklNJye16iWHMCq1s9Ig4KfRQVokpgCxxzb2z3Fla
         xyUGrhX5fRoDnLxTaTSPmpAMR5bQXBwRlb29hXQLLocPfQDhzjRUbOzF8BJXvHTStr2p
         II0g==
X-Gm-Message-State: APjAAAVoq5dsl/v2Me36RHrkg5xeQ18dJRav5p3pn+w8svKMvAREPtSY
        gAwkBdkWxWkkGenuurr3kNbZAgW8J5o=
X-Google-Smtp-Source: APXvYqzc5+JsV7gReflLxcbqyJ5TIbXX5asIOS3Hx/w3yTMuBhui2Vz/6NOrU0sdrLeGSh+lhD19FQ==
X-Received: by 2002:aed:3827:: with SMTP id j36mr32723509qte.196.1557343385892;
        Wed, 08 May 2019 12:23:05 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d14c:17a3:d28e:9336? ([2001:4898:8010:2:ba80:17a3:d28e:9336])
        by smtp.gmail.com with ESMTPSA id 20sm11437191qtu.51.2019.05.08.12.23.04
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 12:23:05 -0700 (PDT)
Subject: Re: [PATCH] Doc: add missing backticks to pull.rebase value
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <0e185c7c4b7ecb20631e1d330ce70ecf78427621.1557340984.git.liu.denton@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <aa4e4eef-01f2-5d64-afbf-eec41cefe15f@gmail.com>
Date:   Wed, 8 May 2019 15:23:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <0e185c7c4b7ecb20631e1d330ce70ecf78427621.1557340984.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/8/2019 2:43 PM, Denton Liu wrote:
> In the documentation for pull.rebase, all of the valid values are
> surrounded with backticks except for "true". Surround "true" with these
> missing backticks.

This would make the rendered docs [1] look a bit better, but I think this series
is incomplete. Looking just a little bit further down in the 'push' config options,
I see more with this same problem [2].

While you are here, could you track down the other similar issues?

Thanks,
-Stolee

[1] https://git-scm.com/docs/git-config#Documentation/git-config.txt-pullrebase

[2] https://github.com/git/git/blob/master/Documentation/config/push.txt#L59
