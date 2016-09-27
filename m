Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A883520986
	for <e@80x24.org>; Tue, 27 Sep 2016 19:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754129AbcI0Tw6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 15:52:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33639 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753284AbcI0Tw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 15:52:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id w84so2715270wmg.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 12:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=eRxY2GKbqjfRpFA77U0gQZm9FiRu1REtv0X2EVDqyuM=;
        b=PRoNuw9BFaKKIOYBmsBhJhXAt+e3jvLxS6Bhacuix1GdQi0dasEIw9ye9eOgK9R6gh
         jXyLXkxee98C7c3HSToO3/KNWWeRIDp801FL6tD7uaTEVuHLQiuqolOKLnc9w/vUN3/7
         UCiDO2AMvf8Gv2gBTo6ZADE0+N+tlVnU2z2xHSgnizCeK+x9ljcZo+9SGu8gWv9wxrlo
         zRuacKBD8bkZWCk83EOqTREP4A3r/FND7uvLmz4hsoFZ2I8BFtiN8RDnjdXOd4umAire
         68DEWKCP8Q4NrO63S0v+M8/NIqQnzxo6tMUO/Hk9CDhzeOjnDXd8kOx7yoe6S/VQoUS9
         3I8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=eRxY2GKbqjfRpFA77U0gQZm9FiRu1REtv0X2EVDqyuM=;
        b=OQMcFotVyZoBnZ2ekqSKrMDihdanFZ0T2ugPVgjov9SXipi7KtZish9PcV/BB/nyIH
         IIPkutKq9+vhZPgiMQsvS4HBoFl5a9CcdBXRYz8Qb9/4CBmBOEUJsvu8t4naX7TCpdtG
         SNDseW3IBkrT6tdEVsIUSKcfXGZ6KttcgF1s86rhw57dGH3xLnVnfujH5heDSksh4yy+
         qSYcUn+mqiGRFrGEZ8BPYJ5H783FIwMPy+HTTuIvzdtVd85lYoAyh2KAC3v2NYBr4e9k
         sT6sD0WXeOWsZvOW6iDOgsiGcVy5VHejPSSvYGgROi0R4Ri6lbyzTM2GfvIIvcumWRUm
         ov7g==
X-Gm-Message-State: AE9vXwOW2NXthuOolHQTFDz81JZclbgFtpT4938N63xsj5xEzc/vo+tkt6A6dqUPumfukw==
X-Received: by 10.194.42.133 with SMTP id o5mr28420729wjl.200.1475005962558;
        Tue, 27 Sep 2016 12:52:42 -0700 (PDT)
Received: from [192.168.1.26] (dbw202.neoplus.adsl.tpnet.pl. [83.23.48.202])
        by smtp.googlemail.com with ESMTPSA id yt4sm4317875wjc.48.2016.09.27.12.52.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 12:52:41 -0700 (PDT)
Subject: Re: [PATCH] gitignore: ignore output files of coccicheck make target
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
References: <93adb7c5-aac7-7241-e383-3ff7997faf7e@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <745b0eed-4c03-9e72-4903-ab1dbbc3622d@gmail.com>
Date:   Tue, 27 Sep 2016 21:52:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <93adb7c5-aac7-7241-e383-3ff7997faf7e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 27.09.2016 o 21:01, René Scharfe pisze:
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 05cb58a..f370ba0 100644
> --- a/.gitignore
> +++ b/.gitignore

Wouldn't it be better to have this in contrib/coccinelle/.gitignore?

> @@ -207,6 +207,7 @@
>  /tags
>  /TAGS
>  /cscope*
> +/contrib/coccinelle/*.patch*
>  *.obj
>  *.lib
>  *.res

