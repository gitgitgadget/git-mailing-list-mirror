Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC7CE2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 13:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbcF1NcQ (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 09:32:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:53993 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486AbcF1NcP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 09:32:15 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lhf3N-1beFVz3UQ5-00moFc; Tue, 28 Jun 2016 15:32:10
 +0200
Date:	Tue, 28 Jun 2016 15:32:09 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Ioannis.Kappas@rbs.com
cc:	git@vger.kernel.org
Subject: Re: git svn clone segmentation faul issue
In-Reply-To: <alpine.DEB.2.20.1606281334450.12947@virtualbox>
Message-ID: <alpine.DEB.2.20.1606281530420.12947@virtualbox>
References: <0BCA1E695085C645B9CD4A27DD59F6FA39AAD5CF@GBWGCEUHUBD0101.rbsres07.net> <alpine.DEB.2.20.1606281334450.12947@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eEqj+LFIT33vpdM7tPf1FOBzEYTl14nKxHdasPVAF4V1JDjTcAE
 day3as+yxCRz+T+iMIMUfYDQF/Ao7xlyPIlBHAAuDGEGWejWmxFcUTGT2qWosGLVrUPi9T4
 Ycob04K4VzUqxuXnDNB+i/7CrqPPaZE/W96DZZk7c0NIztvK0vitdsI2ksLkDlmwBwQn0DX
 j+926KB0rG6doxjuo/8Mw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:jOaHTSNdGeU=:xSfsoniLHMt+MRkFEe9qZO
 x8lX1J+fktzHAqt0YXXKn/aT0LBCLdl+bIKh92NveVK3xjbX0nKlq7mbq+wV194h9Glr+ViXg
 jlgSoKY+sHUrSth4+hhhmfL/KV4JKvxL/MY8iOrantQLHOzCdZ7oGoHkqYFSf1vlnbMKkSfJ+
 rrFK2BLQ6LzddIQnnYDks3nj44haaWU7i8e2fNBPmbXe81/e7xVaI+RfTUnqHnFhoAffOkHWf
 Aor13L9TMS6iulbBJH7LojkOxNINEw9cGntI/PoXOojODCiEsLs4sUmf+J7siMVEPjebWg7jE
 wYOw9BM4fo+0dk2vWvUBmVCaOPQvos7WTcEabRGwlqFsUQHJtycLZUvVVxc6NW2CrS80t2eeQ
 O/ECpm12g6wH2rTOlx/4sBpiXu/7wOmnFW0y3LwCvFu6P+XVayhcJUegDCFNhPnOetkwXOVMI
 E+hzRxT6b6x/mJau8qhnIQnHYAjK+iGOYYvNUWGjzJaKoQt5nHLPQ8g6fKbbQJKfpX7AEhE1K
 aON2GqsE9eWFgK+dXXCg1Vj5rOBM2nt+ohO5KNCPgBMSi6FpLucL711byRt8FwO0KUPX4JDtM
 UumfFwormXArKfNVZjsIiuv5dWL+CHB24/jG6F0IiSe2Vi1CprCLDeV31KsrXefLc0x93XmhB
 bigmMW0EErAlapTOfD+a/1tOMM53mEw2zRh92CZsPOvMJndN9Wae2ROHFGuQKr5u1sE6jalIZ
 yJixMOx/iNmnBIJ92SpYh2HzNdCc3nPScE/01nWyh99sW9is/wwYj0c52LFYAQ9V9uzfGjXxn
 xyUVvIx
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Ioannis,

On Tue, 28 Jun 2016, Johannes Schindelin wrote:

> On Tue, 28 Jun 2016, Ioannis.Kappas@rbs.com wrote:
> 
> > Git can fail with a "malformed index nnn" error or cause a segmentation
> > fault when executing the "git svn clone" command. 
> >
> > [...]
> >
> > Fortunately, a patch has already been submitted to subversion with
> > (github) revision a074af86c8764404b28ce99d0bedcb668a321408 (at
> > https://github.com/apache/subversion/commit/a074af86c8) on the trunk to
> > handle this and a couple of other similar cases. But by the looks of it
> > has not been picked up yet in the latest subversion 1.9.4 release or the
> > 1.9.x branch, perhaps because this patch was identified in sanity checks
> > rather than coming out from a perceivable production issue?
> 
> This is an excellent analysis and a silver lining on the horizon to
> resolve those vexing git svn issues we keep having in Git for Windows.
> 
> Do you have a test case that is reliably reproducing the issue?

I hope you do! I patched the MSYS2 build script to apply a074af86c8 before
compiling, and uploaded the resulting packages for i686 and x86_64
architectures to

	https://github.com/dscho/MSYS2-packages/releases/tag/subversion-1.9.4-2

Would you mind giving them a whirl?

Thanks,
Johannes
