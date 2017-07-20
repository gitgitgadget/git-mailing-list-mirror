Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52BC20387
	for <e@80x24.org>; Thu, 20 Jul 2017 08:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933720AbdGTIcV (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 04:32:21 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35149 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933311AbdGTIcF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 04:32:05 -0400
Received: by mail-wm0-f49.google.com with SMTP id w126so17957454wme.0
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 01:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QE5qDPhBoeidklkk2xscl4ul9P2CsOS9Sp5k4S9WI5g=;
        b=fqdZVfN3xozW19TmKw9+njN3Mm/evaGKDWaSFT8S17rFTNkH4ee0QRVmTXb9E6QM27
         REwp0oUZmBXHp+B/+svz68lCWmZ8Ust61CEavxpD4cLRzvmhuDQrtDyuou1xdI87hyjB
         Tp45hQOsjEQvxXcxrPZzcyLjYcsWjqHDLLRjj3+UsxPQw9Fu36VGodAwhJEVZzzFTdMr
         7Q/hBHt4E7NbOokYW2863L6uUdb/o3vkMe3OI7PqlTR7WWzkzwro+4EkhpPGCSDhyNwA
         s9Z/biCGcUmpGpYy6QTkToUzhrzJOVeeZG1mS+Gpvh6EK6LqXDcE/gGrwuEhhicf207I
         fj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QE5qDPhBoeidklkk2xscl4ul9P2CsOS9Sp5k4S9WI5g=;
        b=FhiN4umfUFqhjA3stubiEZNW+fNa2KPb+CT2oyXABFRKMtzW0SCf7me6Y/wWGLu75B
         jekn9kIuItgQ263UTay6mqa9npGuCgB10xuLuwpxvQkCCXR4fIrrUQbZIAxDpdnpapla
         N3v6tZ3mxU2Zkhll+4tHXJiXenJy6KyO13Zt4o48NAcVMslrOTnmk8K2AISJ0SqJVZfE
         LrBumUB4bJrrsatSINvQwSPTQ8SA06RO9Md60pyyP642fQP3l/QWeCSbIIxKM0PXVLeG
         3qgxwV6zx9KWWmg2mhTSEsDC9bwRRTfCWG5WeqBqES0UoJP8SU95itRwv3xRuGGxFbjP
         XakA==
X-Gm-Message-State: AIVw112oIMoCdF5yV5WuYugEwWi3YYrHGyx4n3e8tzvr6L2Pyvn822lK
        9sqYeWhH7obXhEOS5xA=
X-Received: by 10.28.236.219 with SMTP id h88mr1555339wmi.143.1500539524365;
        Thu, 20 Jul 2017 01:32:04 -0700 (PDT)
Received: from rempc0k844e.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id l1sm1821997wmb.18.2017.07.20.01.32.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jul 2017 01:32:03 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Binary files
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAFc9kS_xYVyPsW7qogDxLugxBb1p2vEFAoP=W9Rdnfqs6XtWKQ@mail.gmail.com>
Date:   Thu, 20 Jul 2017 10:32:03 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C4E3445-7268-47CA-A6D4-514A8EA348AA@gmail.com>
References: <CAFc9kS8L-JJoJqKi7bB90qwKVW8gB=EFk9D8c=4YShqnamwa2w@mail.gmail.com> <CAFc9kS_xYVyPsW7qogDxLugxBb1p2vEFAoP=W9Rdnfqs6XtWKQ@mail.gmail.com>
To:     Volodymyr Sendetskyi <volodymyrse@devcom.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 20 Jul 2017, at 09:41, Volodymyr Sendetskyi =
<volodymyrse@devcom.com> wrote:
>=20
> It is known, that git handles badly storing binary files in its
> repositories at all.
> This is especially about large files: even without any changes to
> these files, their copies are snapshotted on each commit. So even
> repositories with a small amount of code can grove very fast in size
> if they contain some great binary files. Alongside this, the SVN is
> much better about that, because it make changes to the server version
> of file only if some changes were done.
>=20
> So the question is: why not implementing some feature, that would
> somehow handle this problem?
>=20
> Of course, I don't know the internal git structure and the way of
> working + some nuances (likely about the snapshots at all and the way
> they are done), so handling this may be a great problem. But the
> easiest feature for me as an end user will be something like
> '.gitbinary', where I can list binary files, that would behave like on
> SVN, or even more optimal, if you can implement it. Maybe there will
> be a need for separate kinds of repositories, or even servers. But
> that would be a great change and a logical way of next git's
> evolution.

GitLFS [1] might be the workaround you want. There are efforts to bring=20=

large file support natively to Git [2].

I tried to explain GitLFS in more detail here:=20
https://www.youtube.com/watch?v=3DYQzNfb4IwEY

- Lars


[1] https://git-lfs.github.com/
[2] =
https://public-inbox.org/git/20170620075523.26961-1-chriscool@tuxfamily.or=
g/

