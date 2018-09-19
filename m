Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0ABA1F453
	for <e@80x24.org>; Thu, 20 Sep 2018 12:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbeITSeN (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 14:34:13 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:43453 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387732AbeITSeN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 14:34:13 -0400
Received: by mail-qt0-f181.google.com with SMTP id g53-v6so8283321qtg.10
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 05:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=2oTbLM5CnarFP4BJoTg9aIcZtnA0bfTwRpoxBG3xMgo=;
        b=tYtqQkiIB1eHNaw3DaGP2y4q1CnZMq/2IbBgm6ewtGfhq2FUBrxLNpkwRa/1cq1f8Y
         vu3Muj4jCpbikSUb1la6bvHspetZP+gfLaoQlOtkxhaxIsp+zkLfWdvYI1CYsZq0EmGK
         fnRp+81PMu37Ds33aZnL/WUz9a+QG6J6W+fzpgyN/bzp45w2yUbMNSQ3LkNZp9zWWQ7S
         aRFk3iE7gVzZkbkmnxsG89Q5UZM0/RGw6uhM2rTAefFLmyZ97czSFWfnM/GS3q3cepLk
         dXH7uraF3Ha3Y++SKaQ/4QWjhQT6rIkMVhBDb0dZoPUMryohgkw6Qzols0TSTDXOIIQ4
         8O+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2oTbLM5CnarFP4BJoTg9aIcZtnA0bfTwRpoxBG3xMgo=;
        b=q97L8/SVCe/nYUtYMZvuvlEz/wa+GxON8DMmKJJKUB4fnA8Ob2lMHzBE0x7dptBx4A
         VhNu2ReHkLOAyJVImDtdXouJDulhVk4eTwRvaPA7b7UfNTxLjwqrCHOKl8mWF4f0K+Nw
         co3CvdbkV9nIjFiHlBGgJiebSwcQ6+tBfLd6404mjRz9hqAFCAs4Fy/6N3bxLG6srZW9
         sgZK4m/9lVeldhde2ua/uuS+DUtMBuqF0GgF64OVkZJ51Fw66DjAe9gx5vR9wNF5+k0d
         E3pHTaV2oCZK4FpOBXG3NLwFvKhExCup8UAVSgUt+7hs8PPql0TwscDy5J+Z4L6DOrji
         LpQA==
X-Gm-Message-State: APzg51CNAgsKJLe8x/PDqvIp1H9SP+SGH6djgZgx12U/TX3Lk1/LYNsQ
        Ejt62pjf3yWeDTrn+THsCr0nt1RY
X-Google-Smtp-Source: ANB0VdaVqA6UsJsGOchGY9Y5qGDOgXNI8wC8mHnfO3BvR/K3O6/h7FXmRCFMq7rd1KNZr9We3zhrNg==
X-Received: by 2002:a0c:d5aa:: with SMTP id g39-v6mr28195624qvi.176.1537447851065;
        Thu, 20 Sep 2018 05:50:51 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id q26-v6sm17421176qta.18.2018.09.20.05.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 05:50:50 -0700 (PDT)
Subject: Re: [PATCH 2/4] git-commit-graph.txt: typeset more in monospace
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <cover.1537374062.git.martin.agren@gmail.com>
 <acac5c3584b1cc7cf36ce4f7800738548eba8ccb.1537374062.git.martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ced54c95-b323-2c04-e612-eb987c8d9c02@gmail.com>
Date:   Wed, 19 Sep 2018 19:29:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <acac5c3584b1cc7cf36ce4f7800738548eba8ccb.1537374062.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2018 12:30 PM, Martin Ågren wrote:
> While we're here, fix an instance of "folder" to be "directory".

These changes are clearly good. Thanks!
