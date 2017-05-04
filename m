Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B047C207D6
	for <e@80x24.org>; Thu,  4 May 2017 12:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753626AbdEDMza (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 08:55:30 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33378 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753397AbdEDMzU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 08:55:20 -0400
Received: by mail-wr0-f170.google.com with SMTP id w50so7390531wrc.0
        for <git@vger.kernel.org>; Thu, 04 May 2017 05:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=aIlayM0r349jEB8xTrpHTXJSD+0MSXiPs3eYDxWvCQw=;
        b=PrXVkYUhOQdVnu7HzYrIL/sh0pW6wn70vm+byrzNKFEV/hvaV76tUWVymdz4itnSzg
         g2/xPVjnKZxUNhKhI4O9TszIvr1I7nwZzihICAuhUdQGWAy2/dwwyf5p2B4fo4dlvp3K
         sWUBrX+JfQ93LN5LAyAlR9SBKW0Hig6voPMMO1NFPM1JR83dN3O+Sld9C9shBKT1jcbT
         juITrQKcYxOb5O2fbDpaybeSn2eBbZxuxRn1smzDmXcvT45hEWT3WCqzfJLSGgZsEaQR
         o5mW4uC85sQaIObYVhVXgXMQ0GJsZGvKor/+zsrrcwlUUWpvdX4aZcx7QdsCfr6PrqsV
         kdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=aIlayM0r349jEB8xTrpHTXJSD+0MSXiPs3eYDxWvCQw=;
        b=T5oFMaEZe/NlmfQDcTRd+Ucy9jaTH8CAqNTlEi+KAzTbkg783FAFTVSiKTGsava39j
         hY2Umaga1vAjFaDcChQYBGjk5FEgA9qr1Kiya2Rt97YKbg5D/QZbPYbjTsP5xjZJfy2C
         fDtV3it5LQc5XpDLq/RFX+w/7M1rYpxz6C12TivPEjCXrCF7aNAU4D9BQjvltfpPfzxw
         krDFauDRQC9/LxefzkuNCJPqzYuRHk4AbwR+zq5EfJBj4+xFM14z01NvUB4jggnE6qrD
         yfXa0Dft+dObmo3Vf04EAfLmvXkl8Eh6rpVnS/vus1ao2ApXscL/ZUS08P3cciBhIiaK
         qV3w==
X-Gm-Message-State: AN3rC/6AQRjXtuNpiFnFaf1Cmbyz/6/EOuSBuvEh3AZZxv9vvbwrqQ4h
        LQKQlzmTMnj4JHk9oyA0HfgbODDSow==
X-Received: by 10.223.149.33 with SMTP id 30mr27863079wrs.61.1493902518097;
 Thu, 04 May 2017 05:55:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.28.146 with HTTP; Thu, 4 May 2017 05:55:17 -0700 (PDT)
In-Reply-To: <20170503192734.GD9226@256bit.org>
References: <20170430191149.19290-1-ralf.thielow@gmail.com>
 <20170502163612.3381-1-ralf.thielow@gmail.com> <20170503123826.GE30941@256bit.org>
 <CAN0XMOKMwzYEwHJECk0w5rJBRr4CAGo+wzfN=u55OxCYN+WcSw@mail.gmail.com> <20170503192734.GD9226@256bit.org>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Thu, 4 May 2017 14:55:17 +0200
Message-ID: <CAN0XMOLQ-9yu-Hmb9eQ5KZTcghMt3czj_auYjCFByJufVSHa9g@mail.gmail.com>
Subject: Re: [PATCH v3] l10n: de.po: update German translation
To:     Ralf Thielow <ralf.thielow@gmail.com>, git <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
        Simon Ruderich <simon@ruderich.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-05-03 21:27 GMT+02:00 Christian Brabandt <cb@256bit.org>:
> On Mi, 03 Mai 2017, Ralf Thielow wrote:
>
>> Ref or Reference is translated as "Referenz" while
>> Rev or Revision is translated as "Commit" so I think
>> the translation is correct.
>
> Oh right. I also noticed that sometimes complete sentences were used and
> sometimes not. It would be nice to have a consistent style there too.
>

Sure.  Using only one style for those messages is a point on my TODO list.

> Thanks for updating.
>
> Best,
> Christian
> --
> Hallo Briefmarkensammler!
