Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD2E120248
	for <e@80x24.org>; Sat, 23 Feb 2019 17:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfBWR1g (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 12:27:36 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:59582 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfBWR1g (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 12:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gg3EvCRS2HJNavPfpCnbp0rTA/G4aholLQroxNrGq6c=; b=hJNgo3n06oKMhuUCEy82X0ozh
        b2BkvC9W3TgMeRmk9Jh4K2+QdaKUXn7+6MVMk9069e6ykWSiv3yOqQTRgmC1HzKYHpWYBbjgaQdeP
        rlC0ZiOnS1bHJbzXGJK7XqhyK4N+7Rju6z5suH6J/0DCIlBA7tn6QzWrSBMbfPuMUtndLj7sXZx1S
        anTSk9C9iclSwNSiCFpmEu8PjfwXVwm/ugcwxJPdDNLdFbKNbR8RZc9avKm2J+KKF/+uBoz3k8auZ
        YvEqOAulD16rJsyFL3tttKZtST653nkoNqdrrK6LxklOIlpIfKixbJ0iFQwOG37h/6i12Ht8VJ8Np
        iYwhXtxMQ==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:36734 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gxb5J-00GetA-F8; Sat, 23 Feb 2019 12:27:34 -0500
Date:   Sat, 23 Feb 2019 12:27:32 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Todd Zullinger <tmz@pobox.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: on fedora, "man gitweb" exists but actual gitweb command is
 missing
In-Reply-To: <20190223171200.GB16125@zaya.teonanacatl.net>
Message-ID: <alpine.LFD.2.21.1902231226440.555@localhost.localdomain>
References: <alpine.LFD.2.21.1902230756280.24879@localhost.localdomain> <20190223171200.GB16125@zaya.teonanacatl.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-942634826-1550942854=:555"
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-942634826-1550942854=:555
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Sat, 23 Feb 2019, Todd Zullinger wrote:

> Hi,
>
> Robert P. J. Day wrote:
> >
> >   not so much a git issue as what looks like a fedora packaging
> >   issue.
>
> Yeah, it's just a minor packaging issue.  The gitweb manpages are
> included in the main git package rather than in the gitweb package
> with the rest of the gitweb files.  I'll fix that for future
> releases and when f29 is updated to 2.21 it will pick that up¹.

  ... snip ...

  ah, eggcellent, so i can remove this from my TODO list, thanks.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
--8323328-942634826-1550942854=:555--
