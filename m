Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C24881F453
	for <e@80x24.org>; Sat,  3 Nov 2018 17:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbeKDDKI (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 23:10:08 -0400
Received: from mail-yw1-f44.google.com ([209.85.161.44]:40380 "EHLO
        mail-yw1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbeKDDKI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 23:10:08 -0400
Received: by mail-yw1-f44.google.com with SMTP id l66-v6so1674981ywl.7
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=HwmGyNf7fjPLin+4QjQCoN0i/fs5P/5Z8p0ARCi9CV8=;
        b=fXJq8cmrjQXMxsXj4xCqqnVsBVl1xt2q9tOjhZbx5LJhgjLMxXEpRCPr+amrQ0/QMU
         rXDh8s9fR1tF8a52nMj3LD/jX8+pLxQLgCKl5qsxzLtDUFRH4WKP95D5n50rE7Lo6aX5
         DpXMEFTz67HPxmcwbvilnYsy1tBXdqI9b86a53fqMgw9yvzRTxTDDHDobzDyCQ5TZNyF
         uf/iUfsPVqiNnjtFLPYRjHeG9T0yScQQTS0p7a+ITLyiLluJVsAeLwIZVfVX34wP1QnM
         yeCVr29axipMEh52FCtb1RTbla23RhMcpI/iFEI5A5ESoP5esXG5Op27A3Q1GtHNY34M
         xrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=HwmGyNf7fjPLin+4QjQCoN0i/fs5P/5Z8p0ARCi9CV8=;
        b=OHQp193NFxOcdSIjSlGJbAf0TMibjsp6IcYBouQvn5RKVE/SGB66yLOkfiuQUFtTlI
         9byswdTclIjhk3Z1SMwNqnYMi05RLvcDoSgMPUyUGptpDoAiarbU4kN+BJCe/oderpPp
         tsgVAAMfSU08i4EMAJT1Oi4bZhH4THrJOBkJXaCIrNHlX4fFU5brR5h3Xi9Wz5YDwkIP
         EoWWDFnkp8zib2qwOPCQ5cavnKhRRyyz7VyZHAxdJlX2LiLauakkEBhOTktTKzuEdwZS
         aedPdPFHM7wGV90OPZOfpQ/tGJwDAXpmfkl04uMjIe4/9w5ncjM33Zm4K1Es3xTbgyLY
         Svew==
X-Gm-Message-State: AGRZ1gKmlwu4HAwzkNT+iPS/+Hvxe7pnQP0GzTokLC1jQSTDLYKNTfSn
        pl89CTW9qzaw0nuM1P2mMco=
X-Google-Smtp-Source: AJdET5cGB1jNpjgk+Pq/e7l9vIjJTSDZIKNY5BOosstBHKpvhLnnsj89iVhYEhEVLfYoorXK7DJ0fA==
X-Received: by 2002:a81:af5a:: with SMTP id x26-v6mr15948949ywj.281.1541267890304;
        Sat, 03 Nov 2018 10:58:10 -0700 (PDT)
Received: from [172.29.1.127] ([108.191.26.71])
        by smtp.gmail.com with ESMTPSA id 207-v6sm9688704ywi.0.2018.11.03.10.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 10:58:09 -0700 (PDT)
From:   Sirio Balmelli <sirio.bm@gmail.com>
Message-Id: <E62F9E2A-70F1-47A4-B30C-2C767102CDCC@gmail.com>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_3910EBE9-535A-4AE2-A61F-2CE8E7C49C4D";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: git appears to ignore GIT_CONFIG environment variable
Date:   Sat, 3 Nov 2018 18:58:05 +0100
In-Reply-To: <xmqqpnvoqirp.fsf@gitster-ct.c.googlers.com>
Cc:     git@vger.kernel.org
To:     Junio C Hamano <gitster@pobox.com>
References: <3389BCF7-6170-4242-82D3-0FE7FB2EA5F2@gmail.com>
 <xmqqpnvoqirp.fsf@gitster-ct.c.googlers.com>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_3910EBE9-535A-4AE2-A61F-2CE8E7C49C4D
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Thank you very much, I appreciate the answer :)

best,

Sirio

> On Nov 2, 2018, at 04:07, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Sirio Balmelli <sirio.bm@gmail.com> writes:
> 
>> It appears that git ignores the GIT_CONFIG environment variable,
>> while git-config *does* consider it.
> 
> Yup, that is exactly how it is designed and documented.  These
> dasys, with "git config" taking "--file" to work on any arbitrary
> filename, you do not necessarily need GIT_CONFIG enviornment.
> 


--Apple-Mail=_3910EBE9-535A-4AE2-A61F-2CE8E7C49C4D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIzBAEBCgAdFiEEg12XAEksYqKi4XIsxM76bLJSdLMFAlvd4a0ACgkQxM76bLJS
dLPAyRAAxBvfWXhMKJSah/DevqwVI+n/cBxctz5XtOjNBrqxT6V0XutSQMp5JOSB
pAA+YWs1cRq9gN1XjLnQ3B+ayNxIHgn7fdiS6R4h5Qf5YcA9MuErp5DPIxI9Tgh8
ARpsRcf98zDCvVj2uNdWwl0MXsbdERm3Q+tT7aLAfIOP9QsAW3BdcMteoZE5/CDE
02zzD3cpDY2qPfQFyuwCt5vxuBKu5p9/v9LoluqIKkqbZzCpdu6mgiEjYbKMLXCU
ZnH5Y8XinjOJaM4evSg3VBvGbz05rN4puTaZNe5enLHUS8LUN5FCGMzDtqffUSET
vgzphgu018OZmvssCeHp5hSb0CywG1X+E6uc2dLjCq05WnKZLt99eH+Wj6rKyI5+
LoQvhTMRrs7YfOJi0afJaDUuvKI5eP1NYV9pVtj8EjFMq+42wkDo2wxWBZEZnymH
PWXrodjHaJ80Fx9zesUNcLVXcO9JjXOcPsbaihPfP6qgrHspHBnc2bCDlv7RYbly
lfs13XG2r3Y/8ER6KiVIblrurRyHnZbud3Jpt5aeDfLgFGZUgQckFB0NgTSKMcj3
BfnbMLYFh4433P5jGdCFq07TPhzfY1YS8m/xH8geRhS9TbAWBGZV7/Q26P0rE0J4
g9uaDCCPhuacqf8562fp6BC4feQ5/2ZQ5gZkbGAD66wKtn0Ouck=
=HXTK
-----END PGP SIGNATURE-----

--Apple-Mail=_3910EBE9-535A-4AE2-A61F-2CE8E7C49C4D--
