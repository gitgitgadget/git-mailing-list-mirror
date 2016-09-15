Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09E932070F
	for <e@80x24.org>; Thu, 15 Sep 2016 20:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756087AbcIOUQo (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 16:16:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33300 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbcIOUQn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 16:16:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id b187so388396wme.0
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 13:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GMEefhF/g1dIUo+md3r8H7VIXYPivB6JSZP4yuZma1w=;
        b=xk5coH46e2NmWozeV9j8tya1xbzR5/VTULh0rtIa8ZLGs8y0nsHy3TQGCkYCN/RxLA
         Fzr3b+7yswRW8xwjEe4pIgAPAv6XTKczAcFV+g5yoSB3WZYJZ5NTpKkqbBxkAzAsWIed
         +M2UrECTvYVz67yeu2UIFSYlRUvdLH7BiLPVf1vUGIKEPZ3yfkoBVcaJm8S7lP7qyYXe
         jMPngWXxymErmSZbZsVkTqhmY74VfiwnE3DUcsig3d69lNJdCvZYmTGAK4MFJ28B7N/9
         xvNWQZP7vmhl8gzXwZqS/PEMPMZ8sPyZ9Y8LhL439r4IGuSG1girjDVHt0ectX7X4c/9
         G1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GMEefhF/g1dIUo+md3r8H7VIXYPivB6JSZP4yuZma1w=;
        b=WQSXmbEvqG3YqnScKt0y9jNhewP27Tu+DhgFsXA9ClPkBMtyIld8fSy5WWYLraM++P
         5JlnI2HKHP7lYYQpYtU7s733YmMT61KmxBxg69o3z+Qzof+cIbDJmh3Gai3THaX/mDus
         NcQGOonBbe6pwk31R8o3FCIbTKamG/vtJMW6GCASlulXz61rFohLjj0J74HTbUSV7acG
         BEtK5LnFSc5bhl72jgmIeLxwYxtuh0iYJuLIHEjP2qJ/SMAXp5dOa9rHhE0c/HTjqz6A
         AyxAObyy3H2d+MjtY/uVsbIH84i+1OsZSHD3P8PN2Sn4QsLFgIM/BflkB11tNYFtaJiL
         igWA==
X-Gm-Message-State: AE9vXwMKlKK59F5W4E3XjBxVm/+0gxp8jvu//dbcUGPziWtQr70+ErtzV02eSc0luzWEaw==
X-Received: by 10.28.103.133 with SMTP id b127mr4443895wmc.82.1473970601540;
        Thu, 15 Sep 2016 13:16:41 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB61FE.dip0.t-ipconnect.de. [93.219.97.254])
        by smtp.gmail.com with ESMTPSA id m5sm4460031wmd.1.2016.09.15.13.16.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Sep 2016 13:16:40 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 10/10] convert: add filter.<driver>.process option
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq8tuvx1sz.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 15 Sep 2016 22:16:41 +0200
Cc:     GIT Mailing-list <git@vger.kernel.org>, peff@peff.net,
        sbeller@google.com, Johannes.Schindelin@gmx.de, jnareb@gmail.com,
        mlbright@gmail.com, tboegi@web.de, jacob.keller@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <928655D2-312B-4805-99DB-E73448232B9A@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com> <20160908182132.50788-11-larsxschneider@gmail.com> <xmqq8tuvx1sz.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 13 Sep 2016, at 17:22, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> larsxschneider@gmail.com writes:
>=20
>> diff --git a/contrib/long-running-filter/example.pl =
b/contrib/long-running-filter/example.pl
>> ...
>> +sub packet_read {
>> +    my $buffer;
>> +    my $bytes_read =3D read STDIN, $buffer, 4;
>> +    if ( $bytes_read =3D=3D 0 ) {
>> +
>> +        # EOF - Git stopped talking to us!
>> +        exit();
>> +...
>> +packet_write( "clean=3Dtrue\n" );
>> +packet_write( "smudge=3Dtrue\n" );
>> +packet_flush();
>> +
>> +while (1) {
>=20
> These extra SP around the contents inside () pair look unfamiliar
> and somewhat strange to me, but as long as they are consistently
> done (and I think you are mostly being consistent), it is OK.

Ups. I forgot to run PerlTidy here. I run PerlTidy with the flag=20
"-pbp" (=3D Perl Best Practices). This seems to add no extra SP for
functions with one parameter (e.g. `foo("bar")`) and extra SP
for functions with multiple parameter (e.g. `foo( "bar", 1 )`).
Is this still OK?

Does anyone have a "Git PerlTidy configuration"?


>=20
>> +#define CAP_CLEAN    (1u<<0)
>> +#define CAP_SMUDGE   (1u<<1)
>=20
> As these are meant to be usable together, i.e. bits in a single flag
> word, they are of type "unsigned int", which makes perfect sense.
>=20
> Make sure your variables and fields that store them are of the same
> type.  I think I saw "int' used to pass them in at least one place.

Fixed!


>> +static int apply_filter(const char *path, const char *src, size_t =
len,
>> +                        int fd, struct strbuf *dst, struct =
convert_driver *drv,
>> +                        const int wanted_capability)
>> +{
>> +	const char* cmd =3D NULL;
>=20
> "const char *cmd =3D NULL;" of course.

Fixed!


>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index 11c37fb..f6798f8 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -10,6 +10,7 @@
>> #include "attr.h"
>> #include "split-index.h"
>> #include "dir.h"
>> +#include "convert.h"
>>=20
>> /*
>>  * Error messages expected by scripts out of plumbing commands such =
as
>=20
> Why?  The resulting file seems to compile without this addition.

Of course. That shouldn't have been part of this commit.


Thank you,
Lars




