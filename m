Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 521F42027C
	for <e@80x24.org>; Mon, 29 May 2017 11:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750947AbdE2LMB (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 07:12:01 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38687 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbdE2LMA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 07:12:00 -0400
Received: by mail-wm0-f48.google.com with SMTP id e127so55667076wmg.1
        for <git@vger.kernel.org>; Mon, 29 May 2017 04:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GAynLLFGXWWPxRWqldiHgMDmCHRdU75wqinu7hlaex8=;
        b=ZPgD59cogNJnyF94ZGZmFJpWtrzjKQnpUUPCSh9nU26Z+LuI/eJzlB3Z/JTnzvte+X
         IbHsbHuB0hNG3UqZAf4/VBaQaah75Rf82+TPQpCvO1FsvL5Wx0zvMgAylRTaLLgfzL2m
         sdEZ57+YR93LipZiAfLG9LBt7AGqj0imiAclncIhAmFTuHCX4FcW1feq65ynNo0hpp7E
         O68vgj6wKWE0ZVp38FqOD4gR4qJV9nAi7msbYfu415pGHOVsVUhFzJwBk3ywiL79mqoh
         Wbu4Hga49hb1YzF6CXOkc2btYH6QctjY0TKut9GqB2Yfi/GbWabPZtmx5J5viSZej3Yr
         yTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GAynLLFGXWWPxRWqldiHgMDmCHRdU75wqinu7hlaex8=;
        b=MLhP8gQPyN4WEpAiMUhmQARQQz/fuFx5Cz17gtN4h7oSZFwUO6Ici8LG1zC3rvMGG5
         2eA9e6oBoG1WzcinJp3VsxjCzdgpu2lXnrrbEoPDUEoyc4aXg+ZoGjFvMWQzx61uEj63
         TcCWjb6OuxQS7RbT9NUGZliulMlUByGA4dgeNAqMQrIcJhIRhYIa/MfiZb29jVwD/+LQ
         GU+1kISt+NuHONnVb+Jhbi+rYru2MFOosdDorkTZnCgHUtVcI1jG16vokclcPDv20BSP
         w+i8XHbpZ1iH0j+Eb+sPXBBOpj3u+qUTs57l3SbgCFBGA4cbJ0xB2kf/aNnMQ33YxVM9
         ynBQ==
X-Gm-Message-State: AODbwcAZW4Sk9BAM7GkzTDMQD8e2cd4aUyahI7ROW/R49diusqusPD7S
        oYEPS8ZFjz1RV8ah0ak=
X-Received: by 10.223.165.5 with SMTP id i5mr3049292wrb.91.1496056319387;
        Mon, 29 May 2017 04:11:59 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id k7sm11977457wrk.45.2017.05.29.04.11.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 May 2017 04:11:58 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 4/4] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <DB31E695-B7D5-4337-BACD-5191EB642F40@gmail.com>
Date:   Mon, 29 May 2017 13:11:55 +0200
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <832A4D04-F32F-4D1F-A5CE-3514F8469E63@gmail.com>
References: <20170522135001.54506-1-larsxschneider@gmail.com> <20170522135001.54506-5-larsxschneider@gmail.com> <64b1fda4-9f79-1bd8-ad6d-43196b808d61@web.de> <04ECEBE5-CAC8-4344-B07A-6B7A7C795C94@gmail.com> <xmqq1srgm9kq.fsf@gitster.mtv.corp.google.com> <DB31E695-B7D5-4337-BACD-5191EB642F40@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 23 May 2017, at 10:43, Lars Schneider <larsxschneider@gmail.com> =
wrote:
>=20
>=20
>> On 23 May 2017, at 07:22, Junio C Hamano <gitster@pobox.com> wrote:
>>=20
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>=20
>>>>> +	sigchain_pop(SIGPIPE);
>>>>> +
>>>>> +	if (err || errno =3D=3D EPIPE) {
>>>>=20
>>>> This looks strange, at first glance.
>>>> Do we set errno to 0 before ?
>>>> Or is there a trick that EPIPE can only be reached,
>>>> if it is "our" error ?
>>>=20
>>> You are right and I'll fix it!=20
>>> Thanks for reminding me!=20
>>> Peff also noticed that some time ago:
>>> =
http://public-inbox.org/git/20170411200520.oivytvlzkdu7bfh5@sigill.intra.p=
eff.net/
>>=20
>> Ben Peart's bp/sub-process-convert-filter topic also had the same
>> EPIPE issues in its earlier incarnation, IIRC.  I haven't looked at
>> this topic for some time, but I wonder if we can share code with it.
>=20
> That's right. There might be some code sharing opportunity with Ben's
> code that is already in "next":
> https://github.com/git/git/blob/next/convert.c#L660-L677
>=20
> Would it be useful for you if I send v5 with the changes rebased=20
> onto "next"?

Hi Junio,

sorry for bugging you again, but Ben's topic did not make it to "master"
today. Is it OK if I rebase my topic onto "next" and resend?

Thanks,
Lars=
