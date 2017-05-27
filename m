Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A91320D0A
	for <e@80x24.org>; Sat, 27 May 2017 03:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbdE0DYD (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 23:24:03 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36646 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbdE0DWO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 23:22:14 -0400
Received: by mail-it0-f67.google.com with SMTP id i206so3064365ita.3
        for <git@vger.kernel.org>; Fri, 26 May 2017 20:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Li7xSfIPA4Bh9zZefN6K9wIoZq04byRsorZmeLzamvM=;
        b=KGkwj+h2mQHEa90G8O0b4mCQcegNBr8Pk3f+FOsl+s9lcn808mnemcRRjk39qUpCpq
         5BoiFZss7jwcRNjGJ+ArizhsCRfV+llHAt78ANOpElizFx5kjGrCEWgJHC6vmxfaNSmp
         /oGaTkrwUntw4HrD1e+MM4SR/DGDuyjBXQf2PHhWnM5vxrxZahgYKNTfyNC/tm05XBrl
         XVhj1merTskAyztOzaogxuctadbzUMpPwfP1h5k06M6c2GPQCO8GcK59EKa23KSjvvIO
         kXfle3xXXTj6EZY3qC3ZNqnsGEsWQlTgMWGXwVxPUawCn4RDwyE4uzYRwNXuhnSQ8Pnn
         z6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Li7xSfIPA4Bh9zZefN6K9wIoZq04byRsorZmeLzamvM=;
        b=JwXUVQIlTsCp/PLNqU89ppHBcPbojYBek3zPRI/Bl12owdDVyi/wacRP4mkjEsXrNf
         9J5T+wifGawq81rlDa6jmRpRWEY82JgL6FjKmMiQNuhAlWBfpv5SwasN0I7onibM5Urp
         rfwA6hiVvKkrgePF1DBQEvFct7M3NoL91l9Gah990NBoRuyh9SlZbsjXsK4wsdkCLShE
         650GVDoAvEHoUqQYy+dXtihM9cVfI3+OCYyRP8X+dr7N+/Hnm7txVf93WXMioHmE6xxF
         QY7W/e2Rq2Ys9kBH3mIPgYRB7z4tO3dc/hNfIHnmM8JgXxzbq0EiVOtoqESsdHeLaAZn
         NY0w==
X-Gm-Message-State: AODbwcDZ1dY3Q2sJcChNt2OMuMDMMWZpU7npF7q3Snt1DcmxAsF+C7wg
        ms+9qCl6eLIbqw==
X-Received: by 10.36.101.130 with SMTP id u124mr21443563itb.109.1495854948879;
        Fri, 26 May 2017 20:15:48 -0700 (PDT)
Received: from [192.168.2.102] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id b18sm1226512ioa.16.2017.05.26.20.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 May 2017 20:15:48 -0700 (PDT)
Subject: Re: [PATCH v4 03/10] rebase -i: remove useless indentation
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        phillip.wood@dunelm.org.uk
References: <fefd59fb626a9a0ddd6c9bc3a7a42d6d1016b4c3.1493414945.git.johannes.schindelin@gmx.de>
 <20170526031524.27935-1-liambeguin@gmail.com>
 <CAGZ79kYeeCog03NHqqzZeb4Ya_m+jpQfzfG9Aa=rM5pxHpRCKQ@mail.gmail.com>
From:   liam Beguin <liambeguin@gmail.com>
Message-ID: <fcd7f363-9c71-8aae-a298-7698285f479a@gmail.com>
Date:   Fri, 26 May 2017 23:15:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYeeCog03NHqqzZeb4Ya_m+jpQfzfG9Aa=rM5pxHpRCKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On 26/05/17 01:50 PM, Stefan Beller wrote:
> On Thu, May 25, 2017 at 8:15 PM, Liam Beguin <liambeguin@gmail.com> wrote:
>> Hi Johannes,
>>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>> The commands used to be indented, and it is nice to look at, but when we
>>> transform the SHA-1s, the indentation is removed. So let's do away with it.
>>>
>>> For the moment, at least: when we will use the upcoming rebase--helper
>>> to transform the SHA-1s, we *will* keep the indentation and can
>>> reintroduce it. Yet, to be able to validate the rebase--helper against
>>> the output of the current shell script version, we need to remove the
>>> extra indentation.
>>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> ---
>>>  git-rebase--interactive.sh | 14 +++++++-------
>>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>>> index 609e150d38f..c40b1fd1d2e 100644
>>> --- a/git-rebase--interactive.sh
>>> +++ b/git-rebase--interactive.sh
>>> @@ -155,13 +155,13 @@ reschedule_last_action () {
>>>  append_todo_help () {
>>>       gettext "
>>>  Commands:
>>> - p, pick = use commit
>>> - r, reword = use commit, but edit the commit message
>>> - e, edit = use commit, but stop for amending
>>> - s, squash = use commit, but meld into previous commit
>>> - f, fixup = like \"squash\", but discard this commit's log message
>>> - x, exec = run command (the rest of the line) using shell
>>> - d, drop = remove commit
>>> +p, pick = use commit
>>> +r, reword = use commit, but edit the commit message
>>> +e, edit = use commit, but stop for amending
>>> +s, squash = use commit, but meld into previous commit
>>> +f, fixup = like \"squash\", but discard this commit's log message
>>> +x, exec = run command (the rest of the line) using shell
>>> +d, drop = remove commit
>>
>> do we also need to update all the translations since this is a `gettext`
>> function?
> 
> Translations are handled separately, later before a release is done.
> Separation of skills. ;)
> 
> As programming is quite complicated and involved we'd rather ask
> Johannes to only focus on the code in such a patch here and then later
> the translators will focus on getting the translation right. As the translation
> tools are sophisticated, they will likely give the previous translation such
> that the translators see that there is only a white space change.

Thanks for the clarification, I was wondering how this part was handled.

> 
> But as the commit message hints at a later patch that will reintroduce the
> original indentation, maybe the translators won't even see that change?
> 
> For more information on how the translations work in the git workflow,
> see 951ea7656e (Merge tag 'l10n-2.13.0-rnd2.1' of
> git://github.com/git-l10n/git-po, 2017-05-09) or see
> https://public-inbox.org/git/CANYiYbGfDXj4jJTcd3PpXqsDN-TwCC8Dm8B9Ov_3NaSzwsrCfg@mail.gmail.com/
> 

Liam 
