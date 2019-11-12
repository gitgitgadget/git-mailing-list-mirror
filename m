Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64A0B1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 15:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfKLPJA (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 10:09:00 -0500
Received: from mout.web.de ([212.227.17.12]:59447 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbfKLPJA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 10:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573571337;
        bh=FdFCLdeRldw5yd1yxzRw2aJSpzGqEAsJcOZ7TwE+NJw=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=rq6neZVJy6WoZovUOe4XDuv7W38xvVRsbyWe2xm+OLIA4HhHInjyMrIwCZo/CiTE0
         fNd3burTfzQitVMvKBWguXQp9hAZOXXSGHM0IoDXB0kJCKiefKWHWaGlo5PQgWq652
         pJpTKP61lwutZu1UyCOOq3uWL++AuwCfVEHUxdEc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.102.255]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MYf78-1iPZjm3nus-00VRtp; Tue, 12
 Nov 2019 16:08:57 +0100
To:     git@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: coccinelle: adjustments for array.cocci?
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c978fed2-6a89-b6da-7664-9bf8c8cd5b84@web.de>
Date:   Tue, 12 Nov 2019 16:08:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:gbwURCqBJwObzJXD6lcQ7DTjsOXnuYkMbWSWX3TTWxUrqEkUP4W
 WPeMig7H0O4TwjF9ipR05WX5swdsVjIjBtH+oOpnmAIBYHjELJfCSoG86l1rj70O7QSbFr0
 4LHL3ZlIUVjB9uQestUUEuxSA8Mj8vgCcVfYAuZ5y3sY0IDd89f4H1KRAIqrpsqCXHRl4N8
 vfPYov6oQ2FC8txzn1D7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vplMjf9C5nk=:YpHUfKD7WjnbfO2EgfgIm6
 pv3pbtBTU6b5PQFN/QRMO7ZoNAwt3AOn7iiXBJ4mQJbW61yvKhzLtku8IHyYlTuRLf7DNB9P3
 qFPgxTEnJrys/uVaBGi9dkhTxN3yvrtzTDDECWeB7cJ6MiSrUevvtGOv/tWyYak9cfuCBMaDc
 waftsTgylXAXFOiaYG8Y+5tBBmBY0rsiJEFykjeatJnl027WtW/NVj9MaFU7PsdUxmQtznmBg
 cD53TeVj3lvZ9+d3Zl8fgzEly7gZPrt7lecKWcQaFOC3doE6/r3a7yDkO1kAFq88DX9feAaZw
 svrgpbVo94aDZNf/K1u7tU+KKA+4G05nncrmYZckdaw2bSw9mjSPEBH60QoqJo/v/2kfEfXBP
 HgBZR4tZF4TZAWDNeTAxLEa8PUTKJKGTKE3XN86WeET+3lyYbsQciUEelD/LPBPbv8d9Ssyt3
 zD+BdeGYOcxo1lQI6UrZqslrUtNJXezNbR9J1k8Z2Li0a7jYEBi+nIF6CHweeHOWZEV9vYMo8
 86WCIWJrurXD+nkpZTrnq03drf2rsAvXbXZsd4hFFltIIxntrfl/2XMED2LkilX9Ii8ZXW4vk
 sbbWfZC+zGenlBNQMtlSllE2umY7vpNlq1f4f85zwRbh6q2jX5ig2Nf6wruGd1NOcDPLi7XEg
 LI9GLQISqehUFl9BAgv/QsqDu6n6BPutAAENxD46eQbsZrCktBk98ZQRAjWbJUH4mzTT4BdCK
 G5NH8s4ieVxJba/3rK8+3k/mwNPPc42j17uEhyw3YfUHUbrUDfDOrsB25iJ4WWmdK1H9KaaDC
 hnBc0ZwmMIDrBiDHRHAfcjvO5Uwy5P5hE1+87ZC33WvR/n/fe1Wq3TdhuQx4NqGVKUM+ceJOw
 CTohtwW+g/yj85PLRCRK05pnEovUr+r0Ei31ODV5OXw9fp3v1fK67uOORB7Z6sDSgLACg+C0a
 J4GI1u9ztTuvl6ljBUVlygtkaxwzAzHGZr6IJ27EUmF2cF9AA/JakyxXqxoG1Hkvi4+007RqE
 CruGb7+RV6g1R9wop4l3MnsNcQOPilCz8Z0bSsr+/zmXlvWIG8pP/3+0xrj1ysKoOJb1PErPv
 6P5UVkzgtpJmdniLPLyfgQ/iJfXvSsRTBgEf0/272Gi583Op7lWx74jFnFPubU3p8oayQ4EPv
 0U9TpaSwMoIBCeRZ2GZfR4X0NrHonJy/PDnAc8IkxWKVbRlgtprDxhaSWpnVBoNAOpDVpueJf
 e79I3NA99vDjM7YsK0ZlpRWwFsC8MTISCLlaUfpRyQmXC3da5/nDgRJamPH0=
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
