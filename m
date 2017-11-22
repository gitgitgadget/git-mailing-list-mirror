Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD17320954
	for <e@80x24.org>; Wed, 22 Nov 2017 16:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbdKVQrN (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 11:47:13 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:43833 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbdKVQrM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 11:47:12 -0500
Received: by mail-wm0-f65.google.com with SMTP id x63so11646880wmf.2
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 08:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+s3ou1DjjbHp/5HwxtVa3i9v06XvgKgaN5be1UOOWkY=;
        b=ZjZTgS8SmdPHs3loZU+NicsjQ717wPaT8jfrfMZ9fPn435WmWw0PKYj8qDfef8G7Ta
         +S8PJTWhHp7rqxkd1SYzciw6EUcNFfsAloEc8jXbGXLacmZvH8H49RF9n5yX45n2z8Vt
         1Im2GERi5oF1aaTJ3tj9e0bvTpB/se1b+sF2D9Zb9+xXABw0ZA/fEMPOp/ha0fa7wXOf
         1HFjGspFKgbbhul+mPX7yGJugP2MrrnAKYpO31lt4bQZOibwol2zlsq2qtLrrUCFma2L
         jTY5u+gQ0YEN7f8JVe/rGcqF2pyWycDHy21GbYyfRXaPf1IW2QU9xCOSwE/r+v+911jB
         /g1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+s3ou1DjjbHp/5HwxtVa3i9v06XvgKgaN5be1UOOWkY=;
        b=bp+dLSqYT9Szd73S//Fkkqm4E8m1/87ZF7KLs6wvFXsyUNZqU38vyussDiARBV27lk
         xTu8JzKLPohQ2P0IiNzIjXhAdbC7UkotrQmcWKGbi/hEH/7ZbxkxmMr41stIZmj+c/o/
         RKg2cZ3rs8PEX7oJHczenTJJ7Sy2fl5fBuftoFxJDH37eumHOjHL/4T1hyNIkW4UOXOo
         DdoInbrj9BMa+DIY6NHeGqJ4ObFxrc6OAhlqekYFJFJBGqFYjIWWImFIsmtkaoVzOehg
         1wErXwqf5zJ/vhT7PnrbysDB8BCk+wfiNxXauWOmu4cFB330hvXu7pHrtUZaPkicrwTz
         W+Cw==
X-Gm-Message-State: AJaThX42E5i0lsV44DGWKgtA9wq6Aklq1X18yO51x1I929cWojVhkyKg
        PN/lFG2w3Bt515nggBIIEfw=
X-Google-Smtp-Source: AGs4zMYKIa9QGM4MvKGx4erTcylMyWrcvLm1k5oYgNVUssiUmDG770X6/7vu/MEbI70QyHxTh3xtAA==
X-Received: by 10.28.18.145 with SMTP id 139mr4590727wms.43.1511369231442;
        Wed, 22 Nov 2017 08:47:11 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id y78sm14790502wrb.51.2017.11.22.08.47.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Nov 2017 08:47:10 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] launch_editor(): indicate that Git waits for user input
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqy3n4rbnr.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 22 Nov 2017 17:47:09 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0DD1EE8A-47F1-41AA-8F86-C9FDF99D22A0@gmail.com>
References: <20171117135109.18071-1-lars.schneider@autodesk.com> <xmqqy3n4rbnr.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 17 Nov 2017, at 19:40, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> lars.schneider@autodesk.com writes:
>=20
>> Junio posted the original version of this patch [1] as response to my =
RFC [2].
>> I took Junio's patch and slightly changed the commit message as well =
as the
>> message printed to the user after GIT_EDITOR is invoked [3].
>>=20
>> Thanks,
>> Lars
>=20
> Thanks.
>=20
>> diff --git a/editor.c b/editor.c
>> index 7519edecdc..23db92d8c6 100644
>> --- a/editor.c
>> +++ b/editor.c
>> @@ -40,6 +40,32 @@ int launch_editor(const char *path, struct =
strbuf...
>> ...
>> +		if (close_notice) {
>> +			fprintf(
>> +				stderr,
>> +				"Launched your editor ('%s'). Adjust, =
save, and close the "
>> +				"file to continue. Waiting for your =
input... ", editor
>=20
> How wide is your typical terminal window?  With message this long, a
> sample standalone program I used while developing the prototype of
> this feature no longer can retract this "temporary" message.
>=20
> Would something shorter like "Waiting for you to finish editing..."
> work well enough?

Yeah, Eric criticized the verbosity elsewhere, too. I understand your =
point
of view. Let's revert it to your initial short version.=20

- Lars

>=20
> -- -- --
> #include <stdio.h>
>=20
> int main(void)
> {
> 	const char *EL =3D "\033[K"; /* Erase in Line */
> 	const char *editor =3D "emacsclient";
>=20
> 	fprintf(
> 		stderr,
> 		"Launched your editor ('%s'). Adjust, save, and close =
the "
> 		"file to continue. Waiting for your input... ", editor);
> 	fflush(stderr);
> 	sleep(2);
> 	fprintf(stderr, "\r%s", EL);
> 	fflush(stderr);
> 	return 0;
> }
> -- -- --
>=20

