Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6C21F404
	for <e@80x24.org>; Thu,  8 Mar 2018 23:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeCHXlv (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 18:41:51 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:42738 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751743AbeCHXlu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 18:41:50 -0500
Received: by mail-vk0-f53.google.com with SMTP id y127so1039078vky.9
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 15:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PpLu+q+yQMrgO86/+NXiQNxYVWxVpqhlFt9llIdAuYA=;
        b=nIiMZb5kLYc2VcZgYQX54MLrxIX+ZcAUBpaEbQOVkoGkmVNAeU/Kmi/BU3RaiDeXXa
         C7VMYWzo3MaEZ6j2c2vOUakXQP4Ogk1joIWnrxog82MA49TEBNz6/EZmDQq0lHAt0hk/
         T86H3FsTVo8+3oLXam6174T5/A8thdX/ftD3gujBxTPuZtFh//F7QWvjCyAWWQMBeVZO
         S0RLTkurwW5N7PPbEYUoA7YMvqDh6xRptvM7Zcx6s8q+hSs8uAYg386+7Ec/uc8UhcSZ
         JAiGBf9bsTdHAsyUan2MlT+C/EZK/3q9bUu3tr5ZJn9l9UlFVRtydobgZjSOtxPL4Uen
         +QXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PpLu+q+yQMrgO86/+NXiQNxYVWxVpqhlFt9llIdAuYA=;
        b=r6nDn1wyPlAbRKsyY6lnfq45W4REL3ZXTZDKbw/u8mRuU85qWK8dBshbPTDztCemT2
         /9bmWcgcXS3u4oWOW8AwJAgviGthFlrNxvoRmXQO1t8qmQRNrA+Fb2+ZF4NZYS7xOFI3
         rzkmsrkxOMYIbGv2SZkwbr3ZsLfQkyMsiEIVbTmV0CvhZ2MXDRcLCWG1ljADZBQhIJYk
         e31j/+wfD8R2V2Vjlis5n1c8Q6VdAYrYvnBqFEZBW+JS1SGKMYaNx+tVUi8ugmPJIRj5
         Fm3MqcK8uWMuQZdFe6Wez0rR7GmV5RgsazjYxNBc04MpxJCGQUwMNzVBM7+deaStYWQB
         ksAw==
X-Gm-Message-State: APf1xPDm1ZMOlw2sBTg60mV2sf8VU7t1OXNI2yQ4obQ6O9GzeKFb40+F
        OyyMg/in/b5cxs+kHb0+huNgRe2lFVHiddMs8fU=
X-Google-Smtp-Source: AG47ELsMOmL0ohej2JQDQYH2jlcagpmWT0dPpZwH3xnxUD9raJfhcuzdR1obIqLS2DFAYN6K1Yqtx+R9vlOHx2h2T3w=
X-Received: by 10.31.219.2 with SMTP id s2mr19894996vkg.89.1520552509155; Thu,
 08 Mar 2018 15:41:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Thu, 8 Mar 2018 15:41:48 -0800 (PST)
In-Reply-To: <xmqqzi3i6t2v.fsf@gitster-ct.c.googlers.com>
References: <CAPig+cRSDbFZ_C9opu3pr=m7HwFkeuoxUD_8Yqbd4XxX-W0cHg@mail.gmail.com>
 <20180308224458.5730-1-szeder.dev@gmail.com> <xmqqzi3i6t2v.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 9 Mar 2018 00:41:48 +0100
Message-ID: <CAM0VKjkkFR-zVQMMqp0pJn489bV1uqEHZkB8Mo789J0K+qO3vA@mail.gmail.com>
Subject: Re: [PATCH v1.1 1/2] t9400-git-cvsserver-server: don't rely on the
 output of 'test_cmp'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 9, 2018 at 12:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>> diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-ser=
ver.sh
>> index c30660d606..5ff3789199 100755
>> --- a/t/t9400-git-cvsserver-server.sh
>> +++ b/t/t9400-git-cvsserver-server.sh
>> @@ -449,10 +449,9 @@ test_expect_success 'cvs update (-p)' '
>>      GIT_CONFIG=3D"$git_config" cvs update &&
>>      rm -f failures &&
>>      for i in merge no-lf empty really-empty; do
>> -        GIT_CONFIG=3D"$git_config" cvs update -p "$i" >$i.out
>> -     test_cmp $i.out ../$i >>failures 2>&1
>> -    done &&
>> -    test -z "$(cat failures)"
>> +     GIT_CONFIG=3D"$git_config" cvs update -p "$i" >$i.out &&
>> +     test_cmp $i.out ../$i || return 1
>> +    done
>>  '
>
> This makes "rm -f failures &&" unnecessary, no?

Indeed, it does.
