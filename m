Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87A6320193
	for <e@80x24.org>; Wed,  2 Nov 2016 17:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756411AbcKBRog (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 13:44:36 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37482 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756367AbcKBRof (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 13:44:35 -0400
Received: by mail-wm0-f48.google.com with SMTP id t79so52516740wmt.0
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :message-id:cc:from:subject:date:to;
        bh=GQa83grsFCeoIe5scsZxoJkXaEBhetBPrlBc6CpOSr8=;
        b=KNATllVuwm544n/9w2N1lmDm/L3IN+MdG/NJxA7ExFa5Q8FsCIYgF388sWle/K8+r+
         nIz0CwrphdxIugkZ4gG8MsTU2PFdKUDPggHEUVqCedTzA2PZjMHFM3UGtQ/mLO1QKTrF
         5mlMZH8PDTfl3FQ9TDH6ZOmV0ed8lCFp8XZwrFxzgEhuL1EoJJXhSKVa9OphPJ9dvZGC
         nESikCgdl1yBIhHkq/pC4y0vvHMvR3sPNLEJ20tzk7jHC1P5C5HwRHYyLH4ivaCoZcKL
         qRut4PBYBKAKMgEPwz0ztTXvjF7d849Ts/fchfubX2AcV9SuqYauzN54JZgckrlePLx4
         3sUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:references:in-reply-to:mime-version
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=GQa83grsFCeoIe5scsZxoJkXaEBhetBPrlBc6CpOSr8=;
        b=LaJ52Q0+2tmDGKNCdquXFm99eKb+yZCjBdlkBicZ7DByBV5wJKS+1d7acpB6jXs3wH
         nv/L1RCJFANC0CgycBPdj1UYpYRB+rIu2nBp4lVItUvFL3HwPyr/XwPgAQEu88aDOZ0A
         ThN1CPhCJGXi9K23zlYYL4okiYNQTh1HxWylDh5wBbBVXXYew6YKnY9A/ZM4UGE4eLzN
         0VisTEJjjJDsrsGfROMgUGAlcEVXrxX3MycFHAK4q4+R7wQjcs2WnDYPU32EIEEDlIR7
         bIwwiOlhuvkouBHQPkPMfQP8CHNI0lKLGD30evWnK5B+7xHTdEZm93CdtgBnQwA25Fve
         a+sw==
X-Gm-Message-State: ABUngvdsNFqMtI4nloJMgYijBvoc96yUYw2JvAPRuj+UZTNb58KNquyuWmnRiFuvruTfdA==
X-Received: by 10.28.227.4 with SMTP id a4mr4249983wmh.84.1478108674113;
        Wed, 02 Nov 2016 10:44:34 -0700 (PDT)
Received: from [192.168.0.103] ([47.60.176.155])
        by smtp.gmail.com with ESMTPSA id g17sm4012484wjs.38.2016.11.02.10.44.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Nov 2016 10:44:33 -0700 (PDT)
References: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com> <20161102170415.GA6420@tb-raspi>
In-Reply-To: <20161102170415.GA6420@tb-raspi>
Mime-Version: 1.0 (1.0)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
        charset=utf-8
Message-Id: <64EFD774-BA23-4FAB-8942-03185F447EF2@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-Mailer: iPhone Mail (14A456)
From:   Lars Schneider <larsxschneider@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2016, #09; Mon, 31)
Date:   Wed, 2 Nov 2016 17:44:31 +0000
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        mlbright@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2 Nov 2016, at 17:04, Torsten B=C3=B6gershausen <tboegi@web.de> wrote:

>> * ls/filter-process (2016-10-17) 14 commits
>>  (merged to 'next' on 2016-10-19 at ffd0de042c)
>=20
> Some (late, as I recently got a new battery for the Mac OS 10.6 test syste=
m)=20
> comments:
> t0021 failes here:
>=20
>=20
> Can't locate object method "flush" via package "IO::Handle" at /Users/tb/p=
rojects/git/git.next/t/t0021/rot13-filter.pl line 90.
> fatal: The remote end hung up unexpectedly
>=20
>=20
> perl itself is 5.10 and we use the one shipped with Mac OS.
> Why that ?

Thanks for reporting! It surprises me that flush is not available. I don't h=
ave a 10.6 system to tests. Where you able to reproduce the problem on a new=
er system with an older Perl, too?

@Martin: do you have a clue?

I can't debug the issue right now (only on mobile) but I will look into it o=
n Friday!

> t0021 uses the hard-coded path:
> t0021/rot13-filter.pl (around line 345) and the nice macro
> PERL_PATH from the Makefile is fully t

Can you check the line number? Rot13-filter.pl has only 192 lines. I'll look=
 into the PERL_PATH.=20


> Commenting out the different "flush" makes the test hang, and I haven't di=
gged further.

That would be expected because the pl file writes output to a file which is c=
hecked by the calling sh script.

Thanks,
Lars=20=
