Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 851EA20D2C
	for <e@80x24.org>; Mon,  5 Jun 2017 12:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbdFEMFA (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 08:05:00 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:36819 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdFEME7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 08:04:59 -0400
Received: by mail-wr0-f180.google.com with SMTP id v111so30507264wrc.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 05:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Y2INIxXxojrt8gg/wn0ld2Z13JI+9btV6B7BqDb6RDU=;
        b=QsZZd1UrdqvOHJ7mC8GDH9dZgqAkkjEpenllUnp8oNOCZ70ryC/sdvKGk4qL5MFZ8H
         3zmA2bT7FL5elIv7ZymqGSNrEqYq0wI/ZMiElGVyfjKnB57G0HUbWYqZmDLyjU0QaqKb
         FPNDLcbKbVwJ6pMksjNUyZ6mvNpjH99spb3Df1YwA79AyqC/h3E94PIW7d3IsCM+Jzus
         pgCaLlLfnttEwVwv7wXU695zS9iQgY2KpX3Zc19rdhF3D0TLC0Oglyjb8W/T3Q5xV3iL
         O/PoRKQd4Bar6ziqftdiCIXjcWVagXJPqZv0J2wxL0OhRTcvV4t6hrMuuWNI5cdWWG2H
         uDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Y2INIxXxojrt8gg/wn0ld2Z13JI+9btV6B7BqDb6RDU=;
        b=W4u+Mf2BMBLqaLaxmnAUkvqLrw787ErQKzgARxMBtXKUbtayBiCdKojlAaTqsB3wtZ
         ajWfrZfWUf3xEbuUrLdGOAm9wz2ZB5RowLir5ir+sf5v3YH4+b86XTjifWVTJpxSrFtI
         syqX1h9Xou4e0jDpg9Mw5TVnuBGL4bGDrIUpWJmbGx7kF9J7bOFLjBo3qFXPvQBAO73Z
         bbyw+xRaDm7/JCtDE+UaqXCDHXVLnRUWuF7t9+sPvcCe6LWDZrzw5VjwiCak/me7agvY
         AjxBf0TOI4srp2xMs3d0TgrXSCD6O5mICvcczapLKzsvtHCP6Jng5fa1E/JLNtu3pf5G
         LZ2Q==
X-Gm-Message-State: AODbwcDVijGcgh6RtHnp/JaTgDJjAG0KpEyTN4qPBEL9q3FSlxWab4gO
        3XjGWsmL7gXzDA==
X-Received: by 10.223.175.98 with SMTP id z89mr2706066wrc.22.1496664298347;
        Mon, 05 Jun 2017 05:04:58 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB44EB.dip0.t-ipconnect.de. [93.219.68.235])
        by smtp.gmail.com with ESMTPSA id h70sm14737236wma.14.2017.06.05.05.04.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 05:04:57 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: RFC: Would a config fetch.retryCount make sense?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <cf8ce12b-8d5a-ae03-efd8-0f82ea40fce7@gmail.com>
Date:   Mon, 5 Jun 2017 14:04:55 +0200
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9840A095-49EA-4B0C-B318-F86EEF9261B1@gmail.com>
References: <6762A30E-C558-4085-943B-AB85EBF18706@gmail.com> <cf8ce12b-8d5a-ae03-efd8-0f82ea40fce7@gmail.com>
To:     Ben Peart <peartben@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 01 Jun 2017, at 15:33, Ben Peart <peartben@gmail.com> wrote:
>=20
>=20
>=20
> On 6/1/2017 8:48 AM, Lars Schneider wrote:
>> Hi,
>> we occasionally see "The remote end hung up unexpectedly" =
(pkt-line.c:265)
>> on our `git fetch` calls (most noticeably in our automations). I =
expect
>> random network glitches to be the cause.
>> In some places we added a basic retry mechanism and I was wondering
>> if this could be a useful feature for Git itself.
>=20
> Having a configurable retry mechanism makes sense especially if it =
allows continuing an in-progress download rather than aborting and =
trying over.  I would make it off by default so that any existing higher =
level retry mechanism doesn't trigger a retry storm if the problem isn't =
a transient network glitch.

Agreed.


> Internally we use a tool =
(https://github.com/Microsoft/GVFS/tree/master/GVFS/FastFetch) to =
perform fetch for our build machines.  It has several advantages =
including retries when downloading pack files.

That's a "drop-in" replacement for "git fetch"?! I looked a bit through =
the=20
"git fetch" code and retry (especially with continuing in-progress =
downloads)=20
looks like a bigger change than I expected because of the current "die()=20=

in case of error" implementation.


> It's biggest advantage is that it uses multiple threads to parallelize =
the entire fetch and checkout operation from end to end (ie the download =
happens in parallel as well as checkout happening in parallel with the =
download) which makes it take a fraction of the overall time.

Interesting. Do you observe noticeable speed improvements with fetch =
delta updates,
too? This is usually fast enough for us.

The people I work with usually complain that the "clone operation" is =
slow. The
reason is that they clone over and over again to get a "clean checkout". =
I try=20
to explain to them in that case that every machine should clone only =
once and=20
that there are way more efficient ways to get a clean checkout.


> When time permits, I hope to bring some of these enhancements over =
into git itself.

That would be great!


- Lars=
