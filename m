Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A737B1F744
	for <e@80x24.org>; Sun, 10 Jul 2016 07:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbcGJHBc (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 03:01:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:65374 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbcGJHBb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 03:01:31 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MW8PN-1bskhQ2NsP-00XHbg; Sun, 10 Jul 2016 09:01:25
 +0200
Date:	Sun, 10 Jul 2016 09:01:23 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Theodore Ts'o <tytso@mit.edu>
cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] guilt: fix portability problem with using find -perm
 +111
In-Reply-To: <1468102715-465-1-git-send-email-tytso@mit.edu>
Message-ID: <alpine.DEB.2.20.1607100900320.6426@virtualbox>
References: <1468102715-465-1-git-send-email-tytso@mit.edu>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:i0IYVlsEJPnU6u+Rw7BGzjPHfsL39TgY0o+VCn2XAb6OlpFB/LG
 N9K+FGWBz6P/3rOZAyqO0x84gjizf6qNgZICo4eWAVfqJELK6YPQd39SwbfD+5aXZkZd5Gl
 /zhZBuPBMlLTqmsFqjyHDK3CB9wNnG0FHWS1ANTloiGpmTZDEttAy+vvYRqCHgHTl3H3vsW
 HebXWeSFiNMzPSRGAkyYg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:WXOZbQtNflU=:YxfIL8vEaK5RfWWcT1NeeT
 jiyeF24pd5ArAdNunmM4xI3S7kqikH+jInoVHv50mqf6p4Qqh5aFSsEl1h+8qpn8m67yWIuGV
 30JT9zMt7glkEeQnIGtHXRPgyVT3vE3va745ANSdjw6W3lecsDH2FhbOTtm7DU8tGt8SBjBSs
 Vz8lscjDCPjkXMc9twQjUwCreKqoHE4s50I13CtE885pasg3hM1O27vqt750UiCpk64JGVI25
 P584mb5o96F9NvNXMIINbahkY5bitVoe8r99qUCJKx235RiYJ0OWcHiwnjssxqsed2m9VaQQb
 6uIMeqYTWKM0XSdPU0XsC28yhczf6/WOH8ko31SP/Ffjo/PNnNL67qCz0IuIuNrtCUOwWIqjd
 Q0rfam1QAUfasa6RBU6XTup/F1fuEX2JcDmywnz9EXV8zZZ8wk/KKV6rESYM1ecMDS7AqPeFP
 THRU1fWm/8z/CnwTwiICTVfnhQaRf0+oKL+UgAwPRUeklYD4P2jrf4A9CIfkSG9jwwm+NmS1l
 HoUQ6BgnfGOMsGwUjT8j7/SWGzVKoutS+cWFsWRhMPBMO3rt/y3rEBIrqVMsMMmSgIsgiDKpo
 EncIqS7nKEF2O7NhO5rGj4+zxbCg/4XHfMj5UdOiR1DEkgqU/1qghddXSpo1f3r+EVqR7Zyv1
 FCcK3Y8xD4k9MIE2wMwOGOlACuiAB79SXvRAato5ZebNcAjg7vdkCCtOhP/WIi6GD/cCfxrSy
 6ioqH6bDjYdDwR/Xaw2QVQRoUGNWPgSVMZEY54lkVa80t2G6goyDRiW+5vQZMPoSgG4baEGJf
 vIQcqKX
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Ted,

On Sat, 9 Jul 2016, Theodore Ts'o wrote:

> +	# is arugably better, but it is a GNU extension.  Since this isn't

s/arugably/arguably/

Ciao,
Dscho
