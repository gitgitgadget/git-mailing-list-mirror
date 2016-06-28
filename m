Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFB392018A
	for <e@80x24.org>; Tue, 28 Jun 2016 13:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbcF1Nnp (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 09:43:45 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37473 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbcF1Nno convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 09:43:44 -0400
Received: by mail-wm0-f51.google.com with SMTP id a66so28604808wme.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 06:43:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=l+INCJkGjqv3SxpJiZfn0Szmu1JUJK9AY/ZbSx5V6lk=;
        b=PqUfDDZd8MHoh8r/BAJP0eMggfD66XrQcr3OnCMK1q2oo4bC5eh+CM2Rf9aMVqQ1n4
         RolMQyMZxvSrOoeY3S3wrJCpRUTn5DCBpSlzo+aU7A0MFqrHf5PAtqrLSjTxq6ay0izc
         AYmKayZHXwQRqMW/mc8ckfTHC3U7JDmgTxW58rixuoyU7EPyZJwC4AF9EJSFx1UyCXu+
         ctcHwshgZopCqtRlzuwBeqCgheswAwZ+s05zi9ecjTCKxkhMslVVD9Iz256KnSUpqn+7
         7mc2a8t/2goYRYuQipN+hwHvU0Ab2tcv93qjnNCxARRebm/3f7ZynwVImfrFuvoNgx4A
         t7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=l+INCJkGjqv3SxpJiZfn0Szmu1JUJK9AY/ZbSx5V6lk=;
        b=kS+OcUXxaOLp8Zk3Q8eyUf5w5znlLvjh0Wg7XtV4g8HcWViWZCVVAae6YEaz7rzD4Q
         9BLm8uzMsRgLmvu3MUTY6tC7C9TgOGiDtBTZSreaj+Oj9d66j5fhmSz+hzouHwR4+6EC
         M/lL04pBLfhKj/TNGQbCgQGuZqWPjX81R4wG6DvPM7G5XT/AKEHuKz3OlomK+B9WXyyB
         9RQhxlIzlmBwS3vra+31bWfBIFu5JZkq3JLgI3/9QedslQp6+7AuMnHhlHeyXP8Mxxfy
         Ly2ySd475Fkn1MUHeNsAKJ4qFrBnU+vGbKFcJ85Z5eN0duyAiig37xBSmDKsG1/UNKmh
         APVQ==
X-Gm-Message-State: ALyK8tK/ej2053k/zKH88t+q/f9v9N5tWwhVWa9ws+9zXzyh4vf/H4mrl0EDaBkwa29gKA==
X-Received: by 10.194.109.232 with SMTP id hv8mr3254367wjb.115.1467121422290;
        Tue, 28 Jun 2016 06:43:42 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id wo9sm3717175wjb.8.2016.06.28.06.43.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jun 2016 06:43:41 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC] Native access to Git LFS cache
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.20.1606281513380.12947@virtualbox>
Date:	Tue, 28 Jun 2016 15:43:38 +0200
Cc:	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	technoweenie@github.com
Content-Transfer-Encoding: 8BIT
Message-Id: <5491DA7A-4B1E-4015-879F-F01FF7481143@gmail.com>
References: <1467005913-6503-1-git-send-email-larsxschneider@gmail.com> <CACsJy8B7ie_oQRZ7Pw3NTo4YyXwZOer-iDUVxDPSY_uhrQi1bw@mail.gmail.com> <alpine.DEB.2.20.1606281139490.12947@virtualbox> <CACsJy8DCovHoutyEYwaxdCTU4K-h8u_JTOwt8GUiNTkkXzGz3w@mail.gmail.com> <alpine.DEB.2.20.1606281513380.12947@virtualbox>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 28 Jun 2016, at 15:14, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> Hi Duy,
> 
> On Tue, 28 Jun 2016, Duy Nguyen wrote:
> 
>> On Tue, Jun 28, 2016 at 11:40 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>> 
>>> On Mon, 27 Jun 2016, Duy Nguyen wrote:
>>> 
>>>> On Mon, Jun 27, 2016 at 7:38 AM,  <larsxschneider@gmail.com> wrote:
>>>>> ## Proposed solution
>>>>> Git LFS caches its objects under .git/lfs/objects. Most of the time
>>>>> Git LFS objects are already available in the cache (e.g. if you
>>>>> switch branches back and forth). I implemented these "cache hits"
>>>>> natively in Git.  Please note that this implementation is just a
>>>>> quick and dirty proof of concept. If the Git community agrees that
>>>>> this kind of approach would be acceptable then I will start to work
>>>>> on a proper patch series with cross platform support and unit
>>>>> tests.
>>>> 
>>>> Would it be possible to move all this code to a separate daemon?
>>>> Instead of spawning a new process to do the filtering, you send a
>>>> command "convert this" over maybe unix socket and either receive the
>>>> whole result over the socket, or receive a path of the result.
>>> 
>>> Unix sockets are not really portable...
>> 
>> It's the same situation as index-helper. I expect you guys will
>> replace the transport with named pipe or similar.
> 
> Yes, I will have to work on that. But I might need to ask for a change in
> the design if I hit some obstacle there: named pipes are not the same at
> all as Unix sockets.
> 
> Read: it will be painful, and not a general solution. So every new Unix
> socket that you introduce will introduce new problems for me.

Thanks Duy for your suggestion. I considered a daemon, but a daemon makes
it always harder for the user as the user needs to ensure the daemon is 
running! Plus, Dscho's concerns regarding Windows.

I think the core problem is that we invoke the filter for every file:
https://github.com/git/git/blob/master/convert.c#L461-L475

Couldn't we start the filter executable at the beginning of the Git process
and communicate with it via stdin/stdout whenever we hit the Git filter 
code? Would that work?

Alternatively, do you see a way to add a "plugin" system to Git? Where Git
could be configured to dynamically load a "filter" library?

@Dscho:
Do you have a recommendation for interprocess communication that works 
without trouble on Windows? 

Thanks,
Lars