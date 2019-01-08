Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73EB01F803
	for <e@80x24.org>; Tue,  8 Jan 2019 06:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfAHGlE (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 01:41:04 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44756 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfAHGlE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 01:41:04 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so2083876lfe.11
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 22:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=KBqUXG543Y5pm5IT3r66505yRtbu092dRJj9147mUeo=;
        b=MpRiMGjT6d9lyPgTWJ8KXGBPU/7R2ZKXcoq0DTpKBBCCK4UMc64d3JQ1hU69QvkZyR
         QvUQUx4JpFh/xDH9xpubRYeZS4W6Uvd+IwjDbO7cMs3ZvMQKQhrUCO0JIF15JtDZVtI6
         2h45qvuw5Ts5UXFHy4tLATRg9HQUcKPHUXXyJeeyYEVHq9RC2Tuu2vXOvv/BBSrs18Ai
         sUpRDXXnxGEYhg1DB8tokJDw7elgzrkodD9w2+6Umo41VEi6OSOxneSeKF6Q+v2Xa0eT
         5ftudMuJdMp370AvCtYcGABreXD127wxgGeYybXTJOZBI0N/rAtmIdFoS+46SorinU0M
         g6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KBqUXG543Y5pm5IT3r66505yRtbu092dRJj9147mUeo=;
        b=bsWMsLVrFlpvAV5wTTdVa62C/H9YAWd45D7PHEnXHiIjYe7YfKsnA7kvlVHgky+JUh
         DUJpd8MISbVaIz6TiWnJe2MWMLzO+BO1z8PNdEAItvvtv0CIXQI6upS9Iz9GTOPOS/9T
         mxF/wZDiId4zBkiswGbpmZE8wlraoErr6am17UPmMV6qf63IvhXSKJzsQ3Mv4wjJh9Ot
         SyZKL2yUzOnkucXiWrGNFEADfwqFrLnkv12fO79BwMGOgDMN8F3f/lejrJyfvytaV50n
         I0G1GDPGHKskIB/GPRg885csai1015REccTl6H1r0UBNLWipd2c2v/A2y6PjVVEFJVgj
         gYyg==
X-Gm-Message-State: AJcUukcZrQab9n5rnCoJOtai6dKVh4/DrqKJRheolUL/vOVZx6HzXhHN
        02v6wScIpYk1bjifAeiI/1U6dJo2a7Fu4g==
X-Google-Smtp-Source: ALg8bN7RxJ5ohVZurEt1oKaEm/VebjxuZ9QvapCVHp/oGf+CigViaqyoSw59Pn2uXdvyr5r94KNJ2g==
X-Received: by 2002:a19:40cc:: with SMTP id n195mr304445lfa.40.1546929661605;
        Mon, 07 Jan 2019 22:41:01 -0800 (PST)
Received: from [192.168.10.105] (37-247-29-68.customers.ownit.se. [37.247.29.68])
        by smtp.gmail.com with ESMTPSA id x16sm12690343lff.26.2019.01.07.22.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 22:41:01 -0800 (PST)
Subject: Re: gitk shows local uncommit changes after touch file + reload
To:     Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
References: <CAPbeDCm5hjq06fbs=SUPR1rm3bD3GJvifZovP1d-Xd=01JfpYQ@mail.gmail.com>
 <2666a093-f9a5-782e-40b3-0cfbce8fe2a3@iee.org>
From:   Jacob Kroon <jacob.kroon@gmail.com>
Message-ID: <0c4b21c8-996b-3017-a1f9-894ac5b27232@gmail.com>
Date:   Tue, 8 Jan 2019 07:41:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2666a093-f9a5-782e-40b3-0cfbce8fe2a3@iee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/7/19 6:41 PM, Philip Oakley wrote:
> On 06/01/2019 22:51, Jacob Kroon wrote:
>> Hi,
>>
>> Not sure if this has already been reported, but I observe this odd
>> behaviour in gitk from master:
>>
>> git status
>> gitk # everything looks good
>> touch <file-under-version-control>
>> gitk # gitk shows "local uncomitted changes" on the file I touched
>> git status
>> gitk # gitk is back to normal again, showing no local uncommitted changes
>>
>> The issue has been discussed on stackoverflow here:
>> https://stackoverflow.com/questions/49990403/after-tar-untar-of-git-repo-gitk-shows-local-uncommitted-changes-not-checked 
>>
>>
>> Any chance gitk could be changed to so that it doesn't display the
>> "local uncommitted changes" blob in this case ?
>>
>> Regards Jacob
> 
> I believe this is doing the right thing (TM) at the level of 
> investigation that gitk uses to determine the status of the files. In 
> particular, Git uses the modified time stamp as a surrogate indication 
> for detecting that the user has probably edited the file (it's been 
> modified at time hhmmss, right?).
> 
> Now as I understand it, the full (without limiting options) git status 
> command does go and check the content of anything that's potentially 
> changed (but it can be costly), and at that point the status command 
> simply updates its 'Index' record with the new mtime after noticing that 
> nothing had really changed. Meanwhile, gitk, being a continuously 
> running GUI avoids the overhead of the git status (though you can force 
> it) and does report the mtime change as being a potential file 
> modification.

Although gitk it is a continuously running application, I don't expect 
it is continuously monitoring the files. If I explicitly tell gitk to 
"reload" I'd be perfectly fine with it taking some more time to discard 
any false positives in the same way as "git status".

What do you mean by "you can force it", is there some option in gitk I 
can set which forces it to do the equivalent of "git status" on reload ?

Thanks,
Jacob

> There is a separate discussion on the git users forum regarding the 
> compatibility with other tools that has a similar root cause in the use 
> and abuse of mtime as a canary for modification, given that the Git repo 
> storage does not record any file times, so will get a (moderately) 
> arbitrary mtime & ctime when checked out.
> 
