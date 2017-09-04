Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60997208CD
	for <e@80x24.org>; Mon,  4 Sep 2017 13:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753606AbdIDNBK (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Sep 2017 09:01:10 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38351 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753598AbdIDNBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2017 09:01:09 -0400
Received: by mail-it0-f67.google.com with SMTP id z81so130328itb.5
        for <git@vger.kernel.org>; Mon, 04 Sep 2017 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fSuaph+aMXTCoeRm3A9TgPWvQyMOeKgESKnkShpht1A=;
        b=g6/Jdf+kiWoz/bqgoFbzqXbILRiLckIPp/RC5t3kmQ78F2xEByIVZqk/NJ8S4WbdYS
         u/evf9X7SL1cjmP2cTaECSgunkJGpgj0uNIsupYmZyemND7bkK64KKezafDOwdq+Aed5
         8wq4CnSjGHKINXGsDIrBwpSoLNWSM9C2CLekrkNMXZC1VO+LnmNoX/A9NJXHbDfdVl2v
         7DFOr+ALci7w3MTFsK8M4YuCRNHeSSClSkXljDnTuIl23rt11w1m5sW/m+0OvVw+2GxD
         meHjzGEZuJ0omf0SPRsPYz34Gw/lNc8GKioSFWpS3DZQeXx4zn5ynVHdAps0rgBBLmeV
         giNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fSuaph+aMXTCoeRm3A9TgPWvQyMOeKgESKnkShpht1A=;
        b=jg8kvOSrmFXEUktzqZbxfmVcPg+9J9FWN6iVc7+WyB0ipaMuC/Z2jF1CuDoFjKvHLK
         UJovEgZAqIBgKhvZv9Z0cRQaInJnpWjC+wbJuiVxlN+wDe9gE7A/vpCoGTV9h5ySXvLq
         OtH63j6D+cKT36J+4XupwDdbc7fZ+ZNRNJV/Nj8n+H/y79eM3+0QhZ8/ATnNjnT0Tpvq
         EphgVfQlS0aWJ7f+koaRhGWahe13V5qOceB6ipj7mIxYM6refMPygL6JA5vXtl2RnyTk
         Xpg+ySy0TgfXVQkdYuWfBR6wN2pvHNNs/vLaQPyw244jLazl6q0tk0X2gx5+pAcb6ZRs
         zzXQ==
X-Gm-Message-State: AHPjjUiSSIGHKYhnH4KakvUFRDmiGbULp7Xodk/1WwWs7wbmg/r03du6
        I/fxpBYk4nVD3otjKO6CQWFKxNCGZg==
X-Google-Smtp-Source: ADKCNb4j59Eb/LGOFmQw7Fg2h54us8zgSzWRSemKTpTetcuBw1gw19GZ4bJ8yIn6o4zO2GTWcZTIw+0W1YApkFxHQpI=
X-Received: by 10.36.69.104 with SMTP id y101mr349428ita.37.1504530068804;
 Mon, 04 Sep 2017 06:01:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.165.25 with HTTP; Mon, 4 Sep 2017 06:01:08 -0700 (PDT)
In-Reply-To: <20170901212620.w4ml5umoydbtuspw@sigill.intra.peff.net>
References: <CAC-YKd1sTQLMUZ6k+-4K09=NOa_HaOf1gp8H51VNZjziUrxOfA@mail.gmail.com>
 <20170901212620.w4ml5umoydbtuspw@sigill.intra.peff.net>
From:   "josephpattara ." <josephpattara@gmail.com>
Date:   Mon, 4 Sep 2017 14:01:08 +0100
Message-ID: <CAC-YKd0dDDJ_YkT=+Euqc=AMuTYobV-dWdKHkA5SgKJVKwMeug@mail.gmail.com>
Subject: Re: HP-UX (git-2.14.0) Depot File / Source Code Build throws SHA1 Error
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Jeff,

Your information was very useful.

Firstly, I could see the SHA1 hash was definitely wrong.
-bash-4.3$ echo foo | ./git hash-object --stdin
408935f8873a5ef17ef10cf2a316e51937e90f0b

I attempted to build the code with OPENSSL_SHA1=Yes and the build is
working and I am able to do a git clone from my HP-UX machine. I still
used the adapted source code HPUX connect website.
I am wondering whether the package which was committed to the HPUX
site (http://hpux.connect.org.uk/) did ever worked for any one as it
was the same SHA1 error I was getting when I installed that depot
file. My HPUX architecture is below:

HP-UX hepscott B.11.31 U ia64 2256017764 unlimited-user license

But I can confirm with the adapated source code from HPUX connect and
using the  OPENSSL_SHA1=Yes I am able to build a working git locally.


Thanks a lot.
Kind Regards,
Joseph

On Fri, Sep 1, 2017 at 10:26 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 01, 2017 at 03:04:36PM +0100, josephpattara . wrote:
>
>> Dear HP-UX Git Maintainers,
>>
>> Sending this email as I was trying to use the HP-UX depot file which
>> was recently committed to the
>> http://hpux.connectinternetsolutions.com/hppd/hpux/Development/Tools/git-2.14.0/.
>> I tried to use the depot file and also attempted to build the code
>> from the adapted source code (using native HP-UX compiler as mentioned
>> in Installation Note) from the website.
>
> I don't know anything about HP-UX, but I can tell you a few things from
> the Git side...
>
>> But unfortunately both of them failed with an error:
>>
>> Cloning into xxxx...
>> remote: Counting objects: 19813, done.
>> remote: Compressing objects: 100% (9124/9124), done.
>> remote: Total 19813 (delta 10340), reused 16358 (delta 8293)
>> Receiving objects: 100% (19813/19813), 6.07 MiB | 9.72 MiB/s, done.
>> fatal: pack is corrupted (SHA1 mismatch)
>> fatal: index-pack failed
>
> Assuming there's no corruption happening on the network, it looks like
> there's a bug in the SHA-1 routines of your build. One very basic check
> would be to run:
>
>   echo foo | git hash-object --stdin
>
> which should produce:
>
>   257cc5642cb1a054f08cc83f2d943e56fd3ebe99
>
> (If it does that's not a guarantee that there aren't problems with more
> complex inputs, but if it produces a different sha1 that's a clear sign
> of a sha1 issue).
>
>> Looking at the dynamic link I can see the below:
>>
>> _HP_DLDOPTS="-ldd" /usr/bin/git
>>   /usr/lib/hpux32/libpthread.so =>        /usr/lib/hpux32/libpthread.so
>>   libpthread.so.1 =>      /usr/lib/hpux32/libpthread.so.1
>>   libz.so =>      /usr/local/lib/hpux32/libz.so
>>   libiconv.so =>  /usr/local/lib/hpux32/libiconv.so
>>   libintl.so =>   /usr/local/lib/hpux32/libintl.so
>>   libc.so.1 =>    /usr/lib/hpux32/libc.so.1
>>   libdl.so.1 =>   /usr/lib/hpux32/libdl.so.1
>>
>>   Until recently we were using the older GIT version for HP-UX 1.8.5.3
>> and I can see the older GIT had a dynamic link for libcrypto.so.
>
> Git can build against several SHA-1 implementations. In v2.13 and up,
> the default is the collision-detecting version publicized as part of the
> SHAttered attacks earlier this year. We have had a few problems with it
> misbehaving on uncommon platforms or compilers, so it seems a likely
> candidate here.
>
> You can try building with "make OPENSSL_SHA1=Yes" to use openssl instead
> of the collision-detecting version. You can also try "make BLK_SHA1=Yes"
> if you have trouble building against openssl for whatever reason.
>
>> The clarification I have is
>> 1. Is the version 2.14.0 from HPUX connect is it really usable (depot
>> file and also the source code)
>
> That I don't know. I took a peek at the diff between their source and a
> pristine v2.14.0 tarball, and I don't see anything too exotic. So you
> could try the upstream code from:
>
>   https://www.kernel.org/pub/software/scm/git/git-2.14.1.tar.gz
>
> but I suspect the problem would still exist.
>
>> 2. Was it deliberate to remove the openssl linkage from the new GIT or
>> am I really missing any special configure or build flags to enable the
>> libcrypto.so linkage.
>
> Yes, the default flipped but you can still change it. See above.
>
>> 3. Is the SHA1 error which I get is it really to do with the missing
>> libcrypto.so or I am on a wrong inference track?
>
> I think it's likely that you're on the right track.
>
> -Peff
