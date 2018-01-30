Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1339D1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 20:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbeA3UcD (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 15:32:03 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:41585 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752866AbeA3UcB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 15:32:01 -0500
Received: by mail-wr0-f177.google.com with SMTP id v15so12626971wrb.8
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 12:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mhYUX6zJ/0p0L877Iz4ULl7B9Aec04fyS88UleJioag=;
        b=HpzOxkrKbw+g6M+PHLIOY9dlVj4iI2lH2LTmfL/tRpHiu6YB4SSXOcV8zw9eGHv1HL
         udInug6pUSthQ+SSejMWptd1mDhHAQqCm2jPhMs4dccitQDyrTmC1o5OSMpVB44ePtiL
         5MPUG1ANLvsntkeuANpyV5QLFMRNSOheG/zYE8R5dpsVN4TGcrDAeb+AoODGysJVTu+7
         oQetpmTT2ueqhoAISD0PIvWJ5bcRTre+o+E0P79hapicufDJleBYbVFfjmsM3Z2rhlxj
         ED8+DMnSTAsyul/jIMuLO3C7DnvykxiI6xDvy+uvYYjuEASlhMtvm+SYQa/JFmudZs7h
         y6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mhYUX6zJ/0p0L877Iz4ULl7B9Aec04fyS88UleJioag=;
        b=kBsgqsyvztXjKmnjzWBf5trfNaDrRObAtZS098nWL7pRn0tJ9MokyjXnqtMf/mLfDT
         z96vCku2ksBys3qlp3fDwLBC7nydVoUdrkU2/HIw+Nu9V7fB5UBJyAxfBsgFVznjrEPG
         Yo0XKntytnSkwmpVffrDNRdsHAcP8zfHSYK1tpY06Tni4ymkrzxeypHTdwWSsu0fcej6
         EDYPZCgtCKPwrbT1N5zx4xjFEur+u5PqOgjyK1Ek0N3GaU1E5gvXBskQGDymD6Q6ieSs
         t2NgVk2QqNrWUfHYMR51sGAzf5dSNBs/M4OfBE7yQXe2eYURTrd5SgHHmW+kyc9xGS+P
         mwOg==
X-Gm-Message-State: AKwxytdtotJB5vKm6/R/JSX05UVrF+rAEDyS6wFCguJKQkwr6yPnKt0w
        +QlrwUASyqwHjudq3u/Lo1Y=
X-Google-Smtp-Source: AH8x225ifTVPF6pIV9vfpU5UnCAa1QbAdM3g6xBRMW9BzX/y4JicmnEXrxUkGabQd4Qfly3S9M83gA==
X-Received: by 10.223.197.200 with SMTP id v8mr22437366wrg.22.1517344320764;
        Tue, 30 Jan 2018 12:32:00 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5B37.dip0.t-ipconnect.de. [93.219.91.55])
        by smtp.gmail.com with ESMTPSA id s19sm16328002wrg.7.2018.01.30.12.31.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jan 2018 12:32:00 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 5/7] convert: add 'working-tree-encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqzi4vt8n1.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 30 Jan 2018 21:31:58 +0100
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <396FBDFA-606F-41D9-988C-D6886089BC15@gmail.com>
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com> <20180129201908.9398-1-tboegi@web.de> <xmqqzi4vt8n1.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 30 Jan 2018, at 21:05, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> tboegi@web.de writes:
>=20
>> +	if ((conv_flags & CONV_WRITE_OBJECT) && !strcmp(enc->name, =
"SHIFT-JIS")) {
>> +		char *re_src;
>> +		int re_src_len;
>=20
> I think it is a bad idea to=20
>=20
> (1) not check without CONV_WRITE_OBJECT here.

The idea is to perform the roundtrip check *only* if we=20
actually write to Git. In all other cases we don't care
if the encoding roundtrips.

"git checkout" is such a case where we don't care as=20
noted by Peff here:
=
https://public-inbox.org/git/20171215095838.GA3567@sigill.intra.peff.net/

Do you agree?


> (2) hardcode SJIS and do this always and to SJIS alone.
>=20
> ...
>=20
> For (2), perhaps introduce a multi-value configuration variable
> core.checkRoundtripEncoding, whose default value consists of just
> SJIS, but allow users to add or clear it?

Well, in that case I would make it simpler and make
core.checkRoundtripEncoding a boolean that applies to all encodings
if enabled. We could make even simpler than that by removing the entire=20=

roundtrip check. The thing is, I was not able to come up with a
sequence that would not generate a iconv error *and* not round trip.
Would that be ok for you to remove all that roundtrip checking code?


>> +		re_src =3D reencode_string_len(dst, dst_len,
>> +					     enc->name, =
default_encoding,
>> +					     &re_src_len);
>> +
>> +		if (!re_src || src_len !=3D re_src_len ||
>> +		    memcmp(src, re_src, src_len)) {
>> +			const char* msg =3D _("encoding '%s' from %s to =
%s and "
>> +					    "back is not the same");
>> +			if (conv_flags & CONV_WRITE_OBJECT)
>> +				die(msg, path, enc->name, =
default_encoding);
>> +			else
>> +				error(msg, path, enc->name, =
default_encoding);
>=20
> The "error" side of this inner if() is dead code, I think.

Good catch. I think this code should go away if we keep the roundtrip
code and you agree with my statement above.


Thanks a lot for the review,
Lars=
