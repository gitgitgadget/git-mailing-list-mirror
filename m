Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA7EC20984
	for <e@80x24.org>; Mon, 12 Sep 2016 11:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758043AbcILLrr (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 07:47:47 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35257 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757772AbcILLrq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 07:47:46 -0400
Received: by mail-wm0-f53.google.com with SMTP id a6so49378366wmc.0
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 04:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=TFqA0ysLUsDpN6+vTwvTgxoVYoHU04S3Gkp6B9xaApE=;
        b=RoWk70j2NtGyLz6xGkhbY9IeLBaobU+oAW3Ss/SquoKgfz0txvIcQDD493c0O636dW
         kvJ0zJTkj0+oTS+0qD7jkkFzx/1NHLueykXaqOiA67BwrrftIUsBh5ac7TjUaB33Qrhk
         kn4zr6IxwEYv0ZgNvWKCGb7z37tg46iuSV1pQU9jAzIK745gkUsgjqptV+1rlz95NNbN
         mevTzDaOzGi0Z4m6iVdGDWPzLaqzkmX2QjprBW9a4ozR2sXDgWqMDbIEkEQCtEZ8EBgr
         j5NiaIIO6aZ2iuy+hktvpsDnBHdhBQJHaet1/niNDUfl/6fEUzQG4T8n8nWWKaXNNAT0
         OOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=TFqA0ysLUsDpN6+vTwvTgxoVYoHU04S3Gkp6B9xaApE=;
        b=F/JAZdrqA+2AxHL9KOqmaL3Y/DS4HOQ5BOJkVYeDL0v8oiHABToz+gbvCTVyVZefkf
         8jN9Iil7wd6Y4MgkQLQNwSI3wpDX+wme4oH1C/LPRL/BRCAO/EcwesIQJf/H42dOnFgH
         Y1YKEqyQ4LoO4VP2VembBK7Ua3A4c/bPJVYA+F6oWhB7WSkTW2wjUFS4ikO6Cwc37SGe
         udF1zODspOFBKUs02037oNBt/Q3TC6G2tQoqHWa6+Lt5wNCI1ll+FREHL1rfLmepj6KO
         KFmo5Y527/UCYT8CwF/Q8VmJ4M7XXwv3BDVyuMsK4LzrvEkuHNCSSiQ/X1QAitY6Ymsk
         MAAw==
X-Gm-Message-State: AE9vXwNvhmTTz310OkEMEv9lt8hv36vl4eQkRaRWEVkUubKMtJHsLV0QPRKDHo3Z9+5mAQ==
X-Received: by 10.28.0.202 with SMTP id 193mr6125459wma.29.1473680865487;
        Mon, 12 Sep 2016 04:47:45 -0700 (PDT)
Received: from [192.168.1.112] (static-csq-cds-097114.business.bouyguestelecom.com. [164.177.97.114])
        by smtp.googlemail.com with ESMTPSA id jd4sm17529012wjb.6.2016.09.12.04.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Sep 2016 04:47:44 -0700 (PDT)
Subject: Re: [PATCH v2 07/14] i18n: merge-recursive: mark error messages for
 translation
To:     Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org
References: <1473679802-31381-1-git-send-email-vascomalmeida@sapo.pt>
 <1473679802-31381-7-git-send-email-vascomalmeida@sapo.pt>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
Message-ID: <882dcaf3-fd9b-0d83-2756-f3315dd6bb4e@gmail.com>
Date:   Mon, 12 Sep 2016 13:47:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1473679802-31381-7-git-send-email-vascomalmeida@sapo.pt>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Le 12/09/2016 à 13:29, Vasco Almeida a écrit :
> -			warning("Cannot handle more than %d bases. "
> -				"Ignoring %s.",
> +			warning(_("cannot handle more than %d bases. "
> +				  "Ignoring %s."),
>  				(int)ARRAY_SIZE(bases)-1, argv[i]);
>  	}

This one is also missing the plural form.

Thanks,

JN
