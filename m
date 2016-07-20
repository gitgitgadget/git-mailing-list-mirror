Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C34071F744
	for <e@80x24.org>; Wed, 20 Jul 2016 20:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314AbcGTUiw (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 16:38:52 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35571 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbcGTUiu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 16:38:50 -0400
Received: by mail-wm0-f46.google.com with SMTP id f65so189565511wmi.0
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 13:38:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hm7T/+HSjZhoHH4mm4fqYyydksUpeQ0BaXUoSsHIzMg=;
        b=HxBW62n2DhsptefMbqDVrjus099+A3wrbXgDml/U1ZvWjQSNcPLaqz7fwao4CbzFPg
         8SedivxXyi7SNuM+0g+UmH3Rgvf3wuAMbBfQEwQYLWv7RU/VW+nTC3xvHMxdm4ZEKIVq
         16UkGXharjd/3flB+aSRsYO0oAvKgIIvuo6bYhwwdSEn1OWUS15Ul1B/6Jbr0iKE4PKo
         edZXxHFjGDBQoV3eMifWcGLFVmQ9jJCY/Vd//KxqeW1EBTYXRzZst3Hmf8T8acpSHtCV
         ni+BRbdePlJm9kw98FSNbu4mW537/i+rAYdnlVTHdLRkNcqBaDuC6zysOZlS6/68AcRR
         oziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hm7T/+HSjZhoHH4mm4fqYyydksUpeQ0BaXUoSsHIzMg=;
        b=ZjXYx/9ZfQfpNQWPQq7d/opDqNEMoedKnu6wFCMslFhde/79zkIHKiejofipGkjD4O
         I3Nuxjmi4G84GTPq+X4ZHFjD3gPa2MWxf5uuHy3Rm4cILn6aw16k+YTiIr9G0GRKkoIN
         ogm9En2VE5AT6AuDQCfCgHgRd5iX1bPRjR+l+sBCGgYqpEUKqhqgbVfbIXEN1j3iIW9J
         n0FElxsRfsFBSqfQ5zObEwTJjmyN2UXr20ktaE4y0tLS7mUHqeHix3AdlMm98Ip69xyB
         ODwfwfc8J4AIlULOZ6D9UoJzBvcz1omhbcXXTUNrv1x6CVzNvuF8DvzzCW31Yo8uVHZL
         gWGg==
X-Gm-Message-State: ALyK8tLSeZJczDaelHNMa+7x4Wliv0lu3vMLECPCcz+f6ibLXLJFmc4bpUuN633pi5g3J5RGn2ZxEgVOYSpQxQ==
X-Received: by 10.194.51.167 with SMTP id l7mr3180028wjo.78.1469047123017;
 Wed, 20 Jul 2016 13:38:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Wed, 20 Jul 2016 13:38:42 -0700 (PDT)
In-Reply-To: <CAPc5daXoL+v-YWy-EQ=d-8m9o8twv6Cs5U_NL14KGzPMVNQUPg@mail.gmail.com>
References: <CAP8UFD2PjKHkcs-EWzDU6eWF9ar7BzOxRB838iFr6iDAaGnkeA@mail.gmail.com>
 <CAPc5daXoL+v-YWy-EQ=d-8m9o8twv6Cs5U_NL14KGzPMVNQUPg@mail.gmail.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Wed, 20 Jul 2016 22:38:42 +0200
Message-ID: <CAP8UFD1TWYct7OJDcP+w8AYNTroquZ++T_1ovt-Z7SrBtn_S+Q@mail.gmail.com>
Subject: Re: [ANNOUNCE] GitRev News edition 17
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 8:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Wed, Jul 20, 2016 at 5:58 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Hi everyone,
>>
>> I'm happy announce that the 17th edition of Git Rev News is now published:
>>
>> https://git.github.io/rev_news/2016/07/20/edition-17/
>
> Micronit. 2.9.1 (or 2.9.2) would not be a "major release". 2.9.0 was,
> and x.y.z (z > 0) are "maintenance releases".

Yeah, I wondered about that when I saw :

https://github.com/git/git.github.io/commit/d2eb8fbbb30594d19fcda731c309ad03229dc5d5

but forgot to ask or do something about it...

Thanks,
Christian.
