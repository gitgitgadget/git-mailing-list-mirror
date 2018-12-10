Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F2CC20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 14:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeLJOqi (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 09:46:38 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:34937 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeLJOqh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 09:46:37 -0500
Received: by mail-ed1-f48.google.com with SMTP id x30so9706762edx.2
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 06:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HV5qWcKnsiukPNJsfWFBW/JEvYQk+8KYmKYRotVPQIg=;
        b=thM6E+3h96/ypjhvCUj4DG+7IY9WgRgmpKSquoTMh6+8sph+Nc/UDO5nXp8gP9EGuu
         o/lwlq9gpGK+WDiwZGIr6Gc7CpHyqUksQzw0hsx/RzSAUSRBAyCUdpGjEFdfAKXaQ5bs
         jpBnWPwjpfwnhlqLk92jJP+UnIn366XEnK5oVpmbk4mNJNjwWvzCXbLgy11ZFla8K9DU
         ii0rfVBIMwxAyVxfHPD+HFVDuqwiSwzs2ykB5q3Z6cVyK4+bnYtGUCEQZgWMHzCa6oxB
         /16gtAFEhv6TvdxMxr3K7PvlvsSG57xjr7QcPiBQqSMq0XV9gyXfajlLszp2I1xCnAH1
         UkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=HV5qWcKnsiukPNJsfWFBW/JEvYQk+8KYmKYRotVPQIg=;
        b=Am9BQfgm+3QnP/iGt6qU9DssOmu/WZvxNZU68dwF85I9PDftLEVA/yNRWmsYHqefth
         EsHtI6QuMpFBFF8qr2D02XLQY5o8FEKaQd9RuKT6edfqdAyhcM6pYZRJKfMq29LcpOtQ
         9OtpqwvUfnsUurCvCbC84kUIbFfNNZqBTjkH9eQGgy5n8kgUh1O1655C0RkfQiHLgQnk
         OV8xX40RGQVoceSFIr7i0Wh/CUWyCPD7adVpiRKQaCPmEqs8NAncIIZtDAqIYG/HD4AW
         TeOAF2DW/pRXBP5ylImcpYuqR1UjJPZVdeZ1DgTKcwfDZLvKfgDjBEfTUX3mc/16pauq
         qFmA==
X-Gm-Message-State: AA+aEWYqf/gWUOinPIyX6FA04enK3SC20u2GqsFXK6rQELxkVrytQbHJ
        qb+DfqH0bT58sVm3zoN0/hk=
X-Google-Smtp-Source: AFSGD/U8WVTSWcek1tnDbN6TzvAiuPyXE/WM+SsvhLv3OIEk0yNbh94mrPz5wnW6+Ju1uMg7CwfgRQ==
X-Received: by 2002:a17:906:288d:: with SMTP id o13-v6mr9807487ejd.53.1544453196010;
        Mon, 10 Dec 2018 06:46:36 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id q13-v6sm1814323eja.8.2018.12.10.06.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 06:46:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?5q2m5LqVIOWFi+aYjg==?= <takei744@oki.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Questions about ubifs,ubi and mtd?
References: <TY2PR01MB2700AD659601C0341B5C06929DA50@TY2PR01MB2700.jpnprd01.prod.outlook.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <TY2PR01MB2700AD659601C0341B5C06929DA50@TY2PR01MB2700.jpnprd01.prod.outlook.com>
Date:   Mon, 10 Dec 2018 15:46:34 +0100
Message-ID: <87o99txwvp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 10 2018, 武井 克明 wrote:

> Hi all,
>
> We are developing the product using file system using ubi, ubifs on hardware with NAND flash memory.
>
> Although the development of the product was completed, we are seeking your help as the customer who is using it is having trouble with it.
>
> The product we have developed has 6 MTD partitions for NAND flash memory.
> These consist of 6 MTDs named 'kernel-a' 'kernel-b', 'rootfs-a', 'rootfs-b', 'data-1', 'data-2', and online program only accesses 'data-1' and 'data-2' for write access.
> Nevertheless, when loading our program from 'rootfs-a', trying to read the inode with the ubifs_read_node() function will result in "bad node type" (ex: 193 but expected 9) and the LEB can not be read with the expected value. (Even though you do not have write access to rootfs)
>
> Is there anyone who encountered such a problem? Is there patch?
>
> Please let me know, if you have any questions.
>
> Best regards,
> Katsuaki Takei/Oki Electric Industry Co., Ltd./JP

Hi. I think you're on the wrong mailing list (git@). You probably want
to contact one of the linux lists, perhaps
http://lists.infradead.org/mailman/listinfo/linux-mtd ?
