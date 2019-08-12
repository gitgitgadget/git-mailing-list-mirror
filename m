Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0DF21F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 17:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfHLRKz (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 13:10:55 -0400
Received: from mout.web.de ([212.227.17.11]:47237 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbfHLRKz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 13:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565629850;
        bh=ao8s4Ik5WDzU3DQ9Oe98adjKq4dklgOAV2hlDgzmw1Q=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Ubs2usRJ7QRG5tJPcxiyjlpd9UqfWMbCHws9iTr+63SMmYjZNwgrD8LxuXo/+iWYo
         9qNTACveO52cu+7cjWpBmDblKI1u1TeLfyo0nqDzYmJgLoQpYfvOYHzzpEwq/BCNw1
         GLLgYCZHt2DQBmf9EaP9eMoZgbJhrg5ngBRRFmjE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmcjH-1iWYf30CHr-00aFMa; Mon, 12
 Aug 2019 19:10:50 +0200
Date:   Mon, 12 Aug 2019 19:10:49 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com>
Cc:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: Re: suggestion for improved docs on autocrlf
Message-ID: <20190812171049.ydec3nsmkt2xplhd@tb-raspi4>
References: <9c79d35e48df4d28baf995ad3f5b0153@bofa.com>
 <20190808205631.e2647kxq74thotjb@tb-raspi4>
 <3269668c03a8482d8d854ec19dd43907@bofa.com>
 <577a66e0c26545aaa4795de3c5189c9d@bofa.com>
 <20190809033406.5t5ag3qmh36ideec@tb-raspi4>
 <0c1b48c9fad641689ead69fdd9f72d63@bofa.com>
 <20190811121004.guygurnopwwggvsp@tb-raspi4>
 <64c0a35825af4ff3956c6c9a5fb748bb@bofa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64c0a35825af4ff3956c6c9a5fb748bb@bofa.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:sr0EOSiCleUiOUM7Hz4GdA2c2dBvZlGZgY8EyEmJer2Vt64LieP
 crdujJRoU+MCn7SCs5tJTMv7zvOrzu44dz/oajEH0BRMUy68TWUGnZ/Zb7fuFNhiSxHpgrI
 Y3h7m6xb76TeZ4kI++VUB5RkT2qLdrC9v9x2Pe/WIUbm/tggXtE8mvaiWP5UK1X1nncfnpo
 xLgQZSm/OyNj0enOIg4LQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TIfc9Bqunok=:TSgPdd4lRmg5nr6wOk9qUU
 ydhqbczpm6e0TtYprI48I2lRBlrt3JKAZn4tO6n+WMIkv2lh0AsF1SfJXZhu/BVc/znJqJJ0j
 EHmoZpL0VLda+t2A2gE9Yb7AUKUcGqdd217VFKEHsU/obDArrRAJjiO4MtYD6TLwLVa6AYrNi
 k8w7UTfSWquQ1lhpszUhCTP0RYunIReOFfsL0YgQ0Glc4QN/FMUMQAJRKrMS70w64TpftPaXD
 fhuHOdtamRYtGdNlbEPf8y5q8/UwzuIHIqxdOOmUV7rDbozMpc1F3Gexv/5RJHkqj3NKwJHA0
 zErU6ckcu2mkAyHcBRv7whZ4QfjUo79wqgDHsRIu30eWsNid8XlxvNeMtD4UgMeHa0NBahoty
 lVQ4J7pNfL6Rd3RPg4GD/jyUXjNr3dtJkULdWTxjdjzEVXOQbI1a2PWrmbj96dUibM8xSEIR0
 PSZqRWh/NtRxwMd0qn6qMTbe9tk231ij6P1FNt/i/T+WuW/dhFlD4KmSsldFk0egvO8eYZ4VC
 kpoJ6zj+DGKG6i+UX+zPCIxdYxYkGC6R/iImWjiUBxQUMrA855U5XpznjJrxeZP5U2bhsZa4O
 9hf6RNhZU58r34FR3ZGMpcXC7dfLqbg7ltsTZzfDh5TWfPsytBleL/zqz+Q8/+kuQpCRQZ8b6
 nkXjGZ8yF5MSpDWNWtauWU3O4XeaQs0zdPhymHm/nKNk6e96EuE0+KMS1Ua+kFgvCsd9NnbVD
 MtFosivXCAksv8l8LfMpYbn83IcL+mB5iIIDaxfL2HoWUPbS59EuFGM2SUMYRrhtT4Rd6qBdt
 8PmNh3sL3eCHE6SPrcIF9MX5NtNJlZP9t2bgY4CKTaRDrQtwCHZ3sB0mWsLYwFWoi5g4farsY
 goJujmyY1su0NSQtESTdI1jhy/V1eeqIqnZSJvxaJyr6lnwn5s7BwFIYVUZADgx0PIOE1OlsI
 Danw6fa6ulQtpgPvXYlMlZtwta/i0atyn2MpfZlae9/OdRzG1k90k798/7znvjMtp6wYmp1Kp
 0Vl/bWJbjsfVI8Nh9q1h/Xa2zIKo4aftzdcZyzGgyPRYm3dbSor749t1j4lVUgARKNFJ0cZKf
 o2eCQkod7Q4L1Q5YaOVhQEu3VlEjtFrz2jSw4ZTtO4Bcx1MdF+i0fW4MA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 12, 2019 at 01:47:18PM +0000, Yagnatinsky, Mark wrote:
> Wait a second... suppose a file is committed with CRLF line endings.
> You're saying that even if I have autocrlf set to "input" or "auto", the file will never get "converted" to LF format unless I explicitly renormalize?

Yes.

> That sounds like a fairly sensible behavior, but it's not what I've observed in the past at all!
> There have been plenty of times when I had "autocrlf" set to input which resulted in me changing line endings on commit I had no intention of changing!
> Indeed, the whole reason I was looking at the git docs recently is that this happened again and I was trying to make it stop happening!
> Or is that not what you meant?
>
Only changing core.autocrlf to input will not change the line endings in the repo.
That is intentional and allows to to keep core.autocrlf and jump force-and-back in
the history by checking out older versions or later versions.

That is why I would recommend a .gitattributes file,
which travels with the commits and through push and pull.

My feeling is that the docemntation for core.autocrlf should be:
This setting is deprecated. Use a .gitattributes file instead,
and please see the documentation.
But that is clearly debatable.

