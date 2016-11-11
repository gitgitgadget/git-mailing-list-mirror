Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A7B02035F
	for <e@80x24.org>; Fri, 11 Nov 2016 17:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934463AbcKKRjd (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 12:39:33 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33818 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbcKKRjc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 12:39:32 -0500
Received: by mail-wm0-f65.google.com with SMTP id g23so10964566wme.1
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 09:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Q32ykVPHNZiG1NKiahlvXDpmal0rKfil+R1FU5Jiynk=;
        b=tR0mKx+Q9XMhzYsSgrLfeTMGdZ/GT1k7yIXPDZWm5HczssmzeJnUwR3SUGymTz1Lij
         VVw+DO2PMVw3SS8ADQheLVIzt2tXQxcJ7rthO8NtoU8w/64kVejB1d/IN/I2+WiDNvO5
         w+OTBK3GIbHPrNy9vimdG1tk3wZOSny1Et4yHxrxqrC1khyEpzhTNW4TEVee4i9HA/Rk
         d6w9UfowdJB12ROYxDSv3cWBGQQEbcwf2OOzLZC+HALBjkbdmWbKzOBaZgcEFxuet05O
         /vcxE1G5QRtEp8oP8FF/6HZ8a1eMQvRnyDoGCja8O2gjaxlfsDb33bXWHVmztS7WWlpR
         XXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Q32ykVPHNZiG1NKiahlvXDpmal0rKfil+R1FU5Jiynk=;
        b=Nz/88pMinlIrhb1HVChknqRzK3w/QqX/u/K3ZLGJGg33UaLqaU0pkyQ+fAkGEs91x6
         3kN5Bq2hIm4kkXt5f6iwKpO6VODzt0+rdLapCovQEfhRjdpVrgDjhKIMsLluQtfPqxBB
         mBuTK1reLoMyhFahk+I3KqgEV4Sk1lrLjJlqU2fGlUAYaMpuGYgOYHr+wngjLXlY8p8K
         dcZzjc1SNTn7uvlc6RQg+i6S/cPUUvCHahW1KD/rqAOogNDBdGTxlS84WF/Mgw99dJWD
         KSgyjidQxtnWealzqQbBByQRSqpl79R5HgXo2ZpZrLoEzHFyPzYOLLfPR4T+f9jgll4w
         f+bw==
X-Gm-Message-State: ABUngvdpYJqfVl+8jN4Skars8+9fbpW5vdvAZQhighFqNwTpk5F5oCG2hoYZnwp7vKPwaw==
X-Received: by 10.28.173.131 with SMTP id w125mr36171834wme.0.1478885891406;
        Fri, 11 Nov 2016 09:38:11 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id f134sm9920441wmf.19.2016.11.11.09.38.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Nov 2016 09:38:10 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <89DB812E-EC29-4D12-97EA-6E8FF6F86FE5@gmail.com>
Date:   Fri, 11 Nov 2016 18:38:10 +0100
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C3840B91-58E2-4563-9597-5EE514D97CC1@gmail.com>
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com> <xmqqoa1n57u4.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611111711210.3746@virtualbox> <4FF1825D-F699-4532-9B53-A673DFF00D8B@gmail.com> <89DB812E-EC29-4D12-97EA-6E8FF6F86FE5@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 11 Nov 2016, at 18:31, Lars Schneider <larsxschneider@gmail.com> =
wrote:
>=20
>>=20
>> On 11 Nov 2016, at 18:05, Lars Schneider <larsxschneider@gmail.com> =
wrote:
>>=20
>>=20
>>> On 11 Nov 2016, at 17:13, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>>>=20
>>> Hi Junio,
>>>=20
>>> On Thu, 10 Nov 2016, Junio C Hamano wrote:
>>>=20
>>>> Junio C Hamano <gitster@pobox.com> writes:
>>>>=20
>>>>> I'll report back an updated schedule when able.
>>>>=20
>>>> I pushed some updates out on 'master' today.
>>>=20
>>> Which means that t0021 is now broken also on `master` when running =
in Git
>>> for Windows' SDK.
>>=20
>> Part of the reason is that Hannes' squash got lost:
>> =
http://public-inbox.org/git/d36d8b51-f2d7-a2f5-89ea-369f49556e10@kdbg.org/=

>>=20
>> @Junio: Can you apply this (see discussion with Peff linked to email =
above).
>>=20
>> @Dscho:
>> There is still one remaining new issue with t0021 ... investigating!
>=20
> "17 - required process filter should be used only for "clean" =
operation only"
> seems flaky.
>=20
> I don't have any more time today but I will look into it tomorrow.

FWIW: This patch (which would be the right thing to do anyways) seems to =
fix=20
the flakyness but I can't be sure ... it needs to run longer...

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 9ff5027..107766b 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -29,8 +29,7 @@ file_size () {

 filter_git () {
 	rm -f rot13-filter.log &&
-	git "$@" 2>git-stderr.log &&
-	rm -f git-stderr.log
+	git "$@" 2>/dev/null
 }

 # Compare two files and ensure that `clean` and `smudge` respectively =
are


