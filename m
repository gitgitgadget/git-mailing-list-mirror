Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5140920179
	for <e@80x24.org>; Mon,  4 Jul 2016 15:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbcGDPZ4 (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 11:25:56 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38324 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666AbcGDPZx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2016 11:25:53 -0400
Received: by mail-wm0-f43.google.com with SMTP id r201so119938532wme.1
        for <git@vger.kernel.org>; Mon, 04 Jul 2016 08:25:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=d2NmZd1eiqDe9LrKA15FV4IeaIzRql0GKBw2PEFhmlc=;
        b=VhDLMdTvdLycnrjyWgGGQQ2280JvizuAswXGDgABUE6FslDxVihzKDeHzC/G9VWFTg
         wpCjpaz0/O1Ykb5mfog+XFQ47N75QCUwHd8aTCIOhjXmV7M/931av/6NW2e63VpaX5YT
         9o67j1hh7xukmYADqjht/fMKaOBViX9VSFsc59eZ9ny4MUPu05w1h4c+dq2DluYHt/+A
         9/e2xl3MqeMVqNbI5ApbFBGohdDDOpxz2Rn1odbMrDb7Rd/buY+51NjZro6zyC1Tml9+
         Jwt2nji1Gbygj0L1QuMErLkvi9HFzClSRE7tWecmukcMopMHOn8WIrZlhZUwiypE6GFb
         GoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=d2NmZd1eiqDe9LrKA15FV4IeaIzRql0GKBw2PEFhmlc=;
        b=jn8QfbQ7b91CJFAinkwnVXBlhvB/kwQwsdcehDNbi4dZBlKBqh1q2tIrckOqr49E/j
         WX5TJdQPKs5M6hIIbG/4vg10Iyh+ht4T4erGt5rgJ8pVCrYA9jqOukaa21ejO+hozXkc
         /WZD+M9JKFUMjnip/DXyusOEAuf/6jerUHJsRGuDcgibPpj6BCIkoHPoHBpeW0RZSYk5
         PlLO7p1rC8ptMinadFsOpv/J50AOcIng3dNU7ihTM+1yl5m1b0OgXrQrjHx9f8khiDnV
         gXnRQZSISo52Dfb0+K98+56blZaiCH/HVMfMlGEoOn7a+S+mastRh+uKyteZxsP0CulQ
         B8Kw==
X-Gm-Message-State: ALyK8tJ2R/Rx0fup0Jt7m6vzkBA9nN5qNTKLUvco1Tr3y6hw8d2XVyCiqm6F3Wp5atRofQ==
X-Received: by 10.194.109.199 with SMTP id hu7mr10942291wjb.6.1467645951612;
        Mon, 04 Jul 2016 08:25:51 -0700 (PDT)
Received: from [192.168.1.34] (ewv108.neoplus.adsl.tpnet.pl. [83.20.245.108])
        by smtp.googlemail.com with ESMTPSA id 12sm3059769wmj.19.2016.07.04.08.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jul 2016 08:25:50 -0700 (PDT)
Subject: Re: [PATCH v4 1/5] git-fetch.txt: document fetch output
To:	Duy Nguyen <pclouds@gmail.com>
References: <20160605031141.23513-1-pclouds@gmail.com>
 <20160626055810.26960-1-pclouds@gmail.com>
 <20160626055810.26960-2-pclouds@gmail.com> <577A6DBB.2030902@gmail.com>
 <CACsJy8CoSwM9W-HX2X9rA9NbJBVQ8BzySJjp3XjXBK+5r1tXZg@mail.gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <577A7FFB.6050507@gmail.com>
Date:	Mon, 4 Jul 2016 17:25:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CoSwM9W-HX2X9rA9NbJBVQ8BzySJjp3XjXBK+5r1tXZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-04 o 17:17, Duy Nguyen pisze:
> On Mon, Jul 4, 2016 at 4:07 PM, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 2016-06-26 o 07:58, Nguyễn Thái Ngọc Duy pisze:
>>> +summary::
>>> +     For a successfully fetched ref, the summary shows the old and new
>>> +     values of the ref in a form suitable for using as an argument to
>>> +     `git log` (this is `<old>..<new>` in most cases, and
>>> +     `<old>...<new>` for forced non-fast-forward updates).
>>
>> It would be nice to have documented here also other <summary> formats,
>> like "[new branch]", and/or mention that if the <summary> is not usable
>> for `git log` it is put in brackets [].
> 
> Can I do it in a separate topic in future? We may want to unify this
> and the output format in git-pull as well, then include fetch format
> in git-pull.

Yes, of course it can be added later.  Though it feels strange for docs
to talk about <old>..<new> and <old>...<new> format only (note that it
is also suitable for copy'n'paste to `git diff`, not only for `git log`)
while having "[new branch]" in examples / later patches.

-- 
Jakub Narębski

