Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15821207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 17:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934401AbcI2Rpu (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 13:45:50 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55106 "EHLO mx1.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934123AbcI2Rps (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 13:45:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u8THjXYI003559
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 29 Sep 2016 19:45:33 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u8THjYfP014942;
        Thu, 29 Sep 2016 19:45:34 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/4] config: allow customizing /etc/gitconfig location
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
        <20160928233047.14313-1-gitster@pobox.com>
        <20160928233047.14313-2-gitster@pobox.com>
        <f239b2eb-d122-9c4b-187b-fbd40a94bcf4@gmail.com>
        <xmqq7f9uhbc4.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 29 Sep 2016 19:45:34 +0200
In-Reply-To: <xmqq7f9uhbc4.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 29 Sep 2016 10:20:27 -0700")
Message-ID: <vpqmviqk3b5.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 29 Sep 2016 19:45:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u8THjXYI003559
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1475775935.05333@q5MLCX9HkmuOLkBF0SqrGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jakub Narębski <jnareb@gmail.com> writes:
>
>> W dniu 29.09.2016 o 01:30, Junio C Hamano pisze:
>>> With a new environment variable GIT_ETC_GITCONFIG, the users can
>>> specify a file that is used instead of /etc/gitconfig to read (and
>>> write) the system-wide configuration.
>>
>> Why it is named GIT_ETC_GITCONFIG (which is Unix-ism), and not
>> GIT_CONFIG_SYSTEM / GIT_CONFIG_SYSTEM_PATH, that is something
>> OS-neutral?
>
> Isn't "environment variable" something that came from POSIX world?

I don't know who invented the concept, but environment variables have
been there in the windows world since it exists I think (it existed in
MS-DOS).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
