Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18783208CD
	for <e@80x24.org>; Wed, 23 Aug 2017 09:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753563AbdHWJIk (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 05:08:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:52422 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753502AbdHWJIi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 05:08:38 -0400
Received: from [192.168.178.43] ([188.108.200.6]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCwbX-1dtYL00AKZ-009lBw for
 <git@vger.kernel.org>; Wed, 23 Aug 2017 11:08:37 +0200
Subject: [BUG] rebase -i with only empty commits
To:     Git <git@vger.kernel.org>
References: <CAGZ79kYinci-OWXV2VfScLPcUDCHyhSb=7TxTWUWHPnKV5PuDA@mail.gmail.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <36e9c381-81b0-ae71-153a-0bcabc59856c@gmx.net>
Date:   Wed, 23 Aug 2017 11:08:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYinci-OWXV2VfScLPcUDCHyhSb=7TxTWUWHPnKV5PuDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:xDtKi1QttASvh+tldmqIwcJcfWbH0kKTbT1zVj96cV0BaP1GD2i
 NWgF+3qS6mC/97QSCynZIUz3BXNplp/LMVbT/JSq9TzhRMQpMDo7A4T9KQpNUDpTNR6J1L0
 uunp631z6vy76VTeMJ0iQ0OKfNLe27GdibKltgvF9A6PT5ot/LzbVlbEcoqJDWiGrx1Puj+
 89xpEbt2hPCtrzQ9TSjzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2Z6HMMKgTK0=:J7oFC3N6RnnbBbVmnXoXl8
 0o1lzzn/+u7z6lfcs7oGxBWF4h9kLuVK7U42pa45BAqckCdSOWt3flsPLWAqsXXICwn1LvY/j
 jnoouHvK0B/rh3Q0DqkXGRzXptplIUnR4w7gz2DIJz3qdKd3erSyEAXlsXyddKPAfGZAlTZSW
 RWo5Jzt7Ge2kVpl/zLYukt86mTh5//XS3MQnKgXtReOrJ1GgfvILFGteOVWLG81/F8F34GYmZ
 Gl2gt7pXDS3YZqqyqzcVXNnBliAGpMHhz1lEwUaKSKI9KEDL41viYNAX/dF9Z79sR0aPMlsk6
 OIuTR2ZmmGQ8O2lN05/dTDC3TDTZUknk+IkowgJe9TMuLzmHGL0rS16UciFtV+dK6+72s8k/6
 /aSEY8jkKB8g3nZMGT+D+6q2ag3OAhvJHYSvjhLA7+bNzpJ8QkH7FjYGpvUxj8iKdrJajQH6A
 rTr0Zy9dFRcALv8iF36v9ZL4xNNT/yvQbqSUpM8d8+l0u+ZEtC6IYN4HD1fxsB5PoHJTUwZZs
 +Sf2MJctfGfhE2mnbZwDbnUdH/8wLXBDFrUkqu849TLQxxNLDl7oyFvbGd2COOpX43+/1lrEh
 i+fhP4Of1ST0zazylFG/L3W6BO5y3U0ODfBUuk1dsQ6hW8p71Jc5YW6FEjChv0weOQ2BB4gAA
 cJASUmvHcHy3DlIedipy0i1S+aNz+EYsk+l+zjLJ3VP0AZx4RVGq1ZCuSS1JtKtbRZHXo983K
 OjFW2nnLbtGcfqeMDZqtCs4DYQV4tfCVXI57+umCgxwzG/4SassDvFW855TJEAW8Yk/GMsUfB
 RgaeVfFqfFIElFuZ2BtMuNrmlVr+Y2M2V/hZfHnReXx4LDtgJQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 08/23/2017 01:08 AM, Stefan Beller wrote:
> The editor opened proposing the following instruction sheet,
> which in my opinion is buggy:
> 
>     pick 1234 some commit
>     exec make
>     pick 2345 another commit
>     exec make
>     pick 3456 third commit
>     # pick 4567 empty commit
>     exec make
>     pick 5678  yet another commit
>     exec make

This reminds me of another bug I stumbled over recently regarding empty
commits.

Do this:
	# repo preparation:
	git init
	:> file1
	git add file1
	git commit -m "add file1"
	:> file2
	git add file2
	git commit -m "add file2"

	# the bug:
	git checkout -b to-be-rebased master^
	git commit --allow-empty -m "empty commit"
	git rebase -i master

It says "Nothing to do".
Unsurprisingly, the problem persists when you apply other empty commits:

	git commit --allow-empty -m "another empty commit"
	git rebase -i master

Adding a "real" commit solves the problem:

	:>file3
	git add file3
	git commit -m "add file3"

Adding further empty commits is no problem:

	git commit --allow-empty -m "yet another empty commit"

So the problem seems to be that rebase -i (like rebase without -i)
considers "empty commits" as commits to be ignored. However, when using
rebase -i one expects that you can include the empty commit...

Also, the behavior is odd. When I only have empty commits, a "git rebase
master" works as expected like a "git reset --hard master" but "git
rebase -i" does nothing.

The expected behavior would be that the editor shows up with a
git-rebase-todo like:
	# pick 3d0f6c49 empty commit
	# pick bbbc5941 another empty commit
	noop

Thanks
Stephan
