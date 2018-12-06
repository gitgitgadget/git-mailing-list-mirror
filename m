Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8D3E211B4
	for <e@80x24.org>; Thu,  6 Dec 2018 12:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbeLFMAO (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 07:00:14 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:54977 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbeLFMAO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 07:00:14 -0500
Received: by mail-wm1-f49.google.com with SMTP id z18so713621wmc.4
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 04:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AeyzMSaU7Ga8mLhW4eaKVywfzr+VQ9RxIQkblrFbr50=;
        b=luHvNwKwYra5d5FYedqgPhiV0HM18vxeg2jQzgs2Gi6udmW9Fa8jXABh8aYoI02uZM
         I8/YB0AIczD/J9I1kymbTT+D63Xnfx+jdLh170KTIXewQnsN0XcHlSgWA0zInh9R1q4+
         +/AUy3ZPpc1iTo+VsI5WgwHMJ+jd0F/ze8VLuwQM36KFT/evfMsDjBqO2xfFTjW7SCYe
         ZkrOuaU5EnCYrvg0qeiKETxiQV5rnDMYh3ZDkkPsAto1hpPhLnBs9IssZAPKWr/JjNmS
         jK8Rl+ZwLw8PQXC+arde4+nMRlTgdkBMxeznvmFHSnJfovnzp3hbAZt0G6PhjfnlsW+R
         ScTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AeyzMSaU7Ga8mLhW4eaKVywfzr+VQ9RxIQkblrFbr50=;
        b=nPH+XNdME5skkmFtqT0uXi1TQSrpO++8G7TUayeEoDD3Lq4rWFjQfVz7pcmwtohnQ1
         PRNHyHzhHi8KhVB2tJCPC8GBO8M4I8fYT/Sm4YJe+GUwq0jGaBuC6bbZ3rvGOJFpmtjf
         GMJlosfy4lVlXZODi5ZA9tq6pId5nAw40hDd36MWXFukeSHUajlNbO70KvjgfrQnviSh
         IL0a7pk/ZQEfLCgQZxxqR8giP7azxAfNoBlqS5h/hhhcFdL2ElcCWREO1paYCxhfGa2D
         UpV23FFHLJxXxfjsXGCjOyD7sQB1x2PffTSDYohO0JXA1MxJy7qMY70ck3xRQYMq5VAM
         JrWA==
X-Gm-Message-State: AA+aEWa/sejFxvPXvgWv38NTB9i9gQl3QkWIj8qW5/0QfTPh/jL+ysDy
        1NwQrDkZswNuMZ7KlIialkE=
X-Google-Smtp-Source: AFSGD/UQtVeybzxqcI+EvcvN5W/kBpNdi33xsj51f9X20/QP4yDMtVxXR4pTaH8VwtuNpX0QZSWXdQ==
X-Received: by 2002:a7b:c315:: with SMTP id k21mr18658665wmj.145.1544097612359;
        Thu, 06 Dec 2018 04:00:12 -0800 (PST)
Received: from [10.18.187.242] (ersc157.goemobile.de. [134.76.38.157])
        by smtp.gmail.com with ESMTPSA id t76sm963347wme.33.2018.12.06.04.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 04:00:11 -0800 (PST)
Subject: Re: [PATCH v2] l10n: update German translation
To:     Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?Q?Matthias_R=c3=bcster?= <matthias.ruester@gmail.com>
References: <20181130173531.10073-1-ralf.thielow@gmail.com>
 <20181204065430.31033-1-ralf.thielow@gmail.com>
From:   phillip <phillip.szelat@gmail.com>
Message-ID: <6d5df765-51ab-11b6-6414-2abc886732f2@gmail.com>
Date:   Thu, 6 Dec 2018 13:00:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204065430.31033-1-ralf.thielow@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

thanks for your great work! Just two remarks:

>   #: midx.c:407
> -#, fuzzy, c-format
> +#, c-format
>   msgid "failed to add packfile '%s'"
> -msgstr "Fehler beim Lesen der Reihenfolgedatei '%s'."
> +msgstr "Fehler beim Hinzufügen von Packdatei'%s'."

A Space is missing: "Fehler beim Hinzufügen von Packdatei '%s'."

>   #: run-command.c:1229
> -#, fuzzy, c-format
> +#, c-format
>   msgid "cannot create async thread: %s"
> -msgstr "kann Thread nicht erzeugen: %s"
> +msgstr "Kann Thread für async nicht erzeugen: %s"

I think we should use "Konnte" here.


Best regards,

Phillip

