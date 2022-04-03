Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438BDC433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 20:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348916AbiDCUEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 16:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbiDCUEF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 16:04:05 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A316252A2
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 13:02:11 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id s11so6250718qtc.3
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 13:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=schj88B/BcBw1tqgZHmVpYKkGwITabfirO1apDjGmU8=;
        b=IN/0Ue9CXboj4Cyg4DcwW81j0Qtd9mmO1H7mdEOCvymUkABzX37JRyt6gdBffmXT8v
         jPZwmkDKHAoSkwKL6Km0E/M2QJcOZ0ow4xboqHSqkTf0L/fgB5EK6ERzPzb2Q87Isx+7
         wEXpFij/fkC4BgRE8DqaNkd/ToCW99cp1y6Hj8B8LsNoSb3z534GxohoOPz8acVwW/Uz
         SN4efehdMKnboqycSYz57I7F5IVffLM5VpZEEKYgaznMo/xPCk0nwkCBeqRBvJ3Sbx+d
         K61z4lKmLjYN/uikHRPPJThQEDOJLzWN5hnIoMZySnMgmt8kdimatID5+jylddTyEec1
         9Rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=schj88B/BcBw1tqgZHmVpYKkGwITabfirO1apDjGmU8=;
        b=rOjD+AzwGESnDCwGbaHFjvH7AABEUlHs1BpNIk9cdaqyGgKyIV4t+QuE8Rk91uigK+
         HZJwFuepPxM4mQMjanyCXEXJGMJ0K3RpOCyl6Lgn/fMOf/dIMWDLtWnstIdZ/troFIl1
         5du2+4CW2kkSL1EIr6hQze3T+cu8MPQPmtwCnmAU+F71onVVhkA79DEUp7XkWYo3+Xwn
         Mc+5sfmr4NDUw2HTNWWH2459stIZr+2mPTsXdY+X2hma/RfWQ52pzdbn1MGe1f7QE1Cv
         WKj5c52wKH/+Q7TQUFNaEw90Ia0kCERSZxxE20Rm1QOCSRJmPkptjQwLGxSDrnnz5mnP
         Hizw==
X-Gm-Message-State: AOAM53018/C+qD48aZytkGUsXpFzKxnomAe9nYap8lGTjMV/OP6rykuZ
        foCWQYz9OrfmUB22rgj6tq8=
X-Google-Smtp-Source: ABdhPJxLZEBrdSdvlirmqUqLhwZB0LHQAjRe8bmA0Jt9s7N2JKS4xJpXeNZ599mYSVBDyg/vNXimeg==
X-Received: by 2002:a05:622a:1104:b0:2e1:b946:7094 with SMTP id e4-20020a05622a110400b002e1b9467094mr15632363qty.237.1649016130163;
        Sun, 03 Apr 2022 13:02:10 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id h2-20020ac85842000000b002e1ec550506sm6730277qth.87.2022.04.03.13.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 13:02:09 -0700 (PDT)
Subject: Re: [PATCH v9 3/4] vimdiff: add tool documentation
To:     Fernando Ramos <greenfoo@u92.eu>, git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, rogi@skylittlesystem.org, bagasdotme@gmail.com
References: <20220329224439.290948-1-greenfoo@u92.eu>
 <20220330191909.294610-1-greenfoo@u92.eu>
 <20220330191909.294610-4-greenfoo@u92.eu>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <d01710e1-8a42-e4d1-5034-f6796372587e@gmail.com>
Date:   Sun, 3 Apr 2022 16:02:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220330191909.294610-4-greenfoo@u92.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Fernando,

Le 2022-03-30 à 15:19, Fernando Ramos a écrit :
> Running 'git {merge,diff}tool --tool-help' now also prints usage
> information about the vimdiff tool (and its variants) instead of just
> its name.
> 
> Two new functions ('diff_cmd_help()' and 'merge_cmd_help()') have been
> added to the set of functions that each merge tool (ie. scripts found
> inside "mergetools/") can overwrite to provided tool specific
> information.
> 
> Right now, only 'mergetools/vimdiff' implements these functions, but
> other tools are encouraged to do so in the future, specially if they
> take configuration options not explained anywhere else (as it is the
> case with the 'vimdiff' tool and the new 'layout' option)
> 
> Note that the function 'show_tool_names', used in the implmentation of

typo here: implementation (by bad!)

Maybe Junio will correct it before merging to next ?

Philippe.
