Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7920E1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 09:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389260AbfGYJZG (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 05:25:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:51859 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388704AbfGYJZG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 05:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564046703;
        bh=vLqBM/MM6JreYu/+Ddz9kQDtkooMJrV8KE6JZ8YhEbI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WevhsKQxNn/tCFaorJ15m+Dx/fqheUlBq4o611fU7Q3av/HUXrxK6GS7LwHvbv1QH
         mDZzI/pPbKWi4QMvkqjVgnmGCYTaTisNhohRf8PA9QSMnY7IYai9asdATKQIPtbxez
         h78t+HKRy5h7p12gAmMVk+9vEA8DBLHrp0RNBmAw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGVx-1i2JxD3n6z-00PhBf; Thu, 25
 Jul 2019 11:25:03 +0200
Date:   Thu, 25 Jul 2019 11:25:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v3 00/13] example implementation of revwalk
 tutorial
In-Reply-To: <20190701202014.34480-1-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.1907251122260.21907@tvgsbejvaqbjf.bet>
References: <20190701201934.30321-1-emilyshaffer@google.com> <20190701202014.34480-1-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WvBpun1/65daA6E8AedggPR8Yz2RN3+FWwd/9xnYHitttLe+dye
 d76+vUVSGvaPlyCTtdt5s3+N9LcXMH7W5qvtaq3Az6ORw66BHQxnUjDFZvpaxvgCfqYA+2N
 S6qbYpOCKnG2OK4V54XFJOFqKpGYCogYDIeOhl9/Pww1o/wEN2WXr3Nsqy/EZ+OPit0yC/w
 znZd1aQ76byP9+Nsaldng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B0q/OOlZTHM=:W30gLGft57baLDhI/tyznf
 pXDp34lTPBdbmL1/Pu4rtJMBFKDA5FbdReoSfj9m65SXcHvLiJHAPA7Nofbs5biPuT1xNqWgz
 PNxLOPBcYB6QSnXd40goP5VK/AeOt7JpZAAYZHB4cX8m5xbYDlL22ew5xT3f//J3Jx+Kd7AOm
 BvvhghyQ5VGrnMWzPumWr2LroohoyiH3XdTjOWhQDnarI6H6mtbXywcXsU25SIsAMmlX4vuxL
 IPpCqbvFdUkgytHwo2rvhcGRPkl2+DwmizRZm2ni9cIPG8xB48sQ15flMoZhWzXnLCzjNaY8Y
 EIfvumkDixb2H/PH+/2GUjV5dQnT+stp4S7oEwTua1rvwbbOXGVHUXpE199uiBabVqfRr5yyq
 4nSiW2JRrZzNKkrPyoVbXl2rIpW13CVmVQkAKwrXQxf0SAdOKUFBT+iSUptRXQe/GXfMdzjzf
 OgAqgIsh/84g/lCqE7/fJU6wlP1/7yWke5TUG2qQTdINYHkvM9b7R7a9t7ggkWnwlz/jKvdA8
 0M1fGR442Q7UMNNdB4p4Q47ZunP0WpSCsslXDn3tYMlQNERCtaYMBYfi7WKD4JB2Mduv+svQ+
 360kWQo2wSZgI1/bxSqSNqkBb2P1hysiz3+XF9TUGWBecWBIr6JwDu9ra0t7jDmrKbQKzmrjB
 FZifgKgYqV/JMreTmCr6XJwLN52G92iGwudRdEVUn1aquE81JUaLmCuEehPx7dmTDy6+PiJXl
 7k9JsVFAQ4U5t1YkKdc+k6gPmZdpdiPTV5rQDdR6DBrBe/HMfiz12vkLI7Bh79HGgWCVDWMxd
 bScqt3uK3teJro26T7wFj+YFlp0b4v2CAGnocoQAVx1fg7t2rk8IEgLj5B4jT0rAMCzGv5tBB
 xjaHsxCSKaq8HhPxuv3k/HtnKeBquh6riDF89Mw2HByax6/gjDaGOIuaty8EILHb4YxNnrvPI
 xYRpjm2d+ZB3oliOWVT/xaryZWGGlC+BkSJKsxzEhtsWHT5iXDPzDiskkR6oet5ZYP3XX549h
 Jq17n+lh9QfLz/17RHvD8Uir8hB72k1LGZMPLAPCmSPRtNDil8vZLs95lFYUauXJJwqVZ5exM
 JY7d7qL022BCj+WexebRT5aQxBesB8c8rcc
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Mon, 1 Jul 2019, Emily Shaffer wrote:

> Since v2, mostly reworded comments, plus fixed the issues mentioned in
> the tutorial itself. Thanks Eric for the review.
>
> Emily Shaffer (13):
>   walken: add infrastructure for revwalk demo
>   walken: add usage to enable -h
>   walken: add placeholder to initialize defaults
>   walken: add handler to git_config
>   walken: configure rev_info and prepare for walk
>   walken: perform our basic revision walk
>   walken: filter for authors from gmail address
>   walken: demonstrate various topographical sorts
>   walken: demonstrate reversing a revision walk list
>   walken: add unfiltered object walk from HEAD
>   walken: add filtered object walk
>   walken: count omitted objects
>   walken: reverse the object walk order
>
>  Makefile         |   1 +
>  builtin.h        |   1 +
>  builtin/walken.c | 297 +++++++++++++++++++++++++++++++++++++++++++++++

Since this is not really intended to be an end user-facing command, I
think it should not become a built-in, to be carried into every Git
user's setup.

Instead, I would recommend to implement this as a test helper.

This would have the following advantages:

- it won't clutter the end user installations,

- it will still be compile-tested with every build (guaranteeing that
  the tutorial won't become stale over time as so many other tutorials),

- it really opens the door very wide to follow up with another tutorial
  to guide new contributors to write stellar regression tests.

Thanks,
Dscho

>  git.c            |   1 +
>  4 files changed, 300 insertions(+)
>  create mode 100644 builtin/walken.c
>
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
>
>
