Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D5181FF40
	for <e@80x24.org>; Wed, 29 Jun 2016 14:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbcF2ObN (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 10:31:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:50722 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073AbcF2ObM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 10:31:12 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Mc8Pz-1b0sFw2KT1-00JbrH; Wed, 29 Jun 2016 16:30:59
 +0200
Date:	Wed, 29 Jun 2016 16:30:58 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Late edits to the rebase -i tests
Message-ID: <cover.1467210629.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:K09mxKZC01CbRo2Pk4xPnm7nrIi6wGJJRLd6n234wjGZlt/1h5c
 nKg/rEXNsN/xB/3llVXkoSQyE3UmeUeQoXucB/FYxI13URCiPj9ACrk7WRr4EeD2E6pvNxn
 AHReWbT69IiufXH7gUG+GrDdb8SIYO+/l8WgJzzDysy8bgfqsmvarlYqE3KPZhPYVbV7nzy
 QCJgV/+96px7kTrYXa2Jg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:UdUAs0A8gGs=:L8YBwiH8rHtZRK73XaCGaZ
 jZZJ2ahANEwOGIXfuMhkstclq4+r7kgP8yFyUaEXqBkz19UrJBTkezMuWzs4qWQA8Ie8yvivw
 OkQajo8QCnUexpX5PrYqMRxdLF3IczBTKPKDvRM+L0pfncPh7L9DErzWIzNNGZ2n1n4WzjD6b
 PU1kgOcRuKb8k0wZWlZSTFIwjV5HA8d9qi9joXXlQsm3ZKtrkMXb4lbSUJz5zc+Oq2cV+biZH
 E+EBbK2Z7L/Q6up0+xf26d6w4sV5f2l6JTiZGH6Say7AJ5Pa7p8W+siV/8Fq0XK3kjXmAZ3hl
 HIjgFLD7MLAKuz5la8rXi1TyZtMEgf8GYAonBLAvjvbdlv7lPoimFWWP5XDE5Vha//do8G+2U
 kckmLZyhZ0XsmsGwd7pJFrVVjBJcMhHlrPjTEaAKbtibsP6PvbFvJYWuj+IhBrsNaUR8dWv+2
 fiEbIISsX2C9S9aq0533r7ywE79Yy4i0B4/L4+OTjoLav3vuV1LHAvXGySyxWrOaZOwWssLbB
 d79ECtbmE1JfDeBEb9AOkCFiIxXm2QFxUaMSHh7+YCtw1r3tzBFL09xJzt24ih3YuK7ff5yCP
 DJZ9e3/FlvQlAmuayP+7Xo/JLL9uRaS7oTRKG8cv/drfJFweWQTdXXlxWLT0N35sIr45OKihc
 v6okeD79/m5hg77Lkm0r8WdyzAivlIgf3Ws7k65OD8P+qv03QEshhST+naQi+5iP663hamkH1
 uK/0VLtqKC4OzHiq50STWDdGnubtWjH7q1+TEYBA66r/+RqnaLVTixaURqNpHbvH/3AX7I5A1
 Zd/3nOJ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I meant to send the first patch much earlier, but got side-tracked
before I could add the --gpg-sign test.

This is just another patch series in preparation for the rebase--helper
(to be precise, this is the seventh out of fourteen patch series that
have not yet been merged to master; Six are already in flight, so I will
stop here until the queue empties a little.)


Johannes Schindelin (2):
  t3404: fix another typo
  t3404: add a test for the --gpg-sign option

 t/t3404-rebase-interactive.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Published-As: https://github.com/dscho/git/releases/tag/rebase-i-tests-v1
-- 
2.9.0.270.g810e421

base-commit: cf4c2cfe52be5bd973a4838f73a35d3959ce2f43
