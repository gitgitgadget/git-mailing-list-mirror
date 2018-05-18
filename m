Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AF081F51C
	for <e@80x24.org>; Fri, 18 May 2018 15:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbeERPhr (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 11:37:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:60213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750763AbeERPhq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 11:37:46 -0400
Received: from [134.106.48.76] ([134.106.48.76]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M5csW-1eM5aK3hDU-00xejz; Fri, 18
 May 2018 17:37:44 +0200
Subject: Re: error(?) in "man git-stash" regarding "--keep-index"
References: <alpine.LFD.2.21.1805180534170.6786@localhost.localdomain>
 <CAN0heSrJMFij9xt6RstLD16+2CxJ_HALer4iRL74AZQvH0VWRQ@mail.gmail.com>
 <alpine.LFD.2.21.1805180648020.10270@localhost.localdomain>
 <CAN0heSpVKd=-Dpdk09LVtTd0vC2dLUwg0=hbxhKskM3RencsYA@mail.gmail.com>
From:   Sybille Peters <sypets@gmx.de>
To:     Git Mailing list <git@vger.kernel.org>
Message-ID: <96486abe-cf13-ef10-7513-2d6c20a9dc1e@gmx.de>
Date:   Fri, 18 May 2018 17:37:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSpVKd=-Dpdk09LVtTd0vC2dLUwg0=hbxhKskM3RencsYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Provags-ID: V03:K1:JXB/YA5rPK4v81aEazHL4KEdH4KkTJa/f5OKFCAD5vIjx2hm9hF
 JUTdKOS7LGqu/FHHuGQdO7G9QuLR+CCsaze53SsFD41QpI25Z8kGR8OZujx+xeb63rYUbb8
 sbGa8JdKlMcztnE+CoeoVo7PMqtUmzAEzyD3nqqfxAOwGAQR6Nezdw4FX44RgsdObvF/CMp
 HNGob6nX6AbUsRpvdTEaA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2cVIC7TTXxA=:od+kNy/jDVqcanfgXthc0i
 6Ys9XarhIHrxdArqhmp5k0DBWTBnsMoMaHoY1mNXVACX1QuWOumLwXbhWbNUvf0aKjqqudoAS
 XHnxAjuU44gZcjgudynkAr/BPbtlEktkK4RI7Pt59jc3qXbI/A6F/P9ky6Zqhi1a4MpkHS/2r
 vxhcdHBn36YKuiOHhCzz4yY8fHuB357fZiCff4NceD8oBikGdT5vYt/9Lkq8yoCIffP1T5RtJ
 TnKXUwcHj5Zxi1YkzYTDAQYDu8FaZRyo7eKJ2Y6s168HZvZICePUA2h8QSzo/2WwyP1mA/WqW
 2TdOVBZlR6gCOt0p8s+CzAgX+yZiG2E9GJS3IyDpwIWMSCE4jThxt20m0gzX4K9S0fzzEsjM9
 7fYSaPyZIBW0WkyrKinG74W8CBBZbieOWLiGGIpb9WUxfG96NygZbho6nCVXrtvmRVa140BD3
 dS+Or5z+a6Px+gD25dFWpkacaAdv4jJGHk3NV7D8l2+wInmAPvKMyuM6SQePjcPw+Y/OPdVfD
 MbI4naBEwz8ZL3zENp2Pu64embRRo8nDzAf1WVmIyFJ9TBw9PCHngY7lYDCYdWVMeP79BJaXQ
 oHDcF5qceorcg3vxiiWdpXnqtK2ue3tVQoI6iU1r6Sz5ZgsXwoW8ZCI3manG6sbyikyK3iAj/
 dJcAyGc3xmCnHnFFyGDACkgOFr2La21geft7tSOKR8TNLjedVT6+12KWy7CaQiod4jyQq5Ru+
 Q7sGyvZ+uMMMEsicKmF+mFqZ77jqtn2ZlMfLif+2KAPEy+wjddWVISQfXVYovEBCjJ3hBucJ5
 lh81A7y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My 2c on this:

1) "If the --keep-index option is used, all changes already added to the 
index are left intact" (manpage git stash)

That appears to be correct and clear


2) "$ git stash push --keep-index    # save *all other* changes to the 
stash" (manpage git stash)

That is either not correct or misleading. "All other" implies in my 
opinion all changes

except the ones that were already added. *"All changes including already 
staged changes"*

might be a better choice.


Please also see open question on StackOverflow:

https://stackoverflow.com/questions/50242489/how-to-ignore-added-hunks-in-git-stash-p/


