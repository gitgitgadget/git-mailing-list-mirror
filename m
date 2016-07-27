Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7ECD203E2
	for <e@80x24.org>; Wed, 27 Jul 2016 09:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426AbcG0JfR (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 05:35:17 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33887 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960AbcG0J2D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2016 05:28:03 -0400
Received: by mail-lf0-f43.google.com with SMTP id l69so23037039lfg.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 02:28:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4ZwombZPj6ibLaEW1i/bMzWIjzNdy0j4QBH3i5ecV34=;
        b=EIeag3OD4pGMPIWA2MKCAKFdBIjIVHP7IdBVkVIwfXV4pongI3tpEOk7aixovPp3n5
         qul/dpktq+qJFefpjVriAu5eazH8CtL47nAMqJf2KaGYgaYjNXckykQekBWHcSnxiIfU
         XbOqhsXD7h4qC7COZXquA7FRt5DeFegrQmxppQVdzbQLLzF2LIK+SMVnMTyx5qz30+uZ
         6CSjusDf334YtjZrXioTovobkF05QVbCNZy0qbtNEJHTQPQuCLoVn7CJ5jpLuJmjtNUf
         LAISSwBij0JMSGh9DDlCtvK1MBwyr8+hPmLdVSxy0e6v/gzMyQV/tqmU0dmrVDk5KuUf
         Sbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4ZwombZPj6ibLaEW1i/bMzWIjzNdy0j4QBH3i5ecV34=;
        b=YywsK+37rNldgiqACHftuG9xSXB3IGe8GemWg/LNMEk5JY2PjTgzE+4HbHeeirdb5W
         gWoc+hCVM6kr8SoXl/qjFilfSXbaPbFaZ6s+f6KElYvF/001ObMaAnsdGdj2xTtUt0A9
         C2znhrJzaTHEOjeWq3npW3vmlh/BRqiDmMW0VzP2gg7E9aXCZpSy6erQn2GOstAoYEgj
         QYR7pFU9ToRtGYklhO14P0olaJlwWyOw/zAotuctuwExDmMfleHhFiU/GWtYO1ZrD11F
         r4vPrukwFyF5J1JL/YxGtwCZFeSwcAFswhBGNNE8x7oj0lXc7PxlggNTgb2CnvV13WDP
         1ksg==
X-Gm-Message-State: AEkoouvHRGgUhM58ncEBOZTVvuVboqKAsVeM1z0wpE/xOLaM+YS6nHW4BOz1B97C7xE4v8LK3y7zScPnPEoswA==
X-Received: by 10.46.33.76 with SMTP id h73mr10967996ljh.41.1469611681089;
 Wed, 27 Jul 2016 02:28:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.217.93 with HTTP; Wed, 27 Jul 2016 02:27:41 -0700 (PDT)
In-Reply-To: <d10f574d-20fe-cdff-3d4e-0d17db5b1c86@gmail.com>
References: <CAKEmgc=7tyb8FVpoD5yO=s3NMoGeQWr3A3WMPUXv1N+s1A7g8Q@mail.gmail.com>
 <d10f574d-20fe-cdff-3d4e-0d17db5b1c86@gmail.com>
From:	jessie hernandez <hernandezboy@gmail.com>
Date:	Wed, 27 Jul 2016 11:27:41 +0200
Message-ID: <CAKEmgcmWrUqVv4XXbdmB7CnqCCB9C9+UZ5WUdARu6k6om9TJ0w@mail.gmail.com>
Subject: Re: Very Very small fonts in gitk
To:	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I have tried all of that.
A colleague looked at it and he reset xrdb with xrdb -remove -all
apparently this works and my issues has been fixed.

Regards,


On Wed, Jul 27, 2016 at 10:21 AM, Trần Ngọc Quân <vnwildman@gmail.com> wrote:
> On 27/07/2016 15:05, jessie hernandez wrote:
>> Dear git,
>>
>> I have been dealing with an issue in gitk for a while now. I do not
>> know if this is a specific gitk issue or something else. I cannot find
>> any information about it online.
>>
>> When I start gitk in my repository gitk comes up but all the font and
>> all the menus are Extremly small. (see attached image).
>>
>> My OS is Red Hat 6.6
>> git version is 2.0.3 (i tried the 2.9.2 version also and this too
>> gives the same small font)
>> I am running in bash also tried in KSH
>>
>> Could you give an insight if this is a known gitk issue or that this is a bug?
>>
>> Regards,
>> Jessie Hernandez
> Try to edit gitk configure file `~/.gitk` manually, like this:
>
> set mainfont {{DejaVu Sans} 12}
> set textfont {FreeMono 10}
> set uifont {{DejaVu Sans} 12 bold}
>
> I hope it work!
> Thanks,
>
> --
> Trần Ngọc Quân.
>
