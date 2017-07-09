Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C722202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 19:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbdGITUY (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 15:20:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:61235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752149AbdGITUX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 15:20:23 -0400
Received: from [192.168.178.24] ([78.54.56.184]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtUHA-1de9af2Mho-010vlR; Sun, 09
 Jul 2017 21:20:17 +0200
Subject: Re: enhancement request : If 2 commits to be squashed together do
 have the same title and comment ...
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <66e0ec72-699c-f71b-55c7-e1f780111853@gmx.de>
 <xmqqlgnx8muc.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Message-ID: <b3e9aea7-df98-a1db-643b-ce992200ecb8@gmx.de>
Date:   Sun, 9 Jul 2017 21:20:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqlgnx8muc.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:IGGKX4KxwMyOW28gnFFYo9gN0R8dJ202MBrQS3uGLMM4GHSRlh1
 B9ILttgEB6+GLpr7/8o/YQtGD9CZx6tJj+LOCFmv9IZ2NeM0eRpRNWxPpD+1zMpmjla5NnL
 AunLjOdJa8SwFlxCMQBXGvJPM0+3P/cnrO8Lq33qw6GXdki9yVkQBfrFmMU9wuiJZdvGi/N
 JEd2eGyrHxXN66btqX96Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vTgav1CP0Uw=:9o3q/J8kupyS6i8WdJlj+L
 dvKZdvQXX9PsCyrEEK/drzVdjIAFrEZv7bxyJ/J1lz3OFNsIRQ5FMQA7G4ci6wrwrmfFitgog
 bbWdabMgILnwf0EounN71RrNhk9KjEHQCI9EtgoCeZ+1Zqwz1SFHoUadraydJmHojNO3fmoU7
 +uMxFGvkCtzbNc51BqWYXVpAkYHcVragnAsiup7FaAi3bCQlFsisRLDSCmmZZ3de1XFDBaD7p
 VtMyZ6hJaaCLioLJ3k2epUQVC3LREOsZkPL5Oe8aCltzjda9/marZRUxyP0iFEEGyz5zVXLKQ
 OYpGY6zWxyy2psPgI0OsrsLLl7b+gaWzwIHLkBp3gKEvJ1PNzeSa4r6RrJruNus9yFIzlxV92
 anL6Tcw1K4emg2xx26x7x+7cncRZ0CJrJvtiHr/uwiU3IWhix9d1VzRUKcpUINquPiwn93yVL
 iDUcfZs+WpkwvtE6oiKxvhFd8ml/5CTvTY7/Gj0tG/whdEVNMpccOZprAKQDDDs/Z3LEHJPNR
 fXwccdiOu8KxdFw5Cij/F0p6K3OOOJQ8ZX9HGSSugnIFPb6kRYRY/X8b2Y3U/djHz1G5NuO/h
 tdxWEGTVs9ZsIePTRDBnja8xqC5GFoa2gSPu7Y06ZY/8blNnzNKJLfcc1QJIGg84BwzFagpoa
 hWif7peJCzjTcs1YWECxYPxbnmxOvQIv2whvwA3An9EqPq3I+0cJKhpJRRN6acKEn1HBjOrHw
 mH9NtL9g5wyL5QgPUYt+OsXxFVv8UyFCLco21krBOGign4Kix3MN5VHPdbnYPpWDq9YVpxM8q
 yB5Ol4I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/09/2017 08:52 PM, Junio C Hamano wrote:
> In the form, it is valid---sending a message to git@vger.kernel.org
> is the right way to describe a problem and ask for a help (or better
> yet, propose a solution ;-).
> 
> I am guessing that you are talking about "squash" in "rebase -i"
> command?  If so, instead of saying "squash", you can say "fixup",
> which will squish the change into the commit to be corrected while
> retaining the log message of it, which makes the new feature you
> are looking for unnecessary, I think.
> 
> Unless I misunderstood what you want, that is.

Thx - answered my questions ! :-)


-- 
Toralf
PGP C4EACDDE 0076E94E
