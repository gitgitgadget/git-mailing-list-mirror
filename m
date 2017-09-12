Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 019671FADE
	for <e@80x24.org>; Tue, 12 Sep 2017 16:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbdILQSg (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 12:18:36 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:38630 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbdILQSf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 12:18:35 -0400
Received: by mail-wr0-f175.google.com with SMTP id 108so23881733wra.5
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tYWbfR1x22ELLs/jq5iErVj6osXly6k/xwbKFHiWGg8=;
        b=aCxP7inOubFbNZrcVbqOb2tqriXCwr/ea0PEwTyEt6t49hHxxDu8invzL9FM4OUr50
         OIgEwdYOXXwPMGUUfE9q0RWM3YKsXMTDdtdk9vQygvbpy3a5NqVfQPzl6YujCFkFV5gn
         g1mIUYHQrOx4hPhD3xq+nqMqiNuhNPrfoHBYR3SnS0XTijJy9X+/kYpKA3+8fZqwGAKr
         neOXURbzy4UY+ivTe7JZPMC3S93nY0/Z/WeACmChDU5VIJGyCx9d9E/Usfn8HO9saOZi
         GDMegMBgAh/MtO09/JlhN4eyyoFZnqBv52X50rXZaG7upZ3GK1rWw/ETuHDwdTDsnsXC
         dIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tYWbfR1x22ELLs/jq5iErVj6osXly6k/xwbKFHiWGg8=;
        b=CNoMzrmCRKSMoHy8aEnHHIE3JAm9IyK31W4WwmdarUxpTHyIhHWNocC90HlbxqyiQK
         hshaWO4sgtbTLewg3EtDyo7xKFgLBjsPr49PUb9mLjdyky7HRwRLAky5IlM4/35zNy1y
         v8Zb3fx69h4gyaVTsmiCcgZAghMbj43c9Cwvozi+9SWWgZEt+I9zPa0wgQ1W5mWLcWWE
         dMPwaIMoxH0GphDUp4gXmc1CmBK5xTy9snyEyKRCtNEHfvHeK32Y8P5e8k7arQ+9hcbm
         9NA4unUuqt6ZkWG50VaxQ7a/7M/PsWfYzmNgzWFLJv8jgb1uXjQfRoyQ7yF34qvCwPNL
         qn5Q==
X-Gm-Message-State: AHPjjUh2v3L270ZVsVnIHYOixP63+pXnyeGIQCKmFJM9hMP98xuvaHcs
        Tiy44IKYACTmH6+WYkk=
X-Google-Smtp-Source: ADKCNb59UExjVl3pozPAlEoidBKV2ndo0AWshmUJVWzlln3ByqOBcCjt4/H0ybNKNbOuoA9bVP4XOw==
X-Received: by 10.223.198.82 with SMTP id u18mr13075810wrg.5.1505233114334;
        Tue, 12 Sep 2017 09:18:34 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 56sm10980953wrx.2.2017.09.12.09.18.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Sep 2017 09:18:33 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: SHA1 collision in production repo?! (probably not)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170331174515.j2ruifuigskyvucc@sigill.intra.peff.net>
Date:   Tue, 12 Sep 2017 18:18:32 +0200
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <512E7480-E923-4EBF-BA9D-1FEEB99B8BA6@gmail.com>
References: <4D74C1D4-9EA7-4A17-AFC5-0B54B4A6DD0E@gmail.com> <xmqqh929z6wl.fsf@gitster.mtv.corp.google.com> <20170331174515.j2ruifuigskyvucc@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 31 Mar 2017, at 19:45, Jeff King <peff@peff.net> wrote:
>=20
> On Fri, Mar 31, 2017 at 10:35:06AM -0700, Junio C Hamano wrote:
>=20
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>=20
>>> Hi,
>>>=20
>>> I just got a report with the following output after a "git fetch" =
operation
>>> using Git 2.11.0.windows.3 [1]:
>>>=20
>>> remote: Counting objects: 5922, done.
>>> remote: Compressing objects: 100% (14/14), done.
>>> error: inflate: data stream error (unknown compression method)
>>> error: unable to unpack 6acd8f279a8b20311665f41134579b7380970446 =
header
>>> fatal: SHA1 COLLISION FOUND WITH =
6acd8f279a8b20311665f41134579b7380970446 !
>>> fatal: index-pack failed
>>>=20
>>> I would be really surprised if we discovered a SHA1 collision in a =
production
>>> repo. My guess is that this is somehow triggered by a network issue =
(see data
>>> stream error). Any tips how to debug this?
>>=20
>> Perhaps the first thing to do is to tweak the messages in =
builtin/index-pack.c
>> to help you identify which one of identical 5 messages is firing.
>>=20
>> My guess would be that the code saw an object that came over the
>> wire, hashed it to learn that its object name is
>> 6acd8f279a8b20311665f41134579b7380970446, noticed that it locally
>> already has the object with the same name, and tried to make sure
>> they have identical contents (otherwise, what came over the wire is
>> a successful second preimage attack).  But your loose object on disk
>> you already had was corrupt and didn't inflate correctly when
>> builtin/index-pack.c::compare_objects() or check_collision() tried
>> to.  The code saw no data, or truncated data, or
>> whatever---something different from what the other data that hashed
>> down to 6acd8..., and reported a collision when there is no
>> collision.
>=20
> My guess is the one in compare_objects(). The "unable to unpack" error
> comes from sha1_loose_object_info(). We'd normally then follow up with
> read_sha1_file(), which would generate its own set of errors.
>=20
> But if open_istream() got a bogus value for the object size (but =
didn't
> correctly report an error), then it would probably quietly return 0
> bytes from read_istream() later.
>=20
> I suspect this may improve things, but I haven't dug deeper to see if
> there are unwanted side effects, or if there are other spots that need
> similar treatment.
>=20
> diff --git a/sha1_file.c b/sha1_file.c
> index 43990dec7..38411f90b 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2952,7 +2952,7 @@ static int sha1_loose_object_info(const unsigned =
char *sha1,
> 	if (status && oi->typep)
> 		*oi->typep =3D status;
> 	strbuf_release(&hdrbuf);
> -	return 0;
> +	return status;
> }
>=20
> int sha1_object_info_extended(const unsigned char *sha1, struct =
object_info *oi, unsigned flags)

Hi Peff,

we are seeing this now in Git 2.14.1:

...
error: inflate: data stream error (unknown compression method)
error: unable to unpack 7b513f98a66ef9488e516e7abbc246438597c6d5 header
error: inflate: data stream error (unknown compression method)
error: unable to unpack 7b513f98a66ef9488e516e7abbc246438597c6d5 header
fatal: loose object 7b513f98a66ef9488e516e7abbc246438597c6d5 (stored in =
.git/objects/7b/513f98a66ef9488e516e7abbc246438597c6d5) is corrupt
fatal: The remote end hung up unexpectedly

I guess this means your fix [1] works properly :-)

At some point I will try to explore a retry mechanism for these cases.

Cheers,
Lars

[1] =
https://github.com/git/git/commit/93cff9a978e1c177ac3e889867004a56773301b2=
