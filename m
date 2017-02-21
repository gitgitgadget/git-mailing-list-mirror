Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82409201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 02:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751043AbdBUCPX (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 21:15:23 -0500
Received: from smtp2-2.goneo.de ([85.220.129.34]:56783 "EHLO smtp2-2.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbdBUCPW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 21:15:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 8DF8524370D;
        Tue, 21 Feb 2017 03:15:18 +0100 (CET)
X-Virus-Scanned: by goneo
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9qarfNx8Esgc; Tue, 21 Feb 2017 03:15:08 +0100 (CET)
Received: from [192.168.0.165] (ip-88-153-200-99.hsi04.unitymediagroup.de [88.153.200.99])
        by smtp2.goneo.de (Postfix) with ESMTPSA id 23CFB23F8E7;
        Tue, 21 Feb 2017 03:15:08 +0100 (CET)
Subject: Re: slightly confusing message
To:     Junio C Hamano <gitster@pobox.com>
References: <7cca3326-d6b5-4669-7256-ab275567b72e@georgemail.eu>
 <xmqq1susk43m.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>
From:   Leon George <leon@georgemail.eu>
Message-ID: <8e66c3be-7cd9-d72c-123f-308b63ddc1bd@georgemail.eu>
Date:   Tue, 21 Feb 2017 03:15:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq1susk43m.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello
and thank you for your time.

On 20/02/17 21:19, Junio C Hamano wrote:
> This sounds vaguely familiar and indeed I think it is this one:
> https://public-inbox.org/git/CAEnOLdvG=SoKFxeJ_pLmamGj_8osC+28TSg+pbFLLTr+ZLcpQA@mail.gmail.com/
> which was from late last year.
Which means I should have found it before bothering you.

> I suspect that the issue may already be fixed at the tip of 'master'
> (aka Git 2.12-rc2).
You're absolutely right. Took a while to build, but here goes:


£ git gitss
?? test
£ git --version
git version 2.11.0
£ git add -p .
warning: empty strings as pathspecs will be made invalid in upcoming
releases. please use . instead if you meant to match all paths
No changes.
£ git --version
git version 2.12.0-rc2
£ git add -p .
No changes.


Splendid!

have a wonderfull day :-)
