Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D3FC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 19:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E762B2077B
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 19:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgAPTqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:46:25 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:33724 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729414AbgAPTqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 14:46:25 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 47zF7M04cQz1rY5L;
        Thu, 16 Jan 2020 20:46:22 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 47zF7L4v5wz1qr2D;
        Thu, 16 Jan 2020 20:46:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id qQROiy207-ET; Thu, 16 Jan 2020 20:46:21 +0100 (CET)
X-Auth-Info: Ztj6fZCuowJTFDNkWOoGJeR80jLKhllCoC9082TUPfH66gsAxtKzDJudVxR3zgLI
Received: from igel.home (ppp-46-244-172-243.dynamic.mnet-online.de [46.244.172.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 16 Jan 2020 20:46:21 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 04F472C2A0D; Thu, 16 Jan 2020 20:46:20 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [RFE]: git submodule commit push
References: <005801d5cc8e$7ae618e0$70b24aa0$@nexbridge.com>
X-Yow:  FROZEN ENTREES may be flung by members of opposing SWANSON SECTS..
Date:   Thu, 16 Jan 2020 20:46:20 +0100
In-Reply-To: <005801d5cc8e$7ae618e0$70b24aa0$@nexbridge.com> (Randall
        S. Becker's message of "Thu, 16 Jan 2020 12:00:34 -0500")
Message-ID: <875zhbmbg3.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jan 16 2020, Randall S. Becker wrote:

> I'm finding that I have a frequent need to commit and push submodule changes
> because the submodule is currently subject to a whole bunch of changes. The
> submodule is pretty deep down in the java path of a maven project - so 7
> directories down from the git root. It's a bloody pain to constantly change
> directories to get down there and back up to where I am working.

You can also use git -C <path> ...

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
