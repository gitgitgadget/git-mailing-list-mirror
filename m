Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F61320248
	for <e@80x24.org>; Wed,  6 Mar 2019 13:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfCFNlw (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 08:41:52 -0500
Received: from mout.gmx.net ([212.227.17.20]:50659 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfCFNlv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 08:41:51 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mbfyr-1giTz40wtB-00J0ms; Wed, 06
 Mar 2019 14:41:47 +0100
Date:   Wed, 6 Mar 2019 14:41:46 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: ps/stash-in-c, was Re: What's cooking in git.git (Mar 2019, #01;
 Wed, 6)
In-Reply-To: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903061441200.41@tvgsbejvaqbjf.bet>
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5XUF5yTmXETEI8sj7eRF+yj+niA72PyLTll4s/ARn4az4x1SE33
 wZjgj463wb6EAqA6X2rVnER8kXOGfYHQxxBwNBbbDNwwCaC4TcPxztJREaBRjGiB2W3E+Hx
 EyrkUVtAN+3XtvEkMpohAdtqHtekh6y1DwAiznSeuxgzmGFF71YKMssRMB+9fQ3fIw74I81
 HgRUJ1FoXDiBA64lAnlBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aoCGkf7faUs=:nXj33ydr9+WqJBA7rSMb8Q
 QkWOj+Go+8sO2yBGmymuyAeaRtrYjzhgoK+DqjItMIEwITCgAABpe6Jwas/55VK7Gk4gt4Xcu
 3N1vngFWyOB9L0hqBWoZEFXI4EqjuEq83VhoI4jFqJne2E4L110KsMprfQgD83PqOfy4U5dsB
 a29PmkPRuAwmIqT+a0stmTEDQil+hRlyGlH/3hcQ2Zcb3nwQtXduPYSJx/9IZiFeaPOwSkz2k
 uDHthfxX1O5Fh+j1YshH9R4fmcOAxBgivrc5ligrJuTqtbBqmiyR3PzpZmuCPkxgWdko35Rrx
 i/1vEq6TTnS+8y/uknCYszR582TUCz0TklztJSxsPq3DYBV58lB6GvX/QYbm+esHPBBorYGnZ
 G14U68ErZhOolrkrDmjpxnfWcTkyVuJPUmI9pX2a9oujN9rP09kn6bh9S5aHDFFDtvGF2toD5
 AaGO8A1HEU1D6kZ8/20dvP15A0nwQdoPPYvvKptUEX9I1WwJq/H0YXZTrW3YCbTzRHrTD2mBX
 n2GdCEFk9fDs5U9b8a+lAgckcCIfNtnYhmDpn8lFH/tzRGl2tZfNw9sVALWNUL5fBx8yMAvCg
 JuWDuPiSPOp4C9wxvdA/YJ2eodY0NftwqvJfNgGbYTtevkwTiH5KDRRthSMv/f/D0q4FPockc
 yyfGCDBXr8gd3P8APZ8sDM4qHynh3TT/gXkVlfhMQfUcrsaURIQFcXQhy29IOr11/H01Sqbtn
 rqZ6nif6pn2PyuJLSxncRv/vNIqzcdytihLe0Nq+biPBfHXNDDUWCJDrFnMKMJrjQ2Tpau7Do
 vPiw72yo6bL8qEJhInLo69cR7iMGNw6v3o71sIB+Nl0pNhmHb9THwr667EcGlv1jctn+xdF5X
 tHYl9eEgaF5EzHLEYF+db3iPoW1eBrajbBSaRQthPnaThkyNYlnTyOXuZEjRlwAdk9ZaLJusf
 6NF/BBgwEcg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 6 Mar 2019, Junio C Hamano wrote:

> * ps/stash-in-c (2019-03-01) 28 commits
>  - tests: add a special setup where stash.useBuiltin is off
>  - stash: optionally use the scripted version again
>  - stash: add back the original, scripted `git stash`
>  - stash: convert `stash--helper.c` into `stash.c`
>  - stash: replace all `write-tree` child processes with API calls
>  - stash: optimize `get_untracked_files()` and `check_changes()`
>  - stash: convert save to builtin
>  - stash: make push -q quiet
>  - stash: convert push to builtin
>  - stash: convert create to builtin
>  - stash: convert store to builtin
>  - stash: convert show to builtin
>  - stash: convert list to builtin
>  - stash: convert pop to builtin
>  - stash: convert branch to builtin
>  - stash: convert drop and clear to builtin
>  - stash: convert apply to builtin
>  - stash: mention options in `show` synopsis
>  - stash: add tests for `git stash show` config
>  - stash: rename test cases to be more descriptive
>  - t3903: add test for --intent-to-add file
>  - t3903: modernize style
>  - stash: improve option parsing test coverage
>  - ident: add the ability to provide a "fallback identity"
>  - strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
>  - strbuf.c: add `strbuf_join_argv()`
>  - sha1-name.c: add `get_oidf()` which acts like `get_oid()`
>  - Merge branch 'sd/stash-wo-user-name'
> 
>  "git stash" rewritten in C.
> 
>  Will merge to 'next'.

Yes, yes, yes!

Thank you so much!
Dscho
