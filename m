Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB9941F454
	for <e@80x24.org>; Sat,  2 Nov 2019 19:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfKBTOc (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 15:14:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46208 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfKBTOc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 15:14:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id l4so551380plt.13
        for <git@vger.kernel.org>; Sat, 02 Nov 2019 12:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=smH62JyXrinv7oxYmCK6VGhYnKUnZhXj0UUUCpQyKO0=;
        b=j+qGJ6z7QLUCMsv8tNZabHFoaUqSZ6b9a1cA5QxtpjC1wJMTzMZfIIVXdJYxP4TXEY
         7KKLQTYMgecCYAWeU62R7w/vocTWY2NH1fkt9lzQP+6+deC14kJ89HQpXxaQT8c42Y4W
         UXYHXzB8b9w9ZhpVcwYwGSb2QhJBZNJ1k0tqa8Z9XNmaOjMcWH+ndTEuzkT+WNRiGVTc
         V5KvtK2gjV7JQ+TUcalCNn4Kq8srICpNT6Q0lprMpYbfSbEdSwlmpBwcMO0T39glVSSp
         8R6Kn1oTJgjBaWG8Qxeg3vtxZvOmC+GjKYh14tWrjig3wwPX/vvHkL2bYtqYbZIs/mSE
         QcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=smH62JyXrinv7oxYmCK6VGhYnKUnZhXj0UUUCpQyKO0=;
        b=IlTzUuMAUcQ2S+09+Vuodz4fAVcX/el+ra2TLi47UhSMXKY4KmQomFjC+jaxSKc/L5
         VogD6KZBhsVWxGUu83LxzojxdZDjOnW4A4NRk6+BditVFW014SWw/stjrMTQJSjA6MSj
         T53J87TYVFU80PiwsPM8YNbbUf1VADtN1PGqRbzbTbFS0EBE81fr1xbbBOh11jXpucgd
         WDz2wbQodyt9AQMJqP/5S2An7vfhJZPf6m/hgrTg01wLgELByJK/NSo1Uf9A4b3IpswJ
         VbgjlM8bUswCqjQz5hrGQ1+lOpAa+GRdee4/ESzEzLqM3zCYxTg+BTM7/6KMXgbUz2xT
         SFvQ==
X-Gm-Message-State: APjAAAUhH9iV3xLdPM/3fdGIa/Zml0KSJu8/cUkRCNlDl69dTyFoz40e
        9CayYqWkm826NujmIfVByJBPRVixgFcL/21N6/p+IA==
X-Google-Smtp-Source: APXvYqzv5eQGqL6lfIoholkS9tH5L+GO6fHT0+y1/zim9x5Jy+ZJDOX9ICs2g8TJwYYz5vZxdaN/sH/Ha7Ni8L54S70=
X-Received: by 2002:a17:902:8d8a:: with SMTP id v10mr19756595plo.32.1572722071683;
 Sat, 02 Nov 2019 12:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <CABf25VhaqrbtRTpL5ZNRy59o4JSsiKpF3pk3+54sDCkvzdgAmw@mail.gmail.com>
 <20191031230106.GB211076@google.com>
In-Reply-To: <20191031230106.GB211076@google.com>
From:   Arkadij Chistyj <arkdchst@gmail.com>
Date:   Sat, 2 Nov 2019 19:14:20 +0000
Message-ID: <CABf25Vhkkd19Tz5E=oVAWUh8nn2A5HW-Od62bNX3LR-gC3vSyA@mail.gmail.com>
Subject: Re: Question - .git subdirectories
To:     jrnieder@gmail.com, sandals@crustytoothpaste.net
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks you very much for the answer! It was very interesting for me
and now I can understand why this doesn't work.
Have a nice weekend.
