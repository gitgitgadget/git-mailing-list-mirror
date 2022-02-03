Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FF8C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 09:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbiBCJhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 04:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiBCJhU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 04:37:20 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE955C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 01:37:19 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j25so3088950wrb.2
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 01:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=TMwDkdb9o0H4ajZl3KZ7JErSd7byvqsG21dSZ6oh4uU=;
        b=lugZVtoTsG1DkUtpuMmwYEqx2UZfBYQrbC+8b2JEcGlWCBIDz0jS+gtd4SEcRIF98W
         soFYeSNtXBt9V+emzbJTElNO7zInMYy19HebnxwtkC1zTvVXHiHhRDzlMVoebH8DblRG
         fgeodDO86CbE5xvzgbubf1cMsYnGDXCFBMoEOLX0TSycmcwI7jRtUPHZG12otPm9LOof
         UwesrPnzMWWiQah6e/26JmQol21UnFQHDqI14/cGWqGPS7Rdul4VgSXotJRzvo+qNdUT
         FhYplxuxqKY/1sKursrJpGSR+e6QEcnzijx66D4bXnWkfd4PCo3ATulsYyEFoT+9kQuq
         4mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TMwDkdb9o0H4ajZl3KZ7JErSd7byvqsG21dSZ6oh4uU=;
        b=KsR+JRdFqLdPYG2MWCY2+LWQSWuHCYAUf5CN1N4Nn0FR5V2Ny76T0BkqY0bjlMHela
         BmxSFx+rSV545cJSsHwwvUaJu5guKVtIU0oTBo5f/kLoCc/gGRuXa5mV4po6fUKzGUB8
         6IE8Bm9WqpN0tf1s8vc2PoXOJ5QQJmpA2RR+0ZuvacRtmkw2PJSs6m+SWgN1uf0j8EqS
         VtXiPSQ7PHe12RtR2Xe0WoLpQeqtv94SRRF5UsH9uIt9rVicrtvBFCUoeELHZpyWoOyW
         lpZaBAytrjdZJAM3IGS0hb0vg0mloqrj93YhisjQzcI6eEnabwJkRBESmrtLdyAzZfGp
         XqQg==
X-Gm-Message-State: AOAM53391Sz3V/5+Pe7sNogO1nXZO0ni/0yceZwpU6XmyAoswyr53P7g
        d1IcYG96t5E+Qc/Ys7XuBoKyp9iUPMUvGhlb
X-Google-Smtp-Source: ABdhPJyBC/D8GmIm67Louk+DzlngBixxNa7aUSMiRUSQNwzgSYRfVLWIORbnyRW8ROo9FdnnPIeLyA==
X-Received: by 2002:adf:e411:: with SMTP id g17mr11639549wrm.275.1643881037642;
        Thu, 03 Feb 2022 01:37:17 -0800 (PST)
Received: from [192.168.3.156] ([92.173.128.58])
        by smtp.googlemail.com with ESMTPSA id l20sm7419243wmq.22.2022.02.03.01.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 01:37:17 -0800 (PST)
Message-ID: <0c47248d-13b8-9d80-b03f-8ac6fd4ac91e@gmail.com>
Date:   Thu, 3 Feb 2022 10:37:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Question] Translation Dictionary
Content-Language: fr
To:     rsbecker@nexbridge.com, git@vger.kernel.org
References: <016401d81547$728834e0$57989ea0$@nexbridge.com>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
In-Reply-To: <016401d81547$728834e0$57989ea0$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

I guess not all git translators are subscribed to the mailing list, as 
they mostly interact with Jiang. I put them in cc.

For French, I try to maintain a glossary of terms in the header of the 
`fr.po` file, available here:
https://github.com/git/git/blob/master/po/fr.po

Best regards,

Jean-Noël


Le 29/01/2022 à 20:35, rsbecker@nexbridge.com a écrit :
> To the git translators.
>
> I was wondering whether there is an official translation dictionary for
> git-related terms. At times, I am asked to provide presentations with an
> initial translation to companies in various parts of the world. It would be
> nice to be able to follow the official set of terms used in git
> translations. Does such a thing exist?
>
> Thanks,
> Randall
>
> --
> Brief whoami: NonStop&UNIX developer since approximately
> UNIX(421664400)
> NonStop(211288444200000000)
> -- In real life, I talk too much.
>
>
>

