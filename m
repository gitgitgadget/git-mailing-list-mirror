Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A20420248
	for <e@80x24.org>; Mon, 18 Mar 2019 02:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfCRCNL (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 22:13:11 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:38162 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfCRCNK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 22:13:10 -0400
Received: by mail-wm1-f41.google.com with SMTP id a188so11041919wmf.3
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 19:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ocf4QGkLpzoon8Czl66VWO3guP1CA+fLro8A4ivER0Y=;
        b=cLY5HScGb7d1i4RFLXOgO+9p0T+ujwJBeMRKbMR/NmHzIVeeD+KzzyBkzgBw3uyc1V
         ZI/jsv5E1TGZDNJR+W5aL0JKgKHFWnRiHcFZL/JHH8ckQWI4hjCWJM5en0iWoyqTYkmf
         6DA1B/XpSZY7w4L5vAqe8SV9FsXGu2hxPjS7aorowXrdNYclWXMyPzcOtOQPo7bHXtbp
         nF9JR1biCOTZ3FSIt4XIPb5gNK7Z56axL+GsXg+gcHiJ54RqMgUEDHdE42gzTs4ihlic
         qsDVkp4ajWhO1vgBlQ0DaCI29GdpbZq+VXNY+pA4r7AplAYvaa8CCEg2a0lozsGkonyX
         ZW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ocf4QGkLpzoon8Czl66VWO3guP1CA+fLro8A4ivER0Y=;
        b=MZc5cOVWHfB1g7SAEOJfb30QlcuJrrz0DxNBKIwnSFnWp21NtnpPurucfZeYdoQWbJ
         ZZJmpoiDetJYE4orHO1B96RLwYNdOd234bRpmouRvpxFuc+C//ac/m6tqdwDsfiWkDYl
         FIHUjjUzxd6b7m6KETRtgYWjteWvXjYG/SzBuxmpCz6Kknvgj75HeYr347yDlpsOfONP
         z5HwlDwTo79DCx8peElc+sNu9CU97+DWwclpsLySH1o+3pp2jPPR8pX7MyveWt9DtNUf
         sawSm0EZsLbOEp5/jSdRwFc+cv6BX82f6bvTMf/xH0jLR28cIvTOM0BuQgfOGDhrtjbO
         W0Cw==
X-Gm-Message-State: APjAAAX+aBT5nkWvEb0W4tHhbXulkJmwIDocyHybcGz1xalnnhzjvb4d
        dEYY2WuTPXk7IAvquoNk+dGyJOYyePc=
X-Google-Smtp-Source: APXvYqxP6aXXDYzP+sMZ/npqx7ZHx6pwo16MIsz2EkoDEcHLJDL9zQOVh49I22W8liKxGBUllbJCoA==
X-Received: by 2002:a1c:3185:: with SMTP id x127mr9390003wmx.135.1552875188978;
        Sun, 17 Mar 2019 19:13:08 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id f20sm23655619wrg.91.2019.03.17.19.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 19:13:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Alexander Shopov <ash@kambanaria.org>, git@vger.kernel.org
Subject: Re: Update of Bulgarian translation of gitk
References: <20190313120646.14248-1-ash@kambanaria.org>
        <20190314091902.GB19416@blackberry>
Date:   Mon, 18 Mar 2019 11:13:07 +0900
In-Reply-To: <20190314091902.GB19416@blackberry> (Paul Mackerras's message of
        "Thu, 14 Mar 2019 20:19:02 +1100")
Message-ID: <xmqqimwh6ibw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Mackerras <paulus@ozlabs.org> writes:

> On Wed, Mar 13, 2019 at 01:06:32PM +0100, Alexander Shopov wrote:
>> 
>> 
>> Hello all,
>> I am resending the update of Bulgarina translation of Gitk that I last sent here:
>> on 4 of March: https://marc.info/?l=git&m=155169580131311&w=2
>> Any idea why it is not getting merged? Perhaps I missed something or Paul Mackerras,
>> maintaining gitk, is busy?
>
> I have been busy with work and life generally.  I applied your patch
> and pushed it out.  Thanks for your patience.
>
> Paul.

Thanks.  It is nice to hear from you from time to time ;-)

Will pull and push.
