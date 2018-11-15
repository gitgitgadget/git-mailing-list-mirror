Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10FA51F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 03:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbeKONLG (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 08:11:06 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34339 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKONLG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 08:11:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id f12-v6so8774354plo.1
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 19:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mgLkndv0jz+cFIfELUOdOeTW35/hBwZuE8y32kBGdx0=;
        b=lBdwXhOYx9HgZVtMdlccd7yZ5Gi09LpnAcWc+wLoCP9uxfMHky8Te/w/L4yCNffu2W
         GDfBf2iega+7Nrbud3eEkvt7Gt0hqnNxsdjQGqoNhzreYG+DSZhCgpsogzMI7rppEjZe
         BRxRugOkx0tfZpN8V/abG8mEfU5UbLc/8dGqWOnVsLPuoPi10V9KIovTXR+qyaOkaFmT
         tr13d9JDalUjm4t4TyYVpa+x7ssYg7K8L/DGItceBYqKvBSjjAQIWLrbKKNIXi0fhNNH
         r9b3fgxGqW6yogjOA6QKyThQld65H+F3PExGHwFUf/706mJEzSljERGfIc1vjhxoV1/o
         jQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mgLkndv0jz+cFIfELUOdOeTW35/hBwZuE8y32kBGdx0=;
        b=jNGxN4Y9nSEypG91bMtFQgnUAEiujQlxR99yhgO6woyQsmTEZw6+m6t6AIQXkKyf/H
         Om1HNWu3QLRXXymn55o/nzcl5MtLqXlFRO9Ui5phLh/mc1boZs980F5Q/I1bNUUY8vYg
         b/ac6NlQYyspfnN5YXKIQXwuGgZvODn9Ja4PChB+tBw5+Tp2JNPp1FI+VpIkU66VHLDT
         sTUSZxIoqfAThghFOpzA2ewZd9r/wuRdlPJHs6Qcpy7i3DfgUnak2Z2xFMvQhQgVsaPU
         H/y87F+km8opeD+e00VjWQMqEEuB6RnA6DCGMWBJ3V1aEHQ5XKFGJwDT1cAGWfLBL8Gl
         /pdA==
X-Gm-Message-State: AGRZ1gJkqVr1SBUaAKzqqt4cFmoKvpS6oOfuB5c0eB/GicXmPIYSeqv2
        LQSpyM8zQlv9idyKX2XcxlfZbqW0
X-Google-Smtp-Source: AJdET5cfS2KqzVhtelHFoKkbpYZYjgeA9piH5ZXDn94Jj+LtLX24Q1mSK5hQp5cbZ2NvZeWdXN6+hQ==
X-Received: by 2002:a17:902:a58a:: with SMTP id az10mr4636316plb.151.1542251106083;
        Wed, 14 Nov 2018 19:05:06 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id h17-v6sm36690807pfj.125.2018.11.14.19.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 19:05:05 -0800 (PST)
Date:   Wed, 14 Nov 2018 19:05:03 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     yanke131415@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] INSTALL: add macOS gettext and sdk header explanation to
 INSTALL
Message-ID: <20181115030503.GC92137@google.com>
References: <20181115013233.24685-1-yanke131415@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181115013233.24685-1-yanke131415@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

yanke131415@gmail.com wrote:

> From: out0fmemory <jiu4majia2@163.com>
> 
> ---
>  INSTALL | 7 +++++++
>  1 file changed, 7 insertions(+)

Thanks for writing.  A few bits of administrivia, from
https://www.kernel.org/pub/software/scm/git/docs/SubmittingPatches.html:

Can we forge your sign-off?  See the section "certify your work" in
SubmittingPatches for what this means.

What name should we attribute this change to?  Documentation/SubmittingPatches
explains:

 Also notice that a real name is used in the Signed-off-by: line.
 Please don’t hide your real name.

[...]
> --- a/INSTALL
> +++ b/INSTALL
> @@ -165,6 +165,9 @@ Issues of note:
>  	  use English. Under autoconf the configure script will do this
>  	  automatically if it can't find libintl on the system.
>  
> +    In macOS, can install and link gettext with brew as "brew install gettext"
> +    and "brew link --force gettext", the link operation is necessary.
> +

As context (e.g. to go in the commit message), can you tell us more
about this?  E.g. what happens if you don't perform the link
operation?

[...]
> @@ -178,6 +181,10 @@ Issues of note:
>     will include them.  Note that config.mak is not distributed;
>     the name is reserved for local settings.
>  
> +  - In macOs 10.14, the Command Line Tool not contains the headers as before, so it
> +    need install Command Line Tool 10.14 and install the headers which command
> +    "sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target".
> +

Likewise: what is the symptom if this isn't done?

Is there more general advice we can put here that will survive past
macOS 10.14?

Thanks and hope that helps,
Jonathan
