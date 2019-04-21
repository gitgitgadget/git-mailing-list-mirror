Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5C2B20248
	for <e@80x24.org>; Sun, 21 Apr 2019 13:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfDUNOR (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 09:14:17 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52192 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfDUNOR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 09:14:17 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44n9CV51jhz1rD9F;
        Sun, 21 Apr 2019 15:14:14 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44n9CV4LHFz1r2Hh;
        Sun, 21 Apr 2019 15:14:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id oPP0xQuePW-c; Sun, 21 Apr 2019 15:14:13 +0200 (CEST)
X-Auth-Info: 62GVtHOLbEa9OAbAZHiSVa0FVqfzkDqqYq9z43DfvZmDxx335BBuz3/cQVZE/xuN
Received: from igel.home (ppp-46-244-184-191.dynamic.mnet-online.de [46.244.184.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 21 Apr 2019 15:14:13 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id E01D12C124B; Sun, 21 Apr 2019 15:14:12 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     rob <drrob100@fastmail.com>
Cc:     git@vger.kernel.org, rob@drrob1.com
Subject: Re: I messed up my own git tree and I don't know how to fix it.
References: <cb1f725f-1314-d320-104a-726ef1c906fa@fastmail.com>
X-Yow:  Place me on a BUFFER counter while you BELITTLE several BELLHOPS
 in the Trianon Room!!  Let me one of your SUBSIDIARIES!
Date:   Sun, 21 Apr 2019 15:14:12 +0200
In-Reply-To: <cb1f725f-1314-d320-104a-726ef1c906fa@fastmail.com> (rob's
        message of "Sat, 20 Apr 2019 23:01:08 -0400")
Message-ID: <87pnpfwlej.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 20 2019, rob <drrob100@fastmail.com> wrote:

> changes not staged for commit:
>
>   modified: github.com/alecthomas/gometalinter (modified content)
>
>   modified: github.com/kisielk/errcheck (modified content)
>
>   modified: github.com/rogpeppe/godef (modified content)

You have submodules with modified content.  If you want to keep them you
need to create commits in each modified submodule, then add them to the
superproject and commit there.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
