Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A09BD20193
	for <e@80x24.org>; Thu,  4 Aug 2016 16:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965320AbcHDQ5s (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 12:57:48 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:32775 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965494AbcHDQ5p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 12:57:45 -0400
Received: by mail-yw0-f196.google.com with SMTP id z8so20715834ywa.0
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 09:57:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M4sQ86toNQI8Siey+6WuE+zEdO7/P+hPAnTRevRgqH4=;
        b=XgyPaPgpvIoQsRG2kPjBmEjyuJkdZHeTMAhZ2KxrMVh+CuiHX/xWbceeIOpS8L9WBN
         b1RgHIlg/P98J0VLwG+Isn0bioIwG5W2n+S153iRZdK12Uqx/ZfRFMjEiUKpAdQLCsHX
         dsVnXT5xdLU4tIor4SV9VjdMn5YIhFdcwrpUyKoL1Jok8ZWG+ivtSnJQJhEyh/BEt85Z
         MNYzmackZhPHzbP7OlBDU8UC7G4jEYqWfo9kxTPnUH386URV0i47CjLsQ4A8W8B/Bkn2
         HbcaC7MrY26a6nXax/wChaGU+2O5AYJOPNq0QA68mHccrBVSvf8Kcxeagk+uOkFP8ZEL
         05Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M4sQ86toNQI8Siey+6WuE+zEdO7/P+hPAnTRevRgqH4=;
        b=VgkHVNnn6JYDOEFmN395r+yRcpI1E1mTpAmVrs5BtMDWolh/G+T+DOqZwPzDh0E13u
         pGCjAyEn0wGJOvVRtTNBLTZmj9yJRYApl7D3W04StrwKf14Fuc6ilzQ76zCzcBF9rpWB
         aueB9fn+6aw7UZ3JMFxViTAagLptulNHvgFf7KrNkedchhJYaC0p+6egtvSDqcxumpvE
         MQCJTS4CtgCYIy0ZG5a9uEBAVAUezgzSmUO3rROg54EUZpVKdqPqPF7LWbl3fHPiAOxl
         s5Y3pKa0ip4OhHVL1kDXvnBaAVob0PXNxrnKeEc7qNLPlvNEohErTFEuswDZuFZ17Xid
         nQPg==
X-Gm-Message-State: AEkoouvapx+69Ei4+n7nDrxpwuArXppf+EwV4s6PnvR6PqWC006AwEkTt1pBvYNyoo4hv+tcqF/7ZtfNfyIJWw==
X-Received: by 10.129.50.147 with SMTP id y141mr56694702ywy.305.1470329859831;
 Thu, 04 Aug 2016 09:57:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Thu, 4 Aug 2016 09:57:39 -0700 (PDT)
In-Reply-To: <xmqq1t245vhj.fsf@gitster.mtv.corp.google.com>
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
 <0102015640423ce6-5b11201e-736d-413f-be12-7fed613ae484-000000@eu-west-1.amazonses.com>
 <xmqqy44fdpxd.fsf@gitster.mtv.corp.google.com> <CAFZEwPNFohRLCS4piB1t0LO-=keucwzRKZ2Jyhhf234tnWnVGg@mail.gmail.com>
 <xmqqr3a45yi7.fsf@gitster.mtv.corp.google.com> <CAFZEwPMdOawVT6W6Ko=xkMLu4PcWkd0s_GiJA-T5uu-oY2m23g@mail.gmail.com>
 <xmqq1t245vhj.fsf@gitster.mtv.corp.google.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Thu, 4 Aug 2016 22:27:39 +0530
Message-ID: <CAFZEwPMpgJDcEqO0A5xqYc99=kECqAr57SL+3z07CRgt-gbUSg@mail.gmail.com>
Subject: Re: [RFC/PATCH v11 04/13] bisect--helper: `bisect_clean_state` shell
 function in C
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Junio,

On Thu, Aug 4, 2016 at 10:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> Hey Junio,
>>
>> On Thu, Aug 4, 2016 at 9:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Pranit Bauva <pranit.bauva@gmail.com> writes:
>>>
>>>>> Also you do not seem to check the error from the function to smudge
>>>>> the "result" you are returning from this function.
>>>>
>>>> Yes I should combine the results from every removal.
>>>>
>>>>> Isn't unlink_or_warn() more correct helper to use here?
>>>>
>>>> The shell code uses rm -f which is silent and it removes only if
>>>> present.
>>>
>>> Isn't that what unlink_or_warn() do?  Call unlink() and happily
>>> return if unlink() succeeds or errors with ENOENT (i.e. path didn't
>>> exist in the first place), but otherwise reports an error (imagine:
>>> EPERM).
>>
>> Umm, I am confused. I tried "rm -f" with a non-existing file and it
>> does not show any warning or error.
>
> You are, or you were?  I hope it is the latter, iow, you are no
> longer confused and now understand why unlink_or_warn() was
> suggested.

I meant to use past tense. Did not re-check before sending it.
