Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 272EF1F424
	for <e@80x24.org>; Thu,  5 Apr 2018 09:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeDEJmF (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 05:42:05 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40587 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeDEJmE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 05:42:04 -0400
Received: by mail-qt0-f196.google.com with SMTP id g5so26206877qth.7
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 02:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=IAhdhQYO/YTN5LLSuLM05az7jE3OarRD2WMLEYCHuik=;
        b=iy552awkfpefyGRoSzl7xLyKUAe6M+5VLwU3rBYwTPrgrtlD8a1133mnoaT7/yGqJL
         dlYsqF9GNA7OemiSqhsDsT4RMDRIhIhTSLE5E4Gap7U3jBIlcDMKqpvUlOVRpfRvaI7K
         znsbuc93sXD8pdXJvV7ou0FcStUV5SuBidXZV5or5AXbqywqu1hvy/GIegf1Qi1CMjCZ
         hA1RJlPsvxXK8fchbctW0KVogGcVM4v5qmX4vN8zDs7HAy1H3LGCeqU++XEjUpfej31V
         yswznrz6MJlfTpdCBZ3difM59m/t47/C9ueYXhZsGlDSx2yyBBz3lhBkLorVmDvxtyOI
         OjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=IAhdhQYO/YTN5LLSuLM05az7jE3OarRD2WMLEYCHuik=;
        b=SRSHrq9gQr8/7lSTX0GRiDH1+/V6faK3wemlzHz5kRff1WydSiaimm9u1RekCoH9t9
         3D+9HY07oZ5wj4rVmg6D1QtutGdJKCdjhHJO+2zjMSF/bbCAIIz19dHnvEpZF+Z1cpsa
         FGFWOlVxPWSCXDOXUVUPsygl8qFrAMLfeUivDp+D/tOAO5h80wvrix8AmzfOJDLV5qMp
         nH+vE0FoRzHGPsvpvnlduDsGmLNncj/VwqhONsGKYULlFCds81jtCdHxuelpp8Tvyjfu
         x+B6L93/kwRzz7Oj1Akm1FGdBFnRVuHHb6zzG1yF7Q40FgyhZhCnS0xMl2zawf7aKHUx
         RC4g==
X-Gm-Message-State: ALQs6tATq0WP8dvcKDgltvhKMvAuMZPljFFSs8jblQ/tcXKNrVKZj+C6
        +cuvpDQQVApZSbYcBFgwvT0MjjrS15ksboLEmUM=
X-Google-Smtp-Source: AIpwx49Ri67UC5h14Ucdz4DGvoYf2LjHPHb7W0vPx/OKcTjm2/hCMC69zAdVluBRxQZoqLIl43gA3OBdY3SYJTX7RkM=
X-Received: by 10.200.1.2 with SMTP id e2mr31640927qtg.121.1522921323679; Thu,
 05 Apr 2018 02:42:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Thu, 5 Apr 2018 02:42:03 -0700 (PDT)
In-Reply-To: <87605616vr.fsf@evledraar.gmail.com>
References: <0102016293c8dca7-6626fcde-548d-476e-b61f-c83ecdeedfe1-000000@eu-west-1.amazonses.com>
 <87605616vr.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 5 Apr 2018 05:42:03 -0400
X-Google-Sender-Auth: -AHuyoaEVIY9CNh8zMfE3KpPoCA
Message-ID: <CAPig+cTYCtbn6bZ0uNR-fYtPnEh3MtSv3+ssn35FmPq_n2uWPg@mail.gmail.com>
Subject: Re: [PATCH] specify encoding for sed command
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Stephon Harris <theonestep4@gmail.com>,
        Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 5, 2018 at 2:53 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Apr 05 2018, Stephon Harris wrote:
>> Fixes issue with seeing `sed: RE error: illegal byte sequence` when runn=
ing git-completion.bash
>
> This is getting closer to the issue than your previous patch, but
> there's still some open questions:
>
> 1) What platform OS / version / sed version is this on?
>
> 2) What's the output from "set" that's causing this error? Do we have an
>    isolated test case for that?
>
> 3) There's other invocations of "sed" in the file, aren't those affected
>    as well?
>
> 4) Any reason we wouldn't just set LC_AlL=3DC for the whole file? I see w=
e
>    already do it for our invocation to "git merge".

Also, missing Signed-off-by: (see Documentation/SubmittingPatches).

Thanks.
