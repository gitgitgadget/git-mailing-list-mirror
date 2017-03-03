Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04C8720133
	for <e@80x24.org>; Fri,  3 Mar 2017 21:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751869AbdCCVRd (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 16:17:33 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:56872 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbdCCVRd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 16:17:33 -0500
Received: from [192.168.1.50] ([94.219.230.230]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0Ls7Kh-1cIVTW02rH-013uiO; Fri, 03 Mar 2017 22:10:21 +0100
Subject: Re: git status --> Out of memory, realloc failed
To:     Duy Nguyen <pclouds@gmail.com>
References: <84c02ca1-269e-2f26-c625-476d7f087f5c@cafu.de>
 <ea0722e2-c2bd-bd80-a233-50676efcafda@web.de>
 <cbd281fc-3a4b-b4dc-5dff-145c97cd68d6@cafu.de>
 <CACsJy8B3Qy1mra_GwhbYdk5LFrgYx=6NRqq=wvw2_wcWCO_yNw@mail.gmail.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
From:   Carsten Fuchs <carsten.fuchs@cafu.de>
Message-ID: <6cdb5c44-76ad-b38a-c9f2-46f8916cbe5a@cafu.de>
Date:   Fri, 3 Mar 2017 22:10:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8B3Qy1mra_GwhbYdk5LFrgYx=6NRqq=wvw2_wcWCO_yNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:d9Tcbci/Pa3dZ4mb//QmaN1gwIy8uE3IzStskZMPTgHinaxhCTF
 ygmZjD/Tbu/WbLlISclVL4N/HyWF0Pw/Zqx+m2Qk8CZFZ7YN78d2Bp7uVY2k6BrRIdqaBbi
 F9OVAqAN5dDShHLCIo20ms/mPy/MyprGt0zkWYj17y40wC+BYzZwF6tNdP3ZRvbi7YCviCr
 RfdBAWrO4rLjgKw2wSUQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Wp+xdI/NjM8=:0y8LSt1Sj4rSbxPpVQk8xl
 PbdE2/ZWbog+JgnS/Q7b3hVzP2EisQV6pDmOP6jhf4C8QtOz7s1kCrzg/atOuGFq1sf+yeNuR
 oI9mtqcMIgG94JXRaOyIR/7NVCgGTJ6tH+DzAhN9lh8BGzKv73iUAIBt+cAWODtWCv5r+4ggz
 6tfJDDBgqn1z7TWrH0Asx0jYXCOdA6oF6zWTVdUc4bOBC5Iih0GRjLC5Lo6kzIswEH2ZFklg/
 SkC1bSPCj/Ja322FwkNYpq+nRg7pqJ3fZeY53yPtdZE1oziKf5jhDPKMulN/5rBjwp2dNSmPy
 Th3t1Up9ZeaHL6NhPzkavxeAXjATn1BDsszDSK4p/w5H8AlD8OIU754uSfw+KAMlCaqT1mCi7
 KCUgqpL1tsv7FJTR8OXyae7J9g06szkaviCKCnj92FpVZLFlXtN7IFsjKSst3bU6IR1adYPPJ
 JZMoi/NC7SZNkkq1nMLIKpDFARZbUx36yp3ZRMKu8ydZwsF52IdMJqUs8UfmYFKrcF3g6YQKv
 CJnJ+E50syeZGyi6pvXEIRTX3nPZGmZPHMByxV2ScTBg536a2n1NgT0M54KYspXdwbd2Nmiho
 VXcZFdcTikI8y0iw/npzjOC+pKYHzEREOMD99gcmn38Vpo+smkm+tkXM8NttS7sjxD08xvTfk
 ZKm984pqIuykojwUSED+h/eoNo6HNuhuve+4Ejjqu3sL/0vwPlmfhBCE5HbEehvct9t6b3ycv
 3EVD4+oztNb/oc3i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

Am 2017-03-02 um 10:31 schrieb Duy Nguyen:
> You could also try "git fast-export --anonymize" (read the doc first).

Eventually this was not needed, but thanks for letting me know about it! 
I've not been aware of this feature beforehand, learned something.

Best regards,
Carsten

