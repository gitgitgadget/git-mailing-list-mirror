Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AC3E20248
	for <e@80x24.org>; Sat, 23 Feb 2019 09:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbfBWJiL (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 04:38:11 -0500
Received: from smtp-32.italiaonline.it ([213.209.10.32]:58574 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbfBWJiL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 04:38:11 -0500
Received: from DESKTOP-E4U7JCE ([5.169.49.65])
        by smtp-32.iol.local with ESMTPA
        id xTl2gURkl6rc5xTl2gK3BW; Sat, 23 Feb 2019 10:38:09 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1550914689; bh=5xM+Ch0Uyeybk9wAYhX/1QdqifGEkG9WZJ9bDtCZjLU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=m5+rMnSRcuqOJtbfcvTRpqSeVeA3TZelRRO0CeHDCqiOWhlnJeuAtyfB3lQYxgq87
         hzOtg0upp5nAFBiCtnM8XBGqt86G2FpY8tef0rP9HP7FHX4wqQyCx7fkr37s3VkHxE
         nOPstTUxIDSnFpeh9qFWqTAPO8W+3bPqynr9LUpff1PZ9hjLh49OwJiJlPFckQ3N6k
         6NN+LeGVH7rR66wL/pXR+8rdV4V9qrfcFzEebMk77ZeyEnjBnXK6DMFuRfn0BFm4Xs
         Xy2JbDZcFre/dVYgJ3qfKAJuAYOobIe7OaKxRcUvjOKSdPIksn3NGth69YfAaAtNJ2
         vV+oPlH/YsFKw==
X-CNFS-Analysis: v=2.3 cv=d7kkNirE c=1 sm=1 tr=0
 a=zYX2uk1tt1KodCNUFRWNOA==:117 a=zYX2uk1tt1KodCNUFRWNOA==:17
 a=IkcTkHD0fZMA:10 a=ccfrtNQW8_P8NkmYPPAA:9 a=QEXdDO2ut3YA:10
Message-ID: <1550914688.2346.1.camel@libero.it>
Subject: Re: Am a newby and I cannot compile git
From:   Fabio Aiuto <polinice83@libero.it>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org
Date:   Sat, 23 Feb 2019 10:38:08 +0100
In-Reply-To: <20190210224812.wtn2qqm7lmsiarrh@LykOS.localdomain>
References: <1549835814.5977.11.camel@libero.it>
         <20190210224812.wtn2qqm7lmsiarrh@LykOS.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOJtELmdAYrqhnH+IhQxIAFXrwo/DKxFC6WLnu8qtgEBIusUKkC2suOmmBMHjoV6TRoZ710YevOIRWhLXUMC2m6aa683Rg3HucGV8BjJ8QAn1ohXvv/x
 1Uc//EgD8VLuIcht57hui/HZIjS9en78qVRlcYiYZn3XLrHQnWf2wz07YEHy69g/bCGr0qgcgci/2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Santiago,
how could I get a first task? A simple one please, I'd like being
introduced to git developing as a participant in order to get used to
submitting patches, and all the tools I need.
Thank you in advance.
Fabio.

Il giorno dom, 10/02/2019 alle 17.48 -0500, Santiago Torres ha scritto:
> It'd be difficult to debug without more context:
> 
> Do you mind sharing your build log and more informationa about your
> setup? (e.g., what OS are you running, what packages are installed,
> how
> did you get the git sources, etc.)
> 
> Thanks,
> -Santiago.
> 
> On Sun, Feb 10, 2019 at 10:56:54PM +0100, Fabio Aiuto wrote:
> > Hello again my problem is that I cannot compile git.
> > The error message says:
> > 
> > 	Type'z_stream' could not be resolved
> > 
> > I don't know why, because I installed the package zlib1g-dev and in
> > the
> > header file zlib.h this structure is declared. Help me!!!
> > Fabio.
