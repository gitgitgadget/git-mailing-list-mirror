Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D043203E1
	for <e@80x24.org>; Tue, 26 Jul 2016 09:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375AbcGZJcG (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 05:32:06 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33070 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047AbcGZJcF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 05:32:05 -0400
Received: by mail-pa0-f68.google.com with SMTP id q2so13019835pap.0
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 02:32:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=0eKWrY6eOFFP/3rtGcEgYROs3cSpTByY8s55ge5JOjw=;
        b=hpHD0RDNXw+uTsgidIwxUcPx2DaDnS0SGd5ZrdZkkag/A8ecHEijHol6t4LLs0iv6b
         BmOgQCJ9JlHs7xWVLm3oyqengNni1Vtvvnveub4ACZc65IjWsAp4nwdrbLF6eQZT72Uy
         ftWDrB5yUhly3xH713Ke99oMIqOu2SbIgkgeV/8lJVY8UbeHD5On26M5ZigIi2tRloPS
         7K5CnjSUENasLII+ldOW4dpw352zNSfNrc/jCcCTf5o0KbAqJVLezzz56sCx5CMjeVlt
         oZSCcdjwPf991sZfxhZ2eYWGqk8lq84NKpryr0rjX4Kp+rtx0nlQH3yuaKNoENx3DXo6
         hRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=0eKWrY6eOFFP/3rtGcEgYROs3cSpTByY8s55ge5JOjw=;
        b=L0ljftj1wmycKBw9QIBvb9Xj7eI7BUzSxVflO7kYDEiD+hDxu67YtScA3wDJ+qvicv
         R7BYmr67mRH7eH4mMKOvY4Pp6ciJf574D/jd5JP5a0SJCtQjaQkRV826ehuxWS36zzRU
         fYd7FSTijcnrINA5P1KCtm2vZKSC3edgBcDG/ja0LoyS9WfJ2YwaSZTLF1m3Jp1oNUQX
         36gL7aOFEAf3s17xnEu0l+0xIBZyu7V/Rte8mOSP6VYkvxCNaOTQUOmjDPWOVHZELuWS
         3cibzTyFbaNuOeZgFi96x+5ViEA8RHXvYt5ByFMFRecTv7jCyzsQEeyjhWLbiRcUbaw2
         6tCg==
X-Gm-Message-State: AEkoous463yfdAosV1U5bJHojectHmEZJl3f7ETBn+u33J0vIy68B8XLWXja6JU5kqS8iw==
X-Received: by 10.66.42.33 with SMTP id k1mr37453898pal.111.1469525524169;
        Tue, 26 Jul 2016 02:32:04 -0700 (PDT)
Received: from [192.168.1.10] ([122.162.150.0])
        by smtp.gmail.com with ESMTPSA id b7sm46321388pat.27.2016.07.26.02.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jul 2016 02:32:03 -0700 (PDT)
Subject: Re: [RFC] git subcommand to check if branch is up-to-date with
 upstream
To:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
References: <57960CFF.5060104@gmail.com>
 <xmqqd1m17iyb.fsf@gitster.mtv.corp.google.com> <57964D7F.90402@gmail.com>
From:	Sidhant Sharma <tigerkid001@gmail.com>
Cc:	git Mailing List <git@vger.kernel.org>
Message-ID: <57972E10.4020403@gmail.com>
Date:	Tue, 26 Jul 2016 15:02:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <57964D7F.90402@gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Monday 25 July 2016 11:03 PM, Jakub Narêbski wrote:
> W dniu 2016-07-25 o 18:58, Junio C Hamano pisze:
>> Sidhant Sharma <tigerkid001@gmail.com> writes:
>>
>>> I was wondering if it would be a good idea to have a command to check if a
>>> push or pull is required. Perhaps it can also suggest if changes are
>>> fast-forward or the branches (local and remote) have diverged.
>> Doesn't "branch -v" give that information these days?  You'd need to
>> "fetch" first to get the up-to-date worldview before running it, of
>> course.
> You need "branch -v -v". For current branch, you can simply run "git checkout".
> All this is the information for end user, not scripts.
>
> $ git branch -v -v
> * gitweb-docs   4ebf58d [origin/master: ahead 1] gitweb(1): Document query parameters
>   master        08bb350 [origin/master] Sixth batch of topics for 2.10
>
> $ git checkout
> Your branch is ahead of 'origin/master' by 1 commit.
>   (use "git push" to publish your local commits)
>
Nice, didn't know that one. Thanks for the tip.

Regards,
Sidhant Sharma
