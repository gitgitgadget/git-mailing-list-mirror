Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E7762047F
	for <e@80x24.org>; Mon, 24 Jul 2017 04:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbdGXETC (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 00:19:02 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36044 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbdGXETA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 00:19:00 -0400
Received: by mail-pf0-f193.google.com with SMTP id 1so1416435pfi.3
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 21:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TxHn4ik3zNxe+C2hbxnDSYQ8LEUudbCxTkMeHryBTiI=;
        b=pW19zIAkktVcyTEVI0ywHsabMCfHNL0RiloOGA2Z2g3pOKOKjuwYcVNdcAJ0eAxCzJ
         4WYPbs4zYhdwVbbzX6OmSEwFWkG9Hr3EIxw0H0w4DLYGGVLJrADOdpd/JxZwHWMf8ZiU
         TrGQPUftRLdVdNSx8PAQGLiDDohfA4wGYdE1Wl4AXhEZwpj4UFLrynaaoccDswLqQN0n
         /hQ//TSAYUh1vpe62x19GlXOLqxcqSZJFgrgPOliOjmNFDVZCHNse6pZzpv8wqFzzxpJ
         W5HkQrowX3+nPSbfQQygNEsVcA/fRL59IXJhyizR+rzuYPtCEkxlKWbvhKI3TSa76c17
         Lnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TxHn4ik3zNxe+C2hbxnDSYQ8LEUudbCxTkMeHryBTiI=;
        b=qpAqRxJLNUbClq0mNxDctC+pthYC1CYNrom97Ln4aZggXTV63eIbeMFYAW7mMQSCdK
         GIW1fZMOZnegX0gH3z3n3dku2VRF0FL74EpibTSYkEhE+cjawMh2kajt7ii1k8V/ugUO
         PMNZMdi0kv4MZahTUFSM8/9pSZICe0HgcOuG4wjpeZFtrgeVp/twt1qp6anIWa3zg8mA
         9WQvCTRPSsbeyRRYyUkJdgA0GgYu5I0TOejdD+fH9PFiOh2ktAHeGk0ipUjHyJHbSvXS
         Z8kbkA/M/XrRppwzUbGKZEDDsABfXlYfHeyCrEeIIQP6F5ih/6reXbvoV2dvo/5NO2k0
         NdYw==
X-Gm-Message-State: AIVw111RKdw9iE7ZxiX671hd5X50YQ9OVnfcLlpGedSkGp4Tg7NWZLxs
        Eogrxd3KyqUyIg==
X-Received: by 10.84.202.163 with SMTP id x32mr15928228pld.99.1500869940015;
        Sun, 23 Jul 2017 21:19:00 -0700 (PDT)
Received: from [10.45.43.99] (220-245-230-18.static.tpgi.com.au. [220.245.230.18])
        by smtp.gmail.com with ESMTPSA id e4sm22016747pga.71.2017.07.23.21.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jul 2017 21:18:59 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Should I store large text files on Git LFS?
From:   Farshid Zavareh <fhzavareh@gmail.com>
In-Reply-To: <nycvar.QRO.7.76.6.1707232109480.20418@qynat-yncgbc>
Date:   Mon, 24 Jul 2017 14:18:54 +1000
Cc:     Andrew Ardill <andrew.ardill@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <45DFB089-EDA2-4F51-9948-18B84C933FB1@gmail.com>
References: <AC260BC2-FED8-4811-9F5D-220EF1DAAA53@gmail.com>
 <CAH5451mrL=GE6WrX6juoyGPV6trcQhXXthKhjT2=qCDCiffeeA@mail.gmail.com>
 <FF08CB42-35AC-4B97-BB02-2473BEDE66A1@gmail.com>
 <nycvar.QRO.7.76.6.1707232109480.20418@qynat-yncgbc>
To:     David Lang <david@lang.hm>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I see your point. So I guess it really comes down to how the file is =
anticipated to change. If only one or two line are going to change every =
now and then, then LFS is not really necessary. But, as you mentioned, =
text files that change drastically will affect the repository in the =
same way that binaries do.


> On 24 Jul 2017, at 2:13 pm, David Lang <david@lang.hm> wrote:
>=20
> On Mon, 24 Jul 2017, Farshid Zavareh wrote:
>=20
>> I'll probably test this myself, but would modifying and committing a =
4GB text file actually add 4GB to the repository's size? I anticipate =
that it won't, since Git keeps track of the changes only, instead of =
storing a copy of the whole file (whereas this is not the case with =
binary files, hence the need for LFS).
>=20
> well, it wouldn't be 4G because text compresses well, but if the file =
changes drastically from version to version (say a quarterly report), =
the diff won't help.
>=20
> David Lang

