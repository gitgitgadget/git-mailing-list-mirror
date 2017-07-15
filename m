Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E82BF2082F
	for <e@80x24.org>; Sat, 15 Jul 2017 16:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbdGOQNS (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 12:13:18 -0400
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:57970 "EHLO
        elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751066AbdGOQNS (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 15 Jul 2017 12:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=earthlink.net;
        s=dk12062016; t=1500135198; bh=vEKhadMQcFUfklyC8Gqcn50P/9K8YqakKrfA
        xWdgm6o=; h=Received:Received:Date:From:Reply-To:To:Cc:Message-ID:
         Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:X-ELNK-Trace:X-Originating-IP; b=IEwfJ1O92V3FOdHeRHY3LPkl
        a4DSeujwE2X498bmLILmielwnEYlr/klOoZuPG2yhaYOVfGWKcC34i+dx++10nfD5RB
        IM2em0FkV3a6SvbjVD6h+LVfgLj3Kqe0f2dfCbGp2Vpk0KJ9txNaifYznBRkIfrPIi4
        WrCdixW1GTecVtEr817FCLKeUtkcNbQJSIFm+/ynV38omtGXcyDu/qUwA8OuIaWWBPX
        1fPM4tdblHo1hRWutE4e5v94J6xe1Ko966w+5qD1FqtAQhMYImK7o/zJFnKjRK2xlHn
        +LyE2NX7QqzeIPgxDn3OppqU43w6wAz6298frqunlCP8qwsGIw==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=earthlink.net;
  b=ayda96i7jkokSLhzTWShP4mG6b9sN8hyZxL0LFSJYEjx19QjxPPgBk1uIyWodJjmdl71iDrT1Sb2Unnqfd0ikty5+V1GYrAyp/6NS0SNr/quowx57AczdSSRS/Czoo490sM7KR1AzV3fDfPt4qVOB2SROTyC4WPANV2ju2rlb1kfo+NW/KMN7KEU6EeoyAtxEreqnebnsRfRGOcjq5UGm6B3gHwu1mGWUn7F61O+CRG1HKL2aSNKnZ3F9xHKHAJYm02uN59zLIjhkKOvC/ofkewDo++8AH/uIxpE0NTT88ezLrNAtbjRUxaxWYOlREHJbdFBemmSShzT8NbMC9JCzg==;
  h=Date:From:Reply-To:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:X-ELNK-Trace:X-Originating-IP;
Received: from [209.86.224.37] (helo=elwamui-karabash.atl.sa.earthlink.net)
        by elasmtp-curtail.atl.sa.earthlink.net with esmtpa (Exim 4.67)
        (envelope-from <jjfoerch@earthlink.net>)
        id 1dWPgz-000463-3Y; Sat, 15 Jul 2017 12:13:17 -0400
Received: from 98.250.1.226 by webmail.earthlink.net with HTTP; Sat, 15 Jul 2017 12:13:16 -0400
Date:   Sat, 15 Jul 2017 12:13:16 -0400 (GMT-04:00)
From:   John J Foerch <jjfoerch@earthlink.net>
Reply-To: John J Foerch <jjfoerch@earthlink.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Message-ID: <1598254.3570.1500135197092@elwamui-karabash.atl.sa.earthlink.net>
Subject: Re: [FEATURE] git-commit option to prepend filename to commit
 message
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: EarthLink Zoo Mail 1.0
X-ELNK-Trace: c53e46bc05df04c91aa676d7e74259b7b3291a7d08dfec794ed2dee3f3915f7becba1980be08da79350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 209.86.224.37
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Perfect, thank you Hannes!

-----Original Message-----
>From: Johannes Sixt <j6t@kdbg.org>
>Sent: Jul 15, 2017 12:01 PM
>To: John J Foerch <jjfoerch@earthlink.net>
>Cc: git@vger.kernel.org
>Subject: Re: [FEATURE] git-commit option to prepend filename to commit message
>
>Am 15.07.2017 um 16:19 schrieb John J Foerch:
>> The feature would be a command line option for git commit that would
>> automatically prepend the "<filename>: " to the commit message.
>Write a prepare-commit-msg hook:
>
>https://www.kernel.org/pub/software/scm/git/docs/githooks.html#_prepare_commit_msg
>
>-- Hannes
