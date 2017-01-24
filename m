Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 824592092F
	for <e@80x24.org>; Tue, 24 Jan 2017 09:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750739AbdAXJtI (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 04:49:08 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36748 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbdAXJtH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 04:49:07 -0500
Received: by mail-wm0-f65.google.com with SMTP id r126so33345920wmr.3
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 01:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aXtJiqqM1XB9c6pXhIJ+JAyLy/8QtYZnwDdJfojR9K0=;
        b=s/QSg4Z1vYL5CbgHZ79YoBmVpNWJHW9MSLdt5RkCEovvj98MMwZwQWSphnvSgmiMul
         K01wjUGzSQm/HcqaAkBGal0uwS0BAPgwK3fKXTw4GpJj/RUUqw5F9l8Io4oJL691YxRZ
         zT8+YqKByTwXB5JRO3GK/dgD8VsVtShLt4SW7KMOr0u7xjBZJ7FFKXwRR70U29FHJTAK
         ON7cgvISUaVXlHRRyxUzd/6PD3bDBG0/PeErf7HBh45XVekMeGNd+VTsFQ7ND+7Ng9Ma
         e3mnbh7PPSm1BsoB6PwbFDGM8durW4lCzueXYqAsSKX03caI6dt2ULdpEbhEoBy3yzg0
         6aYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aXtJiqqM1XB9c6pXhIJ+JAyLy/8QtYZnwDdJfojR9K0=;
        b=HgHEJniF9VFbH5b390P2N9jIdToWTM8Fgou0DxC3Hkz/ARRWvIRUCANO3fAEqQtXrw
         7YI+gEGYrAHcmg7Cas5oNEIey6ibcFJ6c0FhZf4uZjCpMsFAl6g2xQDbXara7K8KX7u5
         +GZDVoZPS5sho0aRlxsmkcx5uFmD1dwqbXFPwU7MJH5OjnaZUYcGBPnz8hWLXHWIh+Hk
         Z06GvRzj8UxPQvKF2eS3ebKhx8GiF+ZS6v0juVXIndJf59mDh04yzDG3ihdvf2rIdBMk
         tWWEGw5EXv+lwXxzZNdnRXXeaKYXS/uu41+TQyaf+O7JOV81tG/JQXK+27Qfv9mUvIV6
         tMag==
X-Gm-Message-State: AIkVDXIi9H3yI4UYC3/XOftR8HBRW0Xi4Y1p/JOwl/WkdVOOZGRU7MQaw38G6mgS60yPEQ==
X-Received: by 10.28.13.16 with SMTP id 16mr16339071wmn.101.1485251345438;
        Tue, 24 Jan 2017 01:49:05 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB584B.dip0.t-ipconnect.de. [93.219.88.75])
        by smtp.gmail.com with ESMTPSA id x25sm19051690wrx.27.2017.01.24.01.49.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Jan 2017 01:49:04 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC] Case insensitive Git attributes
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqwpdlr2ht.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 24 Jan 2017 10:49:03 +0100
Cc:     Dakota Hawkins <dakota@dakotahawkins.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>, drafnel@gmail.com,
        bmwill@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <77FC347D-574E-4A4C-8114-8AD14222279B@gmail.com>
References: <CAHnyXxRx_iagZhki1rmVEpw+GZPWBRx7mNmahs3pruy57L3h-Q@mail.gmail.com> <xmqqvat5sjym.fsf@gitster.mtv.corp.google.com> <C265204B-BCCF-4085-9933-F28EB459CFB9@gmail.com> <xmqq1svtshnr.fsf@gitster.mtv.corp.google.com> <xmqqwpdlr2ht.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 23 Jan 2017, at 20:38, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> So you are worried about the case where somebody on a case
>> insensitive but case preserving system would do
>>=20
>>   $ edit file.txt
>>   $ edit .gitattributes
>>   $ git add file.txt .gitattributes
>>=20
>> and adds "*.TXT	someattr=3Dtrue" to the attributes file, which
>> would set someattr to true on his system for file.txt, but when the
>> result is checked out on a case sensitive system, it would behave
>> differently because "*.TXT" does not match "file.txt"?

Correct!


>> How do other systems address it?  Your Java, Ruby, etc. sources may
>> refer to another file with "import" and the derivation of the file
>> names from class names or package names would have the same issue,
>> isn't it?  Do they have an option that lets you say
>>=20
>>   Even though the import statements may say "import a.b.C", we
>>   know that the source tarball was prepared on a case insensitive
>>   system, and I want you to look for a/b/C.java and a/b/c.java and
>>   use what was found.
>>=20
>> or something like that?  Same for anything that records other
>> filenames in the content to refer to them, like "Makefile".
>>=20
>> My knee jerk reaction to that is that .gitattributes and .gitignore
>> should not be instructed to go case insensitive on case sensitive
>> systems.  If the system is case insensitive but case preserving,
>> it probably would make sense not to do case insensitive matching,
>> which would prevent the issue from happening in the first place.
>=20
> Sorry, but there is a slight leap in the above that makes it hard to
> track my thought, so let me clarify a bit. =20
>=20
> In the above, I am guessing the answer to the "How do other systems
> address it?" question to be "nothing".  And that leads to the
> conclusion that it is better to do "nothing on case sensitive
> systems, and probably become evem more strict on case insensitive
> but case preserving systems", because that will give us a chance to
> expose the problem earlier, hopefully even on the originating
> system.

I agree: Git attributes should behave the same on all platforms =
independent
of the file system type. I dug a bit deeper and realized that this is =
actually
already the case. However, the default (?) core.ignorecase=3D1 config on =
Win/Mac
generates the behavior explained above. I wonder if 6eba621 ("attr.c: =
respect=20
core.ignorecase when matching attribute patterns", 2011-10-11) was a =
good idea.

AFAIK disabling core.ignorecase entirely on Win/Mac is no solution as =
this would
generate other trouble.

Git users can already create case insensitive gitattributes pattern. =
E.g.:
*.[tT][xX][tT]

However, based on my dayjob experience no Win/Mac developer does that as =
it
makes the gitattributes file unreadable. Consequently, Linux developers =
are=20
screwed. Therefore, I wonder if it would make sense to introduce a =
shortcut
for the case insensitive glob pattern. E.g.:

*.txt ignorecase

If Git detects the ignorecase attribute then it could generate =
*.[tT][xX][tT]
automatically.

