From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] convert: legitimately disable clean/smudge filter with an empty override
Date: Wed, 27 Jan 2016 10:42:37 +0100
Message-ID: <C850C103-E400-43C3-84A4-8399FA1CD5FB@gmail.com>
References: <1453638170-52041-1-git-send-email-larsxschneider@gmail.com> <56A4E86B.1010909@web.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net, jehan@orb.com
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 27 10:42:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOMcl-0005W8-DY
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 10:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285AbcA0Jmr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2016 04:42:47 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38612 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258AbcA0Jmm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2016 04:42:42 -0500
Received: by mail-wm0-f52.google.com with SMTP id p63so17219022wmp.1
        for <git@vger.kernel.org>; Wed, 27 Jan 2016 01:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hpWJUADJI66iDtvAzo02nQGQr8eb7J00UGZZtmrN6M8=;
        b=zj2ZTvldIMmvlAcdHBw1q2nX5z6sRjCHQP3t28zlPthqvnwSFpXxiFKG35OR5d87Nn
         1GEh/2XShBg98WwoqOjKBbTJ9zEElhLUqvw6nGsok0hR45hQn5P8Ypu5rlVY/q9h7u/7
         Ohj2xtVks/F3Z8xHmJJZk7HYW99BzSCXIYW5G5r7hNquM9KXEP3Ypb7msA91hOXaEO8a
         Gp4bo9BfATs70kxz98Kgj48s7a99GFFgB40F4nuDBD4WgVuNTaXIdCWPm0/gwYo46hb3
         zI7xSl7FUxYcYjTYo/ixz7WynTfPaoGGzQl4jnAYRhuDVx9MeJVzvU6z60kgt/rH1f3F
         la1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=hpWJUADJI66iDtvAzo02nQGQr8eb7J00UGZZtmrN6M8=;
        b=ZcX4USejPqLsoC9Pq7lMe0CExfpsOCPd+OwYp7KYXmqmHqtMWgO9Vp8epTX/dbEDys
         2AeZjd59c+PltneTEGfBvgQ3796eG+e0+DlADrxAFHT1iGgmyZAdQLtB+NBPLHJ90GQ9
         xnFA9zMoJ3sjaHC8SV/gQXL0hiqV8VwEqznFhuXQ5Rex43HczbpMax7kefgiJDmUAKxp
         1ORaAYvaDNw/KyZUR6WLBnPMKSigQXqEsH0cHcekDeNAT9DVF6n2lsa4OhOzvHFrBUfE
         UIbx/vwpkHyeWpQ001Ig8ZQc/Nc9+mB193x3x+IzHpiwjoRULIWZCMka+0npEcE8aHko
         tHNA==
X-Gm-Message-State: AG10YOTcwXcv9wFyX1DultlnnfFML0VWfSEsdFLwVp6kYveuHLzowP3rcPXsfv7uEm3eaA==
X-Received: by 10.194.174.73 with SMTP id bq9mr28005315wjc.145.1453887760108;
        Wed, 27 Jan 2016 01:42:40 -0800 (PST)
Received: from slxbook3.fritz.box (p508BA675.dip0.t-ipconnect.de. [80.139.166.117])
        by smtp.gmail.com with ESMTPSA id w8sm5309014wjx.21.2016.01.27.01.42.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jan 2016 01:42:39 -0800 (PST)
In-Reply-To: <56A4E86B.1010909@web.de>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284902>


On 24 Jan 2016, at 16:06, Torsten B=F6gershausen <tboegi@web.de> wrote:

> On 24.01.16 13:22, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
> Some minor nits inside:=20
>>=20
>> A clean/smudge filter can be disabled if set to an empty string.=20
> "set to an empty string" refers to "git config" (in opposite to the
> filter as such, which is specified in .gitattributes.
> Does it make sense to write=20
> "git config filter.XXX.smudge ''" or so ?

I am not sure I get what you want here. Would this work for you?

The clean/smudge filter commands (filter.XYZ.smudge and filter.XYZ.clea=
n)
can be disabled if set to an empty string. However, Git will still cons=
ider the=20
empty string as command which results in a error message per processed=20
file.


>=20
>> However,
>> Git will try to run the empty string as command which results in a e=
rror
>> message per processed file.
>>=20
>> Teach Git to consider an empty clean/smudge filter as legitimately d=
isabled
>> and do not print an error message.
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> convert.c             |  4 ++--
>> t/t0021-conversion.sh | 14 ++++++++++++++
>> 2 files changed, 16 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/convert.c b/convert.c
>> index 814e814..58af965 100644
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -786,7 +786,7 @@ int convert_to_git(const char *path, const char =
*src, size_t len,
>> 	struct conv_attrs ca;
>>=20
>> 	convert_attrs(&ca, path);
>> -	if (ca.drv) {
>> +	if (ca.drv && ca.drv->clean && strlen(ca.drv->clean)) {
>> 		filter =3D ca.drv->clean;
>> 		required =3D ca.drv->required;
>> 	}
>> @@ -835,7 +835,7 @@ static int convert_to_working_tree_internal(cons=
t char *path, const char *src,
>> 	struct conv_attrs ca;
>>=20
>> 	convert_attrs(&ca, path);
>> -	if (ca.drv) {
>> +	if (ca.drv && ca.drv->smudge && strlen(ca.drv->smudge)) {
>> 		filter =3D ca.drv->smudge;
>> 		required =3D ca.drv->required;
>> 	}
>> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
>> index 718efa0..56e385c 100755
>> --- a/t/t0021-conversion.sh
>> +++ b/t/t0021-conversion.sh
>> @@ -252,4 +252,18 @@ test_expect_success "filter: smudge empty file"=
 '
>> 	test_cmp expected filtered-empty-in-repo
>> '
>>=20
>> +test_expect_success 'disable filter with empty override' '
>> +	git config filter.disable.smudge false &&
>> +	git config filter.disable.clean false &&
>> +
>> +	echo "*.disable filter=3Ddisable" >.gitattributes &&
>> +
>> +	echo test >test.disable &&
>> +	git -c filter.disable.clean=3D add test.disable 2>err &&
>> +	! test -s err &&
> How about=20
> test_cmp /dev/null err
> to make debugging easier ?
Right. Although I would probably go with Eric's suggestion and use "tes=
t_must_be_empty".

That being said, I copied "! test -s" from the "filter large file" test=
 in this file (added with 0b6806b).
How does the list handle these cases? Should I add another commit to re=
place "! test -s" there,=20
too?

Thanks,
Lars