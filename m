Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEB961F403
	for <e@80x24.org>; Mon,  4 Jun 2018 07:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbeFDHjF (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 03:39:05 -0400
Received: from mout.web.de ([212.227.15.4]:55729 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750819AbeFDHjE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 03:39:04 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LZvfZ-1g8vjO3n49-00lk8r; Mon, 04
 Jun 2018 09:38:55 +0200
Date:   Mon, 4 Jun 2018 09:38:55 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Regression (?) in core.safecrlf=false messaging
Message-ID: <20180604073855.GA20922@tor.lan>
References: <CA+dzEBm_doNMjEs_OWwia_mm7u3ztAFpCpaFJP3DRpFhEo93jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+dzEBm_doNMjEs_OWwia_mm7u3ztAFpCpaFJP3DRpFhEo93jg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:tO+d92x58zKrQoDQR95fAo5AyKw5S3VAc9q3tR9KYAHWuBjCWbQ
 C9/BMXdi+w0SICph0M4f4cVThaibo3wJcg6ejG9nH5+WA5MFnhrzboz+QOqVjKvYcXnmRR7
 Bs7BYNkTGFSkL9X96SQ0J2+dmfJWzjNW1iqmG9kzyBitc916YsDKK2x9gSBJuf4XSEK7IKH
 JOcyYivdwE3VcgYdjT5EQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EpGyD22boO0=:wvyOGo1Tdpzqkn1xFNpSq7
 I/WS1xwIVjhx4r8C4s5ByLzEDGB9MwJQBbUROkJ3Daf6IPgLpf2mADRZY559A7kyWh6jUX/XP
 OkJ/iUWoXWStfqqurirLxdoYQodzOA5O6ZWBK9WMUEJonVX2NyVBmg9ftjrzFlSh3KKG4Gvo/
 SGWTldJOsGX9ZEUc9/3OdLLm7DPgzmrpCU9SrLUhNB2AH2hgZtOm90fLcspWgYnP3MPLKc+aL
 0/DSHoMzAdQV2uSaixhtSRY13pnrX0Lk9q7165AY4OuWUdFelP4J6IfZm4ziPYDFrZyszyBRB
 oxJ6ZP5EhFFyZ7VkMOasbgO19JZVbun+02C73RlTJXzYxKAOl3UDwaRaM0BLCQU8yEQmdpOgc
 6V+fGWJoFERH9z3tTUM3rM9KhVqvuyUMd+xOn3oBU4b5F+muGDXVzxY+CWruG0W9MR5f3PHN4
 c2tlJPWQ708PAenKOI4Via5n2tFX+3vjqg4ZhVfHTsV6pfBUnJh0n4oncERvF3wXdAY13gI6Y
 taXSLsgV7NaXs8tPh0xGDU/y4rRUVO/N62fmQduJQ+iedWkKC0qq+dBpiibXMTuk3IzeN3RJU
 xkee8YherOw9YwSZ1HlWv3KCk1qEjM5p9Fs6QbN0cV/FjPngNVMqh0G/GlyqJHkk0fRz3pKwX
 J9IY5zg+KeHebhQU7aRZ1A6gb3mwu97zAbf0nCEXQWTG8o1slCybEpSIAt3KJBH39jJqHqBv3
 7Yn0b+Tyn+ApsIiItxI6/GiO3UYjf13Xhxk3ur7+bMlkavpN8NQAcO0Z8b0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(as usual, no top-posting here, please see my answers at the end)

On Sun, Jun 03, 2018 at 10:54:00PM -0700, Anthony Sottile wrote:
> I'm a bit unclear if I was depending on undocumented behaviour or not
> here but it seems the messaging has recently changed with respect to
> `core.safecrlf`
> 
> My reading of the documentation
> https://git-scm.com/docs/git-config#git-config-coresafecrlf (I might
> be wrong here)
> 
> - core.safecrlf = true -> fail hard when converting
> - core.safecrlf = warn -> produce message when converting
> - core.safecrlf = false -> convert silently
> 
> (note that these are all only relevant when `core.autocrlf = true`)
> 
> I've created a small script to demonstrate:
> 
> ```
> set -euxo pipefail
> 
> git --version
> 
> rm -rf repo
> git init repo
> cd repo
> git config core.autocrlf input
> git config core.safecrlf false
> echo -en 'foo\r\nbar\r\n' > f
> git add f
> ```
> 
> When run against 2.16.4:
> 
> ```
> $ PATH=$PWD/prefix/bin:$PATH bash test.sh
> + git --version
> git version 2.16.4
> + rm -rf repo
> + git init repo
> Initialized empty Git repository in /tmp/git/repo/.git/
> + cd repo
> + git config core.autocrlf input
> + git config core.safecrlf false
> + echo -en 'foo\r\nbar\r\n'
> + git add f
> ```
> 
> (notice how there are no messages about crlf conversion while adding
> -- this is what I expect given I have core.safecrlf=false)
> 
> 
> When run against master:
> 
> ```console
> $ PATH=$PWD/prefix/bin:$PATH bash test.sh
> + git --version
> git version 2.18.0.rc0.42.gc2c7d17
> + rm -rf repo
> + git init repo
> Initialized empty Git repository in /tmp/git/repo/.git/
> + cd repo
> + git config core.autocrlf input
> + git config core.safecrlf false
> + echo -en 'foo\r\nbar\r\n'
> + git add f
> warning: CRLF will be replaced by LF in f.
> The file will have its original line endings in your working directory.
> ```
> 
> A `git bisect` shows this as the first commit which breaks this
> behaviour: 8462ff43e42ab67cecd16fdfb59451a53cc8a945
> 
> https://github.com/git/git/commit/8462ff43e42ab67cecd16fdfb59451a53cc8a945
> 
> The commit appears to be a refactor (?) that shouldn't have changed behaviour?
> 
> Here's the script I was using to bisect:
> https://i.fluffy.cc/2L4ZtqV3cHfzNRkKPbHgTcz43HMQJxdK.html
> 
> ```
> git bisect start
> git bisect bad v2.17.0
> git bisect good v2.16.4
> git bisect run ./test.sh
> ```
> 
> Noticed this due to test failures here:
> https://github.com/pre-commit/pre-commit/pull/762#issuecomment-394236625
> 
> Thanks,
> 
> Anthony

Thanks so much for the report, and the detailed analyzes that has been done.
Good work, I would say.

This looks very much as an (unplanned) regression.
I will have a look within the next days, as soon as my time allows it.
