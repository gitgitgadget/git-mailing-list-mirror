Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A04A61F453
	for <e@80x24.org>; Thu, 27 Sep 2018 19:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeI1Bga (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 21:36:30 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42799 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbeI1Bga (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 21:36:30 -0400
Received: by mail-qt1-f193.google.com with SMTP id z8-v6so3996317qto.9
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 12:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=ujWV8jnm0tnqUo66BuNHtjk6xY+6ZrqchIZGCzBPPR4=;
        b=YkjatBemeb5yTfKQ+MIUvVokTIxsXJruqEcjtnE8YX6seIVZWWpwwxS0U5TTyhF97X
         odon6tNNVrzY2cjRt+gzthiMbDp04e2QB/eIcYhoExCsdpodrzynNxxsWefpdk5N76jW
         rZ8haVp6dPHfND0eByE4K7VemgcfcY7IFETvgSTriI/dZEJyjef1I211HZW1YMSfq4aY
         UrBcE8P4RBkvl/tEu6LO3EDrgagsPWsAdje2yDMWfyvVcyXmJ0N0fuGpErMxlxnE64Af
         LAJuelbo04wFbs7mc5+wwScw6NBKOkD0JNhLkhIJCAWHNfO23Z/m+b+zOST5hYhPigzJ
         MGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ujWV8jnm0tnqUo66BuNHtjk6xY+6ZrqchIZGCzBPPR4=;
        b=LqrJNTG47tuy7xQSOjAY3S1E+CCo2bsq3vujIujdZVpsYfIPN2serYMffvC3Ua1je8
         jpXQXFs8FuckymeWHAWgoFR6RaaDXj9NEnoDTGnVeb7nmXcam9+2BymXK4B6C+XSe94G
         CmiH1npy5UoUz9YdONgbW71qIcnH1iD+Dt5332k+6vK7rkjBNSZG4gvcbTclBZ72qnwX
         xUxBRlf+IRDW+/agggeTuV51JyqY0/1mC9crjZOk/ZLHwm2aK9y0GVs4uwnvgLT1rqm4
         x1VnJ1nRh+s/WPZ+iTIBE7NmrqvuwFrH1eDEIZmPJhEl47sz8MbTwdztphoMXmiWA0Zk
         7s9A==
X-Gm-Message-State: ABuFfoiJXOstFNmKloOXOn2Qa7BGeaZxLeFPv9f0OogCx1CsONx+1aVx
        6Hut7xewAwvnsPubsNXNZ99lfU6y
X-Google-Smtp-Source: ACcGV62Nt7Xq/aDNtF2wwiyRV376veKyV8Gln7i9hEgtjf5/oGNC5lD6rE2Oir1ulitHDTpAk/Dw5g==
X-Received: by 2002:ac8:259d:: with SMTP id e29-v6mr9786261qte.233.1538075803983;
        Thu, 27 Sep 2018 12:16:43 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1455:e436:6b50:1b07? ([2001:4898:8010:0:fd8a:e436:6b50:1b07])
        by smtp.gmail.com with ESMTPSA id c18-v6sm1869329qte.78.2018.09.27.12.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 12:16:43 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] git-commit-graph.txt: various cleanups
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <6b1cb43e-a1a8-921f-cd66-3697609854e0@gmail.com>
 <cover.1538075326.git.martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <31d467b9-1ffd-5c1d-2ff2-f4cb76854f0a@gmail.com>
Date:   Thu, 27 Sep 2018 15:16:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <cover.1538075326.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/27/2018 3:12 PM, Martin Ågren wrote:
> This v2 starts with the same two patches as v1 did, then goes on to
> change "[commit] graph file" to "commit-graph file" with a dash, to
> match other instances as well as Derrick's feedback.
Thanks! This version satisfies my concerns and looks good to me.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
