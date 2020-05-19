Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F07BC433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 10:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA6C206D4
	for <git@archiver.kernel.org>; Tue, 19 May 2020 10:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgESKvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 06:51:54 -0400
Received: from mx009.vodafonemail.xion.oxcs.net ([153.92.174.39]:28398 "EHLO
        mx009.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbgESKvy (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 May 2020 06:51:54 -0400
Received: from vsmx002.vodafonemail.xion.oxcs.net (unknown [192.168.75.192])
        by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTP id 64237604FD9;
        Tue, 19 May 2020 10:44:43 +0000 (UTC)
Received: from [192.168.2.101] (unknown [188.110.54.245])
        by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 249506043CB;
        Tue, 19 May 2020 10:44:39 +0000 (UTC)
To:     git@vger.kernel.org
From:   Ernst Reissner <rei3ner@arcor.de>
Subject: bug in git remote --help
Autocrypt: addr=rei3ner@arcor.de; prefer-encrypt=mutual; keydata=
 mDMEXomzfhYJKwYBBAHaRw8BAQdA+7rIM+j3LBatGJ1WR+9Kqmi7nV4QD6K2If9RJ5SWuVS0
 IUVybnN0IFJlaXNzbmVyIDxyZWkzbmVyQGFyY29yLmRlPoiWBBMWCAA+FiEEfGsS9bl804On
 o055yeifkC5HY0MFAl6Js34CGwMFCQlmAYAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQ
 yeifkC5HY0OcqgEAp2b6EhR0t4SCHCWwLTs93dxpDzIifwu72OYDq67DIoIBAOisjDjYsOWN
 Usv3ACEG90VHu2IHvVo+RgEkWnKivLgKuDgEXomzfhIKKwYBBAGXVQEFAQEHQLXfIqdcipWb
 sfw2EEK3HNKXraPHrJvm/MWfzXnBvuUQAwEIB4h+BBgWCAAmFiEEfGsS9bl804Ono055yeif
 kC5HY0MFAl6Js34CGwwFCQlmAYAACgkQyeifkC5HY0NOTQEA4jJVNZwkkM7mSR4z3ft2aCSZ
 2HoQqIEGWVJeODKfiMgBALviyq6zOJeqyn1gc9A+9Qdsv7/5jynlOnQdW2PAxa4L
Message-ID: <2830ee51-ee11-4acc-ca63-3f510e6bcc1d@arcor.de>
Date:   Tue, 19 May 2020 12:44:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-VADE-STATUS: LEGIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have git 2.26.2.

git remote --help

yields

SYNOPSIS
       git remote [-v | --verbose]
       git remote add [-t <branch>] [-m <master>] [-f] [--[no-]tags]
[--mirror=<fetch|push>] <name> <url>
       git remote rename <old> <new>
       git remote remove <name>
       git remote set-head <name> (-a | --auto | -d | --delete | <branch>)
       git remote set-branches [--add] <name> <branch>...
       git remote get-url [--push] [--all] <name>
       git remote set-url [--push] <name> <newurl> [<oldurl>]
       git remote set-url --add [--push] <name> <newurl>
       git remote set-url --delete [--push] <name> <url>
       git remote [-v | --verbose] show [-n] <name>...
       git remote prune [-n | --dry-run] <name>...
       git remote [-v | --verbose] update [-p | --prune] [(<group> |
<remote>)...]


which does not mention `git remote show <origin>` which actually exists.


Greetings,


Ernst

