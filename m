Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 933601FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 03:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbdJFDpy (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 23:45:54 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37056 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbdJFDpx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 23:45:53 -0400
Received: by mail-pf0-f195.google.com with SMTP id e69so15819958pfg.4
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 20:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tSQqTRXYFY2tilBv1GkvMoUz4K0OdMKkQ95gKXfjnS0=;
        b=VRPJymGo+bw9wjU0Yb6NJS8hIarmax5L8b1ViDdpoB/b0JjbjEQnxMGiBbUBhfrpmv
         myug2iBRDaW21XqPUirx4HRIxx5oBzvsJhFCsO6eVYXGRcjwfB2zUHSN0Iy9qOWyVPsX
         1t7Y5veJOqe7nc1+Tt9kGc09cerVcc9Ks3h3ogE29ZwiiOxt8l4bLtnsNIR4FOj5wKLz
         mBuBon+7sQZqdBecLOKTkeAGqStZfJNZPxiRYGHIYyRbzXT8pLDaJXe07/+shfKB5etW
         ecgGXHuPyCEPcJLJL2Q9Rjw99DpvuxBnKqVGITbzKgKbYW6Lkng9WCBItAHJpxs6zEQz
         j3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tSQqTRXYFY2tilBv1GkvMoUz4K0OdMKkQ95gKXfjnS0=;
        b=OaAGRAfM267W9Dp3gCmQrbb7SEhRd/aeJMf+HOckZjdWbUDrAdQ+9OZ+YaUzvmalNq
         dF/R3saHQTdhDjcqabxLYdexnjgkLJZH3wpsMYBXf+fRruFvihReFHxLexmpmzDulqnx
         Sc/nFl4EObgIjmmu5OcaT4BwV8co2XRTsQZWSAqyheCTzidvtls/RTU2g/BZyaAeRgQ6
         vP7JGW3dEKXVxkTzijJPRoemIQQ8Z9D8G+GrveIMdEsLtgoIPwIlpoUWxt2TGNdIXyHi
         Gyz+eRFZDbvm4lhKcaaPP+bbgGKUOoWeQH3REWTZtj/ukkPo0cyidqY1NFIlOK8x4ltG
         5/zg==
X-Gm-Message-State: AMCzsaUVhasXPZKOqMxfEKb8D9wtrQ9/63nP1QdIA8G0O7hR7uQ+8Ynl
        nXDQ6ZGNwwCPM1FT/y2ZnMcLWs02
X-Google-Smtp-Source: AOwi7QDN1N9N1rWhOgdObjv0PUNIVkScpuj8uRnmN4/fie3NDs1vDRUAHH0oCuQcmRSaQp2gBlpE2g==
X-Received: by 10.99.96.140 with SMTP id u134mr738446pgb.191.1507261552963;
        Thu, 05 Oct 2017 20:45:52 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:78c3:3d0d:a9b5:4320])
        by smtp.gmail.com with ESMTPSA id s81sm620473pfg.162.2017.10.05.20.45.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 20:45:52 -0700 (PDT)
Date:   Thu, 5 Oct 2017 20:45:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2] api-argv-array.txt: Remove broken link to string-list
 API
Message-ID: <20171006034538.GA142701@aiede.mtv.corp.google.com>
References: <xmqq4lrdyp8v.fsf@gitster.mtv.corp.google.com>
 <20171006031456.9632-1-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171006031456.9632-1-tmz@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger wrote:

> In 4f665f2cf3 (string-list.h: move documentation from Documentation/api/
> into header, 2017-09-26) the string-list API documentation was moved to
> string-list.h.  The argv-array API documentation may follow a similar
> course in the future.  Until then, prevent the broken link from making
> it to the end-user documentation.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>  Documentation/technical/api-argv-array.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for catching it.  Do you use a broken link detection tool to
detect this kind of issue automatically?

[...]
> --- a/Documentation/technical/api-argv-array.txt
> +++ b/Documentation/technical/api-argv-array.txt
> @@ -8,7 +8,7 @@ always NULL-terminated at the element pointed to by `argv[argc]`. This
>  makes the result suitable for passing to functions expecting to receive
>  argv from main(), or the link:api-run-command.html[run-command API].
>  
> -The link:api-string-list.html[string-list API] is similar, but cannot be
> +The string-list API (documented in string-list.h) is similar, but cannot be
>  used for these purposes; instead of storing a straight string pointer,
>  it contains an item structure with a `util` field that is not compatible
>  with the traditional argv interface.
