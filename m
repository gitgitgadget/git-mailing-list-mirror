Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B22F1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 15:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbcHZPbI (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 11:31:08 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36260 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbcHZPbH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 11:31:07 -0400
Received: by mail-wm0-f46.google.com with SMTP id q128so284036097wma.1
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ni8DRSxdyalm5ih0qrzaGwpxoedFwsBktg3UPDdVVAA=;
        b=ulpVDkehbT4OCmHuT4wPwXXrRlPuB+MRUODCwSjDYcVN+bfnBWAvQ2MlXTKWBWF+k2
         iP4gg0PMtl+B6nYqBmnkBQCRO+ZJ/I50ceeEOa1BZKEywexT5EXXIs6pDxbg4aeEwhPZ
         WjIeB+rTG7KwN9r/OX+yuNT+RY4826rotResDUv6ZMRM3xgaWPRAbKkwPuPXw8t2Ma4W
         xI1CPw7JKesq25QdJjAkNCISri/stYOZf7h9pmo+SalUfKiJ5wIt0WGOvGHhT6VYPKiw
         SJa2uoUrhPTNKw+F/nGuNSJsGFKSuaw0AlqKJUGHcDFgUch6VVodiI1Thun2+P1+LMmx
         0T9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ni8DRSxdyalm5ih0qrzaGwpxoedFwsBktg3UPDdVVAA=;
        b=K2WcpGVIwE5lGu9y/LCXotT5pLbjfVhOrs+tLMk+u2cp67GVAMgA6qwKUqaew+hvnO
         Hvoo2CXJK/vJvRBNxgFa/t2rWP0gqgBMO9JPd2Yr1lAZouV9Y+YHQgOFxxm2w35RVBJ6
         2SGrZqLyJGB/WY9EgkgGeNXxvLbN1wAxZ5j3ViHmakTmTuUqrCxgdITUAriKsbGrHpPO
         wqP5TRv9CbnosDqr5ys0WKg7QCTky6im9Pu1muVQG1WMQN5P9S2CSgjvY6t0RHHk6KkO
         1Uh3kbMn/iAdQeoqhBLvvxOMBL1NmTjq2NJlc+OxfaK4B7jYmo1EtxWwTegtpnA62O/6
         g1jQ==
X-Gm-Message-State: AE9vXwO8J41iyDa6XUqyNePvKhnlFLiXQ/HdcgHO5ZIiWgymjuLD3gIe99jGRf2tboR8sQ==
X-Received: by 10.194.116.1 with SMTP id js1mr5053891wjb.183.1472225465850;
        Fri, 26 Aug 2016 08:31:05 -0700 (PDT)
Received: from [192.168.1.26] (afg6.neoplus.adsl.tpnet.pl. [83.25.136.6])
        by smtp.googlemail.com with ESMTPSA id n2sm20521573wjd.1.2016.08.26.08.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Aug 2016 08:31:05 -0700 (PDT)
Subject: Re: [PATCH v6 06/12] doc: revisions: single vs multi-parent notation
 comparison
To:     Philip Oakley <philipoakley@iee.org>,
        GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20160811215035.4108-1-philipoakley@iee.org>
 <20160812234522.7792-1-philipoakley@iee.org>
 <20160812234522.7792-3-philipoakley@iee.org>
Cc:     Marc Branchaud <marcnarc@xiplink.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <6b37851f-0f2f-0379-c10e-52f7da6b7110@gmail.com>
Date:   Fri, 26 Aug 2016 17:30:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160812234522.7792-3-philipoakley@iee.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 13.08.2016 o 01:45, Philip Oakley pisze:

> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -284,6 +284,10 @@ The 'r1{caret}@' notation means all parents of 'r1'.
>  The 'r1{caret}!' notation includes commit 'r1' but excludes all of its parents.
>  By itself, this notation denotes the single commit 'r1'.
>  
> +While '<rev>{caret}<n>' was about specifying a single commit parent, these
> +two notations consider all its parents. For example you can say
> +'HEAD{caret}2{caret}@', however you cannot say 'HEAD{caret}@{caret}2'.
> +

That's good to have.

Though I do wonder if it is implementation limitation, or if it is something
inherent in the notation, namely that <rev>^@ and <rev>^! resolve (the former
at least in general, though not for every <rev>) to more than one revision
specifier.

Anyway, good addition!
-- 
Jakub Narębski

