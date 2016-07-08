Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BA3A2023C
	for <e@80x24.org>; Fri,  8 Jul 2016 06:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbcGHGeL (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 02:34:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:51136 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299AbcGHGeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 02:34:09 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MFgxF-1b6tAP2jdV-00EeBF; Fri, 08 Jul 2016 08:33:56
 +0200
Date:	Fri, 8 Jul 2016 08:33:55 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: ignore return value of write_file()
In-Reply-To: <577EB546.1090007@web.de>
Message-ID: <alpine.DEB.2.20.1607080830430.6426@virtualbox>
References: <577EB546.1090007@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1483410134-1467959636=:6426"
X-Provags-ID: V03:K0:HQJlidYB62Zxtiqe9wqzbSykgHiH+uwC1zgoMMx02y1UwLVvIbY
 hoETpS/nJpu/f+vUwLlx8vL77avtziZZQHOuC0DMIqPRdnWX970PlmlePDMVo69C4E2H09W
 xB5e6Cw7PZIUo4ZD6poItLRVdTG6W9kZYfuJtyii+p/SzeEuUKbYnkxmRY4qmBwH5xTzwmC
 P2ve/+NaMktbI0b6+mIPQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:eLp4790I7io=:fcFwsbQv//COl+YjC6h+9+
 RMJnPUqbvkJKt3+UU77vuqSwMlWjMG143BpwN1M9gMJfBbeystJVqucRstSBpkWvn09XTbIEr
 0dbpGN8Nw/PSW2tKN8V5IbxcRLSS239At6vIXS2tFYecVkaR+Cbx5wPQV3yEaNhGWofxL16OY
 T4Lavm3mEbPlomKsjYLp+X7AcwhEvtD3fl5q1ll+o44XkGZe9aVvcVS1O40Tf30SgeOlglNa6
 4Jg/w+ZNvTaQF6NIXq7wESZyD8PsnB6Az5VYIoJhqtLRX7pAMhf4ufcBqN/Y2g/TXCCSH3ChZ
 khI9WZknT9OkrFjodl3FqjL8z/ALRDmA+i9cq9ebIFRHHwGnM2ngzUXkrQzeN5ZB7g00gKoSf
 MbVQx8na38GgV6FjGBfa6L1KUTttMWrEyh7hbzmcA32PGBfGWMadTHiJF/wC3CXERGH7OWDd5
 A+pV+WVU6unGhWS3QolfD1XBlI3g9Ru1Af2p7B6s83cVimjzu7SB3sZa+E1DAv5jBoCth8nK3
 Cp8LwWrXqxrIgqcbQrvD0eUJjOMs0MUxadwHb5BagMU6Ik9BFuOqUwGhPST/IF2l29eoeYQfc
 Tm2flhrGROgXyzqKbeRkFJwJN0i5RUhdWGMTf4qV8d2PkjBn9oEPEqfcvXIcnfZE6VkCP4dQw
 /5SNxZ9COwsnx+rJYF5KWRY/IW1+9vQVxmJvIE/FiYqOl1LxNCONkbjPQPwilp2dH5dexpUBO
 3BgUOGxz44/BSeWlLGNngqi806tT9nuktFWmwG8XzhLHkdQpXHN5cY16VD9mVHPHji9LqKvCE
 tmIrZsj
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1483410134-1467959636=:6426
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Thu, 7 Jul 2016, Ren=C3=A9 Scharfe wrote:

> write_file() either returns 0 or dies, so there is no point in checking
> its return value.

The question is whether it makes sense for write_file() to die(). It is a
library function and not every caller can be happy with that function to
exit the program when some file could not be written, without a chance to
tell the user what to do about the situation.

If write_file() was defined in builtin/am.c, as a static function, I would
grudgingly acquiesce, but it is not.

IMO it would be better to fix write_file() to *not* die() but return
error() instead.

Ciao,
Dscho
--8323329-1483410134-1467959636=:6426--
