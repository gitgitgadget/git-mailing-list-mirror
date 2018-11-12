Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA81C1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 05:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbeKLPMR (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 10:12:17 -0500
Received: from mout.web.de ([212.227.15.14]:41153 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbeKLPMR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 10:12:17 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LvB2o-1fNGon3sH4-010PlO; Mon, 12
 Nov 2018 06:20:39 +0100
Date:   Mon, 12 Nov 2018 06:20:39 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] remote-curl.c: xcurl_off_t is not portable (on 32
 bit platfoms)
Message-ID: <20181112052039.GA12275@tor.lan>
References: <20181025161310.29249-1-tboegi@web.de>
 <20181109174110.27630-1-tboegi@web.de>
 <xmqqbm6v3qex.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbm6v3qex.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:LZMiY20YuWzyh4LddN8UPYd7ixFYITydlPgOtYMH6NuAPKrumRG
 KCEJsxPY8U8NOqCRaKNnw7fxMBuhXX8qlJCGpLfL5xRKkMLEMySaaxcXzKAjfdQt3MFlDfj
 Cn/U+hS8qmmiyorr4wYK7M4tUcZD79wu7MNrR8nhS571nA+7TzhiyX3QfQgipwfDAqyKRFo
 q/0NGJpQzuTNZ0dKJ5Q0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nLFT/yWCK9I=:zSp+t5wDmevFzrzN4CMB/9
 90PnFmWCrIeBlT8xnLRLl3/yj7PmlVblWj6ufVZg170kPYcNDZxwuwDVcVZf6f6BE6xroRuUU
 u7SaNzQwKwiKynk/y+KkvxEAZUgoME7Jm8/5jvcgX3QueKudWg8ReLVMNflf55OhH8Pq3YBMi
 n1dNUJ7XFmjvsQFYNJ/x8Qss4+3fPQJEZ5z2hrD4RLQJpgmacoTmP0Caja2jljl4r/tEloPkN
 Yw9iqkvcl9VtaWhn+f+7avJRvIXZFyDBi6WR54OeVHlbKjzoG1k0tRzCTAJ5jrfsQJ/cNn6uu
 qntM9KYPwB/2NzNzvb4jQwYTdyjLXTAUs9gqUl5LRnQm58WxJHhA0VGFmN99kWwdE6Nym+26/
 sKFjrKT+PPLBz+zRDDOcMAIr74TUp4LEvpbnefZFST6P22+nr6vjZlMipSf3u30RH55XCSxRF
 rruC/TN8koAVLbyozABtfS+jZZcIwTxbHFssVgN9oMtzFYmXrQnLXewR3qw0C5UddUhImpJIe
 mw3p/omsCnULxgV7UnPgtOHjnozfe9hcbH3RZeJpVuPqOq+o3UctYdRqhDHaRMZdE4NHD4W29
 MABkLCDokmc7rJWXNBNugICFIYkcwNgGs3uchK6ONzeB26CwdeF2LTTz0k6QhzwZuBpiB7+40
 wS81QqV5uU4K1av2/bIrUIpJNqppiGHr6jYUMiiiTZF5HF212Uq9jKT404NqYto88zyuHaeOS
 5SIS6G9wlnqeT08zx2F5Oq68egYE7PG3IU5SYjoocCsZx0e13sCYRs5x/OeXxV0Buc5qL2M+5
 jTLpcN1sEsdb9sx93FqHQHxU9TfHQY8UUrbJwzMLex2K28AFQdsWf9FrLclPmAepwE24BS+wf
 b7tR2tNclVeF3eOpUH5TYvync87Mz0IBPgG680MiM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 12:50:30PM +0900, Junio C Hamano wrote:
> tboegi@web.de writes:
> 
> >
> > This is a re-semd, the orignal patch was part of a 2
> > patch-series.
> > This patch needed some rework, and here should be
> > the polished version.
> 
> Will queue.

Thanks, is there a chance to kill a typo here ?
s/comopared/compared/
- A temporally variable "size" is used, promoted int uintmax_t and the comopared


> Next time, please refrain from saying "re-send", if you
> changed anything in the patch (or the log message), as the phrase
> implies you are sending the same thing as before (just in case the
> earlier one was not seen, for example).  Marking it as vN+1 like you
> did for this patch and having a reference to the original would make
> it clear, though ;-)

Sorry for the confusion.
The next time I will not send unrelated patches as a series,
so that we have a better "Message-ID:" and "In-Reply-To:"
flow (which should make live 3% easier).

https://public-inbox.org/git/20181029165914.2677-1-tboegi@web.de/
https://public-inbox.org/git/20181109174110.27630-1-tboegi@web.de/

