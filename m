Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30AE1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 17:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLRui (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 12:50:38 -0500
Received: from mout.web.de ([217.72.192.78]:60515 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbfKLRui (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 12:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573581027;
        bh=tcKuyWEKgAjKnZRhvioMKXoo4o4mnknGyucIDj+o+LE=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=f7Sc5oSrHw119wo9kSOL8+lwUjStmsCr3/CZJGQ79zd8i2eXsP4Ap7evhr0OCwt+o
         6mXUACg6Jh73kXO2ZWeGJPl+DIzx/Juc4QvSLRSPb45d4NRLluWllCoMhAuT26ejHk
         ZhboM1/YpRSS8FwW2YQBsjxXhWVjLhwiXvbIVdQQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.102.255]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVLj0-1iOQge3q7K-00YjOA; Tue, 12
 Nov 2019 18:50:27 +0100
To:     git@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: coccinelle: fine-tuning for commit.cocci?
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= <pclouds@gmail.co>
Message-ID: <5ff15b03-aa04-f8f7-2989-cc5463e71d27@web.de>
Date:   Tue, 12 Nov 2019 18:50:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:FgVowUPJcn6sEZtLbM9q+VnKdNjz0eUTKUofnQbrxLtLzRo0QN2
 ixNGpW3jbYvnRpRgN93Fyy2ZIoFMwmdT0Pnr46z2rIv+fvlxGx22LhkwyIEoEAfIO2YuOpf
 AnB440S6hecfOsGW/THoIvxPyY0ucLV9qFZnL9KVibKNccTlt5+ynXbGU0jgV/NdP4I672x
 1bi/+u1D5HPg/lZ7ay4vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XkhH0WQA50Q=:QsyGDArxGdK1P/IbCcW7zY
 7d0LGnVEko1+Wr6ugVtKiyKI+VvoHtH/hNJQ1xCJAfU0QRgYDF9kj4JsAT8QCf1xbKsNFvac8
 VHCMeYsypWBCp3HXhagLSLUIYXLnYsgligUNOH4PRwhlmQB++2oDjyNJk7khsBPbecpsYoOe9
 A9vCRPGoAbxmReVrT5wNsJ705ufLChIqDV4VKX2kFGI/jIl5onb2u5KSMAkdPkfkWBsIXtRWC
 IPRvCH5PlQjvXCyPVQmmWCehxO9qezBd9yIt9ebt5kACDsxG/OykLgf/IcjIWpKbbsiRNXEL1
 IT4bBsUwjW/5hZ4rWAatnBX91OjiJecBeB/7UV1ohyOGwU7FF7XH8e4guWNAg+41mY8SMVgCN
 NCySsq+VbmD3B3C8BoKGrbOGBNPJ6HH4Biec1ILlQsp0ULwVNOgrK2QwKvaomsx0yx5whQGlB
 W3pNW8oyGuFoxMo5eTGHfkX1fFhowuStYl6uq3dd8Xd+P6MIcVZ3oyveT49qk+7WLMGfW1G1o
 9d7EA72x/jXvy2SAORTQMlKn0KJcCRNsithw1zuZt+B8gvzjmU4M2Lmkdeh0YOfcPdqS3qd0n
 J+bmd5GLFucRACbhmAVZnzI8K3TQ2RZ8a55+BpYMVRCtrOWCNMKC5L9P/q0V0q9vOSvNTjm2s
 pb/mDwYb6veyywhp5La4BtrpXfKED4Y9uc2kqkL2P+ZWjIWcCEMKVfqLqcYdwpSfG/xQJL805
 MxbhXE9lvG94vSENcfPLRyw4o4Xkh7ZQQO53os4B7ebmYxb0y0a0Z8c4XaI8uNVbNW6yNMMXR
 VkNTmiABJYzU6tvv7Fl0orEmciWp/+Pf/fd5DkAc09GP+bC2CKl619mgFnrJjC/bjS3PYIoXn
 ZmX+Ia7Mva9u0lPT741rhJWm+pCmxJEzHHjk+yZPmpJbwSP/LEdKAbMOBRH3f8HVJKB6xef83
 G6pEYLUP3qpE2fcba3ghGioatu9RKG3kFPOk9LT0qXebwfDNTuVMQoV0DLA8gKNi7/h5Q+jPT
 jI8eQ7QKJewdXy1jiaPtP0dEahIkameqL2MO3wWgj06CmMeCyWTIm3K2JQeAgzvOiPj0r6clU
 SvMMihzsKFjgt43nd7jLreD5DmjmohZ6Mf0I9t1i/nzJE4nSxrifWT4y2CB17Gz6otv5huljO
 TNfjY90/cO2+RMatomaaFMWfWBzqZylWtIZ/xQyQ2xn/qpOpBH3nOsBit9pdmnDWPF22NIlhn
 t8JkBu7IV6bGheofoWIdbofyGfGPFKLmz5dmN2NQdJMmmSfdhEDP0uXm/O0M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I would like to comment implementation details from
the commit 301b8c7f405d3cd4f32b14bd336ac8c0400d9382 ("commit.c: add repo_get_commit_tree()").


1. Would you like to use a code variant (for the semantic patch language)
   which can work without a regular expression for the exclusion of a single item?

   identifier f != set_commit_tree;


2. How do you think about the following variants for the specification of SmPL constraints?

   * Advanced regular expression

     identifier f !~ "^(?:get_commit_tree_in_graph_one|load_tree_for_commit|(?:repo_g|s)et_commit_tree)$";

   * Item list filter

     identifier f != { get_commit_tree_in_graph_one, load_tree_for_commit, repo_get_commit_tree, set_commit_tree };


Regards,
Markus
