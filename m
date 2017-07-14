Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1ABA20357
	for <e@80x24.org>; Fri, 14 Jul 2017 21:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751062AbdGNVMv (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 17:12:51 -0400
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:46398 "EHLO
        outbound-ss-1812.hostmonster.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751004AbdGNVMu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Jul 2017 17:12:50 -0400
Received: from CMOut01 (cmgw2 [10.0.90.82])
        by gproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id 008A8175B3E
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 15:12:49 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by CMOut01 with 
        id klCm1v00g0QvKlu01lCpsw; Fri, 14 Jul 2017 15:12:49 -0600
X-Authority-Analysis: v=2.2 cv=FvB1xyjq c=1 sm=1 tr=0
 a=gch/BGY/Gm5DEW28s2kmlQ==:117 a=gch/BGY/Gm5DEW28s2kmlQ==:17
 a=IkcTkHD0fZMA:10 a=G3gG6ho9WtcA:10 a=jPaFA2pgRzsEYp5H1wUA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kwIdOFVmgUb1DPHQfMCag5MmNvdNXsyFDmEApI/avFY=; b=T7t3iKIns3kSfV+hB7OSig85ev
        lsKjdcTlFlWyMucBDOb/mnmE5fw2B94p1dtttRBoPH9rZZoiY8Fq19EVra33KJmRkktuOsudHydOx
        kf0fKLQqv2yaeTQSlFch3osAr;
Received: from [65.112.16.22] (port=49200 helo=pdsdesk)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.87)
        (envelope-from <paul@mad-scientist.net>)
        id 1dW7tG-0049ZV-EX; Fri, 14 Jul 2017 15:12:46 -0600
Message-ID: <1500066765.25789.111.camel@mad-scientist.net>
Subject: Re: Git Bash Bug
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Kavita Desai <kvdesai2@illinois.edu>, git@vger.kernel.org
Date:   Fri, 14 Jul 2017 17:12:45 -0400
In-Reply-To: <alpine.DEB.2.21.1.1707142227240.4193@virtualbox>
References: <CAAu0pLedy5xqUgF7drMf=tQgMJD4rXq+JvKaiE54EdRFZWuTkQ@mail.gmail.com>
                 <alpine.DEB.2.21.1.1707141625150.4193@virtualbox>
                 <CAAu0pLdmGc_kq_w0Fm6W4XDqOe=iKSyAyLct+yH6y+7FPUHtnA@mail.gmail.com>
                 <1500043024.25789.105.camel@mad-scientist.net>
         <CAAu0pLdjvcxda0rip8JOzt1q0HNuu4dBNHvEzJbeey6yRSyCCQ@mail.gmail.com>
         <1500044588.25789.109.camel@mad-scientist.net>
         <alpine.DEB.2.21.1.1707142227240.4193@virtualbox>
Organization: GNU's Not UNIX!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 65.112.16.22
X-Exim-ID: 1dW7tG-0049ZV-EX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (pdsdesk) [65.112.16.22]:49200
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-07-14 at 22:33 +0200, Johannes Schindelin wrote:
> > You absolutely have to have /bin and /usr/bin on your PATH,
> 
> As Kavita talks about Git Bash, it is probably Git for Windows, for
> which /bin should not be in the PATH but /mingw64/bin or /mingw32/bin
> (depending on the architecture).

I did check this with my Git for Windows installation before posting. 
Mine is older (2.7.0) though so maybe things have changed:

  pds@build-win MINGW64 ~
  $ type -a ls
  ls is aliased to `ls -F --color=auto --show-control-chars'
  ls is /usr/bin/ls
  ls is /bin/ls
  ls is /usr/bin/ls
  ls is /usr/bin/ls

Clearly I have a lot of duplicates on my PATH now that I notice :)

I have /mingw64/bin on my PATH as well but looking there it has git,
gettext, edit, a bunch of DLL's, etc. but it doesn't contain ls or
other coreutils programs.

Cheers!
