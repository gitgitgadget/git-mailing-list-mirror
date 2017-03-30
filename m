Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6098120966
	for <e@80x24.org>; Thu, 30 Mar 2017 20:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754650AbdC3Us4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 16:48:56 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33962 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754435AbdC3Usz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 16:48:55 -0400
Received: by mail-oi0-f45.google.com with SMTP id o67so43078710oib.1
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 13:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=IV0iU+CU0jKZqtU27L58M8S1bDeus7sRtg8NdaE5SNM=;
        b=siQJk1z2e0ZK9n/S4EwvEPCjrZjFgCfwPZZ87NXomqsv1w6M57ZYVQKDy50/0pboBs
         g+HI+oyW0SSo+kx2XDZwAKuYmZVB6R6IoCkuHLhwoNGySIamfR8LPk+mdo2qaD7adLk7
         IPb30jZX5vdZXXPMl7w0PkAd59CFRtN0sfEZOsQhXbzHfgXspAySW8a6cW6B5r85hFJi
         Rm141IpEI2ERkuBDeMq7IusMrtf6BFxpnMC+xJ3AU5fI7YWatCKw7p2O/MSUTTgkqPOE
         0sjLQFtNO3avSqSNxPm08ncc+NPW+4+08nISFUKvlktSqZG+cBHr1C2Jz+YRwKQMft4L
         3jYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=IV0iU+CU0jKZqtU27L58M8S1bDeus7sRtg8NdaE5SNM=;
        b=kHfqAhOga8wVN2lh+RhnzIILNVdfr11NCaPlffImyxrFRpyHynIumX9SeoUPskWzgc
         Swpi2za04PRQGQovyBQY1Xs7QMjqhE+rIZFBJH+5yV00/y7jejvE1qvJiwdD6CH00KUd
         dr3bhql8Ses2aSQTzY6mKl4I2P8kfaN5KbYMd55wdqQEzp4UMKp1yc+uTjXnb3o2Rd4Q
         3MZUExfNx3e8oRY8WMcDsCZRvd38Mk0LJ8iyZreOXe7MDkfpxAchvJsRdtl927Vf39Vy
         TwZ2OUjoTeHdiVNsySpQTVCcOI02WJYzy/lcHsoMn5Q5EY+BR3oslsQobBW3RLNjuodm
         7YUg==
X-Gm-Message-State: AFeK/H3jQ9B+GFLVImhwf4I5zrOAZ3qCrv7gJcEgeiWHKiqar6POARkzIXgxE7nkMv1bSw+RRaz2iBk1s1b4Vg==
X-Received: by 10.202.94.196 with SMTP id s187mr1250459oib.202.1490906933537;
 Thu, 30 Mar 2017 13:48:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.31.131 with HTTP; Thu, 30 Mar 2017 13:48:53 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <xmqqefxe33t5.fsf@gitster.mtv.corp.google.com>
References: <CAH8yC8kOj5a5PN4V7mj7xZPoNDr-MH-CkirxRKyfx1-qAvfpqQ@mail.gmail.com>
 <xmqqbmskatz3.fsf@gitster.mtv.corp.google.com> <CAH8yC8mMzZGebmZ23dsgY6Zkxk3w_Kpt7O6Z-0CwRQyTBF5uvg@mail.gmail.com>
 <xmqqefxe33t5.fsf@gitster.mtv.corp.google.com>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 30 Mar 2017 16:48:53 -0400
Message-ID: <CAH8yC8kxaecjJxZOsBHn1b0xNUqgtemSL+jTu3nZ8SwgSZfuVA@mail.gmail.com>
Subject: Re: git-compat-util.h:735:13: error: conflicting types for 'inet_ntop'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 4:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeffrey Walton <noloader@gmail.com> writes:
>
>> On Wed, Mar 29, 2017 at 1:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Jeffrey Walton <noloader@gmail.com> writes:
>>>
>>>> Some more 2.12.2 testing on Solaris 11.3 x86_64:
>>>>
>>>> $ make V=1
>>>> gcc -o credential-store.o -c -MF ./.depend/credential-store.o.d -MQ
>>>> credential-store.o -MMD -MP -I/usr/local/include -m64 -m64 -I.
>>>> -D__EXTENSIONS__ -D__sun__ -DUSE_LIBPCRE -I/usr/local/include
>>>> -DHAVE_ALLOCA_H -I/usr/local/include -DUSE_CURL_FOR_IMAP_SEND
>>>> -I/usr/local/include -I/usr/local/include -DNO_D_TYPE_IN_DIRENT
>>>> -DNO_INET_NTOP -DNO_INET_PTON  -DHAVE_PATHS_H -DHAVE_LIBCHARSET_H
>>>
>>> Looking at config.mak.uname, nothing in SunOS section seems to set
>>> NO_INET_NTOP or NO_INET_PTON.  Why is your build setting them?
>>
>> Thanks. It looks like the following is the culprit (from config.log).
>> Am I supposed to specify the socket library, or is Autotools supposed
>> to specify it?
>>
>> To date, I've been specify the libraries I request, like IDN2, PCRE,
>> cURL and OpenSSL.
>>
>> I don't recall specifying a socket library in the past, so I'm not
>> sure what is supposed to happen here.
>
> I'd be hated for saying this by many people, but my suspicion is
> that those who build Git are often better off ignoring the autoconf
> part of the build procedure, as it is my impression that ./configure
> we ship is not as well maintained as the Makefile.
>
> Looking through the first part of Makefile, I notice that INET_NTOP
> and INET_PTON bits are not described; we probably should add these
> two close to where we say "Define NO_IPV6 if you lack IPv6 support".

Lol... I avoid Autotools when I can, too.

In this case, since Git supplies Autotools and the fix looks easy,
maybe -lnsl -lsockets is the path to chose on Solaris. It ensures
things "just work" under the common case. It will avoid future
problems, and keep the mailing list dark and silent.

One other thing I try to engineer around... folks usually don't read
README's. I fell if README's were going to work, then it would have
happened by now in the last 40 or 50 years. Since the indicators tell
me they don't work, I don't depend on them.

I guess another option is to remove Autotools. I'm fine with using GNU
Make as the primary build system. But like you said, other folks may
want to tar and feather you for it.

Jeff
