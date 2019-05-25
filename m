Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A7081F462
	for <e@80x24.org>; Sat, 25 May 2019 13:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfEYN1Q (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 May 2019 09:27:16 -0400
Received: from mout.web.de ([212.227.15.3]:48969 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfEYN1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 May 2019 09:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1558790825;
        bh=Ohe4xfnup669M8ukZ9FU1zbKRCk6E5SdPWe8UvxYB+4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KHJLqlKMFFPui0mcSZvsMV8h93LEHGPDQ7yqohr31SL6BC1RCXu50XHeK4lhseFlQ
         t6Zauazyq9yx7TnyFm1JdZx/aloohoU/+y69Afa8BWAqN6LvBBWaSdKw8F0H58ZrZR
         nl17LxoQDq7uUddj8l1mz9an08p1OpyOXn6uy4C8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.20.65]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWBA1-1h62tM3Kob-00XHyA; Sat, 25
 May 2019 15:27:05 +0200
Subject: Re: git archive generates tar with malformed pax extended attribute
To:     Jeff King <peff@peff.net>,
        Keegan Carruthers-Smith <keegan.csmith@gmail.com>
Cc:     git@vger.kernel.org
References: <CAMVcy0Q0TL6uEGR2NeudJrOiXdQ87XcducL0EwMidWucjk5XYw@mail.gmail.com>
 <20190524070644.GF25694@sigill.intra.peff.net>
 <CAMVcy0ThtcDNjqat0+nQ4B91hC30NTUe=RW8v9WDxA2Q-4SyRA@mail.gmail.com>
 <20190524081337.GA9082@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b4aaff4b-eaf7-9eaf-063f-42c073078060@web.de>
Date:   Sat, 25 May 2019 15:26:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524081337.GA9082@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j64OiUIZq9ac0QuRlhjmg2GJs7//O55lne7oq/9dDMKyX5HJCyA
 KITnWyd3ACdqEfp62LCv1ah4CdL5kaU4lpYmD7CB9/6FUvoET/QIttzrZLzP7kkudNxyZgW
 O9cxsQXbOZe1S3oy7YZ4DWpxt0v6u4u4NMNOBplGJBQKBISfvxK5b8W/gl9BVYiqbFyqEMa
 oJF27vF4S8L19meagP9HA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8WbFMSpbF5Q=:gd6JRRvCnUxRJSUhMP/LvE
 7MQymxxczIYcdjWgDeOdRHeHZvZ7+q7BlOAxUSQ9bjRWiWXyccWSuDsxro0viBjKilIl2HhpO
 W57bcnodG/zHgUNvwmoxmUrlB2pn/VU80bKaMnxv/fRtKAWvC0gPY3AwHM8AVp3TNF19Gd7Qi
 KY1FKrEq3M+Ilmq/ZQORoLEsxqysBuKBWS5+SJRiJkMl+hs3rWPBwJakVNWU9aWukfLllLcnC
 dPWngfIfSC+SS38rKbo0Yt/mDaoKhJHAKENNNXBoVPCxkIzMHS90jaXQxNNxkhCjzPK31xJum
 8mjvnI8D/LYM6W4wn6tH51QoGbGoO8xCgE1QsgEfy4zb13mldhsaV5Q9HVPZEs48hQzZeOGeU
 SAZ5CYuCj4/pobMFR+1OlC6e8Z5rvMjn5r4BoT2vjNAM7vZpg3cknxWLd5UkTjfq6vw4L3awB
 dsZUEbc8nDyH/T+0JlVzkmsqk/DU5ZPXty1NbXL9ARfNJQKzm12u2Fs/v1stGrUvn25Tyxg3P
 figcZTz9EtXiVxnHfHqxEgKQutHij6hRtPC0iAzCwKfxMC++CTvutU5E3n1UnsZ1i+5joBUHx
 D8q1jIejlLk07my6iRBu3QU+WZvHp6VcDOTWzm/nzWCjjbgwoWHNvIcQharCf7WCqLmhO9J7K
 V6rs3qG2Qn5FDNTasOSr4Bt2YwS7JoxFRRLb7R3tIYkYTCOvwwEFgOs09PixZ2lk+yKLvE7Lg
 K26hygPxpoxSCReNkbTJ0Ye6mdQXXNbfEmFy3E0gRu5E7qeuPMId33eqlC0hrGsKV3JuWEziB
 OKrSMY7RmfkkczFfzYtgLpoP7o+FW6c2dFZ1xzE176z8usefHEhh5NgoXmJDyGI4jvR3EuYR2
 KB7Q8vuiSox5hnlpEf93UvaD0G5ESsepaXxkkYOAS4EiZmKG+K6du0bBjdorqwbA4WJ/3AAWV
 R1DlM3BMcKt6YAWlbcCyjQfMVc7muAE0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.05.19 um 10:13 schrieb Jeff King:
> On Fri, May 24, 2019 at 09:35:51AM +0200, Keegan Carruthers-Smith wrote:
>
>>> I can't reproduce on Linux, using GNU tar (1.30) nor with bsdtar 3.3.3
>>> (from Debian's bsdtar package). What does your "tar --version" say?
>>
>> bsdtar 2.8.3 - libarchive 2.8.3
>
> Interesting. I wonder if there was a libarchive bug that was fixed
> between 2.8.3 and 3.3.3.
>
>>> Git does write a pax header with the commit id in it as a comment.
>>> Presumably that's what it's complaining about (but it is not malformed
>>> according to any tar I've tried). If you feed git-archive a tree rathe=
r
>>> than a commit, that is omitted. What does:
>>>
>>>   git archive --format tar c21b98da2^{tree} | tar tf - >/dev/null
>>>
>>> say? If it doesn't complain, then we know it's indeed the pax comment
>>> field.
>>
>> It also complains
>>
>>   $ git archive --format tar c21b98da2^{tree} | tar tf - >/dev/null
>>   tar: Ignoring malformed pax extended attribute
>>   tar: Error exit delayed from previous errors.
>
> Ah, OK. So it's not the comment field at all, but some other entry.
>
>> Some more context: I work at Sourcegraph.com We mirror a lot of repos
>> from github.com. We usually interact with a working copy by running
>> git archive on it in our infrastructure. This is the first repository
>> that I have noticed which produces this error. An interesting thing to
>> note is the commit metadata contains a lot of non-ascii text which was
>> my guess at what my be tripping up the tar creation.
>
> Yeah, though the only thing that makes it into the tarfile is the actual
> tree entries. I'd imagine the file content is not likely to be a source
> of problems, as it's common to see binary gunk there. Most of the
> filenames are pretty mundane, but this symlink destination is a little
> funny:
>
>   $ git archive ... | tar tvf - | grep nicovideo4as.swc
>   lrwxrwxrwx root/root         0 2019-05-24 03:05 libs/nicovideo4as.swc =
-> PK\003\004\024
>
> That's not the full story, though. It is indeed a symlink in the
> tree:
>
>   $ git ls-tree -r HEAD libs/nicovideo4as.swc
>   120000 blob ec3137b5fcaeae25cf67927068af116517683806	libs/nicovideo4as=
.swc
>
> But the contents of that blob, which should be the destination filename,
> are definitely not:
>
>   $ git cat-file blob ec3137b5f | wc -c
>   57804
>   $ git cat-file blob ec3137b5f | xxd | head -1
>   00000000: 504b 0304 1400 0800 0800 5069 694e 0000  PK........PiiN..
>
> There's quite a bit more data there. And what tar showed us goes up to
> the first NUL, which does not seem surprising.

That (the symlink target) is a ZIP file with the following contents:

 Length   Method    Size  Cmpr    Date    Time   CRC-32   Name
=2D-------  ------  ------- ---- ---------- ----- --------  ----
   39733  Defl:N     3403  91% 2019-03-09 13:10 489e1be1  catalog.xml
   54131  Defl:N    54151   0% 2019-03-09 13:10 32f57322  library.swf
=2D-------          -------  ---                            -------
   93864            57554  39%                            2 files

And link targets longer than 100 characters are encoded in an extended
Pax header.

(Usually symlink targets are paths, not file contents.)

> It's possible Git is doing the wrong thing on the writing side, but
> given that newer versions of bsdtar handle it fine, I'd guess that the
> old one simply had problems consuming poorly formed symlink filenames.

Git preserves symlink targets with embedded NULs in the repository and
in generated tar files.  Not sure if GNU tar and bsdtar truncating them
at the first NUL is a bug.  I'm also not sure if there is a platform
that would allow creating such a symlink in the file system, or how one
is supposed to use it.

We could truncate symlink targets at the first NUL as well in git
archive -- but that would be a bit sad, as the archive formats allow
storing the "real" target from the repo, with NUL and all.  We could
make git fsck report such symlinks.

Can Unicode symlink targets contain NULs?  We wouldn't want to damage
them even if we decide to truncate.

Ren=C3=A9
