Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4429E1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 17:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbdGYRk5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 13:40:57 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36454 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdGYRkz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 13:40:55 -0400
Received: by mail-wr0-f194.google.com with SMTP id y67so19565364wrb.3
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 10:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BIws0S5RqA9WedPG2M2E5dBtJC2sohklpFQ3g74amuI=;
        b=dTBWCdYCXPAUF+M33Bouyyh1z4Unkli6uG091zgGewuXfcRpUTua6ZvzeGwzxB8/eB
         9ff33m2WOwGvl15irhsVMClBto3F+7RfNy45HErf3l+STrPXlXHOGiaPvR7netqwKBoB
         VSH6SuffqDaWbxQfgvxJkVOvrQoYlh+atGFCU6sKgyoFe8EC2nIt/57puBHbW0g/r6XE
         AN6cgrxalVOcYmE/lVoXjrffVxz/zVhXvBKTQdKBUNAl3VssBCh58mBPBRqXi0jut2S4
         EZNquNSsq7Y9vm+fg3jLUk0nR77LTJjQ05NZ7mAi3Jks5Va6er4hU2sTgRstacnJl9qn
         QrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BIws0S5RqA9WedPG2M2E5dBtJC2sohklpFQ3g74amuI=;
        b=QchmgcyUkiTyAV6fyzDUz2879sVS9LyBM/556+384CzFu0EH5C4ShXw+7rgtptDj1w
         GuZDGvfYMFE73Rvu55m2B5eGQuWtVxaIepxqwwpXBRDsgiohCzvdPUh3X2dxVWQmzUq7
         SZ0ta+6pxTSySMWy8tHUhwsGkqZH1wKlWOvqd/Z43c5ARGjKR5tycExFVt+0uPfia/jV
         RFXJhF64WSFrhagMV8eY7htCi0jJ7aoYeQSEaEm98mWdKe1yagcjaHznaM8wTlIMwc8N
         X7SvgZAvwgZl8ip1FyQXjn+3Tq2ghfDbCvv8ODRQUZNljB4VBYfiCxH+113vBC4llseI
         RLUg==
X-Gm-Message-State: AIVw110AUM92f9Qq8+/MNxBfAzF8urG5OYmZcKyIKn9wQYWpqNSQoAF1
        at1XANt0CX19TsoCl2k=
X-Received: by 10.223.150.200 with SMTP id u66mr18718681wrb.216.1501002878991;
        Tue, 25 Jul 2017 10:14:38 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id u66sm22693773wrb.77.2017.07.25.10.14.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 10:14:36 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Deceptive site ahead Waring
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.21.1.1707251600370.4271@virtualbox>
Date:   Tue, 25 Jul 2017 19:14:36 +0200
Cc:     Christos Angelidis <angelidis@csd.uoc.gr>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6FD60D91-E1F9-4A24-9D08-4AE81633574D@gmail.com>
References: <5d10822a-c697-e117-441b-d162cc40801c@csd.uoc.gr> <alpine.DEB.2.21.1.1707251600370.4271@virtualbox>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Jul 2017, at 16:01, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>=20
> Hi Christos,
>=20
> On Tue, 25 Jul 2017, Christos Angelidis wrote:
>=20
>> Just tried to download your windows version app and a warning  from =
chrome
>> popped up saying
>> "Deceptive site ahead", maybe you wonna check it if you haven't done =
it
>> already.
>=20
> Kindly provide details. I am really certain that Chrome did not leave =
it
> at three words.

Google recognized GitHub asset downloads as malicious.
The problem should be fixed now: =
https://twitter.com/kit3bus/status/889819401947631616

- Lars

