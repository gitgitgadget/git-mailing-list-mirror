Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D022320562
	for <e@80x24.org>; Sat, 28 Oct 2017 14:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbdJ1O17 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 10:27:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56937 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdJ1O16 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 10:27:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id z3so8395223wme.5
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 07:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=VG9XvGvqE+KOYtb62/TNyGbHD6+RsuAe8vfYHqRO5GU=;
        b=mtoe68LSzgKOYEKKm9NWET9ioq5IWUm/zcJbZCEE3+kTGrnkrCPNNmCCf4xsnWcaVl
         BlRWwZRoZ0uuUfuZXzUDpVuBo5hclBCiCAYN1ysjMw11pAQGu2Y2b725l356HBpv0LGS
         hnlYMtqpeTFoG1Oxl1namLGMA6zI0erqzfA2tQq84Wl4IO9vKwgW9wFlfzbRP6c+/MVJ
         k6Rhvoezeuyu2/eGg4oZNTCVoBGJS4x9Wdjox5vBDCP14JL31aX/g7jRuY2AgX8HBaEB
         uqjlm9NKvfXYzipYf1e/qF3A2gQh0fszCd0hkXbNoxYGkQKFLiqNjaWDGUeRnbWUEgSI
         sUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VG9XvGvqE+KOYtb62/TNyGbHD6+RsuAe8vfYHqRO5GU=;
        b=QQ/4634w854Nitwkrz1kc6oUmGkvDLSAZr3Xb7ktiGq9zO0FeUDlqW6AIW1FPrJu+X
         7mMdH90VK5a9M4iazDxMCLDmbx3ipPIsXx+QxrklYPzBWBLxJtS314+iBtDFNRmGgU4w
         CT8qR1fsPJNWZ+fvTPlKd59MITgSrsTwY7Pl4/RmVoBoXashF/v83m/6Z3WY9p1TmpBI
         GSmIT4KpgNyFGVgjwq4yT1x0axubJ+MeOz3QDVAKampD8qBVTXzDGcPOnzA9mg4gE9p4
         aMj6Hxw3/3aO6TCKN+YsA6ja0gWlX+3fsU7YnXNG7heLfZ6DPgp+8mUbAVR1BmRbnHN5
         OE9Q==
X-Gm-Message-State: AMCzsaW+0sDzifcSRuOCBv4Yo9BCY6S7YEijA9/Ul9bKAIxmpPJhmJp+
        QMAOQO2GfD0Lu49Bb8M1vDwT/O1u
X-Google-Smtp-Source: ABhQp+Quxp8iifuyVG7Qv/U7F9Pjv530vErT8KW4/cIsw8TPpR2BJ3zPIWEuhzMvxK/q7eklM0ldWA==
X-Received: by 10.80.134.135 with SMTP id r7mr4865713eda.152.1509200877410;
        Sat, 28 Oct 2017 07:27:57 -0700 (PDT)
Received: from [192.168.1.8] (93-87-220-21.dynamic.isp.telekom.rs. [93.87.220.21])
        by smtp.gmail.com with ESMTPSA id j59sm6627555edd.78.2017.10.28.07.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Oct 2017 07:27:56 -0700 (PDT)
Subject: Re: Rules for backup discussion
To:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
References: <C29FBE3637EA47B9AEDD7895339AB8C8@blackfat>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <3028f1a1-1311-b9e2-562f-08817a9daa94@gmail.com>
Date:   Sat, 28 Oct 2017 16:27:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <C29FBE3637EA47B9AEDD7895339AB8C8@blackfat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jason,

On 28/10/2017 14:49, Jason Pyeron wrote:
> I would like to efficiently backup my project directories.
> 
> I am thinking that the backup of a git enabled project should only backup the following sets of files:
> 
> Files under .git/
> The results of git clean -ndx
> The results of git status
> 
> Does this make sense? Is there a less expensive way to calculate the backup file set? I ask because sometime git status takes a long time.

What do you consider being an "efficient backup", which files are you 
actually interested in making the backup of...?

Do you use submodules? If not, and if your backup thoughts show the 
idea of files you want to keep (committed + untracked + ignored + 
modified, basically all of them), I think the easiest approach is to 
just backup the whole project folder - that way you keep committed 
history (".git" subfolder/repository) plus all additional uncommitted 
work as well (untracked/ignored/modified files inside the working 
tree), and no extra calculations are needed.

In case you don`t care about uncommitted stuff, you can just backup 
".git" subfolder (the repository), it keeps project`s whole history, 
with all versions of all the files in it (thus latest included).

Regards,
Buga
