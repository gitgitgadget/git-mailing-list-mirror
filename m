Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FE3C433E0
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 14:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B1BC64EDB
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 14:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhBTOMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Feb 2021 09:12:55 -0500
Received: from mout.web.de ([212.227.17.12]:60773 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhBTOMz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Feb 2021 09:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1613830263;
        bh=S7oeOWYdcCC1txcqlbzjGSXvHSEo6jQcCkPV6ihJ3bw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=sT7xIczyqRR3Vcy6qZhdsnoPmnaVFH2QqpO+RkgCJxBN+cL8+EiMP7om6bLQT8cN2
         LJA9/Ub1K5sGc8czCNPRa/QCNpFoT1TIs9A8BIUethRm8KCSzdg/Ly7Zv+I6iwpYGM
         e7MPdMdwvx4xaM4cFaJK8Qfnsxyn/++rSfPLdYOc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5OUd-1m3csq1m0d-00zYbt; Sat, 20
 Feb 2021 15:11:03 +0100
Date:   Sat, 20 Feb 2021 15:11:03 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Divyansh Garg <divyansh.gargsg@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSOC] fatal error: curl/curl.h: No such file or directory
Message-ID: <20210220141102.t43mb4gxwzseides@tb-raspi4>
References: <CAB=huCZLwkBv-Fd4iUqbDwNuNfeFBfjPfKRzYUGShc727KJJzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB=huCZLwkBv-Fd4iUqbDwNuNfeFBfjPfKRzYUGShc727KJJzg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:e0AxJHa7M331LZKYV7ofI7NnAVGlkb/qHrwc+yyH55vQo8OQ8wz
 t7Spxbjk35WXVXoJvTY09QiUOEVSO82cjrhz55KL89QpTIVgJknviu+zQGRZlicMQLBoO9z
 GUfNFUTTq7JyZgO5hKlzmTQHLj7dOyF54VJizt8cc+il/GT6qZ8ZmC9w7sSLrNBXRVJ3Uti
 0PdQVtEFjNcF9a6j037MA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vj4lZiEFaUk=:jkmGLduiejl3beaNXrGHHi
 B8GZHGM9xxe+iUFNZ4o4ov60a69ZtEKStepJFSX++EBaAd1VaDs7lpledMTm4YXIxCyJBNp3P
 njnttnFcfDQEw7PM0jwJqxxWM1SBhKZ6NyUTJNj4FvFTQBjVY0YIIzc1WLQm12cnAv4lAn8e1
 UfXG8l7XaWI3R/2OjlCOih2l1nszNYx1BX8YIpVWZ/UnRvu/5frCbvqE0KBDPfemm6qqaFQZm
 ohjhTW6mLSnlanzsoMSacSXyqYFqFoQT+ytqgKq8GmX63mv77DBzTgcwfmK+3Ev8AWDw/fDCI
 JFa8aps1Sb/zDo01yhW5gz7U/j/ioV3oaE5rn+aR4tkkDAdpkji1UunV13mA8m7dTVrN3myBz
 XY2V1DoMko/6yX0+4AKggIfR/axV3bpMm2TMXFeyng5ixBbHsbmFISjn/tKdb+Oi9yonQ7Fp7
 3Yi2QcaZnT43msDlSsRr5SdV2reDvfG6nfVwcUMbdoO1nLQ/9KkHAipROj+KH7aEuMIEZDUua
 x1ZqQjpy77Rjvquj/TovRUUb6UOmZd7Lc/imlYGnsWln+7A2rKGyZFs5dyyt2lqSlgUpKN8Wh
 hD7fIHlCPKZtzeV1/ucb3+9IaLMyCcv++HvrGAJfrJOzn4Ic3AtWuaHzNWwo48YSEGK8Q8fac
 toaLGzIEasBEQQSb1RrJgoyOzAaTfx3wDTzyjzUUbyfrdObUKKyPFHHtfssN6MIdvxxKSHJyd
 QE0HRmUXcnN4M/m3QKQG/e4AfJ9s9lAvLDS1dTgksprbwKbVZ8UranukFTdL43X0yjtedhrDQ
 1K5yXgV2GvvRUOF+gvhmGlBD3ghl3sKrM6/l+ztgwTdWVTtvycTp6PFcrYmmeUjt3dI6Pia8L
 lyk5La/Z2R7uhIo/WfeA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 20, 2021 at 07:27:32PM +0530, Divyansh Garg wrote:
> Hello,
> I am trying to build the source code on my system (Ubuntu 20.04).
> After cloning the repo, when I proceed with the command: make, I get
> the following error.
> I tried installing curl and searched the internet but couldn't get a fix.
> Please advise, how can I solve this problem.

Welcome to the Git community.
You need to install the development package of some packages,
which come with header files (and not only the libs).

Being a lazy person, I collected all possible package names in a setupscript,
looking similar to this:
  APTGET="sudo apt-get install"
 type curl-config || $APTGET libcurl4-openssl-dev || $APTGET libcurl-devel
 test -r /usr/include/expat.h || $APTGET libexpat1-dev || $APTGET expat-devel || $APTGET libexpat-devel
 test -r /usr/include/ssl.h || test -r /usr/include/openssl/ssl.h || $APTGET openssl-devel || $APTGET  libssl-dev
 test -r /usr/include/zlib.h || $APTGET zlib1g-dev
 type msgfmt || $APTGET gettext

In other words,
sudo apt-get install libcurl-devel
could help.
And you probably need to install more dev/devel packages, unfortunatly different Linux distros
use different names for (from a user point of view) the same thing.
So I can't tell you out of my head, what Ubuntu needs, but there is hopefully a start point.

[snip]
