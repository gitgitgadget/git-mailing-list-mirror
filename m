Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8387A1FC96
	for <e@80x24.org>; Wed, 30 Nov 2016 00:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754914AbcK3Aar (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 19:30:47 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:36698 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753327AbcK3Aap (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 19:30:45 -0500
Received: by mail-io0-f195.google.com with SMTP id k19so32868053iod.3
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 16:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0MvzdMYmu7Z192i0xBIchnTsT9tgOyjgyGGzFv2ZbuA=;
        b=SJBDrr7H1EA2GdxSACouiTTZs1zg4HNtoEjYe4+8oOF/waOSXeCqJPcPpE47H/Pvf9
         xpG/BQ8AVk9B+77IX74N/CetS9BW1uJTHi1LhvmblPuChFPYTd7HzjG1kmhiegl3Xbpu
         KYdoKpHCZg0dYD5YSR2YIL/oUIS58T3wM8R1kUQ5rvnx4vq8QttUexO6NIhPUawnUmyY
         fO+M+NRKoSl1VtZvIB0L2UwsiRhxXNVWfHKZNk4SbpTB2kJ14C7rUK4oxfXK8Bu/TwTX
         0bhtRGyhttCZB79icTJDP4AlT/xzaRP/jnpyLK7Xy+EJrGyAHolB8qHNz7o++TTshji0
         grNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0MvzdMYmu7Z192i0xBIchnTsT9tgOyjgyGGzFv2ZbuA=;
        b=DZKks8igCre7Sw7C9b9W/YphUEmQzpS59ObQx7SM4vTWs/riFCfuziMN8rnGggC2G5
         Jx9XEZk8JitH2CVl7hPbVbDtaqPNn8fYXbKpY0W4GYbc6Hfy09lEW9DNQjR96cdju5DE
         xVyxJH8elUfgqJB20U7sml7Z83WT/7UD5Rja1WWhHjCH2P0IUd4N5mVp2mz7GuXiQMB+
         iRkc6YtCHczmcUVHgnLmav5uq7eXzMfKpbr5qTJ/Li9ce7rEd/rg6a8gtE2mwbqmpnO/
         4H45m4Lc5Qm2PnyQwE7r1Tayfu6Lm7VvteB2xIaSW3dwksOrpNTqMDHlsVuu6vKmxpo7
         oHOw==
X-Gm-Message-State: AKaTC03vAon/CZ51jrKLHMDIiZSw11cn8L5U8SpwJNe/r9mtRoghG76W6zW6jpqq4xnm0SVH3j9sJ8sgywlQLw==
X-Received: by 10.36.50.78 with SMTP id j75mr26036641ita.58.1480465844828;
 Tue, 29 Nov 2016 16:30:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.19.6 with HTTP; Tue, 29 Nov 2016 16:30:44 -0800 (PST)
In-Reply-To: <20161129215538.vhgmxpq4rasri4vm@sigill.intra.peff.net>
References: <CAOE4rSzTq6DVR2ch+as9Pbo35NjKP5b1+Ub1XZWEnwJTahqEfg@mail.gmail.com>
 <20161129215538.vhgmxpq4rasri4vm@sigill.intra.peff.net>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Wed, 30 Nov 2016 02:30:44 +0200
Message-ID: <CAOE4rSxLNh0eWndroNnWsutR3FfLa=QzKPwFPcKOhwSqkKtjLw@mail.gmail.com>
Subject: Re: Partial fetch?
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2016-11-29 23:55 GMT+02:00 Jeff King <peff@peff.net>:
> On Mon, Nov 28, 2016 at 10:34:51PM +0200, D=C4=81vis Mos=C4=81ns wrote:
>
>> I'm trying to fetch a remote repository over https but sadly it
>> timeouts too soon.
>>
>> $ git fetch -v upstream
>> POST git-upload-pack (gzip 1148 to 641 bytes)
>> POST git-upload-pack (gzip 1148 to 644 bytes)
>> [...]
>> Is there some way to fetch partially by smaller chunks and then repeat
>> that again till everything is fetched?
>
> Not an easy one. The series of POSTs is an indication that the fetch
> negotiation is going on for a long time, which probably means you have a
> lot of commits in your local repository that aren't in the remote, or
> vice versa.
>
> Here are the things I might try:
>
>   - git v2.10.2 has commit 06b3d386e (fetch-pack: do not reset in_vain
>     on non-novel acks, 2016-09-23), which may help with this.
>

That output and this is already with git v2.10.2

>   - HTTP, because the server is stateless, performs less well than other
>     protocols. If you can fetch over ssh or git://, it will probably
>     just work.
>

It's only available under https://git.replicant.us/replicant/frameworks_bas=
e.git

>   - If this is a one-time thing to fetch unrelated history from another
>     repository, you can "clone --mirror" instead of fetching,
>     then fetch from the mirror locally. Subsequent fetches should be
>     fast.
>

Looks like something is wrong with their server/setup since currently
even clone doesn't work for me.

 Cloning into bare repository 'frameworks_base.git'...
remote: Counting objects: 739930, done.
remote: Compressing objects: 100% (196567/196567), done.
error: RPC failed; curl 18 transfer closed with outstanding read data remai=
ning
fatal: The remote end hung up unexpectedly
fatal: early EOF
fatal: index-pack failed

But someone have made a mirror for it and there clone works only still
same issue with fetch.
Once I will have this cloned I will try local fetch.

Thanks!
