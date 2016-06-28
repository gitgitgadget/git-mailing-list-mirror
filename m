Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A8321FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 11:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbcF1LyI (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 07:54:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:57757 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752096AbcF1Lxt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 07:53:49 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MQeET-1auwli0NGn-00U0HK; Tue, 28 Jun 2016 13:47:07
 +0200
Date:	Tue, 28 Jun 2016 13:47:06 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Ioannis.Kappas@rbs.com
cc:	git@vger.kernel.org
Subject: Re: git svn clone segmentation faul issue
In-Reply-To: <0BCA1E695085C645B9CD4A27DD59F6FA39AAD5CF@GBWGCEUHUBD0101.rbsres07.net>
Message-ID: <alpine.DEB.2.20.1606281334450.12947@virtualbox>
References: <0BCA1E695085C645B9CD4A27DD59F6FA39AAD5CF@GBWGCEUHUBD0101.rbsres07.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jUGoSdKabZHhqB6xJF85n0lhDhUVP+sdylVTyqdz8/FAngp2Q+0
 isscbJGdYletgj7caZoW399/w2gJ7rjQKiWahfnz2Vcf7Du3reTPOrJmLSchz+dgnZBNst2
 CMdGurpewdSGmAXDceoErpz2PQko7vjNq8vfkOYHtIzAX6FgDC0nCQDoFHwD0G0HYhAxj+M
 GdrYe41qURAa2ueQfbOTw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:jzOzgjnQOHs=:aN/AnMDRVj6sNksC42SCnY
 OUUfp77jF5TqwE6NrTPrpTojhc6aPLOciru0BAkgJRQxDQ5MVen/tPdwLEMlc2zmaAZaoBFpW
 Y7vIcf8e6xmQb/VZPwKM2vv52c45iPrSGkR6d/fD6oqDst/Bcpi8j73SvUTH58hJQkGIQjpYm
 jXykn88GTgq9yASYZCG2SZdYVXIwGX+KHwZvrzSsJpv/U/6hnmUt1eh3F0WjgtkMMULeXkHvg
 eR5+Og49PqCZ+dW/rm9E869KO9azqjzjwk4T+gNubSAZnkyLmKmgo0dkisLXE01rv8QKg8587
 rwrMSm9VMnslmtt5wrGxuPPe404TWH/Y5Jt78ccQAIO3FA7IPUOsf7M0HQnuKvMfJjsmSCtCS
 LGAyXWNRrWOUEMt2WbQs1xSeI0G4KINhZDFourruccBh3X2AlSb3UVjLLdvqBu/gwxbiN4sXm
 J0NV8Zdz+IQHdx7zfNiqwDRDn5fNhDTaLqChLcMCdOCnbnq9xWlF9yHYG1+0AaiZrKzcuTW45
 s2YIK/pMnw/owBlJINEk8oR3dxorikrH2CGAgQ/7Iqve7ZLM3n+Jifq1dLh73ipEt2NDJqCQC
 Fps8KUqi4fwUnJnXe8LDJrOo0fK8hMHLpVAElL9Rk5g8IjeT8w6VfdnXuVfgnXspZM82saqmu
 Pv+5BBLuiul3HS9vaK0haJRYNH5QVJM3bOJFhAhdc02mr/ZNYnR0B5QDzRssvxn7sr9+6yLb3
 T3VsnLGNOnUWM+kvTEkkiUFkKuLPWmrom41ON1ckeo8SBfUlA87ceBc5DO3GDKfwlkMsHfc1k
 /ofhZbY
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Ioannis,

On Tue, 28 Jun 2016, Ioannis.Kappas@rbs.com wrote:

> Git can fail with a "malformed index nnn" error or cause a segmentation
> fault when executing the "git svn clone" command. 
>
> [...]
>
> Fortunately, a patch has already been submitted to subversion with
> (github) revision a074af86c8764404b28ce99d0bedcb668a321408 (at
> https://github.com/apache/subversion/commit/a074af86c8) on the trunk to
> handle this and a couple of other similar cases. But by the looks of it
> has not been picked up yet in the latest subversion 1.9.4 release or the
> 1.9.x branch, perhaps because this patch was identified in sanity checks
> rather than coming out from a perceivable production issue?

This is an excellent analysis and a silver lining on the horizon to
resolve those vexing git svn issues we keep having in Git for Windows.

Do you have a test case that is reliably reproducing the issue?

> Although this issue is not in the Git source code, I thought reporting
> this error here first since it is Git that stresses the subversion perl
> bindings in such a level to cause the failure. Perhaps the patch can be
> applied first in those git binary releases that include subversion (I
> believe Git for windows is such a case) while in the mean time I submit
> this case for consideration in the subversion bug tracking system.

Yes, absolutely. Thank you for reporting this!

> The Royal Bank of Scotland plc. Registered in Scotland No 90312. 

Oh. I am sorry!

> This e-mail message is confidential and for use by the addressee only. 

This footer does not make much sense when sending a mail to a public
mailing list ;-)

Ciao,
Johannes
