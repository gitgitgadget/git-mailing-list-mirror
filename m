Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35DD71F790
	for <e@80x24.org>; Tue,  2 May 2017 12:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751060AbdEBMc2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 08:32:28 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:34830 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbdEBMc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 08:32:26 -0400
Received: by mail-it0-f51.google.com with SMTP id c15so36287180ith.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 05:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mvGLRuy4+gmAEQJS+ejWxL3sA7LE7iiDKGBaJUXLiI8=;
        b=OxeG9WSXDlPQA8NqiYmpMSgEBU+l1h4NBobRlS2zj89iqf1T5lYmbY6O8b3GZRiT8w
         UE6QDhnrZadVl4uRwDBbnJPDO7mSqjSOolGCNU2gE7++jHcBw7i9U/2jixXd/IC3o6tr
         iX22qPuPJHwkPZd1FUj0I8K4KMcpGpUw9o2YHVAgR/EZd5neBSG/78mrx5x+CSiEiTkt
         j21pMInVrPcRm9Ox4UcgSVqobstZEVny6snhGxmcaUP+rRfipVASJIJjvMmJy53uN5BV
         rOfXyfIO5a3HCB+n7uNuzSFsFTBYy2l5w01RRaa9V6IBMNfGRblwC6+jOG+Tk5oc2a58
         oftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mvGLRuy4+gmAEQJS+ejWxL3sA7LE7iiDKGBaJUXLiI8=;
        b=ODzgFkyZg69WrrgZxLPP/C6Y7UMnMGpihy+C4VjRCdiSUQNu+yI2Nr44SHpQhz2Baa
         ovWzpZedVobpYF6XAr9/FO2c1YZdJmG2jcH3FDHqgdSW24aZBiWVhq3wdmD+znDBRTKk
         F8yLkhn0MGRIZLM1MWG4dhEAgheNFu4aEWISjOCjkVUa8RNzjyNf758hItdozGKo2dDG
         X3Nzo94HCfJ/w8eUmzsTzqRH/lLzgH20239WikRO8h1pkSsXcXn1lHMaBDfzgwr3eO6P
         JxlERD2hZZXnojdLD659d0kCF7rU4g1F1+TDyqZ4tZVcdyrMeBBL5yhFf/7af9RVKO9j
         YoAQ==
X-Gm-Message-State: AN3rC/5t16brJwNWJPHErPm5FyvKXMHrNso3FX9dRFmBoD1qvUDI0zSE
        It39KQ4xq/IhZZewDCw6CB9fknjO1Q==
X-Received: by 10.36.26.87 with SMTP id 84mr10644936iti.94.1493728340134; Tue,
 02 May 2017 05:32:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 2 May 2017 05:31:59 -0700 (PDT)
In-Reply-To: <xmqqr307d2jc.fsf@gitster.mtv.corp.google.com>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com> <CACBZZX4ty91vh=ykMtpF0pV8Ru3BKWBXyQYsFRdPkKkxMd8pzw@mail.gmail.com>
 <xmqqa86wgo33.fsf@gitster.mtv.corp.google.com> <CACBZZX5N0L_M9b4RTRLSvcA2u69H=s=S-VEc-Nr71wW6Scyjvw@mail.gmail.com>
 <xmqqr307d2jc.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 2 May 2017 14:31:59 +0200
Message-ID: <CACBZZX53Y50CbmkPb1USmXF4E+BzBbyo_Sr=H+Q55rujF9+ZvA@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #01; Mon, 1)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2017 at 11:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>>> That squash looks good to me.
>>>
>>> Thanks.
>>>
>>> That is not a particulary helpful comment, by the way.  I can help
>>> topics by contributors by queuing emergency fix at the tip to make
>>> ones that do not build correctly buildable and testable (which is
>>> what the "SQUASH???" commits are about), but I'd rather not see me
>>> forced to find among 19 commits which one is broken and needs the
>>> hotfix squashed in myself.
>>
>> I'm happy to change what I'm doing to be more helpful, but it's not
>> clear to me from this & the context what that would be.
>>
>> * I sent a v4 that had this bug in <20170425210548.24612-6-avarab@gmail.=
com>
>> * You pointed out that initialization bug in response
>> * I sent a v5 of just that patch (not the rest of the series) in
>> response to that in <20170426074856.29903-1-avarab@gmail.com>
>> * You replied in <xmqq1sser7ty.fsf@gitster.mtv.corp.google.com> in a
>> reply I (probably mis-)read as "no worries, I'll just squash the fix
>> in"
>
> Sorry, I completely forgot about our exchange around your v5.  If
> your comment were "squash is good but you've seen a replacement sent
> as v5 that is not there yet", I wouldn't have made such a silly
> comment, but given that I've already responded to your v5 saying
> I'll handle it, that is asking too much from you.
>
> What I pushed out a few hours ago should already have the fix in.
> Thanks for clarifying the situation, and sorry again.

Okey, no worries. Was just a bit confused & wondering if I could make
something easier for you in the future.
