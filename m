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
	by dcvr.yhbt.net (Postfix) with ESMTP id BC4AF1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 15:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfKLPI6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 10:08:58 -0500
Received: from mout.web.de ([212.227.17.11]:45309 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfKLPI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 10:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573571337;
        bh=FdFCLdeRldw5yd1yxzRw2aJSpzGqEAsJcOZ7TwE+NJw=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=rq6neZVJy6WoZovUOe4XDuv7W38xvVRsbyWe2xm+OLIA4HhHInjyMrIwCZo/CiTE0
         fNd3burTfzQitVMvKBWguXQp9hAZOXXSGHM0IoDXB0kJCKiefKWHWaGlo5PQgWq652
         pJpTKP61lwutZu1UyCOOq3uWL++AuwCfVEHUxdEc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.102.255]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MJTdf-1iS3c33oHz-0034AC; Tue, 12
 Nov 2019 16:08:57 +0100
To:     git@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: coccinelle: adjustments for array.cocci?
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
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
Date:   Tue, 12 Nov 2019 16:08:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:EfcA8RTOhYxVXzv2BdVhGr6U8oEgbjgsrikylctuttpcg21prqm
 cQ1VMpl8c7RUZDfXxrHsfLJ3L5K9cSK2G6zTNXdO4FQxpL1ramNfhwXSzdpp17Y4GStWBpl
 ZwVdCpsrZMDOvJC1t074dM0/1FqURl1cZ3Emen7udaq3W7HmeYO9h+YCLVaotlzPYkYzE7J
 /McLRId2vLyRjmiQ/qPpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+BGwngSLTBc=:hxzlv9b1+4tmg03a3uCQRU
 0KExMhHtVlPDt5M8USkBJkrxPqXxeHmxqWb52RUNmlQRNNzEZbCkDnmHuCr5PBB86p/a6lwVL
 JaF8kHradLx9H9yg23jgmREJORG27I/m+xXA3mLKqNHmsBPhx6xj6hMvF/e0B/ezTLrf1Ml6s
 ND0te5uGYMIqm3vVZozuGu0SQeABCvhhdPa1U8W4BL//U4EGCeMZCewZ8NEffdt515zu2zTv3
 m+24mOt0sg+1t9qUEjGtM3qnT6hnnTV3duwwucMlsMuOSmusajstnIEHphDvAIp0sSgQk5Egf
 6zK2UBwHxYnsRg5aV1WzGFmMM9eWmnln+fNT1jvoDGREHPoF2yEm44HLMV4iyX5McuWp7esHS
 GDt7ku78dCU8oS3mJEM/XhY5drZenVMRljG/hvpLBn9Lv7G7yXABdU240IR+mrW0J14SQo05E
 IFtrCBusmb6fkHq5o2SuJdKT4V3FxysXV5XQ4lbcCNKvHLhXFGe/cSgyl31nv3+l2ynSU3l9n
 tZxugrsFwtg0w8Tkfg4Fka+G1rfcQdDZKM0qgKhtJeBoXNETCu3C8QkUoSggEhmBiZ1ODTO85
 uraDWJCLyAW4gxNCoHmLoqY117yYv969QvqMzeN4S6+fBdXiXHzL1Ws1ZvxDYlnFR6Hato7bI
 UtlCHgBYSS3MpooxHMTxvFQtZ5SRhgWzkQIM5bfkl29LKbECXdE+yct1qvIPAm38vlcbfX9iI
 JbXTLPy0B33wKhidD8SX7p4vMY+sZnEcabPKlPgoUXiGFETp3oYnUWVH2361MDcenuriAKriJ
 wokWmigdv58tyVgH04OmHmZCfOYWn8XfO3F8hfwpY4fFoaJfoAHPKv62C3oTmuD3wJbwXTU6k
 lU2PJ/W/a1ZqD1fCKfsgcxvnEGZ04/tJA5vjAqygbO5dVrLA+WS0p6ZP2qSYZLRfQC3O41LgP
 uPpQnQ25ptDDn8RHqXc3+Tct7BPsib6cfz05nF3hzOjQ9BOASu9JYkvxIZAz1D7QPie8DS7Mw
 qkJPPap4uN5cY15ZYWLj8kRy9FHrwd+Z5S4v+w379RFtQXYm2DjUYvpgMT0tDUQK4nOM+pmV2
 /CB4GKCKXZB5jSWMOYWA+FzJGbIbPzrJ+PEqjUkR7FpH9eAIz6HbbpS+iiRTlXVyYqvaKW8XA
 j01uErcpXt3BsOQhIu1EyfEko5BKnqDS7zOv+EM0cSEc0UvkD3w4TWFbonnAJqRJT8q1cj4iJ
 +QEnU1LVeWHgiQEEOfLQ3nzxUQL7G2CmfSIy9qXUSw8/EB9czpl37LTAOKz4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I would like to comment implementation details from
the commit 177fbab747da4f58cb2a8ce010b3515c86dd67c9 ("coccinelle: use COPY_ARRAY for copying arrays").


Do you find the following code variant (for the semantic patch language) also useful?

 memcpy(
(       ptr, E, n *
-       sizeof(*(ptr))
+       sizeof(T)
|       arr, E, n *
-       sizeof(*(arr))
+       sizeof(T)
|       E, ptr, n *
-       sizeof(*(ptr))
+       sizeof(T)
|       E, arr, n *
-       sizeof(*(arr))
+       sizeof(T)
)
       )


How do you think about the following SmPL code variant?

-memcpy
+COPY_ARRAY
       (
(       dst_ptr
|       dst_arr
)
       ,
(       src_ptr
|       src_arr
)
       ,
-       (n) * sizeof(T)
+       n
       )


Regards,
Markus
