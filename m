Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 516041F404
	for <e@80x24.org>; Tue, 18 Sep 2018 04:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeIRJmc (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 05:42:32 -0400
Received: from cat-porwal-prod-mail1.catalyst.net.nz ([202.78.240.226]:49960
        "EHLO cat-porwal-prod-mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726434AbeIRJmb (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 18 Sep 2018 05:42:31 -0400
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Sep 2018 05:42:31 EDT
Received: from [IPv6:2404:130:0:1000:cc36:790:3beb:d33f] (unknown [IPv6:2404:130:0:1000:cc36:790:3beb:d33f])
        (Authenticated sender: victorengmark@catalyst.net.nz)
        by cat-porwal-prod-mail1.catalyst.net.nz (Postfix) with ESMTPSA id 45A89807CD
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 16:03:33 +1200 (NZST)
From:   Victor Engmark <victorengmark@catalyst.net.nz>
Openpgp: preference=signencrypt
Autocrypt: addr=victorengmark@catalyst.net.nz; prefer-encrypt=mutual; keydata=
 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
 JPUM38S4RlHBoBjN/Rl7d11q
To:     git@vger.kernel.org
Subject: Cannot negate `*` ignore pattern for directory with space in the name
Message-ID: <955f404f-83ed-758e-017b-d6b4a1f69ef7@catalyst.net.nz>
Date:   Tue, 18 Sep 2018 16:03:33 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To reproduce (from <https://unix.stackexchange.com/q/469708/3645>):

$ cd "$(mktemp --directory)"
$ mkdir foo\ bar
$ touch foo\ bar/test
$ git init
Initialized empty Git repository in /tmp/tmp.iGmBR6y2xR/.git/
$ git status --short
?? foo bar/
$ cat > .gitignore << EOF
> *
> !foo bar
> !foo\ bar
> !"foo bar"
> "!foo bar"
> !foo*
> !foo bar/
> !foo\ bar/
> !"foo bar/"
> "!foo bar/"
> !foo*/
> EOF
$ git status --short
[no output]

The pattern *can* be negated if it only matches directories:

$ cat > .gitignore << EOF
> */
> !foo\ bar/
> EOF
$ git status --short
?? .gitignore
?? foo bar/

I encountered this problem because Visual Studio Code creates a
configuration directory called "Code - OSS", and I exclude everything in
~/.config by default to avoid noise in `git status`.

$ git --version
git version 2.19.0

-- 
Kind regards
Victor Engmark
