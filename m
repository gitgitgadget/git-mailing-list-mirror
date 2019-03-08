Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 912CE20248
	for <e@80x24.org>; Fri,  8 Mar 2019 08:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfCHIfA (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 03:35:00 -0500
Received: from posti7.jyu.fi ([130.234.4.44]:44180 "EHLO posti7.jyu.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfCHIfA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 03:35:00 -0500
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Mar 2019 03:34:59 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
        by posti7.jyu.fi (8.13.8/8.13.8) with ESMTP id x288ScAx006803;
        Fri, 8 Mar 2019 10:28:38 +0200
X-Virus-Scanned: amavisd-new at cc.jyu.fi
Received: from posti7.jyu.fi ([127.0.0.1])
        by localhost (posti7.jyu.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rjf1OdZmALQl; Fri,  8 Mar 2019 10:27:12 +0200 (EET)
Received: from [130.234.82.94] (semyol-329-b.ktl.jyu.fi [130.234.82.94])
        (authenticated bits=0)
        by posti7.jyu.fi (8.13.8/8.13.8) with ESMTP id x288RB3O006775
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
        Fri, 8 Mar 2019 10:27:12 +0200
To:     git@vger.kernel.org
From:   Mikko Rantalainen <mikko.rantalainen@peda.net>
Subject: Improve support for 'git config gc.reflogExpire never'
Openpgp: preference=signencrypt
Autocrypt: addr=mikko.rantalainen@peda.net; prefer-encrypt=mutual; keydata=
 mQGiBDz/sJkRBACmcWhi/1Z0Jbv/TryVmaYGcP8Qo73yVXFuqwSrf7/uISAqc3VN38UdZfiK
 9rgCZcFHKD/NIZJvkpOg97MNLg3jFidmxT3gxcvI9CfnGc0XKztXAya3QojkAKoLzVJiJa7b
 EyFNtk4QeaIMZrypdjjl+ycaTb9z5BjdUMRkKn5RPwCgpffJNOlVvTs5QeM4SUMJQnzPMH8D
 /ifcfjcZGcmGP/3ARiH6JbeMvr+UiDex4aMnfkWeiqO5ikBVDeR2FwT6DggNtBFHR4o3BC8N
 it9NPQnK0OtFjSEJR/DprcwJxxbTgay6R9sh0pZ0krEcVntr02JHixK3ndMoNVr+FMxdVt/8
 gdTTEMMv/PZG69zxszQ0cTQvh57DA/9463/OINLNYiIAv/rrh9kWUsp733z0zyrdlHSvU7c9
 FfgxJuv59QPd7t2P/ZFZ7lpsQNr55Y5uf1yyRTk+1rLXMgXUXytKk92GNmhXayKqhRntYuvT
 L5WM0JFcewHsmizQ2BrsMNASalJPiteog3+KdmjowOLgkDotTu03GihyULQuTWlra28gUmFu
 dGFsYWluZW4gPG1pa2tvLnJhbnRhbGFpbmVuQHBlZGEubmV0PohhBBMRAgAhAhsDAh4BAheA
 BQsJCAcDBRUKCQgLBRYCAwEABQJLVWmyAAoJEBTc0QdWMWjrSocAn1ZlO0aLjelabaFS3ge1
 g0ewG0dGAJ0Vv1mVfwa0WXxZlUDxag8XCw54rbkEDQRLVVheEBAA2268nffio6wsdyS3BFKr
 KlAOhXQbmaHuYelUIjMf+qUHFPcNgJscXJV8JTx/7sMb5FNOFrGSZyzPQ9p6wafBtYAcSRdw
 RxgZiIuUrC/oxzz7+S26Ipln4RuOcCrdZFjlVCAMnEMpfUPK3xtWG8NxHEtCuBSb9089xV3V
 w5ln709F3lxZoTS2AeFX4HQofnERTHlTzW60KbxqcSN5nEd9SHMv7fmiko86iyELU0VaA8+T
 +8ViqmBubbD78S+Wk8EhMCwysDwPwQGPrkf55k3gAiR6A2dXosfwOOWgyPerM0A9z/4Bx5MB
 H5CHuw7N/EL7Rn5yWNhebl/5LB/jRocp8UnRgwZ3caP2T//lXfP60swSLMhr7W7G0c74RxI0
 Vr2xti9g+8udwY30ZaucbDB6iFUSDbY+Zp8otSBgNUwAXR16bBQTfwZTQqIweCkhG7csLl2J
 xoIqpNu4m+6hbUzdFVHFig8Qs+Sx84pQ5+aHsZSNbp6SuS4kMkcBANttWkrRyCk763LcxW1B
 Y4j2mZ9/Yah2B0AXg1mqLSRU/F1VbWZg1WkFVc9ic6clwO887Tq+WyUMGGSrFr2cTjCf4DZB
 3bOs5pS5/yn8t6PBKndWlu6WRJRHWanab3hdM14t4hwqtHP9PwT3gQ2nZQ/MxP5yX1eOKVlu
 o+wfw6fnzWLpj6sAAwYQAMbuOaQApdRC6XKHij/x6h5kfFmtO1utaagzQW8lCjF1kvE++o6Q
 ElmU28rBVo47LvvuUELaBA6AhHm/HT/zLrms/qqvAeW/Ca2VYnk9uDphxDck+R+pkmv2wZO5
 QxkcNxCYkjh0uRtAdrwbHlNCiTaksYzVicW4pMj3wC4yD+JkKkoXoAd94YrfWMqqPqf3SjDU
 Z+FYV8c+HMaCYQiGM5y76o+R4oavxZT8iZijvug8hJlKmZib0mXpDi5rElGmtpuw2QQaCltE
 Xfw35ge6HGZ1cH6rJXon26vcBp03Hkyk4A4vkp3n8Nrf3EHuP86x3UpREb39PBxJlNBLaGRJ
 ULCcwFryh4u6JpFmk4z//DVaHV6E4Wy1gUKGKIquxgtJAHaStlFZJEITlkdqNEHf6/TkczFG
 pq+qzQ6u+3wZCdXpRfV8cZeayzlvqrVT3fCbymEXRNKUMyWFA8jH0sCjPUV1LVrumxkiRoHK
 qCsSMh82nYMvopnPQ9RyZJfcHrr72OAOqx1eK4QzM+0PyPlZjaBGDWld2lR9xxGopPxvF8ZE
 XRA7aGc3FqSTc4nHOfBEclhf5aTAhuglG2qoFxTuyXM6cQTdtaodripxpUdDBK4VeXNyfnza
 AEbmqhrSJWwxa72WVry7dGCIA/1+K52J4On2iIcQ4rOCbjGOTsQ/S20UiE8EGBECAA8FAktV
 WF4CGwwFCSWYBgAACgkQFNzRB1YxaOtiKgCfV/EUgN7aCDPBC1nYaSzCgsIMxVUAnirPpulR
 yXyHJtNSZX0bZigw0s1C
Message-ID: <39a0796a-7220-1e81-e7fe-3bf7329ed7de@peda.net>
Date:   Fri, 8 Mar 2019 10:27:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I configure bare repo with

git config gc.pruneExpire never
git config gc.reflogExpire never

then git will never garbage collect any commit ever stored in the repo.
This is what I want.

However, all commits referenced only via reflog are kept as loose
objects and will not be included in packs. In long run this will cause

warning: There are too many unreachable loose objects; run 'git prune'
to remove them.

and the performance of the repository will slowly decrease.


If I have understood correctly, git should notice that reflog will keep
referenced commits forever and include all those commits in packs
instead of keeping those as loose forever.

A more generic behavior might be to always compress all loose commits in
(one?) special pack so the performance would stay good even if
gc.reflogExpire is very long instead of "never".


Discussion about this case:
https://stackoverflow.com/questions/28092485/how-to-prevent-garbage-collection-in-git
https://stackoverflow.com/questions/55043693/is-it-possible-to-get-git-gc-to-pack-reflog-objects

-- 
Mikko
