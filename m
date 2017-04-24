Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F4C207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 16:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1172140AbdDXQCJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 12:02:09 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36148 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1172007AbdDXQCH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 12:02:07 -0400
Received: by mail-pf0-f182.google.com with SMTP id 194so14365769pfv.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=992bD5Xv9bc1ZcjsBV0ZxlDLQUZSfzPTAl2QiB2/NOg=;
        b=n6wwPGQhPtxgCMJ6XEsqHIXL5od7rUQkBcLeH4f6k80Nbal2wBHK+Ar+yS/odUK2iM
         XmDkAS/FDNNiCH+xOx2t2SirqdVnLJIJn+sRvKF/LZQRVCLWbQuw6Qv31R/SFh+TrlJz
         tmMAcPqY/lU2OswNZAFBnVAM28FwMydMUZqf/wbWGzJKLe3xihvHxE426KGqhghx4pSA
         IyeJ6syy1sQ1+utFjE6znTcGLCgnhJO3EvyMMQC2yvdvhnT+HD7/B74Q4rU3bHRvcp29
         h1BTpMe+WUOwzMmnB40VS8UoV23xmLkyv6pgECvEpUb4F5tuIm8PdaLUM/idFCZ4wLM4
         EnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=992bD5Xv9bc1ZcjsBV0ZxlDLQUZSfzPTAl2QiB2/NOg=;
        b=I+z0QlwZXcjSXQ7zo45x/UThKRKhVNwLeL8ev6O/h4Na6RnT3dcX8Iv5iskp7DXfRx
         lFUqfwQYj0hWFI5YwYIX5UhP/KMtNXybJTDMMyq7bQuqSNos4iQqUfQCjTQQwFBQ9Y7U
         7NXGZlIU+vHLPJqmfnZiF3Fi/+shENhZodjlrSs3SU5qlo+tRxWM2iO734AWpxUd3aHN
         1ucMLgZ382J6FacITkyMVplT3Bwco9u8s724EK3uS+fYauJRTKhoNbaf48fccD2z1eTY
         X68pYJcRaOdRPsHidpniLOoiCeLIFLqpQtL9X5gcsH18vtz4mlXpfPiRsgD+SBxjkK4G
         k9Kg==
X-Gm-Message-State: AN3rC/7dUT68fFRCAFMHZlH4dFElu0I8HcC74KhIY7k7zJIsnETtr+dH
        RvtfNQKOTSLkieKI9EPdr0tKE6c6KcGd
X-Received: by 10.98.24.195 with SMTP id 186mr25605438pfy.35.1493049726394;
 Mon, 24 Apr 2017 09:02:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Mon, 24 Apr 2017 09:02:05 -0700 (PDT)
In-Reply-To: <75974e19-4b8c-3f52-8358-b0c2ba1e57b1@freenet.de>
References: <ea2780fd-8d63-6060-fb17-df5720bbc3de@freenet.de>
 <CAGZ79kavV-58JyUce9BMO9S3LVKGeUBQU-Qt79LAR41xgr=MxA@mail.gmail.com>
 <4f4e6b6e-7917-49c9-f4b4-627eaa062915@freenet.de> <75974e19-4b8c-3f52-8358-b0c2ba1e57b1@freenet.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Apr 2017 09:02:05 -0700
Message-ID: <CAGZ79kaLeGDvTvt2_ZjjB=ZrGjz=9d7JLsMaaOX2TqpSVzroyg@mail.gmail.com>
Subject: Re: minor typos in documentation
To:     =?UTF-8?Q?Ren=C3=A9_Genz?= <liebundartig@freenet.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 23, 2017 at 9:22 AM, Ren=C3=A9 Genz <liebundartig@freenet.de> w=
rote:
> Hi Stefan,
>
> I submitted the patch to the mailing list.

Thanks for following through. :)

> Based on my experience I submitted another patch to improve the
> documentation.

Thanks for improving the documentation how to get started. :)

Cheers,
Stefan
