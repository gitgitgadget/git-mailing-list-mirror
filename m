Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC75B1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 18:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755942AbeDYStt (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 14:49:49 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43123 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755295AbeDYSts (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 14:49:48 -0400
Received: by mail-pf0-f195.google.com with SMTP id j11so15985135pff.10
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 11:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HYZ3QvD+g1OBO08lT+Lf2zZTMHZ+3Igm3J/Z307/I+Y=;
        b=bVLEDXyXNXINsuUMmX7dpoUaqZ1P2S9QDm3V6nlGdw1sPjGIlcYDo4brQYzzAp3pct
         lj1/keHH0HAR6+m9HFAjoyYShwev2/aS3zTufuFDC8w7FsYMPlmZFmERFtHoQSpg1/fn
         RDEGsSYQVG5n1d0I87tiTICtYDpc/2YP70O2Nn7rdgvDczJFR+hXHYGUkT2t6bL9q8b7
         mBpJ87ACpbVXX/vL02xvEeKYyn8XGlizae04pg2xn6oqjUPZh77dIEcMWEvHmG5ASeST
         rSGNueVYRkzo6HfFKabxDW4bydPPJTml6escGSYQU2ltCTPtIEbxcg75S4y0AEXRoxE4
         LkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=HYZ3QvD+g1OBO08lT+Lf2zZTMHZ+3Igm3J/Z307/I+Y=;
        b=B6I5aKgjLOxzXg9tzGckL7yfRcxN34llxx2fKLkDSblhl9fLZ1cyObexGvkT4zVuM9
         1ADNNTT0yQh785NDrHdsgVEv2xFcsgcxmWVBJlDCI7M3b8/+d6ggQ5RsjBFu2fqWrgfP
         yQKiQoI1QHgL8vmf7ETYs2y4f7MiYGrjF5M161xW1OevUfkjI4pKMkvf9nwEJVZMnZpY
         Xpo5jOwGaVhwTXueckXj4p0g3B9yLdT/82/mwM6reQOWirZGYqm/Z8Gayz2sIoRTlc5e
         u7P4sQ6ekMZuq0MzL3CInol6Mmjx/qKOf4FnJSriXUqNDDvzgeuWyffSi3DuHidAKehz
         cBhA==
X-Gm-Message-State: ALQs6tDh6Pd3fbN7hgxF9WYOCxUvSLW6QkG3Csz6rDZK4t91J6kZFoX0
        j6/nQWWmqt92lbDpjljffgRnznw+K4JKvppPXLuPOIyJ
X-Google-Smtp-Source: AIpwx4+tDNI3nXjzN+1rHo48ZYDG+iupBqxG6yaysS3xET9/b2c/+Khj0F2EIUsHDqhw25wBcUEGoXTEovmpQbrLqbg=
X-Received: by 2002:a17:902:284b:: with SMTP id e69-v6mr29667579plb.240.1524682188475;
 Wed, 25 Apr 2018 11:49:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Wed, 25 Apr 2018 11:49:47 -0700 (PDT)
In-Reply-To: <20180424235150.GD245996@genre.crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-19-sandals@crustytoothpaste.net> <CAN0heSouHbAj8TbiROe=XRsBJ788Vi6P4a_Wvv=7OrdsXqQXHw@mail.gmail.com>
 <20180424235150.GD245996@genre.crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 25 Apr 2018 20:49:47 +0200
Message-ID: <CAN0heSqpj9JfTrnMFRbquraxve9iTwoowgWRUhcD-gXHMg3V=g@mail.gmail.com>
Subject: Re: [PATCH 18/41] index-pack: abstract away hash function constant
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25 April 2018 at 01:51, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Tue, Apr 24, 2018 at 11:50:16AM +0200, Martin =C3=85gren wrote:
>> On 24 April 2018 at 01:39, brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>> > The code for reading certain pack v2 offsets had a hard-coded 5
>> > representing the number of uint32_t words that we needed to skip over.
>> > Specify this value in terms of a value from the_hash_algo.
>> >
>> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>> > ---
>> >  builtin/index-pack.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/builtin/index-pack.c b/builtin/index-pack.c
>> > index d81473e722..c1f94a7da6 100644
>> > --- a/builtin/index-pack.c
>> > +++ b/builtin/index-pack.c
>> > @@ -1543,12 +1543,13 @@ static void read_v2_anomalous_offsets(struct p=
acked_git *p,
>> >  {
>> >         const uint32_t *idx1, *idx2;
>> >         uint32_t i;
>> > +       const uint32_t hashwords =3D the_hash_algo->rawsz / sizeof(uin=
t32_t);
>>
>> Should we round up? Or just what should we do if a length is not
>> divisible by 4? (I am not aware of any such hash functions, but one
>> could exist for all I know.) Another question is whether such an
>> index-pack v2 will ever contain non-SHA-1 oids to begin with. I can't
>> find anything suggesting that it could, but this is unfamiliar code to
>> me.
>
> I opted not to simply because I know that our current hash is 20 bytes
> and the new one will be 32, and I know those are both divisible by 4.  I
> feel confident that any future hash we choose will also be divisible by
> 4, and the code is going to be complicated if it isn't.
>
> I agree that pack v2 is not going to have anything but SHA-1.  However,
> writing all the code such that it's algorithm agnostic means that we can
> do testing of new algorithms by wholesale replacing the algorithm with a
> new one, which simplifies things considerably.

Ok. I do sort of wonder if a "successful" test run after globally
substituting Hash-Foo for SHA-1 (regardless of whether the size changes
or not) hints at a problem. That is, nowhere do we test that this code
uses 20-byte SHA-1s, regardless of what other hash functions are
available and configured. Of course, until soon, that did not really
have to be tested since there was only one hash function available to
choose from. As for identifying all the places that matter ... no idea.

Of course I can see how this helps get things to a point where Git does
not crash and burn because the hash has a different size, and where the
test suite doesn't spew failures because the initial chaining value of
"SHA-1" is changed.

Once that is accomplished, I sort of suspect that this code will want to
be updated to not always blindly use the_hash_algo, but to always work
with SHA-1 sizes. Or rather, this would turn into more generic code to
handle both "v2 with SHA-1" and "v3 with some hash function(s)". This
commit might be a good first step in that direction.

Long rambling short, yeah, I see your point.

Martin
