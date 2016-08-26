Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFA1C1F6C1
	for <e@80x24.org>; Fri, 26 Aug 2016 11:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbcHZLeE (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 07:34:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36765 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbcHZLeD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 07:34:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so10996503wmf.3
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 04:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=dVrI51eOIrznHIjOja+/CPIM16/PrU2EPkqltkr6LlQ=;
        b=zeDMKMXGkBW0ayIQRAKI4FVhgoRQb956/E0l5E6KVyIZMct2tcyp1q9HLMlnQDvss+
         0kvVhl8CbfO3WHW0ZnQUgPwsUcPcr9zh9T59vDst8TkLw7jAcGD377tb88uXFWHPGx5O
         407cEjBXXa3bwzg69J5DcgiI+MY9nrD+QY1na7rUyXmTFEjISr5WQ7Rsh/q/xBWoRJES
         ImXk6MenYG5BBVb6lrC4YzVhuOwm+Tv4/uICBwYrc48MNI2O0q02qH/t1J6OXuCWWj5l
         N5yUmuNSrRGYnoy06kG5zyamnQczVWuarldi8jx9Ik4Kz60nfqFBKIO9qU+pXhpy6t0G
         xWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=dVrI51eOIrznHIjOja+/CPIM16/PrU2EPkqltkr6LlQ=;
        b=ArcDwcYyaCbbq7+Dl7TpCPWsLms0fOpg4Rsot3ryQXE78G3hQ648vbVzO7rVjmP5ZO
         sfDE6xelGUAYzjfiDzFIkWW8gl828/iKu5+uPzwtCnb3JmYzXeqd5hnTfb1pDziCIJza
         iFRlY7R7EwOVqu6o7xf5douR6APfWmUzPHGSYblHS+EimFCcORoCY3iPTIlhTQb9ofaz
         v7+dcYBKe0FS0dzdaAvDHHGwa1NmPPgIhQNtMJrEWCd7xwXjnFB58csOGAvqG81aGEoS
         WLLyDG1MXxoEi3aYsOs9JSuUNjErvxv5Q2OENoRn6nIEr37nxSgVXpXTTuWckOT//sqM
         V8Xg==
X-Gm-Message-State: AE9vXwN5VHiPxzEEsQVooLRFEKsj4Qeb/nTAiFicGMX0u20E9Z1/gjN8FoACjkSaOZcEjg==
X-Received: by 10.194.145.103 with SMTP id st7mr3368165wjb.61.1472211194419;
        Fri, 26 Aug 2016 04:33:14 -0700 (PDT)
Received: from [192.168.1.26] (elj39.neoplus.adsl.tpnet.pl. [83.21.203.39])
        by smtp.googlemail.com with ESMTPSA id cw7sm19601454wjb.38.2016.08.26.04.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Aug 2016 04:33:13 -0700 (PDT)
Subject: Re: [PATCH v5 01/12] doc: use 'symmetric difference' consistently
To:     Philip Oakley <philipoakley@iee.org>,
        GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160811215035.4108-1-philipoakley@iee.org>
 <20160811215035.4108-2-philipoakley@iee.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <eca8d854-9483-ea30-c5a8-71a35c3ca7bd@gmail.com>
Date:   Fri, 26 Aug 2016 13:33:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160811215035.4108-2-philipoakley@iee.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 11.08.2016 o 23:50, Philip Oakley pisze:
  
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 4f009d4..6dc0bb0 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -225,7 +225,7 @@ excluded from the output.
>  
>  --left-only::
>  --right-only::
> -	List only commits on the respective side of a symmetric range,
> +	List only commits on the respective side of a symmetric difference,
>  	i.e. only those which would be marked `<` resp. `>` by
>  	`--left-right`.
>  +
> @@ -766,7 +766,7 @@ ifdef::git-rev-list[]
>  endif::git-rev-list[]
>  
>  --left-right::
> -	Mark which side of a symmetric diff a commit is reachable from.
> +	Mark which side of a symmetric difference a commit is reachable from.
>  	Commits from the left side are prefixed with `<` and those from
>  	the right with `>`.  If combined with `--boundary`, those
>  	commits are prefixed with `-`.

That's very nice that two^W three related options, namely --left-only,
--right-only and --left-right now use the same notation.

I guess that "symmetric range" was to mean "symmetric difference range".

Best,
-- 
Jakub Narębski

