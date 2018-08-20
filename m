Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE2991F97E
	for <e@80x24.org>; Mon, 20 Aug 2018 08:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbeHTLlx convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 20 Aug 2018 07:41:53 -0400
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:40944 "EHLO
        rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeHTLlx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 07:41:53 -0400
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 954DC63E22
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 10:27:09 +0200 (CEST)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id 1188E66F73
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 10:27:09 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Mon, 20 Aug 2018 10:27:08 +0200
Message-Id: <5B7A7B5B020000A10002CDC5@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.0.1 
Date:   Mon, 20 Aug 2018 10:27:07 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     "Duy Nguyen" <pclouds@gmail.com>
Cc:     <git@vger.kernel.org>
Subject: Antw: Re: non-smooth progress indication for git fsck and git
 gc
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
 <CACsJy8Dukjw_PKQXMTxwd_C3juA_0cqZSjb=1L2wKqtJoC3rkQ@mail.gmail.com>
In-Reply-To: <CACsJy8Dukjw_PKQXMTxwd_C3juA_0cqZSjb=1L2wKqtJoC3rkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Duy Nguyen <pclouds@gmail.com> schrieb am 16.08.2018 um 17:18 in Nachricht
<CACsJy8Dukjw_PKQXMTxwd_C3juA_0cqZSjb=1L2wKqtJoC3rkQ@mail.gmail.com>:
> On Thu, Aug 16, 2018 at 1:10 PM Ulrich Windl
> <Ulrich.Windl@rz.uni-regensburg.de> wrote:
>>
>> Hi!
>>
>> I'd like to point out some minor issue observed while processing some 
> 50000-object repository with many binary objects, but most are rather small:
>>
>> Between the two phases of "git fsck" (checking directories and checking 
> objects) there was a break of several seconds where no progress was 
> indicated.
>>
>> During "git gc" the writing objects phase did not update for some seconds, 
> but then the percentage counter jumped like from 15% to 42%.
>>
>> I understand that updating the progress output too often can be a 
> performance bottleneck, while upating it too rarely might only bore the 
> user... ;-)
>>
>> But maybe something can be done. My git version is 2.13.7 (openSUSE 42.3).
> 
> Is it possible to make this repository public? You can also use "git
> fast-export --anonymize" to make a repo with same structure but no
> real content (but read the man page about that option first)

Hi!

Actually I tried that locally, but with the resulting repository both, fsck and gc are very fast. So I guess it won't be very useful. Also the original .git directory uses 5.3G, while the anonymous .git just used 4.3M...

I tried to capture the behavior as screencast, but it seems the screencast optimized the little cahnges away, and in the result git almost had no delay on any operation 8-(

Regards,
Ulrich

> 
>> Regards,
>> Ulrich
>>
>>
> 
> 
> -- 
> Duy



