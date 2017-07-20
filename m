Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 850011F600
	for <e@80x24.org>; Thu, 20 Jul 2017 18:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936011AbdGTSga (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 14:36:30 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36476 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935990AbdGTSg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 14:36:29 -0400
Received: by mail-wm0-f46.google.com with SMTP id v76so3696496wmv.1
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 11:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LCrI6y7EZKPk4K/Mz0lCgo6765Ygr33O7Hf+A4MvAvo=;
        b=dl8EcY3gcmTUDQxLvUK/6/ttJcdhMsA/b+Z8IsBtnzJJhOr/LJkdMyDqWoIHDoTAmp
         bCZ+DuBnEgDircBuE+E/rKjZt/IntGtv30hE92+NzBp/LCyIlLJ95ASz2TuaBEUUT+W/
         dIN2SUSxG+SJ2TGMViKXohp1jiVou8IjYh2XNbIX4WlLDKxxVaCwflPCuRajS1g8b6dl
         0QfEbjQ1pI67BD5cEMcnGCh+9UaHd3gUxDJjyAv+CIstt0ehqW5dd2ApBRvHoV8NLdK1
         s6pb+IdVesiVOFp6TQC/Upq5YP5gSUeToQnX6scZ4LEHOuFXncoWHfrLhCgUI2/jJtjL
         d9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LCrI6y7EZKPk4K/Mz0lCgo6765Ygr33O7Hf+A4MvAvo=;
        b=WnyddCuSK375Bio80lQ7wYf+1Vq/84gR9v3RG8A/bn4TbM8tF+XiG/q93wWVcNq2M0
         6iJH6eG8soda5tsDXyCHZzgkUBAV0b1uuyMOpUO6wayL836A+E9IFIsQCHxpdxi1nn6Y
         kogaRKHpzduO0O+hytNYYs9QkQ9fnXCraKtfHyMFCV9wzgdf3knX4t1mDrD6TzZV+Z5G
         UU/DeRjYsSlw645TjaiTNjcfEGnDQDVq0LduYDjAID6QdiJzlFCVepbBxZ1rHn275ddf
         9eOtgpknEfB1hoWHanjD7Qgy+7l/xw1l6vCBuVPa5WDVKt7giP1URiL2o+6VLKeLYKV+
         H/YA==
X-Gm-Message-State: AIVw112Sck3daw0WslZiq2DBt7DBYmsjLrNN3/zaNI0f1b8GkUx4OWGi
        Vb6HR71yfNevUA==
X-Received: by 10.28.99.215 with SMTP id x206mr2967841wmb.21.1500575788391;
        Thu, 20 Jul 2017 11:36:28 -0700 (PDT)
Received: from ?IPv6:2a02:8108:dc0:3364:a8ea:429:7058:d761? ([2a02:8108:dc0:3364:a8ea:429:7058:d761])
        by smtp.gmail.com with ESMTPSA id y100sm3081991wmh.7.2017.07.20.11.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2017 11:36:27 -0700 (PDT)
Subject: Re: [PATCH] l10n: de.po: update German translation
To:     Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Jan_Kr=c3=bcger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?Q?Magnus_G=c3=b6rlitz?= <magnus.goerlitz@googlemail.com>
References: <20170714161220.9565-1-ralf.thielow@gmail.com>
From:   =?UTF-8?Q?Matthias_R=c3=bcster?= <matthias.ruester@gmail.com>
Message-ID: <4f846a80-dfd8-f895-3b90-df1f78041a9f@gmail.com>
Date:   Thu, 20 Jul 2017 20:36:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170714161220.9565-1-ralf.thielow@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ralf,

I think the following should be "hinzugefügt":


>   #: builtin/add.c:288
> -#, fuzzy
>   msgid "warn when adding an embedded repository"
> -msgstr "ein Bare-Repository erstellen"
> +msgstr "warnen wenn eingebettetes Repository hingefügt wird"
>   


Everything else looks great! Thanks!


Kind regards,
Matthias
