Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C89E2098B
	for <e@80x24.org>; Mon, 17 Oct 2016 00:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754610AbcJQADs (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 20:03:48 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35091 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752353AbcJQADr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 20:03:47 -0400
Received: by mail-pf0-f175.google.com with SMTP id s8so71635412pfj.2
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 17:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vCDFwiDdy8HNRUE0vVghO+/Dqe8G61xTxYd8f7pNecA=;
        b=xa1wiQ9mrLSYD3rDCw5gjeA/BtEHT3NkEQ7YSXGIFD33GGK9DH6vHgy+T4EN08pls6
         PAy5O29SC6QxBh9GUchzT6bRUXf/iD9/kTlzK8U6Aw5iqm8bQVO2EW8bE1Zg12Mb1dlU
         6Tbcvzezh0QLNE8piBPzjl1c5xsEYY9CAh9ZTBQJnMeIjoHScX/qCE5e429cJSLrve6p
         NzPS6skG6LItEAcj68nWjzPfQyZ+9RQi+yxyUJrzeSrEqdDeE1cEr5k3DLAgbAhRH+UC
         DUUeU8otP3xW6vtyt30YJWTkYs0im3Ofmsz9w5qjCAKP0J9CzUU5cK7ClRkWLcfrtOLy
         PbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vCDFwiDdy8HNRUE0vVghO+/Dqe8G61xTxYd8f7pNecA=;
        b=iJEKz0unkd2D12Zjl7hez2Txel4aPN8CMoCOjCO2MyHiCUnt0PBG0o3Df1CaxNkevr
         nGfVN5g0DiP/bZ42Ad4GU+CphFYxLcMO55NaqtMzIvNyKEP2UeKSmYocEMHGI3Rk5lX5
         RiCdLrcsQ/nnI7pOT1YxXz8r9DasQ6f7pA2h1rvdARU9wFW6MK+wH8V0lPYc4+pBbdhR
         5W52eymyoSV1q3dHMjPGUpqxoYRcOYV/ZcBzG086LKtryX7WH2KO0nSdYeAGZKGNHjCR
         6inRFVSq9OjvUervrThii1HaE6wX4hd9rrwKpZiXKnK04cI9KO4vr3/4uxZ+edmH6X7M
         yN4Q==
X-Gm-Message-State: AA6/9Rm+//GN0bYxperIm0LRGZbAT+61QQaJIobTQkl/TTC14wejnhIMgiXVf0q5wls94Q==
X-Received: by 10.99.67.7 with SMTP id q7mr27497749pga.74.1476659627697;
        Sun, 16 Oct 2016 16:13:47 -0700 (PDT)
Received: from rem3n8pj12.ads.autodesk.com (adsk-nat-ip4.autodesk.com. [132.188.71.4])
        by smtp.gmail.com with ESMTPSA id cp2sm10312303pad.3.2016.10.16.16.13.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Oct 2016 16:13:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v10 13/14] convert: add filter.<driver>.process option
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161011100946.GA13745@tb-raspi>
Date:   Sun, 16 Oct 2016 16:13:44 -0700
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>, peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <486BC777-E132-4B69-92A7-60D6682625A2@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com> <20161008112530.15506-14-larsxschneider@gmail.com> <xmqqint0dlis.fsf@gitster.mtv.corp.google.com> <02E73D87-B036-40CA-AF54-F93415A028BC@gmail.com> <20161011100946.GA13745@tb-raspi>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 11 Oct 2016, at 03:09, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
> On Tue, Oct 11, 2016 at 10:11:22AM +0200, Lars Schneider wrote:
>>=20
>>> On 10 Oct 2016, at 21:58, Junio C Hamano <gitster@pobox.com> wrote:
>>>=20
>>> larsxschneider@gmail.com writes:
>>>=20
>>> [...]
>>>>=20
>> -test_cmp_count_except_clean () {
>> -	for FILE in $@
>=20
>> +test_cmp_count () {
>> +	expect=3D$1 actual=3D$2
>=20
> That could be=20
> expect=3D"$1"
> actual=3D"$2"

Sure!


>> +	for FILE in "$expect" "$actual"
>> 	do
>=20
>> +		sort "$FILE" | uniq -c | sed "s/^[ ]*//" |
>> +			sed "s/^\([0-9]\) IN: clean/x IN: clean/" |
>> +			sed "s/^\([0-9]\) IN: smudge/x IN: smudge/" =
>"$FILE.tmp" &&
>> +		cat "$FILE.tmp" >"$FILE"
>=20
> How about=20
> 		cp "$FILE.tmp" "$FILE"

OK, I'll use "mv".

Thanks,
Lars=
