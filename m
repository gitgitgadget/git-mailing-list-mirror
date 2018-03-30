Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 423061F424
	for <e@80x24.org>; Fri, 30 Mar 2018 06:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750764AbeC3GmN (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 02:42:13 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:34767 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeC3GmM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 02:42:12 -0400
Received: by mail-wr0-f182.google.com with SMTP id o8so7237777wra.1
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 23:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FS9W2HkprEfTdxaE0k4ugt5JSMDI3sdBg2JibWpxjm8=;
        b=Kn5bngxwvhsQ/+nqd9Hkjsb4HIIfNfoN/4XWrm7Etxb59I5LIIm1KMVOwF0AUlrfUa
         sNb8HL8RV7mjjNT1BnBgbX0CHvBC+mRoz4TBwySiMfL0YMUbXZ2fV2Ttdr8zcW26Aq9+
         JFFEj17TrO9EUq5fKFaOw3qNGFzHgBgouptNGZPMCFxFEjVyTmcFp+CYaIvOA1js5Jxy
         o+3XovADIVG1p8UXK988Rur2r5tnXkdafiCUqXOCWEIl9BKB987tnRJdAxwGeT0AQf5J
         aQC10BZi9KrbMXGZWUUhn/hILpH32PzwAQJ6m8eEGxlggCEwp5dQbiTKSBE+mkwCKamB
         VbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FS9W2HkprEfTdxaE0k4ugt5JSMDI3sdBg2JibWpxjm8=;
        b=diZ88EHu42aSJwjm4Se9H0YgUSOgbeQs5OMtKxowHjXiCaLU6+hRokVyd+0cfrQZTO
         qoTS5Xpr/7RgvlgevrAvb2oTVwSnYg83rFMBB3qOrDHKcZZOaSSuLi3yFRsBr5skkivx
         85CYRl92RPzRkpJp8b0AA8LeAfUkoqddLk//4kLd1dUJx5D8EavqD7qSOoqrOPwY3HoX
         SiKUYPWaz3Y4/hKvWBGTy9F444Y8KgWLu9u0dMnsDoIsej98XC+nYnyam+0YkCV3I9SW
         y4R7sGIBYAjurddUWzSeQ+ylPviIzG/nFE8qBEggcvtqdooA1HWL7r5hJnUcnpZpSnBf
         /ErQ==
X-Gm-Message-State: AElRT7EVJWt59/dl6+CwNWiN7JyEQKz9EIxfaQSaFfJ2yPVdpY+7JlF1
        moK2J/qUkxYjET/iM8QIuc4GNYGSorI5b1dhGhA=
X-Google-Smtp-Source: AIpwx4+CdU6Z4UeK2Q6Ti/J7vE5apEUoULzlg/Sw5X09Bpk8/PqGUc77ieuOtcef2WAf9u5WuWVgTmePLLM3Stgh3OE=
X-Received: by 10.223.136.13 with SMTP id d13mr8372281wrd.271.1522392131294;
 Thu, 29 Mar 2018 23:42:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.156.140 with HTTP; Thu, 29 Mar 2018 23:42:10 -0700 (PDT)
In-Reply-To: <CAP8UFD2EjZ9-qeS-3oWWS8O8ayP92aXAxAb1qK9qjKKqDh7y2g@mail.gmail.com>
References: <CAL21Bm=U=p+tw5FSXXBU01Bm=YCS6oQQSseB-Xv758onmxszwA@mail.gmail.com>
 <CAP8UFD2EjZ9-qeS-3oWWS8O8ayP92aXAxAb1qK9qjKKqDh7y2g@mail.gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 30 Mar 2018 09:42:10 +0300
Message-ID: <CAL21Bm=hcvk7LUKP4PY5FgXJFBDanf-=MMzFEMv-1paUHfojYg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] ref-filter: remove die() calls from formatting logic
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-03-29 17:41 GMT+03:00 Christian Couder <christian.couder@gmail.com>:
> On Thu, Mar 29, 2018 at 2:52 PM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=
=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
>> Move helper function from strbuf to ref-filter.
>> Get rid of some memory leaks.
>
> The above seems to be the changes since v5. Usually in a cover letter
> (patch 0/X) there is both information about the goal of the patch
> series and the changes since last version.
>
> Repeating the goal in each version is useful for reviewers who might
> not have time to look at the patch series before, or who might have
> forgotten about it.

Thank you, I wasn't thinking about it that way. I agree, it's important.

Description:
The main idea of the patch is, if you want to format the output by
ref-filter, you should have an ability to work with errors and final
message by yourself if you want to.
So I decided not to touch signature of show_ref_array_item(), but to
move all die() invocations to it. So that we could invoke
format_ref_array_item() and be sure that we could handle errors by
ourselves, and we also get formatted message so we could continue
working with it if we want to.

Thank you,
Olga
