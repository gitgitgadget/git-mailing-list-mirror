Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DCC91FF6D
	for <e@80x24.org>; Sun, 18 Dec 2016 13:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932455AbcLRNMr (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Dec 2016 08:12:47 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:36338 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932335AbcLRNMr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2016 08:12:47 -0500
Received: by mail-wj0-f193.google.com with SMTP id j10so20253580wjb.3
        for <git@vger.kernel.org>; Sun, 18 Dec 2016 05:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lu6EqStce067FbvZa08mIvSUlr7Jz/mkHYKNxgLxbkI=;
        b=mGKkmC5sjpBQ7GvB54XMBX0pD+GLIBxQncjOSy+QgNGjHmiFO+oQyT73WA5OwktEdE
         HCEBO0HI4mS1VzLYfQjbKBJw9KRAozA1QuZKI1qnicF/PoaHZdDUKbk3Irp8xIuwHpTh
         ao3UabSoPvFwobzPUj015aMssN6J0Rf9KFLMJqvK+Hd5q1zRIGk/hvwZun0yDXFNkjIy
         WI1dD4lNaMbbB8t1EPcmHMPYhBydHwx5GG+POlB5aTILo6Ts5NhQKGuHv/PQJdjQ6/+p
         fQhYEURMChjnao+k1wiVxFfgSoLuE/JUrFWkJHZeZBgOeNwX4fFU0ckTwIxxCr8wTaGI
         WMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lu6EqStce067FbvZa08mIvSUlr7Jz/mkHYKNxgLxbkI=;
        b=fLmZxk/2W7q3qv61S8RnQZawRsHGN15D6PAMf2OW/34TN0bEQlm2g3GiBKpJZ9QaKO
         zaG6F8gGuXe4WUOEs600XmW368xeviKyIyCPtkBRrR0S3GE6yk60IzbiXryPJyJLVq69
         FtCkwl7Sf8xBmGUXw+quYE9MNX+pOMLTS11LtJq7/1CwSHo92H51g/n7BMVE7HZDDcJl
         vf5GHhRIyjNTJaeqwAaCXCrFzPDlJqO4GXaXQeWmwbeD1hQwVhD0hlPcQEnKJXZmBN/r
         9gyZaKVQgW/UJEdJrsntbSmM7kMUq6IQeqF44F9SSYeIWZVJ00WvIR16d32olscC2ZJd
         TgVg==
X-Gm-Message-State: AIkVDXJZnnuJpA0T5hY+DmBTW8HEcNEXuzYHGzk/CgsK2ewNBWsAwiG/WsZLC1ObFhqJqA==
X-Received: by 10.194.88.201 with SMTP id bi9mr9696697wjb.71.1482066765077;
        Sun, 18 Dec 2016 05:12:45 -0800 (PST)
Received: from slxbook4.fritz.box ([93.219.100.150])
        by smtp.gmail.com with ESMTPSA id d85sm12492374wmd.17.2016.12.18.05.12.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 05:12:44 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC/PATCH v3 00/16] Add initial experimental external ODB support
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAP8UFD2uyq3Uf1co_BUKJX_eogdCDJ30KJZmQ1BQXNQ1dw=w3A@mail.gmail.com>
Date:   Sun, 18 Dec 2016 14:13:11 +0100
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>, Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3819FEA8-BF58-47D3-B60D-2840062022B7@gmail.com>
References: <20161130210420.15982-1-chriscool@tuxfamily.org> <A5ABBF3E-BED9-4FF3-9DE5-B529DEF0B8E8@gmail.com> <CAP8UFD2uyq3Uf1co_BUKJX_eogdCDJ30KJZmQ1BQXNQ1dw=w3A@mail.gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 13 Dec 2016, at 18:20, Christian Couder =
<christian.couder@gmail.com> wrote:
>=20
> On Sat, Dec 3, 2016 at 7:47 PM, Lars Schneider =
<larsxschneider@gmail.com> wrote:
>>=20
>>> On 30 Nov 2016, at 22:04, Christian Couder =
<christian.couder@gmail.com> wrote:
>>>=20
>>> Goal
>>> ~~~~
>>>=20
>>> Git can store its objects only in the form of loose objects in
>>> separate files or packed objects in a pack file.
>>>=20
>>> To be able to better handle some kind of objects, for example big
>>> blobs, it would be nice if Git could store its objects in other =
object
>>> databases (ODB).
>> ...
>>=20
>> Minor nit: I feel the term "other" could be more expressive. Plus
>> "database" might confuse people. What do you think about
>> "External Object Storage" or something?
>=20
> In the current Git code, "DB" is already used a lot. For example in
> cache.h there is:
> ...

I am not worried about Git core developers as I don't think they would
be confused by the term "DB". I wonder if it would make sense to have
a clearer "external name" for the average Git user (=3D=3D non Git devs)=20=

or if this would create just more confusion.=20


>>> * Transfer
>>>=20
>>> To tranfer information about the blobs stored in external ODB, some
>>> special refs, called "odb ref", similar as replace refs, are used.
>>>=20
>>> For now there should be one odb ref per blob. Each ref name should =
be
>>> refs/odbs/<odbname>/<sha1> where <sha1> is the sha1 of the blob =
stored
>>> in the external odb named <odbname>.
>>>=20
>>> These odb refs should all point to a blob that should be stored in =
the
>>> Git repository and contain information about the blob stored in the
>>> external odb. This information can be specific to the external odb.
>>> The repos can then share this information using commands like:
>>>=20
>>> `git fetch origin "refs/odbs/<odbname>/*:refs/odbs/<odbname>/*"`
>>=20
>> The "odbref" would point to a blob and the blob could contain =
anything,
>> right? E.g. it could contain an existing GitLFS pointer, right?
>>=20
>> version https://git-lfs.github.com/spec/v1
>> oid =
sha256:4d7a214614ab2935c943f9e0ff69d22eadbb8f32b1258daaa5e2ca24d17e2393
>> size 12345
>=20
> Yes, but I think that the sha1 should be added. So yes, it could
> easily be made compatible with git LFS.

What do you mean with "the sha1 should be added"? Do you suggest to add
sha1 to GitLFS?


>>> Future work
>>> ~~~~~~~~~~~
>>>=20
>>> I think that the odb refs don't prevent a regular fetch or push from
>>> wanting to send the objects that are managed by an external odb. So =
I
>>> am interested in suggestions about this problem. I will take a look =
at
>>> previous discussions and how other mechanisms (shallow clone, bundle
>>> v3, ...) handle this.
>>=20
>> If the ODB configuration is stored in the Git repo similar to
>> .gitmodules then every client that clones ODB references would be =
able
>> to resolve them, right?
>=20
> Yeah, but I am not sure that being able to resolve the odb refs will
> prevent the big blobs from being sent.
> With Git LFS, git doesn't know about the big blobs, only about the
> substituted files, but that is not the case in what I am doing.

I think the biggest problem in Git are huge blobs that are not in the
head revision. In the great majority of cases you don't need these blobs
but you always have to transfer them during clone. That's what GitLFS
is solving today and what I hope your protocol could solve better in
the future!

Cheers,
Lars=
