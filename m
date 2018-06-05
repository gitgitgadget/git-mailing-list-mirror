Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F19A1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 20:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeFEUj5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 16:39:57 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41185 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbeFEUj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 16:39:56 -0400
Received: by mail-pf0-f194.google.com with SMTP id a11-v6so1927166pff.8
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 13:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iBVdudfehB5YZNHUiuMHx8ZsOd2AW4e0of9Ipg8R/5Y=;
        b=rLfnRTEUHQ3sGl6RcMI3QSR1b1LeWi4KOnxqKWmw/oPKKLEQrNILnbUu/+N5c3gRXJ
         ws559CxCMhDmEIG/17D4tFc7YZCXgfNuYHFJ1iHUDccP4PUkqt2+aONJOPyQ1xOlDj/n
         xEUClShfyuVtPVBuwmVt8mq5GUFVnQfZ8JgXBqMTbINndxANnqAO+gl/AbAfdtd9I9/j
         HrzbnV8pyWEXcBDHgXkaxRu4vosUjKye/9l4X+hsgQpacQFrIx3FJ3MEauUGuxAA47Uu
         K82YCioVD+8BAIsVlVIDYdpH7SozL9yycz3lzsKSjFOLp72yoMHtxkBr/UZ4cTlvVBWA
         vrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iBVdudfehB5YZNHUiuMHx8ZsOd2AW4e0of9Ipg8R/5Y=;
        b=Z+wh6eODEjYcet2/NSxCPsUX3Pz34eh78hEcn/mLq+Qj399XjBgmeGoKFHJ2eWF5WW
         IQUUuJfQueceRRU9/HS1YLxRY0GM7w+rhrYNA0/zkBRkHo3qyixsuRZUN2jgqs7sv6MJ
         9Iz89KZ5T6hh/8c/2qvnHlYHNpW7kybEh0AgUiTQMFe1u1h7mvoW/ggvvhUl8lZ6bHsD
         x9IR2vP81iKvdunTbkOq9XoiV5DJZD3ydpN39npw/2ddhYARsp++fLBHN65xF2p+L1/R
         1xHIxEHzv5bKSh1pQNuXoH16YVQ8TrkuCfcd3CRvnU6Kj+bth9wLq2IHLzdU7FxfeNYw
         AtcQ==
X-Gm-Message-State: APt69E1UhTDPCBGSMOTDhHxJVKWgwMhxzeKuvqx/dMTval9CIiqD9GXM
        T5NYz78g5C0ErQ7tRzUWagI=
X-Google-Smtp-Source: ADUXVKJlWvFnXnjL7SjFq5YrVWaXAE/b43xWJZn16mNVCpfWTs6ESHq0XEe7C+SLqGTSXNXcox+IdQ==
X-Received: by 2002:a65:644a:: with SMTP id s10-v6mr129993pgv.360.1528231195708;
        Tue, 05 Jun 2018 13:39:55 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id u65-v6sm42973994pgb.36.2018.06.05.13.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 13:39:55 -0700 (PDT)
Date:   Tue, 5 Jun 2018 13:39:53 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs: link to gitsubmodules
Message-ID: <20180605203953.GB9266@aiede.svl.corp.google.com>
References: <20180605202449.28810-1-bmwill@google.com>
 <20180605203704.GA9266@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605203704.GA9266@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:

> --- i/Documentation/config.txt
> +++ w/Documentation/config.txt
> @@ -3327,13 +3327,13 @@ submodule.<name>.ignore::
>  submodule.<name>.active::
>  	Boolean value indicating if the submodule is of interest to git
>  	commands.  This config option takes precedence over the
> -	submodule.active config option. See linkgit:git-submodule[1] for
> +	submodule.active config option. See linkgit:gitsubmodules[7] for
>  	details.
>  
>  submodule.active::
>  	A repeated field which contains a pathspec used to match against a
>  	submodule's path to determine if the submodule is of interest to git
> -	commands. See linkgit:git-submodule[1] for details.
> +	commands. See linkgit:gitsubmodule[7] for details.

Gah, and I can't spell.  This one should have been
linkgit:gitsubmodules[7].  Updated diff below.  Tested using

	make -C Documentation/ git-config.html gitsubmodules.html
	w3m Documentation/git-config.html

Thanks and sorry for the noise,
Jonathan

diff --git i/Documentation/config.txt w/Documentation/config.txt
index 1277731aa4..340eb1f3c4 100644
--- i/Documentation/config.txt
+++ w/Documentation/config.txt
@@ -3327,13 +3327,13 @@ submodule.<name>.ignore::
 submodule.<name>.active::
 	Boolean value indicating if the submodule is of interest to git
 	commands.  This config option takes precedence over the
-	submodule.active config option. See linkgit:git-submodule[1] for
+	submodule.active config option. See linkgit:gitsubmodules[7] for
 	details.
 
 submodule.active::
 	A repeated field which contains a pathspec used to match against a
 	submodule's path to determine if the submodule is of interest to git
-	commands. See linkgit:git-submodule[1] for details.
+	commands. See linkgit:gitsubmodules[7] for details.
 
 submodule.recurse::
 	Specifies if commands recurse into submodules by default. This
