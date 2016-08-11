Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9931F859
	for <e@80x24.org>; Thu, 11 Aug 2016 08:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbcHKI4F (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 04:56:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33303 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbcHKIzV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 04:55:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so86333wme.0
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 01:55:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4ymDwTaVBbe51TQuMj9AJwgOucotSvpx/n9vbUg0dxU=;
        b=OnFTpxZMhLGie8iudkkAmoro3hlL0ivmO9IuCUbNbNbIWWWezI2TVW6FELEWT404Nv
         fY5Ngw3nKxoVJHlBAyMVcChImfHjGKD0WnQFrY+boFmSIaNKklQXMXgCvKeNJgcfkQH3
         QZT4u9th5k0+IeqsbwQ2P6PtKmikH4mFkgxU5/56mB4154DPOmwsk5NJMR8uEwYDxx3A
         Np1N+IIe+OscdgjIkpFo2oRgRD5vo5/6gBsMbrMo+GiL/M3/43db4bo7OVDpMOwzWyn+
         1DjVgjObCGe1eN9o6/WfPrkkpWIs/O0gDJAbS7VNX61MADZK/+x5o8f8E+DJ02/H/Z0l
         ptJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4ymDwTaVBbe51TQuMj9AJwgOucotSvpx/n9vbUg0dxU=;
        b=JJOyYTVlVJoiPyyh/+gkhOBxVf8F3FWj2j6BqEKKvc3Yw1IKD1nUbRX907IGhpKMvw
         n60qwXtlH//FNy3bhbcYJ43V828r2wTxAOrRUS22SlL2A2oM9cmC4knDhd83fedhp43J
         wEkpxsXB5M76DN+l29h2HYtyiCI5AOBQIsd2NPIOVO1RHorlDzBSVbmP7xMkiH12VXnV
         oEJx+K+EYvfcVo3ynIyVNkhR/lHO/ZrJvPBX6Ik7PniOrjH7Euikp87i+UsqJdhxmHy9
         9mNrDL9Z9toit4lA22f/x7G0NM+QONPAD+oa87/8fKxWnBhqizUH8MjEBnz3tu+0HT+v
         x2bQ==
X-Gm-Message-State: AEkooutvKf4qyNI75tN3DWw8CD60lOP4PMQOwt9YS0cPid73IiTsVXlkkIz3G+kkPHBY5n9YXGZj3//9LFtScA==
X-Received: by 10.28.113.151 with SMTP id d23mr8315159wmi.89.1470904860187;
 Thu, 11 Aug 2016 01:41:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Thu, 11 Aug 2016 01:40:59 -0700 (PDT)
In-Reply-To: <50063bbb-aa5f-cf75-310e-f8305ef30d2d@atlas-elektronik.com>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
 <20160808210337.5038-2-chriscool@tuxfamily.org> <50063bbb-aa5f-cf75-310e-f8305ef30d2d@atlas-elektronik.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Thu, 11 Aug 2016 10:40:59 +0200
Message-ID: <CAP8UFD1kuriMbc4u89aPgQAjonRZiDH=6H7JjE_a_=tUnNSPaQ@mail.gmail.com>
Subject: Re: [PATCH v10 01/40] apply: make some names more specific
To:	stefan.naewe@atlas-elektronik.com
Cc:	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>, "l.s.r@web.de" <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 4:51 PM,  <stefan.naewe@atlas-elektronik.com> wrote:
> Am 08.08.2016 um 23:02 schrieb Christian Couder:
>> To prepare for some structs and constants being moved from
>> builtin/apply.c to apply.h, we should give them some more
>> specific names to avoid possible name collisions in th global
>
> s/th/the/
>
>> namespace.

Thanks. I will send an update with only a new version of this patch
and of 28/40.
