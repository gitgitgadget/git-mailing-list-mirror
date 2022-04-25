Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970B3C433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 09:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiDYJZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 05:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiDYJZn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 05:25:43 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC6A766B
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 02:22:40 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id k27so2437092edk.4
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 02:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uoJSZlOL99X3IX2BVyvyEG4bjAylVp6+lI6VoVgaelQ=;
        b=G3mCYSiC4YBOHshIC0joSNHBXaQ+6We4xWdBRpTVZz6mk77bklIId3FmPpHrK8XzGI
         BA1R5DAfAGBC9WORMcNVF0cuj+nyU3N7m6pqS9u5njPVYJX62Mbw3upSJmZPYCEIJCuw
         FW3jJxmjsjGSDhyXE7skCysVzXnWBqq/M4FUrqX2wKzYYtviJ4cz9H4J1TAgwZiPbFjP
         PB2nRAZ6ylcwpcOdyruEyrOrwpM6uGKuo5yriK0aiMw5KNlhfk+junxi89a2DOrl5M1G
         VTWdZbAqCFNymV0EI+e21YebZkz4+jiOreOibjEpGg9U+U6GmaHzC09Qt8lnhQeg6/QW
         PrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uoJSZlOL99X3IX2BVyvyEG4bjAylVp6+lI6VoVgaelQ=;
        b=YIHqmGwS4QjkOUwyzB3jydK/U5/5911uNZ8ZvUJAH+sE5oXLsGVNTyyS03thZsiXZz
         +nnKvZXfmfT/YSHNGNRxC17b0FStPenlulxHMGobJXVqgGWbV0bJz6pbY9S/9JtRokvc
         z/yHGHwQjYRzpCUbPlbKfePI24wwaMzvvlxDyn0gRpUlsUPWScTHZn0Y7rKzf8gD2htV
         lrSRudtMYUJE2VK3mBlzDC6yvKxgif/DcsbglNeNRCYkuPuOfv2OEy3BgGhSnzDQqcbV
         32Y7jwO505U5QSvwK4kbC5wnsjjekSTZqHuc3X0eR/rmQQ6bnu4VPrRtcC/S8Q2ymu+N
         hUOg==
X-Gm-Message-State: AOAM532iR/XTZozEx1cPlIAJUZGQ3+/H1Wuo5FT8grjcPnjltmcddp5d
        hb/egfGiictdctoSfVSBwK9wCkUPLo8=
X-Google-Smtp-Source: ABdhPJz3kh8WUwL9nPsfx6OavfUnW9yrS6FHBh1Z8P2h11r8RYj61uyqhWADSf/FkOTdlqEitozloA==
X-Received: by 2002:a05:6402:1d4a:b0:425:e356:36e7 with SMTP id dz10-20020a0564021d4a00b00425e35636e7mr5348825edb.172.1650878558378;
        Mon, 25 Apr 2022 02:22:38 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id r24-20020a056402235800b00425c4dd84a2sm3590811eda.29.2022.04.25.02.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 02:22:38 -0700 (PDT)
Message-ID: <b94dbce7-d2d5-d260-27c7-b98e009b41a3@gmail.com>
Date:   Mon, 25 Apr 2022 10:22:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Git user experience workshop
Content-Language: en-GB-large
To:     Jorawar Singh <jorawarsingh12@gmail.com>, git@vger.kernel.org
References: <CAK-fT4Ge88sp_zcTiWuvg5pe7qpGhqWbq3Jt4W0DRVVpy54pwg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAK-fT4Ge88sp_zcTiWuvg5pe7qpGhqWbq3Jt4W0DRVVpy54pwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jorawar

On 11/04/2022 11:18, Jorawar Singh wrote:
> Hello Git community,
> 
> There's been some conversation about holding a workshop focused on
> user experience [1]. I've volunteered to work with Jonathan Nieder’s
> team on organizing this event.
> The purpose of this workshop is to help incorporate UX practices into
> the Git development cycle.
> 
> When?
> Anytime between mid-April to April-end.To get a consensus on preferred
> dates, including workshop duration and times, please vote
> at the google spreadsheet link [2] below by Friday, April 15th.
> 
> Next Steps:
> Once a reasonable consensus has been reached, we’ll set the date and
> time, and ask for RSVPs via email.

Is there any news on a date yet? I filled out the spreadsheet but 
haven't heard anything.

Thanks

Phillip

> [1] https://lore.kernel.org/git/CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com/
> [2] https://docs.google.com/spreadsheets/d/1Z2QEveILRG9HEDlMhf50jTVhxaPFh8q_yK7K8RUsvdM/edit?usp=sharing
> 
> Thanks,
> Jorawar Singh
