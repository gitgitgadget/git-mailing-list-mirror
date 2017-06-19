Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2B91FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 14:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751113AbdFSOvm (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 10:51:42 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36633 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdFSOvl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 10:51:41 -0400
Received: by mail-pg0-f67.google.com with SMTP id e187so7626754pgc.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 07:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ReGQLH8cA0fEoeOVR3ggX7HX4BqHZDI3j4qrlJaOO2c=;
        b=UwrxdTrv6WtXY1HL00zIeg0HlRg0UvOj4loXx6Gy7gYK6evxn2LxRCDhWVowbVLAY9
         elDHQYCxoKh4kLTkvSE78sRtboKD/hdVzeSHmZd+S4KqelNpNa2gqPwVnQlAPFdBzSXW
         iouL+fTOYPIyGSSCr23YUWsCury4KEfO2nwKM4RZ5cYBq3wY9bpWvpC60cuy9L1SIaRX
         IneHU8/PbDYyMzUar7dVXfWbs7iEQgt7qADAWmlOPgtWkZLRt+BR4v/fetjqsXHmozYY
         3hbiwHtowLrLvlB1TZF0H6BCFrHRCzsaj65tVuFx/n42/O6pPinMuLtVyZpTQDEcHa96
         AO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ReGQLH8cA0fEoeOVR3ggX7HX4BqHZDI3j4qrlJaOO2c=;
        b=Wqx3DGcUz7Hv94VCArlK0PkUw95HBnFZy3dCpgGebtZDt5phRMFQ2eBW/pRkaXmNy5
         1K0WMi2eieft4XH9cdM0bY1v4jq12wX5l/Nzic3hr8QWmLblRwbhUDL/fljAKYs6IoZZ
         QhUD5by1BxBR8mlYhMB3dqn3Dki4mZFBWfmiPdaSD+2eqVTG3HaEKsBbGniu/+83CVp6
         4V3C5BKSkvhN655EBQYKkqABgVqPM+/gJZ81Qh0IcWIVSPoZyOWB67HfmbYTrLUcsZM0
         KknwbflcRvtYvnS1BmRqyBZOK10D4VzPAYHzoUW2w0Krf1/gmn6Iuxy/DW4ygns6AQgV
         I8PQ==
X-Gm-Message-State: AKS2vOzRGmufzmiJnHpx2Nw48sRQKSTJTNNk4fRatB3z4TsTwBF5myJS
        wkyGO8wde2Pi2nGCtzJ0sEvXq82FNw==
X-Received: by 10.98.69.76 with SMTP id s73mr20948365pfa.94.1497883900552;
 Mon, 19 Jun 2017 07:51:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.182.236 with HTTP; Mon, 19 Jun 2017 07:51:20 -0700 (PDT)
In-Reply-To: <087c8d6e-10f0-2c1f-1974-a97f4f685288@ramsayjones.plus.com>
References: <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com>
 <1497820591-93434-1-git-send-email-sahildua2305@gmail.com> <087c8d6e-10f0-2c1f-1974-a97f4f685288@ramsayjones.plus.com>
From:   Sahil Dua <sahildua2305@gmail.com>
Date:   Mon, 19 Jun 2017 16:51:20 +0200
Message-ID: <CALiud+=By79=ngbi6KoeSEW7PYAhrZR2my_=objq8Mgmx7h-RQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] config: create a function to format section headers
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 2:08 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 18/06/17 22:16, Sahil Dua wrote:
>> Factor out the logic which creates section headers in the config file,
>> e.g. the 'branch.foo' key will be turned into '[branch "foo"]'.
>>
>> This introduces no function changes, but is needed for a later change
>> which adds support for copying branch sections in the config file.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>
> Adding my SOB isn't really appropriate here - I only made a very
> very minor contribution. At _most_ you might consider 'Helped-by:',
> but even that would probably be overkill. ;-)

You sent a minor patch and I just applied it and squashed into my
patch. I'm okay with keeping your SOB, unless it's not appropriate to
keep it. (it's my first patch, so advise me. I don't have a strong
preference.)

>
> Thanks.
>
> ATB,
> Ramsay Jones
>
>
>> Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
>> ---
>>  config.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/config.c b/config.c
>> index 34a139c..32fd3c8 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -2169,10 +2169,10 @@ static int write_error(const char *filename)
>>       return 4;
>>  }
>>
>> -static int store_write_section(int fd, const char *key)
>> +static struct strbuf store_create_section(const char *key)
>>  {
>>       const char *dot;
>> -     int i, success;
>> +     int i;
>>       struct strbuf sb =3D STRBUF_INIT;
>>
>>       dot =3D memchr(key, '.', store.baselen);
>> @@ -2188,6 +2188,15 @@ static int store_write_section(int fd, const char=
 *key)
>>               strbuf_addf(&sb, "[%.*s]\n", store.baselen, key);
>>       }
>>
>> +     return sb;
>> +}
>> +
>> +static int store_write_section(int fd, const char *key)
>> +{
>> +     int success;
>> +
>> +     struct strbuf sb =3D store_create_section(key);
>> +
>>       success =3D write_in_full(fd, sb.buf, sb.len) =3D=3D sb.len;
>>       strbuf_release(&sb);
>>
>>
