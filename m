Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E131020987
	for <e@80x24.org>; Thu, 29 Sep 2016 21:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934361AbcI2V1h (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:27:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33603 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932267AbcI2V1g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:27:36 -0400
Received: by mail-wm0-f67.google.com with SMTP id p138so683464wmb.0
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 14:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=IAbLx8hvgJ0L4jBtIacvEdsYd39cIEBBjutYTYvxRqY=;
        b=LHBgIcp3BAcUzFvXlBGKlb88ujww8hkkJ0U9Vq1fIUZz1q83XxkZIVOjJITOjCzKSR
         Uj/YYbAfKmBIMtuRzQez7u9TkYVcHQ6jCdA/XLqsmf3J4hx19b4LXGahsHgw9TGpFMTB
         STJYrxnthCS60inQvJ0oEJ8SiJdp9U4nJcldd6KHOUZRFrVbqhEXcTCSDFvon9cJPWiR
         EBrGLLN91IgHOPczxgl37cz29RHQKPpozpNXLcFRxGGW46HR/3NyPolbQP4zWTdIDZwV
         d5a7UFcmjuF/Wj78qsV0UKpJJDdMTmDbjBdZ9AzIJy/4xlAG9H9ZlCXBx/AXzxqVDMYb
         0JzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=IAbLx8hvgJ0L4jBtIacvEdsYd39cIEBBjutYTYvxRqY=;
        b=UpWU4+Ar6vxMMMHIWN4sCF6caH0uZ8A0oipetw+ezxDtSfM2fPD5dZord7p7UFKMGq
         yDvPsSX/vl67l0jvoXZdf21Q9GjqmvCIFdeOvI8qT06MezYZoIRmf+PeCXu4wdzubnwR
         4q3deC4qjqpRuC1X7duT+Mthv9za5eK2oEaEZCA9tLRzEj/teuHNt+HFy6wzGacjpuy3
         jeLr7p4zEtndtijIoDOLzwJ5Rc4W1dunT3nfZW/GsAZOGscBwmn2cpYyJyvxktNaRuoT
         EYPwqgjtWNQVj1v7z80W9wBBYQlrOKzawziLYvnCe945M/YvsJkWE5u6fWdxpJsJNOXv
         8BrA==
X-Gm-Message-State: AA6/9RmMsDNgoUXn0VixBXjNwq6xuLUF+EKdKCjAsR0up5CfPWPRRq6PA2cpZsPIunJX5w==
X-Received: by 10.194.222.101 with SMTP id ql5mr3238516wjc.184.1475184453454;
        Thu, 29 Sep 2016 14:27:33 -0700 (PDT)
Received: from [192.168.1.26] (eln216.neoplus.adsl.tpnet.pl. [83.21.207.216])
        by smtp.googlemail.com with ESMTPSA id yt4sm16159325wjc.48.2016.09.29.14.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Sep 2016 14:27:32 -0700 (PDT)
Subject: Re: [PATCH v2 02/11] i18n: add--interactive: mark simple here
 documents for translation
To:     Junio C Hamano <gitster@pobox.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
 <1472646690-9699-3-git-send-email-vascomalmeida@sapo.pt>
 <xmqqmvivy4i9.fsf@gitster.mtv.corp.google.com>
 <1475159493.2435.7.camel@sapo.pt>
 <xmqqfuoihc1m.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <07371844-7fde-5b7f-b9e1-7db1a54fdbb5@gmail.com>
Date:   Thu, 29 Sep 2016 23:27:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqfuoihc1m.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.09.2016 o 19:05, Junio C Hamano pisze:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
> 
>> On the other hand, would it make sense to translate these commands? If
>> so, we would mark for translation the commands name of @cmd in
>> main_loop().
>>
>>  sub main_loop {
>> -       my @cmd = ([ 'status', \&status_cmd, ],
>> -                  [ 'update', \&update_cmd, ],
>> -                  [ 'revert', \&revert_cmd, ],
>> -                  [ 'add untracked', \&add_untracked_cmd, ],
>> -                  [ 'patch', \&patch_update_cmd, ],
>> -                  [ 'diff', \&diff_cmd, ],
>> -                  [ 'quit', \&quit_cmd, ],
>> -                  [ 'help', \&help_cmd, ],
>> +       my @cmd = ([ __('status'), \&status_cmd, ],
>> +                  [ __('update'), \&update_cmd, ],
>> +                  [ __('revert'), \&revert_cmd, ],
>> +                  [ __('add untracked'), \&add_untracked_cmd, ],
>> +                  [ __('patch'), \&patch_update_cmd, ],
>> +                  [ __('diff'), \&diff_cmd, ],
>> +                  [ __('quit'), \&quit_cmd, ],
>> +                  [ __('help'), \&help_cmd, ],
> 
> I don't know offhand.  If the code to prompt and accept the command
> given by the user can take the translated word (or a prefix of it),
> theoretically I would say it could be made to work, but to me it is
> dubious the benefit outweighs its downsides.  It would make teaching
> Git and troubleshooting over the phone harder, I would guess.
> 
>  A: "Hi, I am in a 'git add -i' session."
>  B: "Give 's' at the prompt."
>  A: "My Git does not seem to take 's' as a valid command."
>  B: "What? I've never seen that problem."
>  ... back and forth wastes 10 minutes ...
>  A: "By the way, I am running Git in Portuguese."

Also, for one-letter commands to work (there is setting where you
don't even need to press enter, IIRC) all those translations would
have to be chosen to begin with different letter, isn't it?

Best,
-- 
Jakub Narębski

