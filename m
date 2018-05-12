Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D69A31F42D
	for <e@80x24.org>; Sat, 12 May 2018 08:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751048AbeELIpe (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 04:45:34 -0400
Received: from mout.web.de ([212.227.17.11]:60095 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750908AbeELIpd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 04:45:33 -0400
Received: from [192.168.178.36] ([91.20.55.213]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0McnqH-1f0AHl469R-00Hw5J; Sat, 12
 May 2018 10:45:25 +0200
Subject: Re: [PATCH v14 4/4] ls-remote: create '--sort' option
To:     Harald Nordgren <haraldnordgren@gmail.com>, peff@peff.net
References: <20180409014226.2647-1-haraldnordgren@gmail.com>
 <20180409014226.2647-4-haraldnordgren@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sunshine@sunshineco.com
Message-ID: <b5555929-9f7c-1c4a-78e8-708ebdaaa9d2@web.de>
Date:   Sat, 12 May 2018 10:45:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409014226.2647-4-haraldnordgren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zBCnwKbm6YAlQxT6OoRP3wZ8DqxJ1S3VasRMiRV29UAm3SRyHy1
 /fUNp4GePPtsDSh403/h9w8AGOm7AahHsDw1aPK7K69Lzhx1UWuDxpSZyLUg0KUznaWXfns
 +mt+AUBtg4lUcUtORhwmGZNPH7oZzcKPO5kzsMArTpd9TB4FozdRMU+LTwlPECOBXWoZRkL
 MO3cu0WNh02utwTxN7nNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WRdeHWl2weQ=:dsW1ROUHKRM5bcdX/hTG2y
 APsY7bjEF9hfwXgSQ//UjYaSvNp462zkvtODQmLqmUwBqoMv36L2kFT5PRCQpo9Eb8MHBzE3b
 GZ5MrMES2+4fdfiDeLyxhAt4HjqU5ABn256SMqTcKclJgjtx40QFx0rEuoKBo30+cj8nvvhoS
 zZc8MIuzge4h7L7aFeWBcaTygveJsg8OEG8t6RNXdxx3fNOF9cvdxvYIaoHrKoMtFvfrxQyO2
 7UKG/jqngIQgy0bARiTouf0qaqnu8AUaHMzorsml4aGPCg+NtxqcS/Curaaulk6XFNZnbtOq7
 o6m0PBInVKKidjSRkjaup1F31bItIxbyL5cgXGI6B8FD7uRbQM5ejAhvUwtkME1vHI3yHqy+5
 w9LDIY3CAUlTTF4zFsimjcdEEMU+GiRyZqQiLKWcAcKpQBLTPE85Mzuu7a9YX/3rkSB9jzfzl
 U3YuA7/AHY19yRBpR8Ahb5IH+0MXHKanL3dzVo5AmwayUN3478wmW99tzSDwVR8NBkb9bqQO6
 EPzFmlqZiav5MH5vhMZthcypUNsLtsy8hT7/VpAAzAdoIlv/oC1cfK+7tc2/M9W87equhf+uU
 aDni/tPLDhH03aYsC/AwURdsSWzXead7aE/RlZMaqAfkPinHd7x+aX0pUacseiykMVlA4f9IM
 tulHjHM7EuXuDSKlZr/Zc+sDWqPX+kEahydOIIRd6af4KrZk5rxcbaGuWOOYiPRhVVKxfshAf
 6ANPF1EoHoRdL7AyNnY0gLueatAlBFMbniToQrq6+k1kmkDpE/unP/YMgRzOYkZAgwnaebZcI
 VxBHcAZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.04.2018 um 03:42 schrieb Harald Nordgren:
> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> index 02106c922..83cd35c39 100755
> --- a/t/t5512-ls-remote.sh
> +++ b/t/t5512-ls-remote.sh

> @@ -170,14 +206,18 @@ test_expect_success 'overrides work between mixed transfer/upload-pack hideRefs'
>   	grep refs/tags/magic actual
>   '
>   
> +git fetch origin
>   test_expect_success 'ls-remote --symref' '
> -	cat >expect <<-\EOF &&
> +	cat >expect <<-EOF &&
>   	ref: refs/heads/master	HEAD
> -	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
> -	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
> -	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/HEAD
> -	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/master
> -	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
> +	$(git rev-parse HEAD)	HEAD
> +	$(git rev-parse refs/heads/master)	refs/heads/master
> +	$(git rev-parse HEAD)	refs/remotes/origin/HEAD
> +	$(git rev-parse refs/remotes/origin/master)	refs/remotes/origin/master
> +	$(git rev-parse refs/tags/mark)	refs/tags/mark
> +	$(git rev-parse refs/tags/mark1.1)	refs/tags/mark1.1
> +	$(git rev-parse refs/tags/mark1.10)	refs/tags/mark1.10
> +	$(git rev-parse refs/tags/mark1.2)	refs/tags/mark1.2
>   	EOF
>   	git ls-remote --symref >actual &&
>   	test_cmp expect actual

Why is fetch called outside of the test?  Its output is shown among the
test messages, where it doesn't belong:

    ok 23 - overrides work between mixed transfer/upload-pack hideRefs
    From /home/lsr/src/git/t/trash directory.t5512-ls-remote/
     * [new branch]      master     -> origin/master
    ok 24 - ls-remote --symref

-- >8 --
Subject: [PATCH] t5512: run git fetch inside test

Do the preparatory fetch inside the test of ls-remote --symref to avoid
cluttering the test output and to be able to catch unexpected fetch
failures.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t5512-ls-remote.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 83cd35c391..6a949484d0 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -206,8 +206,8 @@ test_expect_success 'overrides work between mixed transfer/upload-pack hideRefs'
 	grep refs/tags/magic actual
 '
 
-git fetch origin
 test_expect_success 'ls-remote --symref' '
+	git fetch origin &&
 	cat >expect <<-EOF &&
 	ref: refs/heads/master	HEAD
 	$(git rev-parse HEAD)	HEAD
-- 
2.17.0
