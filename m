Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8DE31F404
	for <e@80x24.org>; Sun, 15 Apr 2018 22:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbeDOWk0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 18:40:26 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:54314 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbeDOWk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 18:40:26 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 40PRL02ys9z1qxxr;
        Mon, 16 Apr 2018 00:40:23 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 40PRKz4NvLz1qqkp;
        Mon, 16 Apr 2018 00:40:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id JG7Dc3damRB8; Mon, 16 Apr 2018 00:40:22 +0200 (CEST)
X-Auth-Info: /wpcQPVLKMBDmD+bb7QfW/vZXZ37tzBxGXe2NmmHmeF63LSAX1eopuL6YUWLegEW
Received: from localhost (ppp-188-174-156-232.dynamic.mnet-online.de [188.174.156.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 16 Apr 2018 00:40:22 +0200 (CEST)
Received: by localhost (Postfix, from userid 1000)
        id D28582C3D74; Mon, 16 Apr 2018 00:40:21 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: .gitattributes lookup doesn't respect GIT_WORK_TREE
References: <877ep8p9yz.fsf@linux-m68k.org>
        <xmqqin8s18pg.fsf@gitster-ct.c.googlers.com>
X-Yow:  The PINK SOCKS were ORIGINALLY from 1952!!
 But they went to MARS around 1953!!
Date:   Mon, 16 Apr 2018 00:40:21 +0200
In-Reply-To: <xmqqin8s18pg.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 16 Apr 2018 06:05:47 +0900")
Message-ID: <8736zwozze.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 16 2018, Junio C Hamano <gitster@pobox.com> wrote:

> I may be mistaken (I do not have the code in front of me right now)
> but IIRC after the setup.c code runs (which happens quite early in
> the sequence that starts from git.c::cmd_main()), the Git process
> moves to the top level of the working tree,

git log/show don't appear to do that.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
