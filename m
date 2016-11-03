Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6BA6206A7
	for <e@80x24.org>; Thu,  3 Nov 2016 14:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757904AbcKCOVV (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 10:21:21 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34974 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757501AbcKCOVU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 10:21:20 -0400
Received: by mail-wm0-f52.google.com with SMTP id a197so208502457wmd.0
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 07:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :message-id:cc:from:subject:date:to;
        bh=vT88lJjlJHqoIgw77cxphcgdu/eZNtm3rkGNerpopPk=;
        b=n7iXinm87/TzwudassSXkgmm5woNad/Qt2WIfz/e08+8ao/7Iyz798q63zqoZEVB60
         d7q1zsx+FZ8UA6wr3Hnn+GRV+azRuPSfBs4ZL05nDppq6Y1R8TcKkOapFkeozID+QysJ
         Grvi2mS2dZwGfz6WUGd3TM8cNXhsKSnnwrvTb0xomBGGP14JPDtg9VkWwc6yCknTtBcF
         HjR8IwqHxm5871kMNCErdgR2HnB7sOShweVSDjGwPHGoan9JNVhlQKF46nChr8m6YBp5
         35Whyo7ZXEaZOAjhmNMKfkQQ6A1Gxd9znXboXBgUMNvOc+V3/AjuK1kzMcAC+zy++KXJ
         mvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:references:in-reply-to:mime-version
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=vT88lJjlJHqoIgw77cxphcgdu/eZNtm3rkGNerpopPk=;
        b=Vvf/ksjzMtOLF4rAZPcN9BAGxXwV1TSRB6tj/YM+xjlB4xitSASd3tFvmHlqp0ykaA
         kt1T7tvN6UuFjERsrenfrFvYjXPsWLNYUWYkYesXCOYMCc2wDDqD96kqLlNpy8dAVI8e
         SO+J4KGR/GMbLDnOjkCJ2WS1uCpGJptmxZ9LvVgJ2J61ZYQoASUkKZpaM19i5QQBzagn
         v2ahdBbbxSWkG7EdtPDDI7jd+QXUTqxOiAslgC3kihDkqDJp3NGwoV8ZCUyWEP0tP48t
         knNjJvU+3Ds9RvYbWQmaPDc0in0Wp4XR6uAUoILTDx3WN+xcr9eE+LjpCQRenBAXAGoU
         ZxSA==
X-Gm-Message-State: ABUngveJXyID2IKEch89bwEgs1exyoCKmnuhx7k0LNwNXuh6nQp7CqwgOVPAMAFFYHnLxQ==
X-Received: by 10.194.110.73 with SMTP id hy9mr7633569wjb.139.1478182878579;
        Thu, 03 Nov 2016 07:21:18 -0700 (PDT)
Received: from [10.80.143.13] ([195.76.49.194])
        by smtp.gmail.com with ESMTPSA id 71sm42402732wmo.7.2016.11.03.07.21.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Nov 2016 07:21:17 -0700 (PDT)
References: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com> <20161102170415.GA6420@tb-raspi> <73aed2a3-f2ad-ecc2-d43c-86b4a110a970@kdbg.org>
In-Reply-To: <73aed2a3-f2ad-ecc2-d43c-86b4a110a970@kdbg.org>
Mime-Version: 1.0 (1.0)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
        charset=utf-8
Message-Id: <421804D4-56C2-410C-B579-0E92D15B446F@gmail.com>
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-Mailer: iPhone Mail (14A456)
From:   Lars Schneider <larsxschneider@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2016, #09; Mon, 31)
Date:   Thu, 3 Nov 2016 14:21:15 +0000
To:     Johannes Sixt <j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 2 Nov 2016, at 17:43, Johannes Sixt <j6t@kdbg.org> wrote:
>=20
> Am 02.11.2016 um 18:04 schrieb Torsten B=C3=B6gershausen:
>>> * ls/filter-process (2016-10-17) 14 commits
>>>  (merged to 'next' on 2016-10-19 at ffd0de042c)
>>=20
>> Some (late, as I recently got a new battery for the Mac OS 10.6 test syst=
em)=20
>> comments:
>> t0021 failes here:
>>=20
>>=20
>> Can't locate object method "flush" via package "IO::Handle" at /Users/tb/=
projects/git/git.next/t/t0021/rot13-filter.pl line 90.
>> fatal: The remote end hung up unexpectedly
>>=20
>>=20
>> perl itself is 5.10 and we use the one shipped with Mac OS.
>> Why that ?
>> t0021 uses the hard-coded path:
>> t0021/rot13-filter.pl (around line 345) and the nice macro
>> PERL_PATH from the Makefile is fully ignored.
>>=20
>> Commenting out the different "flush" makes the test hang, and I haven't d=
igged further.
>>=20
>=20
> https://public-inbox.org/git/e8deda5f-11a6-1463-4fc5-25454084ccb1@kdbg.org=
/

Woooh. I am sorry Hannes - I completely missed that email! Looks like Peff a=
ddressed the issue already. His patches look very good but I want to try it o=
n my machine tomorrow.

Thanks,
Lars
