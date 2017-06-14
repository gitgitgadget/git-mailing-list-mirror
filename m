Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ABAE20401
	for <e@80x24.org>; Wed, 14 Jun 2017 07:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754511AbdFNH2H (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 03:28:07 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32911 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754386AbdFNH2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 03:28:06 -0400
Received: by mail-wr0-f196.google.com with SMTP id v104so36672624wrb.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 00:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=g+V17PPBw9XrTeISnu+7xEf4Ldj4rmEaVofP+rVuiz0=;
        b=jr5cE1LyOS/y8tYsweDR0Ji/SfhDjslBdghTPpIVYiqEC6ueb+Wpgj1SwL9MvCmPML
         6OAmfc4hN0G5TVeyXNZgYpVMhWybt2bmvOOKzxdfqBbwRFx50JWP1nszCm+sEMz1Ylgw
         5bL3nKRioOcGgT0iXqYhuPT5ZbUCfZDlNQt0RWOnf8rxW1S0rAroJfQZE4eHY12ebnOU
         tSBSyWVjvjiPUlb3KaT3y5Zcx4HF68QTkitnlZ/MVaT3XxCSXSPi9PGGo66saUDf1Cud
         mEkKN6W2aN4/yQ7zhLy7U+yOvBsNXHmJsSWvIH9XCoKWTkGpxDQSRUnTAmH2mPa4vZ8C
         xFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=g+V17PPBw9XrTeISnu+7xEf4Ldj4rmEaVofP+rVuiz0=;
        b=C+F47EI+3ESNJIGZ7Ae9mteXDoycnmqYxOl3KwyuCDtc7sNn50NRxrvLr9103F5Uot
         FxA/7wn2cawscfT3iLNDLy/BZn5IH2VTJI3EP8xfdZHX2UMpvRk8jvK4hAz27cvfBPsc
         ZnPmVsQQmHiJmE390MmUNVriDLtS7SfjTo/eXMIuuS9+l2HlpUAuB/PmxfA7SYvxbzN8
         lxjCHdxmgD0DNO+b3lk37XK4exyhdw50sFaq08SuK1mg8NT9Td/oLVuzUx5nDvYjaiNg
         uzPUYXqwlNubw+wLrIg0llgEMhQqCk6R4b4QIuwEQZ3owvvOB4wJxvjCcZjRZ4CcXmf3
         JpIQ==
X-Gm-Message-State: AKS2vOx74BYhuCZXGG5cSBwOF101vaSjSnX/TDA80r7WVRCti43kELoJ
        +hCsSvbxvDbN4w==
X-Received: by 10.223.134.198 with SMTP id 6mr5254580wry.63.1497425284753;
        Wed, 14 Jun 2017 00:28:04 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4E74.dip0.t-ipconnect.de. [93.219.78.116])
        by smtp.gmail.com with ESMTPSA id e24sm149705wre.54.2017.06.14.00.28.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 00:28:03 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] Configure Git contribution guidelines for github.com
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170613090427.igjz7erniblh3wie@sigill.intra.peff.net>
Date:   Wed, 14 Jun 2017 09:28:03 +0200
Cc:     git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.org,
        jrnieder@gmail.com, avarab@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <FEFF27D2-1A56-4F37-8114-126613C144A0@gmail.com>
References: <20170613081807.33196-1-larsxschneider@gmail.com> <20170613090427.igjz7erniblh3wie@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 13 Jun 2017, at 11:04, Jeff King <peff@peff.net> wrote:
>=20
> On Tue, Jun 13, 2017 at 10:18:07AM +0200, Lars Schneider wrote:
>=20
>> changes since v1:
>> * mention submitGit
>> * link to mailing list address instead of mailing list archive
>=20
> You might want to link to https://git-scm.com/community/, which has a
> section on the mailing list at the top. It gives the list address but
> also talks about the archive, that you can send to it without
> subscribing, etc.

Agreed. I removed the mailing list email address as this is not
useful until you have subscribed to the list.

>=20
> The text itself looks good, but two minor grammar nits:
>=20
>> diff --git a/.github/CONTRIBUTING.md b/.github/CONTRIBUTING.md
>> new file mode 100644
>> index 0000000000..fc397bb8fc
>> --- /dev/null
>> +++ b/.github/CONTRIBUTING.md
>> @@ -0,0 +1,19 @@
>> +## Contributing to Git
>> +
>> +Thanks for taking the time to contribute to Git! Please be advised, =
that the
>> +Git community does not use github.com for their contributions. =
Instead, we use
>> +a mailing list (git@vger.kernel.org) for code submissions, code
>> +reviews, and bug reports.
>=20
> I think the comma after "advised" is unnecessary (you could also drop
> "that" to turn the first part into an introductory clause, but I think
> it reads better with as "Please be advised that").

Agreed!

Thank you,
Lars

