Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7B1C77B73
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 17:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjDPRgw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Apr 2023 13:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPRgv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2023 13:36:51 -0400
X-Greylist: delayed 405 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Apr 2023 10:36:49 PDT
Received: from smtp123.iad3a.emailsrvr.com (smtp123.iad3a.emailsrvr.com [173.203.187.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B391692
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 10:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
        s=20180920-g2b7aziw; t=1681666203;
        bh=qDANeTIaC2wzvVvJ9wBQEzkREhTQsE+Z5u/pmm5eYxc=;
        h=Date:From:To:Subject:From;
        b=qEfwYrcW4AkuaIEd87SB+n6DfMgY1HUjfN6S+BdSXEa6+y2aIaUf2xoysmg4+8a6A
         49wlVjxBhom4tjB1QexfGAehUvyNObAn6th1TuR03PqiTghzY6Ndkyst6QhTx41/tN
         UJWsew5x/pXJ3bXYoJKbfLFWakob5BTi2vQvgbkk=
X-Auth-ID: lars@oddbit.com
Received: by smtp8.relay.iad3a.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id 4CD292AD1
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 13:30:03 -0400 (EDT)
Date:   Sun, 16 Apr 2023 13:30:03 -0400
From:   Lars Kellogg-Stedman <lars@oddbit.com>
To:     git@vger.kernel.org
Subject: Re: Regression introduced in 03267e8656
Message-ID: <5vey46onc6xwy5ifqieuut6m4ni3gpy5mweucmc2lroemtau3n@d5x4rgauq5zt>
References: <bt4342bdip3nzlikjsv6wozszmcbsc2av6cyo3z2lra4jhx3ii@ut2sl5h4f5xn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bt4342bdip3nzlikjsv6wozszmcbsc2av6cyo3z2lra4jhx3ii@ut2sl5h4f5xn>
X-Classification-ID: cb537b44-0716-48ba-9740-25cecf14755d-1-1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

...with apologies for that munged subject: line.

-- 
Lars Kellogg-Stedman <lars@oddbit.com> | larsks @ {irc,twitter,github}
http://blog.oddbit.com/                | N1LKS
