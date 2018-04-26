Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 740051F404
	for <e@80x24.org>; Thu, 26 Apr 2018 06:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeDZGac (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 02:30:32 -0400
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:56042 "EHLO
        rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbeDZGab (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 02:30:31 -0400
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 4D0515AEAE
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 08:30:30 +0200 (CEST)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id 317CD5851A
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 08:30:30 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Thu, 26 Apr 2018 08:30:30 +0200
Message-Id: <5AE17203020000A10002B5EF@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.0.1 
Date:   Thu, 26 Apr 2018 08:30:27 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     "Alban Gruin" <alban.gruin@gmail.com>, <git@vger.kernel.org>
Subject: Antw: Re: java diffs show no method context
References: <5AE07A3A020000A10002B5C5@gwsmtp1.uni-regensburg.de>
 <aae8d748-101d-1eb2-f8e8-9da2e53e2388@gmail.com>
In-Reply-To: <aae8d748-101d-1eb2-f8e8-9da2e53e2388@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Thanks for that. It sounds plausible, but I wonder why it works automagically
for C, but not for Java (Politcal reasons put aside): Using ".c" for C is about
as common as using ".java" for Java ;-)

Regards,
Ulrich

>>> Alban Gruin <alban.gruin@gmail.com> schrieb am 25.04.2018 um 17:05 in
Nachricht
<aae8d748-101d-1eb2-f8e8-9da2e53e2388@gmail.com>:
> Le 25/04/2018 à 14:53, Ulrich Windl a écrit :
>> Hi!
>> 
>> This is for git 2.13.6, and it may be an FAQ or frequent feature request. 
> Anyway:
>> I'm new to Java, and writing my first project using Git, I found that "git

> diff" only reports the class in the diff context, but not the method (as
seen 
> for C, for example).
>> I'd wish to have the method where the diff is located.
> 
> Hi,
> 
> to achieve this behaviour, you have to create a file named
> ".gitattributes" at the root of your project, containing this line:
> 
> *.java diff=java
> 
> .gitattributes allows you to configure other things, as described in the
> documentation[1].
> 
> I hope it helps.
> 
> [1] https://www.git-scm.com/docs/gitattributes 
> 
> Cheers,
> Alban



