Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B238C2035F
	for <e@80x24.org>; Thu, 10 Nov 2016 11:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755247AbcKJLTa (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 06:19:30 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34240 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755235AbcKJLT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 06:19:29 -0500
Received: by mail-wm0-f68.google.com with SMTP id g23so2456002wme.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 03:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=M9v+ml4/O2t4z4kezIfyBiM35wQTGt+VQ1ZpfdnqG/8=;
        b=LgYXZu25U9YTvOebRywTlIyXka6W6HnluP5WepHc6A+6XkOXo50EUz0Qpvvkw5Tyj6
         cZdqdAfBx3yuObc+3GctkDFgcupQoBntDzcUApnPWtLeiyblVczzQADLW6h40Pmg0/Y1
         q+NLf0ETO7XDdhs62jv7BgD5YDCKLhgRL3qdIy9MdaRGV4RjDyYsR07mv2Ns/UUn84GV
         qJo+4F2cQi3ZFU0DbkW+pnfRwlXqalxt4K82Zk1odWF5L8GEZVHc0OHVxLXwULoYg3qW
         5A3umGVGEZ1eAntZmuWw7G6ILd3WHjYMHuI1ZPiwMKVD7V8npxF8dO88K1AYekEPpfmy
         SvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=M9v+ml4/O2t4z4kezIfyBiM35wQTGt+VQ1ZpfdnqG/8=;
        b=Z5pO3J+0AYGoAk0+RTnemTmu6tK+Cp+DTd4APiqKLQIjKrxdl5lI4GqABs3yvOiXvQ
         cPuGQbENFjNuheW0/hErnpTEDPcJ34xrW7MRfEsL8unR4eOlb/xxxFUAbtjkTfyBYbXE
         8KD9RDRKhgSgRRnXeKvc+Nxl/Teb7NRD6Zf9cRY50QiEUG7I0CRVYX5AK2bJxkh0WVC/
         PvDwTiOqdhrZIkSslytWCptL9DCb6Ixwuw/XTeFIWbZIYb7+tJZqoAoxNd7iDGUPlTf1
         7DzR0DHr50vU5HK2Sg72j5rTzJM9Drbyx+IrNBLQZ2lf95wOzlVHEJKeq86rpXQrTfQq
         qDrA==
X-Gm-Message-State: ABUngvcebwxvzsvN8taBgK+VwlzG7W6a1pmjWMHE6sAMG9w4tMH7cQ0HWshg0/CjdbjywA==
X-Received: by 10.28.163.5 with SMTP id m5mr5100005wme.98.1478776767824;
        Thu, 10 Nov 2016 03:19:27 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w7sm12319982wmd.24.2016.11.10.03.19.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 03:19:27 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1 0/2] Fix default macOS build locally and on Travis CI
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqwpgc6x4t.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 10 Nov 2016 12:19:26 +0100
Cc:     git@vger.kernel.org, tboegi@web.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <584C7DBA-71FE-4E66-85DC-EA22A6D2BB80@gmail.com>
References: <20161017002550.88782-1-larsxschneider@gmail.com> <xmqqwpgc6x4t.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 10 Nov 2016, at 00:39, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> larsxschneider@gmail.com writes:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Apple removed the OpenSSL header files in macOS and therefore Git =
does
>> not build out of the box on macOS anymore. See previous discussion =
with
>> Torsten here: http://public-inbox.org/git/565B3036.8000604@web.de/
>>=20
>> This mini series makes Git build out of the box on macOS, again, and
>> disables the HTTPD tests on macOS TravisCI as they don't work anymore
>> with the new macOS TravisCI default image:
>> https://blog.travis-ci.com/2016-10-04-osx-73-default-image-live/
>>=20
>> Thanks,
>> Lars
>>=20
>>=20
>> Lars Schneider (2):
>>  config.mak.in: set NO_OPENSSL and APPLE_COMMON_CRYPTO for macOS =
>10.11
>>  travis-ci: disable GIT_TEST_HTTPD for macOS
>>=20
>> .travis.yml      | 3 ++-
>> config.mak.uname | 6 ++++++
>> 2 files changed, 8 insertions(+), 1 deletion(-)
>=20
> I've followed what was available at the public-inbox archive, but it
> is unclear what the conclusion was. =20
>=20
> For the first one your "how about" non-patch, to which Peff said
> "that's simple and good", looked good to me as well, but is it
> available as a final patch that I can just take and apply (otherwise
> I think I can do the munging myself, but I'd rather be spoon-fed
> when able ;-).

Sure! Here you go:
=
http://public-inbox.org/git/20161110111348.61580-1-larsxschneider@gmail.co=
m/


> I do not have a strong opinion on the second one.  For an interim
> solution, disabling webserver tests certainly is expedite and safe,
> so I am fine taking it as-is, but I may have missed strong
> objections.

I haven't seen strong objections either. Just for reference, here is the =
patch:
=
http://public-inbox.org/git/20161017002550.88782-3-larsxschneider@gmail.co=
m/


I hope you're well, again!!

- Lars=
