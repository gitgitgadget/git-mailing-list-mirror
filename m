Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E45207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 22:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757420AbcILWof (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 18:44:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35370 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752762AbcILWoe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 18:44:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id c131so332522wmh.2
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 15:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=4KXqrnrAE3g2bnnsOGDN37CogQ4unMRtJCqFwYGU7Bk=;
        b=qc+mYMAeP+8uWw4ODifauSF6OJ4hYpzm4tlsBrxiRUpoHQ9Ck5N0u06hnZ70GBM2n0
         G+9VD+USYtOu4/a+c8nNCdAckh47lPwhacBWXYBl5SMyAryUyj1u3ee4YS1hRaCZGAUX
         seWeVSV7HdfObg4rNe0FbV1R37i96d6Vxn0OAsbs2gNmACQwdlz/ZB3rTbxLApjxENlE
         L9L63H2fi5nYnAQYv12ihyRbl99hplL+F8CCWAdqJd6LseiOiBhQKGmHx9BTpKTUy78K
         MCjI/stFAydhkhPIB6ZInCoGAkhNMusQHT+/6Zk7hGPJoA9/7JHT51xWNr8+lNzVBjeq
         rOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=4KXqrnrAE3g2bnnsOGDN37CogQ4unMRtJCqFwYGU7Bk=;
        b=RB2MsQj9MSnPYOmenxbpfiMYmX5wrP/o0sj2dBK2vwkBoiFdZ22VJctbOUlfBoo/eR
         e49e+RuE9sAyl1yOFREO9F7I7bRyI3Tt37JFB6T0/iev8eM1VIGpA/0XIBnqT6gZnmwp
         V9GOS+0jZUeg0qbuxoxe0uFlN1FGSIAlO1tRInipBVQ+SaNUS+vOhGNa3LwrNikkIdnG
         V6NNYGOYkWXVN4co2hTLlzFESwzCcSjkqs9zNDW5Q+804TupqOOEaGYlbPct+UasAgt0
         td77SD6/LAaZwRXdBMqQI1/YgKo9S74XJzzB05vvD+dIsfvmATQMmD7/lWZHW91p6MQi
         hsow==
X-Gm-Message-State: AE9vXwNKhKvl8TRNXQUDNTPQdFtwMPXU6g4XyXrja+AXhPkqqoT8yAifn+plJIwnI1Ta9w==
X-Received: by 10.28.18.18 with SMTP id 18mr1911715wms.28.1473720272495;
        Mon, 12 Sep 2016 15:44:32 -0700 (PDT)
Received: from [10.1.2.89] (dslc-082-083-141-056.pools.arcor-ip.net. [82.83.141.56])
        by smtp.gmail.com with ESMTPSA id t65sm19887647wmt.15.2016.09.12.15.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Sep 2016 15:44:31 -0700 (PDT)
Subject: Re: build issues on AIX - aka non-GNU environment, no gnu grep, no
 gcc
To:     Junio C Hamano <gitster@pobox.com>
References: <CANvxniXkbAKgjm+NZ0cyyCToEYp23Kd8s4yxSqUOsAUAHJSA7g@mail.gmail.com>
 <xmqqy42wzx1f.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Michael Felt <aixtools@gmail.com>
Message-ID: <d746a170-a0b0-cc2a-9d27-f146d872595e@gmail.com>
Date:   Tue, 13 Sep 2016 00:44:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqy42wzx1f.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Try again, reply all this time...


On 12-Sep-16 22:24, Junio C Hamano wrote:
> Michael Felt <aixtools@gmail.com> writes:
>
>> I had a couple of issues when packaging git for AIX
>> a) option -Wall by default - works fine with gcc I am sure, but not so
>> well when gcc is not your compiler
> That is expected.  As you said, it is merely "by default" and there
> are mechanisms like config.mak provided for people to override them.
>
>> b) needs a special (GNU) grep argument (-a from memory). This I
>> resolved by downloading and packaging GNU grep. However, I hope this
>> has not introduced a new dependency.
> Read the Makefile and find SANE_TEXT_GREP, perhaps?
Ah - read the manual heh?. Generally, I just download, unpack, and run 
configure.
I do not mind needing an extra tool - as long as it is only for the build.

And, since you have something about it in your (still unread) install 
Notes - it has not slipped in by accident.
>
> Thanks for helping to spread Git to minority platforms.
The link is: http://www.aixtools.net/index.php/git
I do not use it much (I prefer to package "distributed" src tarballs, 
but when testing a potential fix - git can be extremely useful!

All in all, thanks for an easy to port to a "minority" platform!

