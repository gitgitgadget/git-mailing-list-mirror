Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EAFB208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 16:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbdHRQ5L (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 12:57:11 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36874 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752114AbdHRQ5J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 12:57:09 -0400
Received: by mail-pg0-f45.google.com with SMTP id y129so67849296pgy.4
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f4aPr+l0O6Iwy67C1ZV0dGOcMqk2Go09NvtAVo2mr6g=;
        b=PGHqOsxNJE6vzCjh8mONRSWs0ARRMc60rnlfTGC4rT0n0OjublewYVNanQ9r3Q2Xkg
         hM3XdfnQPp+EG/ZxQOURvN5a5YM8hbUrZxlpWYhl8FV6cajEnLblnoFi8A5F74CZ0uBf
         IuCLAIhdTXluSYEnRIx4WSUD6QIewIfsHDmq7w8QnpigK9KgLJ/3rLj8qB3SMsYXXV/u
         HqvBYHFcVYZCgygKsaHF2g2BJWf/q5nyynR5Fc4QGY2FVnviS8oBzh6zsFAOFXmv2vdu
         G4f29JPQBXbtvhX2udBO9X/feLXTW95jqRaCs4cn7zXT8/r9I9ZIH2x8RD0fxr7nQ55R
         gXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f4aPr+l0O6Iwy67C1ZV0dGOcMqk2Go09NvtAVo2mr6g=;
        b=krAAJBI2SDuHHK/sagiSfPGXVjg1uMkyLdxdK4etjfo8WIPgMrG5mFbYNKjvlu7RkE
         +T49v6/4KzHiVdwBsE5zvFiyPkV2jAEPajh+gkjCYVpEW2KOFsGRFTwdqPJSONPitU+x
         i9IM8p0r80OwyJnv2WCxrsF6JA590S9W7njq+mEc4DvPDGRgo3CycMEMN+69piChE/MP
         mSTbK7LWTJiRdCh/oIFtktzC6FhItr5Ec2M1oYYwzYFpCKMdqDyp8X27siE74jV0sr/h
         UVcPuLYFlEwOV8HK7oov3bv2NTZXP6Ghe+yJEXkU3sfnHayiEuO962CpyeC1cETjbBVR
         gqNQ==
X-Gm-Message-State: AHYfb5jAvHMCajRJvRzKBXiIOq4CdYZOW2N5exC+ropD9Pr8Q2vsoBCJ
        lXXai9ul1QaQoAx/FaIPxL6qfGqSxw==
X-Received: by 10.99.105.8 with SMTP id e8mr5139834pgc.165.1503075428537; Fri,
 18 Aug 2017 09:57:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Fri, 18 Aug 2017 09:57:07 -0700 (PDT)
In-Reply-To: <xmqqr2w8dej6.fsf@gitster.mtv.corp.google.com>
References: <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com> <20170817025425.6647-1-kaarticsivaraam91196@gmail.com>
 <20170817025425.6647-2-kaarticsivaraam91196@gmail.com> <CAN0heSquaXk421sR6Ry59C+er8n26nC93=3KG1wD0xNXZkuiGw@mail.gmail.com>
 <xmqqshgqezox.fsf@gitster.mtv.corp.google.com> <42219b51-8232-e1ee-9c48-f67ccdcbb4c8@gmail.com>
 <xmqqr2w8dej6.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 18 Aug 2017 18:57:07 +0200
Message-ID: <CAN0heSrU-TQnFRYiSF4ubcYXviwVmkxHY7Sf_U7=9i2vzdYp3Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] builtin/branch: stop supporting the use of
 --set-upstream option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18 August 2017 at 18:30, Junio C Hamano <gitster@pobox.com> wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
>
>> On Friday 18 August 2017 01:25 AM, Junio C Hamano wrote:
>>> Martin =C3=85gren <martin.agren@gmail.com> writes:
>>>
>>>> On 17 August 2017 at 04:54, Kaartic Sivaraam
>>>> <kaarticsivaraam91196@gmail.com> wrote:
>>>>> Helped-by: Martin =C3=85gren <martin.agren@gmail.com>,  Junio C Haman=
o <gitster@pobox.com>
>>>>> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
>>>> I didn't expect a "Helped-by", all I did was to give some random
>>>> comments. :-) I'm not so sure about the comma-separation, that seems t=
o
>>>> be a first in the project.
>>> I didn't either ;-)
>>>
>>> The line looks odd so I'll remove it while queuing.
>>>
>>> Thanks for noticing.
>> I should have been better with my wordings :) How about converting that
>> line into two 'Suggestions-by:' or 'Reviewed-by:' ?
>
> I personally do not think either is needed for those small things we
> saw in the discussion.
>
> Unless Martin feels strongly about it, that is.

No, no strong feelings. Thanks.
