Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0361C2047F
	for <e@80x24.org>; Mon, 24 Jul 2017 03:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbdGXDqd (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 23:46:33 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33171 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbdGXDqb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 23:46:31 -0400
Received: by mail-pg0-f47.google.com with SMTP id g14so2523514pgu.0
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 20:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=P16e85G8ZfM2yLAa/2oTllpWL1WezOpmOJJ6E3IY5gk=;
        b=VNO0g2GA+UJ52R433GetlyZ+yS+iqON0nMZ76OMsIZ/xvvgSxvJPkWZn79v5lwiSm9
         kdqroY9L6OqGeCKDDj/ROxqjQiCXsymo6xuOCQFvXJf9LsXiLJfaLTFRmtmeW++4Psq6
         vXpVkW9W9cHY3zNQDhM+Qb5KpZHLFKW9V7tmKMuxuJLVpfbJPoOU0FDMmEawwlVF9XHQ
         nGQnfhp40qM9oPSQWXx/kCSOtqRhSm15+EQ5BZW2DA3H3j6oCBbf9/IdKnde7uu4IRYp
         C5PXMsARbcJxz3IlDkEp2VPx4uRhs2uf/Yx7L9uSL0btC0XvsxwfgfkhZBfc54srNo6b
         iqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=P16e85G8ZfM2yLAa/2oTllpWL1WezOpmOJJ6E3IY5gk=;
        b=it3DaEc1xT5zzs9Z8rVR9ikx5AMytKr+nMGKvr1ny2nF8Gb7a4UTnS9tyk7w+ZVr5U
         QnfM04t7lRj8RIrzVgIWviXStkSaItYpmkcnIqQzIU3d+oq2vdHZreT+vrjwUzVyosyL
         ihmuD0GxQT8+BeH+KmboirwTO+OXLLMKIWhDok/ylMpyxy0oLaF8y+Y2SRICNg8qKxRH
         DmfU4tgufqVf2R3fURCmJ2V9BE88/Izo+Hv8wyYYN2mfMgp2G9uU+JVV2JOX3Puoln6f
         rC9pmoVV4Av238eKhzdfyEhL93pLrx29ESh/Vza32R2IyZMd0STLHag6srGkQ7L+HF8a
         WdFw==
X-Gm-Message-State: AIVw110WsoCPl00o3pe1ImP0rNSXO+5Ffr9aERMw3oRMP25gwLW73fHt
        IRW15gfxDIHY+Q==
X-Received: by 10.99.114.25 with SMTP id n25mr14698775pgc.290.1500867991042;
        Sun, 23 Jul 2017 20:46:31 -0700 (PDT)
Received: from [10.45.43.99] (220-245-230-18.static.tpgi.com.au. [220.245.230.18])
        by smtp.gmail.com with ESMTPSA id 79sm19256292pfn.51.2017.07.23.20.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jul 2017 20:46:30 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Should I store large text files on Git LFS?
From:   Farshid Zavareh <fhzavareh@gmail.com>
In-Reply-To: <CAH5451mrL=GE6WrX6juoyGPV6trcQhXXthKhjT2=qCDCiffeeA@mail.gmail.com>
Date:   Mon, 24 Jul 2017 13:46:26 +1000
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF08CB42-35AC-4B97-BB02-2473BEDE66A1@gmail.com>
References: <AC260BC2-FED8-4811-9F5D-220EF1DAAA53@gmail.com>
 <CAH5451mrL=GE6WrX6juoyGPV6trcQhXXthKhjT2=qCDCiffeeA@mail.gmail.com>
To:     Andrew Ardill <andrew.ardill@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrew.

Thanks for your reply.

I'll probably test this myself, but would modifying and committing a 4GB =
text file actually add 4GB to the repository's size? I anticipate that =
it won't, since Git keeps track of the changes only, instead of storing =
a copy of the whole file (whereas this is not the case with binary =
files, hence the need for LFS).

Kind regards,
Farshid

> On 24 Jul 2017, at 12:29 pm, Andrew Ardill <andrew.ardill@gmail.com> =
wrote:
>=20
> Hi Farshid,
>=20
> On 24 July 2017 at 12:01, Farshid Zavareh <fhzavareh@gmail.com> wrote:
>> I'v been handed over a project that uses Git LFS for storing large =
CSV files.
>>=20
>> My understanding is that the main benefit of using Git LFS is to keep =
the repository small for binary files, where Git can't keep track of the =
changes and ends up storing whole files for each revision. For a text =
file, that problem does not exist to begin with and Git can store only =
the changes. At the same time, this is going to make checkouts =
unnecessarily slow, not to mention the financial cost of storing the =
whole file for each revision.
>>=20
>> Is there something I'm missing here?
>=20
> Git LFS gives benefits when working on *large* files, not just large
> *binary* files.
>=20
> I can imagine a few reasons for using LFS for some CSV files
> (especially the kinds of files I deal with sometimes!).
>=20
> The main one is that many users don't need or want to download the
> large files, or all versions of the large file. Moreover, you probably
> don't care about changes between those files, or there would be so
> many that using the git machinery for comparing them would be
> cumbersome and ineffective.
>=20
> For me, if I was storing any CSV file over a couple of hundred
> megabyte I would consider using something like LFS. An example would
> be a large Dunn & Bradstreet data file, which I do an analysis on
> every quarter. I want to include the file in the repository, so that
> the analysis can be replicated later on, but I don't want to add 4GB
> of data to the repo every single time the dataset gets updated (also
> every quarter). Storing that in LFS would be a good solution then.
>=20
> Regards,
>=20
> Andrew Ardill

