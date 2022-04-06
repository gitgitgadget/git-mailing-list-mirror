Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4188C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 13:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiDFNPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbiDFNOI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 09:14:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91F342CA4D
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 02:52:31 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w21so2391802wra.2
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 02:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NaHy+RZmAusn3w45G2acadZQ8t9mm9K4eh6ijYw2uxQ=;
        b=MKdEcmWfqBx6cyq0r+YydczU0vSdIjR80YxhjuJGHqwF42E5G83R0RLa1KdXW7yJRO
         WsB/Pog0HEzc39Y/9S6DaX4VQ1OsmcETX9H5Nu3fnzC8vZnfYBgtgYJLHmiKVXyqZwuR
         C4+faAUfaClZFZXleHJa4koPKDcq2woOIF+9wDs0uhiBv55MuplC+iKO5W1/HTP5XnS/
         auQSoqGLh9u8sZs1h+K5XIVzgPPdp7k9WjC9eDjUm+ADrPXUIGRmbndBJvn+xpmkDO4B
         i+XQAq4IBk2dCQwn+Oqko2/nWScd4ITXwEgJ85h+jLVRb+eP2AVVf+GvvqK2JtWnXC4A
         v2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NaHy+RZmAusn3w45G2acadZQ8t9mm9K4eh6ijYw2uxQ=;
        b=chnJi57gsxBPZ50z4yqo3mgixunCVMXtu0gHoflsghesCVHEpUvReDYbZ6uZx9RUzw
         TqZFa8idG+HHwZDl2FUGOgKY8jJ/lSLBIWo0p2+7SJe01jSJdSfiNucRPhvSuMuxqyDK
         Un36m3/uIBTOXDxZc+9IzVgzA163IjnhHMZaOENK17oSbx4xnNtAuDMqI0RkD66A78zu
         IYGur7lYZhWSLrMGR0nYwn80wpP1MiR/LabBI6X9FwYah2hEu0QJZVjEUkC3fvnRjMhn
         VAJHYoqQQf/x3tqM+R2fsxwah3yAbvdP0+7Dbeq8I0JQ+g0QcYun633siDo6tEUJqiNc
         sBaQ==
X-Gm-Message-State: AOAM531KYLGmrjAFgioQXl9qJUsaHlAZl08eFTlfnGJ8HjM1xVnK+DmF
        x8eX/POt3RjXge3Zqn5NqcpVtytqKI8=
X-Google-Smtp-Source: ABdhPJxr3jNMchFxEydbtRVf0Aema3VyaUiC3rL7w4GCOr6hFkOcXxbtJfcBOgKnChpYK0wQg/0HPA==
X-Received: by 2002:a05:6000:15c3:b0:204:1185:7033 with SMTP id y3-20020a05600015c300b0020411857033mr5728315wry.625.1649238731753;
        Wed, 06 Apr 2022 02:52:11 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b0038d0d8f67e5sm4473008wms.16.2022.04.06.02.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 02:52:11 -0700 (PDT)
Message-ID: <997c94c9-e7f4-02c0-b9ca-719b745be2df@gmail.com>
Date:   Wed, 6 Apr 2022 10:52:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [ANNOUNCE] git-scm.com Heroku credits update
Content-Language: en-GB-large
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Dan Moore <dan@fusionauth.io>, git@vger.kernel.org
References: <YkcmtqcFaO7v1jW5@nand.local> <Ykt6lPF0JC1Mg2Tx@nand.local>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <Ykt6lPF0JC1Mg2Tx@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor and Dan

On 05/04/2022 00:09, Taylor Blau wrote:
> On Fri, Apr 01, 2022 at 12:22:14PM -0400, Taylor Blau wrote:
>> To that end, we have a few options about what to do with the website in
>> the future:
> 
> Dan Moore (cc'd) has graciously offered the support of his company
> FusionAuth [1] to help assist with our hosting costs. From Dan:
> 
>      [M]y company has benefited tremendously from git and would be happy
>      to foot the monthly cost if you are looking for sponsors.
> 
> External support would go a long way towards keeping our existing funds
> available for things like sponsoring travel and lodging for Git Merge
> attendees who could not otherwise make it in person.
> 
> Dan: thank you very much for your gracious offer. Does anybody have
> objections to having some external support? I think the only change to
> the site would be adding an entry to the "Sponsors" section of the about
> page [2].

That sounds like a good solution. Thank you Dan for your generous offer 
of support and thank you Taylor for looking after the website.

Best Wishes

Phillip
