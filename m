Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FA851FE90
	for <e@80x24.org>; Tue, 18 Apr 2017 08:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756214AbdDRIdI (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 04:33:08 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:35409 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755895AbdDRIdD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 04:33:03 -0400
Received: by mail-wr0-f182.google.com with SMTP id o21so97196109wrb.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 01:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :message-id:cc:from:subject:date:to;
        bh=5fclgz26xS41bzO4xuisWPJfftLh7+SIRhf1EoSjjs0=;
        b=Pgp8/S3kRC/Q93FbOvzzYuh4Rn64Z+w4O5Hy51PYuLM2UYgb7A1YPONxfBudeqnLET
         oOY85tDLRydRG8s9WR6XqR9H6qwkdTxA/4JdyHz8rEoVrrJYCszr1FTR/yVQ16r65CCe
         0m5uRG9ih5e70wawTXyY4sAD3seetJMsgjj1Zx07Y4EjBdhlRQxYF6buBlwcivkapRgG
         4Hg47C03LfpUfrSjlGeMcra8axNf7MypS0hReFXSvqtH4L8pQVl4DwRX77FvD+x1IV47
         l/3Kfgp8j908z5dCRnzqs7hNCyqpJ9ZfwJy71Gell1+64KwTzv6OggiOiIaOFO908HXM
         LHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:in-reply-to:mime-version
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=5fclgz26xS41bzO4xuisWPJfftLh7+SIRhf1EoSjjs0=;
        b=SV9rgt0c6Of9Ssz7EIsxZewM5xGTBkJCHmi7ndKfaQSTGCGnBw3v2NQIUiKaz44Q3/
         5rYGtnE5/HzJ6A9KWxoXNTI56szqbpt/0FGNHR79F/eYm7eW23dOcRaLByDqlWHWBMGb
         eTUCcGra4vjgQHjutYdbuFR2a/IqHGWK3NYjk+gNbZ5PuzC944Z95XNlrC2ZODhTV8jU
         uEKepbpYpkPabMK7gdholqya6jK64QzulkprVkG/jFwoZY1w/v9r0tqYyNnZOlDHCPAp
         0ZVdaMIcajvsBJVyUh5FmhfS9qhP8vhwyk0AauNFTys1pz7eTUQXPRAogxeRqT7Wuslm
         3hbw==
X-Gm-Message-State: AN3rC/5Vn7r9GADpFAvla0QNj/6vXMrQ8EVddFRhPfEhMYlaIPIJX6cQ
        x2l6kzN+vCDGPA==
X-Received: by 10.223.135.58 with SMTP id a55mr21936735wra.138.1492504382457;
        Tue, 18 Apr 2017 01:33:02 -0700 (PDT)
Received: from [172.16.1.108] ([92.70.185.162])
        by smtp.gmail.com with ESMTPSA id j185sm13958571wmg.23.2017.04.18.01.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Apr 2017 01:33:01 -0700 (PDT)
References: <20170411083309.58315-1-larsxschneider@gmail.com> <xmqq37dcorr7.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq37dcorr7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (1.0)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
        charset=us-ascii
Message-Id: <63CA5B3A-8AEA-473B-9F4C-86C2BBB0530F@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
X-Mailer: iPhone Mail (14E304)
From:   Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 0/3] travis-ci: build docs with asciidoctor
Date:   Tue, 18 Apr 2017 10:32:59 +0200
To:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 14. Apr 2017, at 00:41, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>> this is a mini series to build the documentation with asciidoctor in
>> addition to asciidoc on Travis-CI.
>=20
> Overall, this looks sensible.  I didn't spot anything questionable
> other than a minor style nit, i.e. write these
>=20
>    make doc USE_ASCIIDOCTOR=3D1
>    make -j2 doc USE_ASCIIDOCTOR=3D1
>=20
> more like this
>=20
>    make USE_ASCIIDOCTOR=3D1 doc
>    make -j2 USE_ASCIIDOCTOR=3D1 doc

OK! I'll change it and send a new round next week.

> Having said that, I wonder if we get some interesting results out of
> building the documentation twice, though.  By looking at the Travis
> log with timestamps, we probably can see how long each build takes,
> but that is much less interesting than learning if new versions of
> text used mark-up that does not format correctly on one or the other
> (i.e. catch documentation breakage early in each CI run), for
> example.  I have an impression that neither AsciiDoc nor AsciiDoctor
> "fails" in an obvious way that "make" can notice (i.e. they often
> just silently produce nonsense output when fed a malformed input
> instead).

True! But wouldn't we get a syntax check here? Wouldn't asciidoc / ascidocto=
r bark if we use wrong/unsupported elements?

In addition, we could push the resulting documentation somewhere. However, t=
hat would still require a human to look at it. Do you think that could have v=
alue?

Thanks,
Lars
