Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EE011FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 21:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbcF3VZy (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 17:25:54 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:33407 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbcF3VZw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 17:25:52 -0400
Received: by mail-it0-f48.google.com with SMTP id f6so5680125ith.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 14:24:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucar-edu.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=oO8c2aUFBjWe4QR/yxJnze1Wa6ItIdcuXG8R6SlMlUs=;
        b=rtdLRgFTh0mh0KHhgqb9ouMjTQ/5TB/UDmMd6C5RdEyCYW7cShvx7g56/Nc1bBok3l
         918HD0ifmOxncogM9RaX61oRCFICGtG2N+wRjuP7SdsUzNzDp45bBgNhisFv5jDvyjxd
         opYQiJNjVCOU60BWWrjbOHgb2FSDhiE+NX2kFxsW2DAHXtp3TxO+p/ZACBY4ab6I8JB3
         0xlObHTEpLCkhZ8/FvrAepaG/Ipm/TQ8gtmvCu3IJhb9WqId7YN64NULkBoCMniXGmAb
         z+2EqNeBg3ph5VcVWqrm+n6ydblMjTs8frXuRrcJVuryijQwPfFJFuXIAZYzeFAikjoL
         jK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=oO8c2aUFBjWe4QR/yxJnze1Wa6ItIdcuXG8R6SlMlUs=;
        b=CtOcp/MwMw8+IfS3nju1dKAxepS61tS6wOnMDHcC9dGZgF1UgZ72X2YTSrbxPVwhBS
         28sYXiLpQp8s5i8UwftbYfZ1SnzsuqUKUSNv5hF7OE89UFft8xAxejaNnVLTLohXcbG8
         01jUaYoBnUn1irM9I1DM8wsX9hIf4ycsb0tb9CYcOP/PIyh90EJhrY1gNyP8psAKzrrG
         BlJJQLiio4GnrS4PlnLLqrsDNRxGRHuJMy54CM2SbBpIHpf1FZ7G9j9GdyVO/Dlrq1jp
         wx/yxgpG3T3Iooj29URkZUTq45ZZD3zPQ0vwZ/VOu6yl7fBHrkS1C12tUytuUrzFNby0
         RmnQ==
X-Gm-Message-State: ALyK8tL65mpZtiaII8+zvOAN3ME4zIt5ybNw/a8cWcc1YirMgwEquMla+7bS4O6LgDO3JY+Q
X-Received: by 10.36.0.207 with SMTP id 198mr27938423ita.30.1467321892770;
        Thu, 30 Jun 2016 14:24:52 -0700 (PDT)
Received: from [10.252.237.120] (c-73-181-114-81.hsd1.co.comcast.net. [73.181.114.81])
        by smtp.gmail.com with ESMTPSA id p102sm4731442ioi.7.2016.06.30.14.24.51
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2016 14:24:52 -0700 (PDT)
To:	git@vger.kernel.org
From:	"dmh@ucar.edu" <dmh@ucar.edu>
Subject: git-credentials-store.exe crash
Message-ID: <7210bce6-093b-9fdf-9a9b-94059ad0d4e3@ucar.edu>
Date:	Thu, 30 Jun 2016 15:24:41 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Since I cannot submit a github issue, I will try here.



  - Which version of Git for Windows are you using? 32-bit or 64-bit? 
Include the
    output of `git version` as well.
git version 2.9.0.windows.1
32-bit

  - Which version of Windows are you running? 32-bit or 64-bit?
64-bit windows 7

  - What options did you set as part of the installation? Or did you 
choose the
    defaults?
no git credentials manager

  - Any other interesting things about your environment that might be 
related
    to the issue you're seeing?
Unknown

### Details

  - Which terminal/shell are you running Git from? e.g 
Bash/CMD/PowerShell/other

  cygwin bash

  - What commands did you run to trigger this issue? If you can provide a
    [Minimal, Complete, and Verifiable 
example](http://stackoverflow.com/help/mcve)
    this will help us understand the issue.

I kept getting complaints by git about credentials lock existing.
deleted it and then git-credentials-store crashed as follows.
```
Carson:part2: git push
fatal: unable to get credential storage lock: File exists
Everything up-to-date
Carson:part2: ls ~/.git*
/cygdrive/c/Users/dmh/.gitconfig* 
/cygdrive/c/Users/dmh/.gitignore*
/cygdrive/c/Users/dmh/.git-credentials*       /cygdrive/c/Users/dmh/.gitk*
/cygdrive/c/Users/dmh/.git-credentials.lock*
Carson:part2: rm ~/.git-credentials.lock
Carson:part2: git push
This application has requested the Runtime to terminate it in an unusual 
way.
Please contact the application's support team for more information.
A s s e r t i o n   f a i l e d !

  P r o g r a m :   C : \ t o o l s \ G i t \ m i n g w 3 2 \ l i b e x 
e c \ g i
  t - c o r e \ g i t - c r e d e n t i a l - s t o r e . e x e
  F i l e :   e x e c _ c m d . c ,   L i n e   2 3

  E x p r e s s i o n :   a r g v 0 _ p a t h
  Everything up-to-date
Carson:part2:

```
  - What did you expect to occur after running these commands?
completion with no errors

  - What actually happened instead?

  git-credentials-store failed.

  - If the problem was occurring with a specific repository, can you 
provide the
    URL to that repository to help us with testing?
	url = https://github.com/Unidata/thredds.git

