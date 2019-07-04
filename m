Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12AFE1F461
	for <e@80x24.org>; Thu,  4 Jul 2019 09:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfGDJcV (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 05:32:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:50983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbfGDJcV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 05:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562232734;
        bh=d+Eqe2+E3Aw9P39kHOY/GDDiNGVrCZ4jBJxxc+RFrfc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fuo487VXfl4NSoh2QDrX7zrXcAixhdoTgpOv9zmOQ9gURwdzgn1Njdu17d9lg709z
         p57BOndg6nIi8I+kPJHkaamqQM3E4f2Yr8wv6DebFPPW83vR+XrKjBlirGl4xfuFqn
         GkhR9qR8X+DlarCez6CbuYVwI/vUPizrGz6U74uk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPUZ7-1heJGJ13XF-004mJ6; Thu, 04
 Jul 2019 11:32:14 +0200
Date:   Thu, 4 Jul 2019 11:32:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: nd/index-dump-in-json, was Re: What's cooking in git.git (Jul 2019,
 #01; Wed, 3)
In-Reply-To: <xmqqpnmqzrbg.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907041131270.44@tvgsbejvaqbjf.bet>
References: <xmqqpnmqzrbg.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:T4pojzF8mBjHaaEqNQezi3RLSRrDKHOq3fQ9Y9TnsSsBFeNrqv0
 bNuZJfVEMr7UNnb9+2ddbK7xGfhimyGb8G5nXrUbFqxa24YalXkfpZooMseksM+Jwq4R2As
 XCEQyxtqvS/YTP4bJXbRfFsz0+9g8wNWfCWWMgsL8DDeDn1Z++PilQsojozPdwvhhxrQ1ta
 qhX9M+FG1cffHmd5Em71A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x8CR+U5uWJs=:fbcgepGvv1GpghG83/uoW0
 GAKqh44reu2+4qf/J/nZbyW0xuIY6MTvfrXuhdED0kPjZwLqYqOQnuHUVIVNmOPoH4Qb7iZNp
 1ES/L8uEBx77hgJ4RZLqvGoJ9PdkoBMER00NK4CyyAd9vwwn/4HWVyJwOUdLwyy0R94j/FuVm
 cYc1MS+EFoEv3vDil9oIZqrbgu56jUdBo85XKWPeUDRxsg0JN8FwcvJc9OyFoAT3/Iqsx/eap
 3gvGIsSlbgck+Vf/mMJ3RKlUy4qr2tl9acztWm2IWQY1Y3x2+hgaYJULbo/I7CNX9EFHnJ76F
 9gR1tQEVLBEd3Bt2I2ZkNkHB1HLRSUnS2Lbfin8SoXOBgBnbJ3fAmQFIv7PeSvQ/WJRl/HCzP
 AaabM7wr6GwB+6ihWG0NWefxDUoa+PqGjrklmwHLK9WHNAIloibaPZk+OV8U6TwKkgas9wSUw
 plKRM7ixAyGHrI4s3iEpYk88i4TrXSTKb0CfTvLTrV32YKPspEzJI0qLFlzCUy5m8DpeqPhFP
 jhJGU+o6e+IBS3d8wj9nke3bJC0Bpu+UeLcB2uVsF+uZPs/v/DVLinHBmOC7rkQd+ssX1x/wx
 Jff6iXOW8PHveIL802M3uz8LJv6NTm79BvVLQQb2W0mUCrctUtbJUnYAcK8dzNJDDHgPfdua0
 nbCDUK8PZ61jEzr3EryMFarvvmfQGhDqQkRusdZ6N78DzIttC/yCZIs7QGoFTEQnQEj57UAde
 bqoLM/HLa82FUhVxb92N6PFb7xt01aZKcECz4xmH0CTjEJMQc1C8G8SUWJl6Ar6Z3JEz2BTZo
 vhzuI5EG27GD9ibUfH/e5nkjcTGxfwo0wS/yMdTuPM2rXkTgINLuzOQmMbG8J/d62qHJgzm8j
 2o3u0Z/J9fFxNbU1LSwS2HU+g3tI407ph0sjZgA5c52x+7dW8Q0O4l+QAQJvnjy4ZbWGrcPKx
 IqMHGJcOZnewV8HkjHM7dGt1VVEofrgVaY5husUaGAbBq8zsyA+gTeUmjTwEmTaiSHFm3IPSM
 FeXnW+x73rfcgbz905HJiAzHpN4XfLiC6rmB70VRX0Tc3bR0Gm8fCaEocbQsVrpLvwoXIMREX
 bWsDVPOaST1332DjCFwRvv6Lubgc1AB2Z6q
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 3 Jul 2019, Junio C Hamano wrote:

> * nd/index-dump-in-json (2019-06-26) 11 commits
>  - SQUASH???
>  - t3008: use the new SINGLE_CPU prereq
>  - read-cache.c: dump "IEOT" extension as json
>  - read-cache.c: dump "EOIE" extension as json
>  - resolve-undo.c: dump "REUC" extension as json
>  - fsmonitor.c: dump "FSMN" extension as json
>  - split-index.c: dump "link" extension as json
>  - dir.c: dump "UNTR" extension as json
>  - cache-tree.c: dump "TREE" extension as json
>  - read-cache.c: dump common extension info in json
>  - ls-files: add --json to dump the index
>
>  "ls-files" learned "--debug-json" option to dump the contents and
>  the extensions of the index file.
>
>  At least the fixup at the tip needs to be squashed into the right
>  commit.

... and the test flakiness should be analyzed. It might be an indicator of
a bug: why else would an index extension sometimes be omitted? It could
even be a bug in the code that updates the index, where it might "forget"
the extension from time to time.

Ciao,
Dscho
