Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 568ED1FAFB
	for <e@80x24.org>; Wed, 29 Mar 2017 01:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbdC2Bzj (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 21:55:39 -0400
Received: from mx1.riseup.net ([198.252.153.129]:54056 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751350AbdC2Bzi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 21:55:38 -0400
Received: from cotinga.riseup.net (unknown [10.0.1.164])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 268BE1A1A11;
        Wed, 29 Mar 2017 01:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1490752537; bh=tgWgNRzi/HHtNZMJhk1y0jY4iR96gaM3ENAPSj+MohM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVhz2h8tOVnS1oLiGRRz9Mhdcgz/pcqeFpH6jlOhUh27Fy9ZFURf4OdXhSczJVvy9
         aab7MkLK0eoenc0fFa/rJX/LifytEJB8pYhm7fWtVG81dI3o/d2Ey3kgws4kcqytHD
         ieAm9pqnbdeAIRlavqwfXI8Glk8Qr+MyyMrRYJlY=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: pickfire)
        with ESMTPSA id 3162941BAA
Date:   Wed, 29 Mar 2017 09:55:32 +0800
From:   Pickfire <pickfire@riseup.net>
To:     jacob.keller@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: Re: Re: Microproject | Add more builtin patterns for
 userdiff
Message-ID: <20170329015532.R50BRdAbP%pickfire@riseup.net>
References: <20170328104652.XsS8a6ysu%pickfire@riseup.net>
 <CA+P7+xr+vJP=usEhnR2gZdNY+k8035sX9FgFvvrrL5j_xCu=Mg@mail.gmail.com>
 <20170328175356.1GG4n_Oas%pickfire@riseup.net>
 <CA+P7+xrYKE1JOhmVQLVB1RKPnkGNsPPaW+-t8=PqcVpRDcZ=Nw@mail.gmail.com>
In-Reply-To: <CA+P7+xrYKE1JOhmVQLVB1RKPnkGNsPPaW+-t8=PqcVpRDcZ=Nw@mail.gmail.com>
Mail-Followup-To: jacob.keller@gmail.com, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> wrote:

> On Tue, Mar 28, 2017 at 10:53 AM, Pickfire <pickfire@riseup.net> wrote:
> >
> > Yes, I can't reproduce it outside the test suite. I have added the builtin
> > and yet the test fails. test_decode_color gets same output as expect but
> > still it fails, should I send in the patch?
> 
> You also need to ensure you have the exact same color settings as used
> by the test scripts.
> 
> Thanks,
> Jake

Yes, I used the same color, looks like the block that are failing is:

    test_must_fail git diff --no-index "$@" pre post >output
