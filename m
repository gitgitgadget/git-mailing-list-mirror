Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 740DC1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 02:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbeIYISc (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 04:18:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35195 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeIYISc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 04:18:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id v133-v6so2762734pgb.2
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 19:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IfZ0odzdPXaKqxnMuUWJvrfMbt5zO3N3yRmVRfLVsmw=;
        b=mH/pXAVkF4H8lFynHuqR0BUZagmvIaH8nUYUwLWjUhVv35ib4343hA5cQP6eF3ltIg
         gPzonYYjo0KsFtJ9dNObdXPQTulEFcGvZLx7mur+9lpzEAEacwuYcgTsi8ggL49V+CzG
         ZCJVcM5YRgBgi8smirFyxrFFdvCDwIz2unyT9MHS0PgSCGMEJl2mARmBoZuvY7dCbQXm
         6KTTbgsE/WxGfuVWiF9KHq2GK0woG3a5MjH1lK/LX4jJ5OiA+v5b4c5ZOSXCiGObWM4c
         wTmSDrc2LmD95Of+cfD85hsTvXYSUWwRgP4DTwvwuXiXkcEcSmkjICBs+1PnvFkQMLrR
         5ZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IfZ0odzdPXaKqxnMuUWJvrfMbt5zO3N3yRmVRfLVsmw=;
        b=dRTJT1mwGKSyHqk6Kh14auWHMFbuNXUj3MlKeAYk7DNTBRvkuY2iQN/G+JkupJ63Z5
         qDPdaNfEjR0pRZyqdxteXXulHmPe1+jjuW9iqN0OdrtCka+KejeRfrWii8XXuy0rZfkG
         6KNRxWvOT42Wj6xAfl1MQcwkodTMix5OfsqdcAh0hqNPgqXAWuS+tNNgEgJLe0bg42vd
         PxDPwd8NgR0D68dPU6es/vbNw3AGCHrNrEgzHh7HcaxjqoKgstE5Xtjt/bJ5OhzbYeo8
         fsbUjCFVYmeCyCnEWPJPqYtesZe3G2xwMz2DqDsiTk6He2mACh88J2qYPetzyjqen30q
         VwVA==
X-Gm-Message-State: ABuFfojBDHUiv/qYE29zmbU/mb4lhCACv1jAaiKFFapHyNs85RlxSZqW
        0MHPWMqcGgUvlGsvR6vqfTs4PlvY
X-Google-Smtp-Source: ACcGV61gCk9Z+H6upWQnQQBkBSUPr4MPFGWLtaxP8Pcp8db0A4tLgOVqP/6cvHGmcpeTnt3ggLb6aw==
X-Received: by 2002:a63:6283:: with SMTP id w125-v6mr1177968pgb.83.1537841604095;
        Mon, 24 Sep 2018 19:13:24 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id k64-v6sm734195pfg.141.2018.09.24.19.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 19:13:22 -0700 (PDT)
Date:   Mon, 24 Sep 2018 19:13:20 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] mailmap: consistently normalize brian m. carlson's
 name
Message-ID: <20180925021320.GQ138072@aiede.svl.corp.google.com>
References: <20180506232421.975789-1-sandals@crustytoothpaste.net>
 <20180508015845.268572-1-sandals@crustytoothpaste.net>
 <20180522220826.GP10623@aiede.svl.corp.google.com>
 <20180522224215.GI652292@genre.crustytoothpaste.net>
 <20180917181800.GA140909@aiede.svl.corp.google.com>
 <20180917222158.GY432229@genre.crustytoothpaste.net>
 <20180924173902.GB138072@aiede.svl.corp.google.com>
 <20180925011547.GG432229@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925011547.GG432229@genre.crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On Mon, Sep 24, 2018 at 10:39:02AM -0700, Jonathan Nieder wrote:
>> brian m. carlson wrote:

>>> I think this commit message makes sense.
[...]
>>                              What would it take to make the patch make
>> sense, too? ;-)
>
> I certainly didn't mean to imply a failing on your part for explaining
> the change adequately.  I've just always found the format confusing and
> I know others do, too.

No worries.  I took the opportunity because the patch isn't in "next"
yet so I was looking for a way to nudge it forward.  I think v2 is
simpler than v1.  Thanks for your help.

[...]
> This has been a really helpful explanation.  Thanks.
>
> Maybe I'll have some time over the next week or so to send a patch to
> the documentation to make it more understandable to past me.

Sounds good.  I think the (non-)handling of the 'name <email> name'
case is likely to be a bug.

>> How about this?
[...]
> Having read your explanation, this looks good.  Thanks for fixing this.

\o/ Thanks for looking it over.

Sincerely,
Jonathan
