Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B54221F576
	for <e@80x24.org>; Wed, 31 Jan 2018 06:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeAaGjx (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 01:39:53 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:44326 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbeAaGjw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 01:39:52 -0500
Received: by mail-qk0-f175.google.com with SMTP id n188so2046459qkn.11
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 22:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nXaGZvUmUiYqHl1Fnds2s9K5We9cWT/pTH/CZnwRyNA=;
        b=h/ZlG7d87n0JiF/KZnEhDOWOHHKfg4VhA5uC7zRFwGOmIVe3lP5H4+UoX425nQ2D90
         vNu6l/WldnkW+sz9kluoG6MMsL867agFNEJEtd7Hz5yMc5O8RXNHx50myNA7mr/l3Zni
         yIDY21firLmuUs98HDVedWcO2yeDTGM0tvIDsN3uRaJqJWd4yVp9PPyLGcJHCN/7eVUD
         tXZFl3k70+tSAmEGI17n93t25+Vd7DzTbF/HQWAgKEzkx0a388A3Zd2fGWByUkV+EwIf
         lFIH2od2jKrX1oLSVudedVjwVO4zErE0wyVMDQiTlkpL7CZBbvCxQEHIrLz7Tvk7dwgm
         x3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nXaGZvUmUiYqHl1Fnds2s9K5We9cWT/pTH/CZnwRyNA=;
        b=flq8AauuVhvVEwK83i3t+ji32JRcgMG+8n7R0Fjc2lTTE4DyXsaCgSp/pmPs6iLnsj
         JSoB75cZDd+ivOpEICjKVDqHZpR64emVCThyT4DhrE4hCxw08Qpxlc9tDAkGNMCm4Btx
         yphtYWuOWlaGa6D1xwOaqYyqrAYTnYuSdPnCVPthVaVIRNiposOnk65AP71S5QLs3hOh
         VTVgvTtT7fC6zvYVukwwZxlI/IjDjWay4ze5EiwU93lZcRn+Tg10WFkcOaITHNvhNtZi
         0K7Xl6eKCuTyfGueKEhJtdDw4APD8yAtu/oNcgmV6twSW/kbA+9NcGWHF3aOJeyk1yWu
         6MqQ==
X-Gm-Message-State: AKwxytca3a1ukBPtbCO8Clfh6aZUZL3imYPubTuIR795quuQQL9XOrjm
        aBpOkJuFYAuJnmI1FHOVqoM5D5AuSkdXzElNnfo=
X-Google-Smtp-Source: AH8x224pnX4YcRKQjQADLT0/C0ndapdzoDO3L3u6xkz1jkrDa8iZMohPq1FEX2nOwN7I2AzFfnBQJZijUje+xinumKs=
X-Received: by 10.55.104.17 with SMTP id d17mr44788504qkc.306.1517380791723;
 Tue, 30 Jan 2018 22:39:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.28.54 with HTTP; Tue, 30 Jan 2018 22:39:51 -0800 (PST)
In-Reply-To: <xmqqd11rt6ks.fsf@gitster-ct.c.googlers.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
 <xmqqfu6s74pf.fsf@gitster.mtv.corp.google.com> <CAL21BmkOGE6UZQJTFQjq3qnmywwBJQOUXE7jSwP1_Vn6PZ8ezA@mail.gmail.com>
 <xmqqd11rt6ks.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Wed, 31 Jan 2018 09:39:51 +0300
Message-ID: <CAL21Bm=cMQ-dx1v9rRhEuZQW7BrHGsCMTmvy=ONrv0weLM+JJg@mail.gmail.com>
Subject: Re: [PATCH RFC 01/24] ref-filter: get rid of goto
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-30 23:49 GMT+03:00 Junio C Hamano <gitster@pobox.com>:
> =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F  <oly=
atelezhnaya@gmail.com> writes:
>
>>> one place improves readability.  If better readability is the
>>> purpose, I would even say
>>>
>>>          for (i =3D 0; i < used_atom_cnt; i++) {
>>>                 if (...)
>>> -                       goto need_obj;
>>> +                       break;
>>>         }
>>> -       return;
>>> +       if (used_atom_cnt <=3D i)
>>>                 return;
>>>
>>> -need_obj:
>>>
>>> would make the result easier to follow with a much less impact.
>>
>> It's hard for me to read the code with goto, and as I know, it's not
>> only my problem,...
>
> That sounds as if you are complaining "I wanted to get rid of goto
> and you tell me not to do so???", but read what I showed above again
> and notice that it is also getting rid of "goto".

No, I am not complaining. I tried to explain why I did everything that
way. Sorry if it was not clear enough.

>
> The main difference from your version is that the original function
> is still kept as a single unit of work, instead of two.

And I am not sure that it is good, the function is too big and it
actually does so many different separate pieces. If it is possible to
shorten long function by getting some separate logic (that's our case,
we do not request object until that final goto statement), I think
it's good idea and we need to do so and simplify future reading. But,
if you do not agree with this fact, please explain your position in
detail, and I will change that place as you want.

Thanks.
