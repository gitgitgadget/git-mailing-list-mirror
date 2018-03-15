Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 664501F404
	for <e@80x24.org>; Thu, 15 Mar 2018 22:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932864AbeCOWmr (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 18:42:47 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33998 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932706AbeCOWmc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 18:42:32 -0400
Received: by mail-pg0-f46.google.com with SMTP id m15so3349023pgc.1
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 15:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yWibKj9P36j+P52MygFufG5HQ27cZZusAGc/eDRhTjY=;
        b=TFXuJ+YYSahFmJ1b1ZjePDdXXusdqTcsuVVSEQ6kZKT4AuNObvKCyfS7ZyouINj+EA
         vbsGvItskzlFriw2fe3wAf0xgI3o/+3V+CroSVRUuSKSXrhT9CQ/DvERUw9ZWP1lMReS
         cbTGPrqgwtRvhKeiKtH16gEC7hSVBxErwaYAgniJeGtjpSwGiaJh5LfzOVll1KpCSD4R
         sJdXHYjRLwx/wxKpE4EFhMQpLTjhTIjaKXxx983ezUDABwQ3kiTIVWv1AoW+4LbEk3Mp
         c47ZP2JZ3lx+IC/QZRAuEh9P96ZkgKICvx7CoqIu2cY1uM3ERF7NSqcmcajH/aGOtmTi
         pOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yWibKj9P36j+P52MygFufG5HQ27cZZusAGc/eDRhTjY=;
        b=JtPsdgF247QllVyVxi/NHckRDgL5ynwd0Pw9ShXeiKO48yMao9zCeL3vBvawgBgSS6
         tYZZMXYuATliV0J1Esuat6t2G594VVLh1SQHWrQ4AI+O0ZCLHWnigATt2TAdVbDw+So9
         n7Z41VM5/SOwG3uEeos621wyi4lqAlknN7luH+c+iUbsE0HmvSMCyAMGYNvpyUO9SoZm
         xTSG7z9pewHaE7y+/faoE+435ucVcPJJ0KLae2WiMGgifRTij00oTSZGh/jVV9TMRsRO
         omB5WQNPZLJXXTJ0nwkXlDrOKXcDzKEK+/bsFT/izeUH4FtM0qgOT+JlMfdiy3JKye7X
         41qQ==
X-Gm-Message-State: AElRT7Gv3ibo/PrLR0F9pmVrxpOUzNU7eVAahwC6wZMbVaXxuBOIPZmJ
        e8JoiMRssiZ/4UZSJssTJq4=
X-Google-Smtp-Source: AG47ELu9H8HgqNAcCcPYoLZWzl1tFsl69IC74sGbhL/327fvYBI4ifXSGtSmOk0VWu17vz6fzTNCvQ==
X-Received: by 10.167.131.135 with SMTP id u7mr9053378pfm.50.1521153751941;
        Thu, 15 Mar 2018 15:42:31 -0700 (PDT)
Received: from rem2ua0031cfw.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id d70sm11955915pfl.119.2018.03.15.15.42.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Mar 2018 15:42:31 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v11 08/10] convert: advise canonical UTF encoding names
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqefkt5ak0.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 15 Mar 2018 23:42:26 +0100
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D1598F51-5D9E-42FA-A9B7-C1462526B9CB@gmail.com>
References: <20180309173536.62012-1-lars.schneider@autodesk.com> <20180309173536.62012-9-lars.schneider@autodesk.com> <xmqqefkt5ak0.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 09 Mar 2018, at 20:11, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> lars.schneider@autodesk.com writes:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> The canonical name of an UTF encoding has the format UTF, dash, =
number,
>> and an optionally byte order in upper case (e.g. UTF-8 or UTF-16BE).
>> Some iconv versions support alternative names without a dash or with
>> lower case characters.
>>=20
>> To avoid problems between different iconv version always suggest the
>> canonical UTF names in advise messages.
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>=20
> I think it is probably better to squash this to earlier step,
> i.e. jumping straight to the endgame solution.

ok!


>> diff --git a/convert.c b/convert.c
>> index b80d666a6b..9a3ae7cce1 100644
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -279,12 +279,20 @@ static int validate_encoding(const char *path, =
const char *enc,
>> 				"BOM is prohibited in '%s' if encoded as =
%s");
>> 			/*
>> 			 * This advice is shown for UTF-??BE and =
UTF-??LE encodings.
>> +			 * We cut off the last two characters of the =
encoding name
>> +			 # to generate the encoding name suitable for =
BOMs.
>> 			 */
>=20
> I somehow thought that I saw "s/#/*/" in somebody's response during
> the previous round?

Oops. Will fix!


>> 			const char *advise_msg =3D _(
>> 				"The file '%s' contains a byte order "
>> -				"mark (BOM). Please use %.6s as "
>> +				"mark (BOM). Please use UTF-%s as "
>> 				"working-tree-encoding.");
>> -			advise(advise_msg, path, enc);
>> +			const char *stripped =3D "";
>> +			char *upper =3D xstrdup_toupper(enc);
>> +			upper[strlen(upper)-2] =3D '\0';
>> +			if (!skip_prefix(upper, "UTF-", &stripped))
>> +				skip_prefix(stripped, "UTF", &stripped);
>> +			advise(advise_msg, path, stripped);
>> +			free(upper);
>=20
> If this codepath is ever entered with "enc" that does not begin with
> "UTF" (e.g. "Shift_JIS", which is impossible in the current code,
> but I'll talk about future-proofing here), then neither of these
> skip_prefix will trigger, and then you'd end up suggesting to use
> "UTF-" that is nonsense.  Perhaps initialize stripped to NULL and
> force advise to segv to catch such a programmer error?

Agreed!


Thanks,
Lars

