Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E427203BD
	for <e@80x24.org>; Thu, 27 Oct 2016 14:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbcJ0NsI (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 09:48:08 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38141 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbcJ0Nrc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 09:47:32 -0400
Received: by mail-wm0-f49.google.com with SMTP id n67so43476650wme.1
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 06:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pelly-co.20150623.gappssmtp.com; s=20150623;
        h=subject:references:cc:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=p15CmRcFgPP0ErfQlMIXHXFjkeGO0MISfryP1xa2OZQ=;
        b=qLI2gwysC2Pupqo6Eb4CT8MHeYuMLsqdoj6CvcoOoJq46wDHCIo/8XZCB34X8WxQ+a
         Mfc7KMJECyODNi7J6T5ZXwL7ZRZb+7+xglUCXdko5t/fpNn+6+i8PWhw+c5vxperSs/U
         ZHHAZMwJTWZ7Q4vFQSipY5fPdQH+gWcLNKHw3lKz3sSha8bLbYovCpMmw0LKAyvmoGaa
         VC91xQm7ewO7M7AKf9CMZgjfYVRRHgE60O/vOagINtINmdcFxQonfctVcp5mfijzc4KI
         UTfZGfC1+zSRn4s93FIFt+iFb01uBE1W0AnU9q5xvmoNVzRtWrkj2yzRMclyvrxIKmcZ
         WNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=p15CmRcFgPP0ErfQlMIXHXFjkeGO0MISfryP1xa2OZQ=;
        b=mXslM9qI9Kci724h4PFmq4EfkRzbZ9xpaBa2Ka5xCxIj6i5HWBSNWzNdwwCfKZPZpS
         gXScIZMEBGxZd8glXc9lv2j9mCmwi4tKgmmfuSdfCwdXC8FF8+l6hc80I8UZ0AkZgeHi
         QFkHQWamN/bzGaeKDHWjrV+b20S+//N1+YbehF129Ue/Vqze2Y7YuSXouJe2K/lq0Als
         8iqgWbJ5S12/bIpbeZTur0JqscjEgl7OydwVl9YiW1NS10OYzSuKfRc0gO3ZqrX4S3QY
         yiOHgSzsYoToaQfRKv43PLfvf2At6K2c6jBbGiMGn88JYoeRPszoR5Op58YwoEGYPwwX
         CcuA==
X-Gm-Message-State: ABUngvfaiBqJx5p23C9rJqJJl0ab25tEXhlXRE39u/Ll7hq3mZDRInUYmekyJ9MCMw5//Q==
X-Received: by 10.28.66.218 with SMTP id k87mr7230695wmi.79.1477561903291;
        Thu, 27 Oct 2016 02:51:43 -0700 (PDT)
Received: from [10.3.1.6] ([49.50.252.82])
        by smtp.googlemail.com with ESMTPSA id n3sm4008622wjq.34.2016.10.27.02.51.41
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Oct 2016 02:51:42 -0700 (PDT)
Subject: Re: Expanding Includes in .gitignore
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
 <CAGZ79kasr6ubuOm01rLtdK7pfWqriZE1vioLyxAr2G2Hd1xGhg@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Aaron Pelly <aaron@pelly.co>
Message-ID: <0cf156b2-8fc1-2eb7-e26c-f11f59eec4e2@pelly.co>
Date:   Thu, 27 Oct 2016 22:51:38 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kasr6ubuOm01rLtdK7pfWqriZE1vioLyxAr2G2Hd1xGhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/10/16 15:22, Stefan Beller wrote:
>> The use case for this is where I did not write my own rules, but I want
>> to keep them updated. https://github.com/github/gitignore is a damn good
>> resource, but I want to pull it and include relevant bits project by
>> project and/or system wide. I don't want to have to update many projects
>> manually if that, or any other, repo changes.
>
> .git/info/exclude could be a (sym)link to an up to date version
> of the gitignore repo as a hack?
>

Using links isn't a bad idea, but you still end up at some stage
combining the contents of several files that already exist. Well, in my
example, anyway.

I accept that I'm being pretty trivial, and once it's set up there's
never any pressing need to change anything, but it still irks me.

Even with a linked .gitignore, or .git/info/exclude there will be
sections that are project, language, editor, machine, whatever,
specific. So I still need to copy stuff from one file to another by
hand. By allowing includes, I only have to have a link to each file
describing the data types for each component of the environment.

And they are community maintained, so I don't have to google every time
I try a new editor.

note to self: reply-to isn't the list.
