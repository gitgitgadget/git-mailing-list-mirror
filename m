Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7C6D20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 14:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbeLNOAK (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 09:00:10 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:43632 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbeLNOAK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 09:00:10 -0500
Received: by mail-wr1-f43.google.com with SMTP id r10so5522469wrs.10
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 06:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OfFY5zmJXRroYdKWfYPNxCGibhhWpKJPe/o+cCyme6M=;
        b=W+ULIcBpv3VYf2LKljz6EnwGzhpLmDsWVZD0dQWMs1/pgMqoxlWMa8aofL+dwF4iG/
         GMohyW1FbXglg4rr6DsM2Y/uVNF6t06Gb8RfS6mThGiOQYALfdvzc3ormtI1ePjVMUMD
         Z4tftPh/0Ly0yuBnB46a5tm8+FW7mMDi5C03bGF+TbJ0Pj2xAEAClM0oqoDXLk5tJcjq
         1SsdNXeZ91PHT0a3xozSehuooNmpKZ2FwX2Xy2HCp5wAWKnyq1XuVLP6QwSxRNnFF85j
         a0vbCPj/dIht2c9eKEkQmIDtFPxHo5/t/bbEJC+fa19pTHOV3BQsVR2Mpe3jJIrrv8lJ
         K1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OfFY5zmJXRroYdKWfYPNxCGibhhWpKJPe/o+cCyme6M=;
        b=QUmF/GxtHnQLX1E1y/R+VlDNWppHIXsAz6LrqxTWE3/JBdSNRDqQ3zrH8k+EsfdlI1
         hdo2pLdTiQO02wWtSXOmJamwPEMHX3nSPgISta59y1ON52nd++ZcoDhqJvkREPmHJ8+h
         +lUHAHYOqJMhucpVeDXiLx+GbxWrV+xUNLBO21KlI1barTMtPq9ro+qisOdZCHDQ5hN0
         gWxYTZmMr2BcKahDhaAprhrq6ePls1KzFpUG2jzNQK0/mAE38KVv0JyOdRPocIlpB2AU
         XiXcEZfOerbEA4LvIf1vnGm6bdPMItzxDymcHFM6EHcl/vxVpfhDm13ZG0UAQuTZP++V
         20Rw==
X-Gm-Message-State: AA+aEWY4XL0Kq7ZkFD27Rvc858Ta3xz/2RmCixM/EA1NxFmJfHbkCnAc
        X7Dnx/BvDcJrnmIHs8SSeXw=
X-Google-Smtp-Source: AFSGD/VtdnL8aD3+ovnSrfULBYCedqMV2Hv0E7kP2qhCIVdz8c9J74O7W/RWoTEcWfeKl6zBTeJtJQ==
X-Received: by 2002:a5d:4046:: with SMTP id w6mr2900672wrp.92.1544796008483;
        Fri, 14 Dec 2018 06:00:08 -0800 (PST)
Received: from rigel (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id q9sm5645923wrp.0.2018.12.14.06.00.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 06:00:07 -0800 (PST)
Date:   Fri, 14 Dec 2018 14:00:03 +0000
From:   Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>
To:     Oliver Joseph Ash <oliverjash@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: `git commit --fixup` with duplicate commit messages
Message-ID: <20181214135818.7ta7y5feumzau4g3@rigel>
References: <CADBHO9E7Bzk9C5ciC416S+5-cS2ANA9d+CzSjKSG+HyxwrU+2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADBHO9E7Bzk9C5ciC416S+5-cS2ANA9d+CzSjKSG+HyxwrU+2w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 12:30:28PM +0000, Oliver Joseph Ash wrote:
> I believe I have found a bug in `git commit --fixup`.

That's not a bug, it's actually the documented behaviour of rebase
--autosquash.

As you figured out, the squash/fixup is based on whether the message
has the squash!/fixup! prefix and the subject matches. But it also
allows specifying hashes.

So for fixups, you can be explicit and use: git commit -m 'fixup! SHA'.

Similarly for squashes. (But a little less friendly as you'll need to
deal with passing an argument to -m that contains newlines).

But adding 'squash! SHA' when the editor opens should also work.

I believe the main reason this works based on subject message matching
is to be more friendly with scenarios where you're sharing series of
commits that include fixups and squashes. (Either via format patch, or
by rebasing the series on a newer base without --autosquash).

On such cases the commit you're trying to fixup will have a different
OID, so any hardcoded OID will be useless while commit message matching
works most of the time.

One potential improvement to this is to teach --fixup and --squash to
also add trailers like: "{fixup,squash}: SHA" or "target: SHA" and teach
--autosquash to respect it when possible.

Thoughts?
