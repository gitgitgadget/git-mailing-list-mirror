Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08E2A2034E
	for <e@80x24.org>; Wed, 20 Jul 2016 16:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbcGTQC1 (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 12:02:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34065 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbcGTQC0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2016 12:02:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so7691976wma.1
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 09:02:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=68wu1cNGbVZ82c7NXgLPp1jFJoNGGt/dJiOvn5KdNgs=;
        b=EhXit9HYWFFsdbD+Dubh885RGf5IBUEgvqp3MDf74GTTghQMDlrr+cpBFIPbDziESy
         CSaU/+owoD/001opKkKqw2oVDxzCtUkM060eeWES+8Yz5OqyeCdZdioXdDtb524zF0IB
         RJFHjcedVHWG6E487/yVD3yUFpQf2AmBilZa5Pz2J4Ea3nDhuqP+Lcd1DrlVPGu8ORiL
         aejr3bLHXeyDKnYdb3JmINg+84pEoYC6RHqHwfXHEDkWyNN3BqjzQVkrBixhiaSJPCZk
         ISXAgQ+W9yfLZAYX/wwU4DiZauycthPMT3Mgtl8WgG9vhTdYlaPPqE2jqtXvRKRoqy29
         9wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=68wu1cNGbVZ82c7NXgLPp1jFJoNGGt/dJiOvn5KdNgs=;
        b=RuLdKY94+9UeI+HIlAgdSTL3wzA0JGfPYoCpGXNhlEvrwl8sBLvm7zRxe3aAt3iOSV
         VnkOf7mcuM3ejJ42mBvHSGWJIN4GX5Fz/94c8YEW0uvpifO2lFrIYDNEUtL4YrNwymOW
         8XIU8FnhQ/t9g3OgCDrQovmc9iLtOM71J6FNLYjg0yx8atNE+gyv5A6ffp/CkB2qPiE4
         bpxLA24I77szoTzrrZ4aMwxya55N16DYKqs8I29sA1BtReQEOIMuGkRv5X2NezwHj3ey
         Rs00HG2o0jgeuj7vlmxKk/EP/qBZQGBRWG4xCfJ6pU/3J1HTbsACBMYr67YUDayd/V7v
         uB+g==
X-Gm-Message-State: ALyK8tJ3hNEiyL/1NQM4S6TZe3sGLI2LSo0jyCBn/88s+9xJ9+a+OW+Thjo1xGv0TuG6jFeXnFlzMifaT4d2Ow==
X-Received: by 10.28.56.132 with SMTP id f126mr510914wma.13.1469030544212;
 Wed, 20 Jul 2016 09:02:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.102.70 with HTTP; Wed, 20 Jul 2016 09:01:44 -0700 (PDT)
In-Reply-To: <578F9D2A.2030204@jeffhostetler.com>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
 <1468966258-11191-7-git-send-email-jeffhost@microsoft.com>
 <578F9923.3000403@gmail.com> <578F9D2A.2030204@jeffhostetler.com>
From:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:	Wed, 20 Jul 2016 18:01:44 +0200
Message-ID: <CANQwDwfWW4Fn7KBHrNv2nfvGHMrPQ4jGpz6wGAEGg3edn-ztfg@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] Unit tests for V2 porcelain status
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 20 July 2016 at 17:47, Jeff Hostetler <git@jeffhostetler.com> wrote:
> On 07/20/2016 11:30 AM, Jakub Narębski wrote:
>> W dniu 2016-07-20 o 00:10, Jeff Hostetler pisze:
>>>
>>> +test_expect_success pre_initial_commit_0 '
>>> +       printf "## branch: (initial) master\n" >expected &&
>>> +       printf "?? actual\n" >>expected &&
>>> +       printf "?? dir1/\n" >>expected &&
>>> +       printf "?? expected\n" >>expected &&
>>> +       printf "?? file_x\n" >>expected &&
>>> +       printf "?? file_y\n" >>expected &&
>>> +       printf "?? file_z\n" >>expected &&
>>
>> Why not use heredoc syntax (cat <<\EOF), or prepare a file
>> with expected output in the testsuite?
>
> The tests involving renames needed to embed a tab character
> in the output and hiding a tab character in a heredoc seemed
> error prone.  So to be consistent I made them all printf-style.

Ah, so that's the case for series of printf. I think in some other
cases the Git testsuite simply uses HT variable for the TAB
character. I guess that "\t" for TAB is available in POSIX and
all shells that Git is run on?

See t3300-funny-names.sh, t3902-quoted.sh, t4213-log-tabexpand.sh

> Also, some of the tests include SHAs for the commit and for
> file content, so having pre-computed expected output is awkward.
> Granted we could hard code the file SHAs, but not the commits.

Right... but heredoc can include variable expansion (or rather
it includes variable expansion by default, and you can prevent
it by quoting end-of-heredoc marker).

-- 
Jakub Narębski
