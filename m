Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C1722018E
	for <e@80x24.org>; Sun, 10 Jul 2016 12:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933279AbcGJMYP (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 08:24:15 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:37764 "EHLO
	mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932411AbcGJMYO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 08:24:14 -0400
Received: by mail-it0-f53.google.com with SMTP id f6so36427979ith.0
        for <git@vger.kernel.org>; Sun, 10 Jul 2016 05:24:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d418qkLMJ9bgJalFMAlwOk34QRhLny6jxmBPOas/VKA=;
        b=0WGpUcXkPHvTr4YzG3z4M2+pKjE/Q1sgY786wDGAFySalZhAJUpdlzpkUBRCXJrJ0p
         nzMOu3Sjxbz7eW2Q03xQcZUxdrxB8jtJQmNm8VJgp3GZHDv16Z62A+7O6aoJrHCWp0QS
         8uXDZ0LHHuiupmOsctoCP7Nd7JsSsj64/KnWTKWsHxW5245AlmFTd3H+RgGvSES0aAbL
         0Ts0saQvidLX6ymZ6o1ikyCBGHOqPy8aTYOCYCqOjC7ZcJT1YajS8TV/Y+s1ok+h3U/M
         t/wp/r4dbf26DMMpL5GR9s47A+29QOonRBlPZ8WMmShwemXyAepRtpJu6y99M01m4o+1
         Ki7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d418qkLMJ9bgJalFMAlwOk34QRhLny6jxmBPOas/VKA=;
        b=LV4/9rU+GuhLI35P0kqoTBh/IWcYpAZ6VM+Ll9S/W7GU3EQq82Z1Qtft8reqOP15XZ
         AEIV9koDHlAer4HCf433V+upjjrRc2bAYzecbsCCNva9IE0YlQNcKAxzkUCQWZDY55VC
         WEG1A01FmpdbrvvZG5hRPw4xLirSkgF07K9I2tLNJS6g/rSmwShYygbIO1b1yLKTrb69
         PCcdD/bwRcKh5RYj40+7/ZRx0jSGQ06uhQy7o6x+KNnl1VhD5xcWuigUqZlTOk6XUzUD
         /lwmo1opzcRiSFO/p7veOnLUnG57fs3pnFlc2lesLI3Z8NV7vnNTGuinf6sf47n2t9cw
         Dm6w==
X-Gm-Message-State: ALyK8tK+N+daZi7xG0ffXWdshdqdp7ea5pbp9+Dkl6E88I+h43JjCKw1SrCGQc956dB8X/fRlKHzPBiGnuOaAg==
X-Received: by 10.36.65.29 with SMTP id x29mr10490521ita.21.1468153453550;
 Sun, 10 Jul 2016 05:24:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.12.216 with HTTP; Sun, 10 Jul 2016 05:23:54 -0700 (PDT)
In-Reply-To: <87bn254v7b.fsf@linux-m68k.org>
References: <CAK8tuqiZjfrvHCoxkFUqoDx0+9=FUxfE93aMhUkYYZAAWm-u_w@mail.gmail.com>
 <CAK8tuqhMiHqPoK4gk7onT+VXsLJE5ogcpu7dc=_8am+ifL=5yQ@mail.gmail.com>
 <87a8hubtw4.fsf@linux-m68k.org> <20160707033538.GA7595@sigill.intra.peff.net>
 <CAK8tuqiCMUjoS_xXKSJ4qiGK8ioAjfGsQ3_WO0OQj5-5-i7rOw@mail.gmail.com> <87bn254v7b.fsf@linux-m68k.org>
From:	Peter <peter.mx@gmail.com>
Date:	Sun, 10 Jul 2016 14:23:54 +0200
Message-ID: <CAK8tuqj8_Xgp1f+SPArmMHQs_+u6gOMnt958GXXRnTp4MAuB3g@mail.gmail.com>
Subject: Re: Fwd: git rm
To:	Andreas Schwab <schwab@linux-m68k.org>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ah, ok, I see now. But are there any other situations where the "-f"
switch is not needed?

Peter

On 10 July 2016 at 12:57, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Peter <peter.mx@gmail.com> writes:
>
>> So if I do:
>>
>> touch abc
>> git add abc
>>
>>
>> And after that I do:
>>
>> git rm abc
> error: the following file has changes staged in the index:
>     abc
> (use --cached to keep the file, or -f to force removal)
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
