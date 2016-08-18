Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6E6C1F6C1
	for <e@80x24.org>; Thu, 18 Aug 2016 12:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbcHRMSI (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 08:18:08 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36356 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbcHRMSH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 08:18:07 -0400
Received: by mail-wm0-f53.google.com with SMTP id q128so238986742wma.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 05:16:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=2x3NWURxs6WcCsbmHALx+JKH5TkPceOmmmayZ+kAGM4=;
        b=LycKgYNZ0b1CuvAfyoUZHWk7YUrgurvttqkSfqK3OppkfoxC/NxtuAqMPKNPVrv3Wq
         CIClheGRru/Qjde4igS846yq3ixnfrB1oda5uedIvQdi6WU/89Y/NciERYFGvb7YW646
         fbXvWtleIX9FRnLXXt/O+4cKrfDPocWIsheluul1wPeBZCzp4PLBbz3tBApHdiW0T2tl
         ENaM/OU0txmP3fr4TRJObLv73azjyqdBDQGOs4haj5kt4cC0xGLUjbQoW9Dw5nYpamap
         /DnpK6t3MrA3cuzy6B+fHN3w0ywr2IHxV9Ryzhh5NNneTg1pbmy87lbdwWh0PmfGLd0Y
         1h8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=2x3NWURxs6WcCsbmHALx+JKH5TkPceOmmmayZ+kAGM4=;
        b=R7/i8LXgf36f71VKqO+4JZp+mmTbJDv3h/nbj3DNxLFLXAEiSrP2MngqMF5K/VirF0
         8XKM3p1bto8NdSHvfFS5mSQVLYv6Od08uFPRRr8/w4AQMAGpxT/mKoPkwDyHUZv3BvUs
         MJSf4JIiWcojGFrsOocOj47vCG05jEuKo2+8CaA/ntW6raFjigOfZRu92jG/piIjBGu2
         GldpuwOtYHxNYsGMYp7pR1lmNub9WZdDvNbZjo7JzmjP9jOKtZSpSHGZsTdbUv67ffhI
         mSbMNV/eruDVIStl5RxjGbyVRNreyNy/HOZsz1CEHkP9EytMA8Ja8LGHNSSsws8iYFBA
         3euA==
X-Gm-Message-State: AEkoout+5VOAEk+ldHCLDePP3xNfRQvJeSfkCWX0av3hDtTy7qC0VQ1KcSSjdZQpY5YAgA==
X-Received: by 10.194.190.232 with SMTP id gt8mr1971496wjc.141.1471522601422;
        Thu, 18 Aug 2016 05:16:41 -0700 (PDT)
Received: from [192.168.1.26] (abpo56.neoplus.adsl.tpnet.pl. [83.8.56.56])
        by smtp.googlemail.com with ESMTPSA id n2sm2022246wjd.1.2016.08.18.05.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2016 05:16:40 -0700 (PDT)
Subject: Re: Working with zip files
To:	Junio C Hamano <gitster@pobox.com>
References: <87y43wwujd.fsf@thinkpad.rath.org>
 <alpine.DEB.2.02.1608160926330.11774@nftneq.ynat.uz>
 <xmqqeg5oejmn.fsf@gitster.mtv.corp.google.com>
 <34d64f4f-3cda-385c-cdce-5f1852d545e3@gmail.com>
 <xmqq8tvwcvrc.fsf@gitster.mtv.corp.google.com>
Cc:	David Lang <david@lang.hm>, Nikolaus Rath <Nikolaus@rath.org>,
	git@vger.kernel.org
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <12866c04-f910-2a83-b445-6eada3d2efc9@gmail.com>
Date:	Thu, 18 Aug 2016 14:16:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tvwcvrc.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 16.08.2016 o 22:19, Junio C Hamano pisze:
> Jakub Narębski <jnareb@gmail.com> writes:
> 
>> There is also `textconv` filter that can be used instead; it might
>> be 'unzip -c' (extract files to stdout, with filenames), or 'unzip -p'
>> (same, without filenames).
> 
> That assumes that the in-repository data is zipped binary blob; the
> result won't delta well, will it?

Full solution would involve `clean` filter to rezip with no compression
(which should delta well) and optional `smudge` filter to recompress;
if round-trip bit-for-bit equality is needed, the original zip parameters
must be saved somewhere, e.g. as ZIP archive comments.  This was mentioned
in the earlier part of my email (which might have been not clear):

JN>> You can find rezip clean/smudge filter (originally intended for
JN>> OpenDocument Format (ODF), that is OpenOffice.org etc.) that stores
JN>> zip or zip-archive (like ODT, jar, etc.) uncompressed.  I think
JN>> you can find it on GitWiki, but I might be mistaken.
 
Using 'unzip -c' as separate / additional `textconv` filter for diff
generation allows to separate the problem of deltifiable storage format
from textual representation for diff-ing.

Though best results could be had with `diff` and `merge` drivers...

-- 
Jakub Narębski
