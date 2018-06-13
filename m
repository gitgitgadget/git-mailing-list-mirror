Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55E7F1F403
	for <e@80x24.org>; Wed, 13 Jun 2018 01:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935167AbeFMBQG (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 21:16:06 -0400
Received: from mout.web.de ([212.227.15.14]:40163 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935096AbeFMBQE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 21:16:04 -0400
Received: from localhost ([213.64.64.87]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0McFQF-1fmN3637od-00JZZT; Wed, 13
 Jun 2018 03:15:55 +0200
Date:   Wed, 13 Jun 2018 03:19:23 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] config.c: fix regression for core.safecrlf false
Message-ID: <20180613011923.GA5772@atze2.lan>
References: <20180604201742.18992-1-asottile@umich.edu>
 <CAPig+cSzJ=2Zz7jRNB7sK7FyZ+YwdAFseCTSDbM_m4E8K9WxHA@mail.gmail.com>
 <CAPig+cRyv=JuGo+OfULuvbLrqRxoYZyBZDrSJrt5F8YRwzNn6w@mail.gmail.com>
 <CA+dzEB=7tGeXduxdKrJpDpXrmNbb_ZnYg=CmByJ7J-w-iiyxsQ@mail.gmail.com>
 <CAPig+cSm7My9r8KN1vNyssendf_v_nMARDAq6ALA=X7nZ+spkA@mail.gmail.com>
 <CA+dzEBk8H_=a9k1DaFUK=JJBhd17bhS3+ngSUBcBV+7hD-RFMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+dzEBk8H_=a9k1DaFUK=JJBhd17bhS3+ngSUBcBV+7hD-RFMw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:z4D8BhSNWFcJTkVbBsEYwtitHf6gR2h9CNJb0a7zQB6Nfd2l0Qy
 99RGeCMj9cl24UiqvOiGKzZP4T/nT5ZAiqUhaI6va+G31oPqdLoHYFcmHvlrPxsUgK6g1bu
 I0hKKLMLgbto6qGWSIj+riJ3DF7X9t0zILS6sKIrPuBrMtVXFHxN69YWV+5E7AbxUVumBn9
 whChhs13n+cJWQS42b1oA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EovteRFpl2o=:El51D7W48el+3yAkOlxLSV
 umrjhJyInhQU6O/TZcsJp/aoVhfgZl7ncRv8lZDLDJmhoy55P3QScQtG7dnncdNnVV6/qLVUV
 Xj4GtqwSn8J7X7gxKzuqk5m8Nm+oR+Bqen/2NqimXOERUjzx9vzVXCZp5oEfXbNS/XWXdDAO8
 05Op0LP9pteDR0gp76YrRldR1w0xDtt2pvL+TFRaiZDTp/7jZViGp5TP/IKxS3yjBKjbbyRdq
 uNoWe9sDC+dieNpDIhxQJHAiKPXAO2elD2H9VUHKDxMSzL5n663hPR610NkPjTQhKB6iW4E3O
 HocN9rptH7PQvi1NgRYlJpPIXX0NAxlpSgTVRcW3seS1c4+0rcZIGwUVfh6QEFMIxYav+Xstw
 Rth3W5q+pX7fXDCZosBa7uVFFWzelVrLjSCtC06XrmfJ5Cot4joBg8I7ezcOCGE67dtS+FwTI
 8VSyK5dcrTXV5NHYMRsy24dbJ74mkY4QxB/yWDFni+iFd3+QK6tsBZrXLkqb5Vkq3uOT/yAj2
 Q2kThOYKRN3e/J55zFphOM6mdPPm01YwfLioM4LBBrufpfg0cJOk3Lifvad5ZHOWynqCk07E/
 i21CMUff5O4nrrytBsNKC2IN6wlazy9KKv60c4kX52ldnqF8szHQZMLH7yqit4Jmp2nct9T/a
 HoDC5dE99o+7HVka2tF1k+cwiDeXLZTuf/xJ09vxfBWRDL7Y00aXTTdWCWWcigSMzRWLbPKr1
 ioUREsbz11GDokWTS75a42K1Td6yrpkHplpsa3O33c8k/Sb62Vl7oGcSH74=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 06:46:34PM -0700, Anthony Sottile wrote:
[]
> Anything else for me to do here? (sorry! not super familiar with the process)

Your patch has been picked up by Junio, and is currently merged into the
"pu" branch (proposed updates):

  commit bc8ff8aec33836af3fefe1bcd3f533a1486b793f
  Merge: e69b544a38 6cb09125be
  Author: Junio C Hamano <gitster@pobox.com>
  Date:   Tue Jun 12 10:15:13 2018 -0700

      Merge branch 'as/safecrlf-quiet-fix' into jch
      
      Fix for 2.17-era regression.
      
      * as/safecrlf-quiet-fix:
        config.c: fix regression for core.safecrlf false

From there, it will typically progress into next and master,
unless reviewers come with comments and improvements.
You can watch out for "What's cooking in git" messages here on the list
to follow the progress.

From my experience it will end up in a Git release, but I don't know,
if it will be 2.18 or a later one.
