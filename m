Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 615AF2034E
	for <e@80x24.org>; Wed, 20 Jul 2016 15:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbcGTPzy (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 11:55:54 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36589 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbcGTPzu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2016 11:55:50 -0400
Received: by mail-wm0-f47.google.com with SMTP id q128so61956199wma.1
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 08:55:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jjzH+9AWJJFIBCOvVgHkWd5DBKX95FIudirs6iBXx5A=;
        b=fjGWzZC+ON89iinvSmyAtxRvs/JX6S4XUCtsdWPZpjS0maCSgUkX3GLf6+8Hbzt8Xn
         iizewJbZFjuvsHckbrmiWIdrXDz3mqqBqLEeeY7g+xk7/PMdteWjFt1imZnK3amgef3R
         MNVAXXcPoa2afZIsTEYn2Is0yD3BtttfH+/MpkNcmb5jALZb6Vu7jo0hnKe3dUJeHxYP
         RaKD8r4b8Vh0XoNDmla3cbTayRJwU3XnL5JXmU9/iLXwv/GpkQTAPLy68I+HynjQuQ0H
         OAbFvCRO0KiVQMzCKpJeOox8rqlmkzYmsNrt6y354S+BIK0p87EHMufhiFyRO1x7NMhP
         qlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jjzH+9AWJJFIBCOvVgHkWd5DBKX95FIudirs6iBXx5A=;
        b=d/tAcYWEVnuP/YWHXrowv2kr6cZi1Fidg72G3ALbs7jQalZmkulukVglLiPtgJi0ZB
         aKMCBHCMrUGEbmfOTl1XcJh/ROID8qMnxPtsb8Mp5onhVJ2kaUIygKuEwtsUNMB9Hpqq
         u75/hxKTpIP4Pdvr57ZjPWjuDktxEsUr4q/QLCC85qnecyBGXz0/WgI/wztdQ+S1WVjr
         ++BjlU8sNqJuODso2zXtMXdGQ8e9pHY5MEcF253T2jdkbDXUNFcXhCBoriHcDP+S+noz
         sE0RhAxKDx8OEdG5T3tszZMyRFaylvxXZTQyyyiVUyUza4JPaV7MzSV8PCVpQj16zmTC
         aIEA==
X-Gm-Message-State: ALyK8tI7ouyMDQX71vIzf1S44das5Jo3Ex2ggMG2we7iiODdEoKpLIlvJ6/hw39anTWSQZ3RcSToLiMXrPcCaw==
X-Received: by 10.28.168.206 with SMTP id r197mr11977433wme.15.1469030148559;
 Wed, 20 Jul 2016 08:55:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.102.70 with HTTP; Wed, 20 Jul 2016 08:55:09 -0700 (PDT)
In-Reply-To: <578F9BC8.4040809@jeffhostetler.com>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
 <1468966258-11191-6-git-send-email-jeffhost@microsoft.com>
 <578F98BC.9060201@gmail.com> <578F9BC8.4040809@jeffhostetler.com>
From:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:	Wed, 20 Jul 2016 17:55:09 +0200
Message-ID: <CANQwDwcjppbjfmgAf0pp_DHjF7pic153zkYHGeDKB70dxnw+9w@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] Add porcelain V2 documentation to status manpage
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 20 July 2016 at 17:42, Jeff Hostetler <git@jeffhostetler.com> wrote:
> On 07/20/2016 11:29 AM, Jakub Narębski wrote:
>> W dniu 2016-07-20 o 00:10, Jeff Hostetler pisze:
>>
>>> +Porcelain Format Version 2
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +
>>> +If `--branch` is given, a header line showing branch tracking
>>> information
>>> +is printed.  This line begins with "### branch: ".  Fields are separated
>>> +by a single space.
>>> +
>>> +    Field                    Meaning
>>> +    --------------------------------------------------------
>>> +    <sha> | (initial)        Current commit
>>> +    <branch> | (detached)    Current branch
>>
>> I was wondering if all possible combinations are allowed.  It turns out
>> that for technical implementation reasons it is not possible to have
>> "(initial) (detached)".
>>
>> Just something I was wondering about, no need for any change...
>
> Right. I don't think that combination is possible.  Not sure how
> to document that succinctly.

I don't think it is something we need to document, at least not here.

-- 
Jakub Narębski
