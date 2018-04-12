Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 429BC1F404
	for <e@80x24.org>; Thu, 12 Apr 2018 21:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752354AbeDLVW6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 17:22:58 -0400
Received: from mail-out01.uio.no ([129.240.10.50]:53105 "EHLO
        mail-out01.uio.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeDLVW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 17:22:57 -0400
Received: from mail-mx04.uio.no ([129.240.10.25])
        by mail-out01.uio.no with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <h.b.furuseth@usit.uio.no>)
        id 1f6jgG-0000Rf-GQ; Thu, 12 Apr 2018 23:22:56 +0200
Received: from bombur.uio.no ([129.240.203.105])
        by mail-mx04.uio.no with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        user hbf (Exim 4.90_1)
        (envelope-from <h.b.furuseth@usit.uio.no>)
        id 1f6jgG-0005Dg-05; Thu, 12 Apr 2018 23:22:56 +0200
Subject: Re: File versioning based on shallow Git repositories?
To:     Rafael Ascensao <rafa.almas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <hbf.20180412fvfi@bombur.uio.no>
 <87d0z4b6ti.fsf@evledraar.gmail.com>
 <4af21bcd-7a68-50df-4cce-0b050ccaeb90@usit.uio.no>
 <87k1tcf905.fsf@evledraar.gmail.com>
 <CACUQV592km3SaHiY9uZon4E3jhakmYmzwcejmsnExzaybNm3xw@mail.gmail.com>
From:   Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Message-ID: <2e700b4e-d52c-afc5-dacd-51405fb51c21@usit.uio.no>
Date:   Thu, 12 Apr 2018 23:22:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACUQV592km3SaHiY9uZon4E3jhakmYmzwcejmsnExzaybNm3xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
X-UiO-SPF-Received: Received-SPF: neutral (mail-mx04.uio.no: 129.240.203.105 is neither permitted nor denied by domain of usit.uio.no) client-ip=129.240.203.105; envelope-from=h.b.furuseth@usit.uio.no; helo=bombur.uio.no;
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.7, required=5.0, autolearn=disabled, AWL=0.289,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: F7B7D34D8D1B2ABBC9D79C7E1565352CBF7A16F3
X-UiOonly: E1185BC6F4AE6CC6DE13B0489F6265DE6D7B2F7F
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12. april 2018 23:07, Rafael Ascensao wrote:
> Would initiating a repo with a empty root commit, tag it with 'base' then
> use $ git rebase --onto base master@{30 days ago} master;
> be viable?

No... my question was confused from the beginning.  With such large files
I _shouldn't_ have history (or grafts), otherwise Git spends a lot of CPU
time creating diffs when I look at a commit, or worse, when I try git log.
Which I discovered quickly when trying real data instead of test-data:-)

Ævar's suggestion was exactly right in that respect.  Thanks again!

-- 
Hallvard
