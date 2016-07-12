Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C83A92018E
	for <e@80x24.org>; Tue, 12 Jul 2016 08:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbcGLIpJ (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 04:45:09 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37977 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbcGLIpC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 04:45:02 -0400
Received: by mail-wm0-f46.google.com with SMTP id o80so15856782wme.1
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 01:45:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=wokBS2o1dnAbOt66QcGtaMobfDJ/1JqRDf9wyAhNjLk=;
        b=EjyVMVw8ZSjnUHGulJXBvbRdC1Cf6mEyYoU7aYIXqDjVUR9uMroqVrlrElg8Kas8CP
         aSOssO0ln4oYWne7GePW8NPG/DsCvO29S9owyD7B0x6KMFB1tFaacx5ZhcfhQLXZbTtz
         R/8UY/HBqNbfEvOIuwCdHi6yVDORbKSsoRJVgOh140NjBqnR2mzJjrpxkd+7Wi4nBZ8N
         gL/0xC30BjVP5mWRXlmA1TJJvb8XnD8LPDnsaERyKl3kz9X7Lb8CGQhxjWTi3cTXOFbj
         wUIUkhapFqTzMzyZCS1ueJnNba/MrDhicadNhDgbWmXOW+ybxk861M+qlP6RJWJXJNyw
         mzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=wokBS2o1dnAbOt66QcGtaMobfDJ/1JqRDf9wyAhNjLk=;
        b=GniiQxQk9PIOzzAzSpg6gGvtkJy+TV3k5VXGSrhRm87ocAYbYQiiC7y8F0t0qutOLi
         nVD2TQuTKjjXfaW8dkwQt07edo863+6hDI6gLHOiFR7jrwvb+4QprVKHQz/M0t8jTN5I
         KJY7AO7qWOmp6UofH4RtRPvnUP7inML9kqK6XHa3BL+Zld0Zpjov7COuIOBeX2WdjDSc
         LyjBhggaIrDObTbt3LAir4Z0VV0ckm78mAKi1yjVeuQxJOdkIXrSpOojaobqtl1V30BU
         oES7Z5VXxvR71glEL1empu0i1NbLOznOIpvfvBqCvkKXhXzCy3tongF5GP5+hgO1v3gm
         pMEA==
X-Gm-Message-State: ALyK8tKTUcJy/FQ66iHqeNZOdw3v+rNB7KffiNQuzg42bSeFaFs3LgOPcWWz+pGYrWzPZQ==
X-Received: by 10.28.11.79 with SMTP id 76mr1616712wml.91.1468313101207;
        Tue, 12 Jul 2016 01:45:01 -0700 (PDT)
Received: from [138.38.103.116] (cspc-lin-03.bath.ac.uk. [138.38.103.116])
        by smtp.googlemail.com with ESMTPSA id d8sm3916518wji.39.2016.07.12.01.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2016 01:45:00 -0700 (PDT)
Subject: Re: git push doesn't update the status with multiple remotes
To:	Johannes Sixt <j6t@kdbg.org>
References: <5783CF57.1010105@gmail.com>
 <84c1ac72-cbe7-7490-2c61-9302703cb28b@kdbg.org>
Cc:	git@vger.kernel.org
From:	Garoe <garoedp@gmail.com>
Message-ID: <5784AE0B.2040709@gmail.com>
Date:	Tue, 12 Jul 2016 09:44:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <84c1ac72-cbe7-7490-2c61-9302703cb28b@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Thanks for the quick reply.

On 12/07/16 06:26, Johannes Sixt wrote:
> Am 11.07.2016 um 18:54 schrieb Garoe:
>> I have a repository on github, a clone on my desktop and bare repo on a
>> private server, in my desktop the remotes looks like this
>>
>> all    git@github.com:user/repo.git (fetch)
>> all    git@github.com:user/repo.git (push)
>> all    user@server.com:user/repo.git (push)
>> server    user@server.com:user/repo.git (fetch)
>> server    user@server.com:user/repo.git (push)
>> origin    git@github.com:user/repo.git (fetch)
>> origin    git@github.com:user/repo.git (push)
>>
>> If I commit to master in my desktop and run 'git push all master', the
>> github and the server repos are correctly updated, but if I run 'git
>> status' the message says:
>>
>> Your branch is ahead of 'origin/master' by 1 commit.
>>   (use "git push" to publish your local commits)
>
> But "all" and "origin" are different remotes. Just because you use the
> same URL does not make them the same remote repository from the view of
> your local repository.

I expected git to be "intelligent" enough to detect that if the url are 
the same, it had already exchanged information with the server by the 
push command, so it would update the message without explicitly pushing 
to origin.

>
> (Additionally, "all" is not a special name, just in case you had
> expected that.)
>
>> The message won't update unless I run git fetch or git push origin
>> master.
>
> Yes, that's how it is supposed to work.

 From my point of view the current behaviour is counter-intuitive. 
Anyhow, I understand by your answer that the current behaviour is 
desired and it won't be changed.

> I think there is some way to configure that a single push command pushes
> to several remote repositories, but I can't find it right now...
>
> -- Hannes
>

Thanks again,
Garoe
