Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F1611FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 15:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754451AbdDRPE4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 11:04:56 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33664 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754208AbdDRPEz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 11:04:55 -0400
Received: by mail-wm0-f53.google.com with SMTP id y18so13563720wmh.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 08:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:subject:references:from:in-reply-to
         :message-id:date:cc:to:mime-version;
        bh=W0csAydRCpiUlSijIHNYQVS123h6K5GJRgcaC2POA00=;
        b=QxluRhcAgUl32+nn2X1zRyzZ6MS5DI816bfAvviQt2cp453G3njMgBN4MDOFu8/aym
         LBsDxG8SLXvbj4asKEiweORMg+T8JOA1SS+aSeUWyxKUHAaivgEQ2fPGaBV/rPz0lLKj
         rwS70DZHucwL9A8F9wnLsH/naWpbajBGQPcwRr7zCyTfhh2i24g4JmyW/WC83LO5VDjM
         5YKizHPtscVXVz9CnoYyZ2UAVYtk+jNFReSZHE9YyLFVTwRVICxUoLKbeT5AFx+Vw9O0
         PdGHP/dJbVqDCQ3ra/SmIocKqheIdWC+fykoBnJh99nxMN+sPtf4hVkAMtDTk20JnryJ
         U/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:subject:references
         :from:in-reply-to:message-id:date:cc:to:mime-version;
        bh=W0csAydRCpiUlSijIHNYQVS123h6K5GJRgcaC2POA00=;
        b=pQyahr+OIPMQWHmLavg8syXAeh5YkzwDeQk3n3vlx2Ob5BH08nJXTDgdm4Wdwdpepe
         oX0Vau2CsRYxNjySGlEGCmj2IM1RH5Bns1kpkv1eGKp1IDBmG4gdbadpyNPpxmDQsD3d
         80AXTE9IaL4L9cRxzD8PHtR+rRHFP4eiODkeyEHpAuXqmT7UPpg6OTqU1kF03yJ+JnwN
         wPNBybUDXDffhJGaQXeAwjhYKALdpgkYNLJ5wwZhq/C+fctbbliyhCIXLCVA2HmAX11E
         15pCyFnFjQbuZHbwLeyJnPGo++jyvpHUN6wfVsybKfcxNC5dAnvtyKMUCIicTMavB6Vx
         JljA==
X-Gm-Message-State: AN3rC/5nG8ElDPQavuUCRQCt4g1r8/xedRMOFehA+lnp2aMZqwDf+Sj8
        dw4V3Z4rNRi9AQ==
X-Received: by 10.28.184.207 with SMTP id i198mr9601466wmf.104.1492527893746;
        Tue, 18 Apr 2017 08:04:53 -0700 (PDT)
Received: from [172.16.1.108] ([92.70.185.162])
        by smtp.gmail.com with ESMTPSA id i144sm15314027wmf.13.2017.04.18.08.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Apr 2017 08:04:53 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/3] travis-ci: build docs with asciidoctor
References: <20170411083309.58315-1-larsxschneider@gmail.com> <xmqq37dcorr7.fsf@gitster.mtv.corp.google.com> <63CA5B3A-8AEA-473B-9F4C-86C2BBB0530F@gmail.com> <20170418104411.hdkzh3psvej63tqw@genre.crustytoothpaste.net>
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170418104411.hdkzh3psvej63tqw@genre.crustytoothpaste.net>
Message-Id: <D9F45212-91F7-4BB1-A0EC-74A84DA81860@gmail.com>
Date:   Tue, 18 Apr 2017 17:03:50 +0200
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Mime-Version: 1.0 (1.0)
X-Mailer: iPhone Mail (14E304)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 18. Apr 2017, at 12:44, brian m. carlson <sandals@crustytoothpaste.net>=
 wrote:
>=20
>> On Tue, Apr 18, 2017 at 10:32:59AM +0200, Lars Schneider wrote:
>>=20
>>> On 14. Apr 2017, at 00:41, Junio C Hamano <gitster@pobox.com> wrote:
>>> Having said that, I wonder if we get some interesting results out of
>>> building the documentation twice, though.  By looking at the Travis
>>> log with timestamps, we probably can see how long each build takes,
>>> but that is much less interesting than learning if new versions of
>>> text used mark-up that does not format correctly on one or the other
>>> (i.e. catch documentation breakage early in each CI run), for
>>> example.  I have an impression that neither AsciiDoc nor AsciiDoctor
>>> "fails" in an obvious way that "make" can notice (i.e. they often
>>> just silently produce nonsense output when fed a malformed input
>>> instead).
>>=20
>> True! But wouldn't we get a syntax check here? Wouldn't asciidoc / ascido=
ctor bark if we use wrong/unsupported elements?
>=20
> Asciidoctor isn't very strict about questionable items.  If you want
> that behavior, you'd want to check for output to standard error during
> the make process, as Asciidoctor uses Ruby's warn function.

That sounds good. I'll check stderr in the next iteration!

Thanks,
Lars=
