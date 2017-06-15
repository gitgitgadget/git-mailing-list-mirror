Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAAD620401
	for <e@80x24.org>; Thu, 15 Jun 2017 21:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750749AbdFOVeH (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 17:34:07 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33770 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdFOVeG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 17:34:06 -0400
Received: by mail-pf0-f195.google.com with SMTP id w12so3004354pfk.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 14:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ql0xHxjHg758Cdp49dWlQGKVis0PEJozipNSNftM4xU=;
        b=C87v/KKqdIEaN70Qe3nOzqdWsdCLXnN672El4nFuP+s1fdTjpzboi68IkSFBsHSWRo
         ITAFHKjbfMrbc0l6OJpel+LXEkFvkv8EVxvHTd3GhvzT3b0hXAp1ZkdcZei5Eai0wYv6
         ZvSSeBI3Ad5JUzmrqQ/LdqAsEkxogvZk12tgg8dwRBpuMhdsC4rPldO96r9C7hXgO3Yo
         M98P7RXUlWz9kDwO4jU5VUTOqF1uUobWoTI6iEJzUpJCe33K0lvLgKdYdHv0dWVoHKZS
         tY+4fs3yd+9RyA0mwLsXZ2AJGz+8l+7feBdOhxDaRCGsyE+iq9MvorRaf6SkKZc3ZmrG
         EleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ql0xHxjHg758Cdp49dWlQGKVis0PEJozipNSNftM4xU=;
        b=n03WpKvYs6A0OSjULrFPR96I4gchU3MvcWKytN486n86qphniaL8iGJcELbGxEMbsX
         O8RCcAJnw6OSgmTLcapWxJ19uFX/xeTtbGDdjzfTV6ZNhi1aeJmLrui3urNw9ouIqAxR
         X+y8Qt/AJoUSBWs8hUb08umTA4fiLby40pZIXgn9OjUeXrpm+SBJkqPX/MSyyhJ5eVpQ
         zQc25U6n9fycSY7Bre5jjAExpELpQg0crTiJwnRyy+pVH9XvRzdviciizb5WvsRT4Heh
         ozqWgFHksHRX7MXXHX2BPF5jOxsUO9BykL4AohaDZYeMeUaCE+0xCfr1oCxuBhOVYkBB
         +KsQ==
X-Gm-Message-State: AKS2vOztMc7/vPJMELEy4EfGnEvrCPz0cUeJP7jsY/SpzxZTFx95abJP
        hadPBFYRv82NzAYUuEM=
X-Received: by 10.84.128.78 with SMTP id 72mr6804616pla.161.1497562445202;
        Thu, 15 Jun 2017 14:34:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id k129sm400287pfc.87.2017.06.15.14.34.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 14:34:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Ben Peart <peartben@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] sub-process: fix comment about api-sub-process.txt
References: <20170614151225.31055-1-chriscool@tuxfamily.org>
        <20170614182607.GW133952@aiede.mtv.corp.google.com>
Date:   Thu, 15 Jun 2017 14:34:03 -0700
In-Reply-To: <20170614182607.GW133952@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 14 Jun 2017 11:26:07 -0700")
Message-ID: <xmqqmv99ylys.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Christian Couder wrote:
>
>> Subject: sub-process: fix comment about api-sub-process.txt
>
> nit: this one-line description doesn't describe what was wrong and is
> being fixed.  I think something like
>
> 	sub-process: correct path to API docs in comment
>
> would be easier to understand in "git log" output.

Indeed.  Thanks.

>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  sub-process.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> With or without such a tweak,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
>> diff --git a/sub-process.h b/sub-process.h
>> index 7d451e1cde..d9a45cd359 100644
>> --- a/sub-process.h
>> +++ b/sub-process.h
>> @@ -7,7 +7,7 @@
>>  
>>  /*
>>   * Generic implementation of background process infrastructure.
>> - * See Documentation/technical/api-background-process.txt.
>> + * See: Documentation/technical/api-sub-process.txt
>>   */
>>  
>>   /* data structures */
