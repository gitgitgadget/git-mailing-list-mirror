Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A0F320286
	for <e@80x24.org>; Wed, 13 Sep 2017 13:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbdIMNLS (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 09:11:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:61189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751173AbdIMNLR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 09:11:17 -0400
Received: from virtualbox ([37.201.203.107]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MarAM-1e87rK40tO-00KO8E; Wed, 13
 Sep 2017 15:11:09 +0200
Date:   Wed, 13 Sep 2017 15:11:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael J Gruber <git@grubix.eu>
cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Unexpected pass for t6120-describe.sh on cygwin
In-Reply-To: <52f990d5-cdac-b516-269c-acbb68897e6e@grubix.eu>
Message-ID: <alpine.DEB.2.21.1.1709131448390.4132@virtualbox>
References: <7c3db153-2a56-f27d-af71-e4b61f1252a1@ramsayjones.plus.com> <alpine.DEB.2.21.1.1709121538360.4132@virtualbox> <52f990d5-cdac-b516-269c-acbb68897e6e@grubix.eu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8DsBcRf+u8ZC+BwF0zebyJIEWt3r81/7EacUMUsrC3JNaNsLiX1
 SaTVslGdaT0d7hxsBi+MDnymQQsxXYVVxHRU0Cq5cSKJ6ufnBzBhIdYxsOfpa1gXoepFiOF
 BjaaFCsj9q7KQycruB9Kyw/I4nktx1wJ6N1EuVbymcF2PoafXhCxQRzgXP4efThnOPV42yW
 tO+BtVMN8dmVn3iueZsHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m11YlZebit4=:YQimESIeuFl3+r6k2XaDWg
 MCBxNp7aUvUJBHmDifgZiRxVacn6ORR5w+7x9zwnC67Rjh3XMIfSe2aXLjT40AdyFJ7TB22M1
 8dLn4qFhTbKiP716KqACRg7M4+bfHnVwUnDFDlsPSbGvVRuatbWxpb6lrNkyzmoXuIZiHgx8p
 dKrL2w8FTxM8bw5vA4x6D/sp91BaU5fqqFB8i5SI8NMqXEujcYPOIhDc+psUqV5Q/p8U/LX2i
 yIA0bS42m1Xzgo023NxBGt932h+DExnGgwCpI+jHcna05N0MWFhtrkaLzCiZcH0jJHH4NRR4r
 /D+oHVCMlMRwkFWGp6XpYX2i1kPvQNlZiYpj8F62K9aykETXshmdKc3Yjf7lj44B6GBOqgoB9
 fOmG23NpB+SSEWM5HMV2zr6WfYL0aOYyCzkMbbYPPmeWYLnkpABo2Z7iHfPOWw8730xUIE7hY
 ++GpB4aymQ9Ivu7GNtJ1iNe0Agf9QCNT0/PrR3VJSAKeLC/PXZZTsr6r9p6gQ6Im8AW410j+/
 gJ7vmkJTpzBfXOqhdGMtYaNhqjj2vyBNrMK1y5WOakddUbI6woLbZc/sGZifMqAZyMk1XG7RG
 KmK8RLF+0yJwRIKbnOxwbLXjsDZS0Uf4xQUpgmk3UIkolthl7aqa4ekL75YA1e8vSYjgrU+Mg
 T3MAASUJrpqHyl85iwqftECfTd4/cvuvgYR9IR62O52yJFzMit4or4BMezr+eRpaDATkqeRNM
 vYZfwrflNo9k7XqX1GbYDK3e3gW3Tljt2NXjTEZ8fmVLx26QHwt9ZAr+ObVe8zVNWdvu4mA1p
 X/EZR3w3ECw6pbtuLpn8N1b3f+4jIdy7TzXTfBJL9XAsxuowkM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Wed, 13 Sep 2017, Michael J Gruber wrote:

> Could you please try and report on the following (cygwin, MinGW):
> 
> ulimit -s
> ulimit -s 4096 # anything lower than the value from above
> ulimit -s
> bash -c "ulimit -s"

Git Bash (MINGW, well, not precisely [*1*]):

	me@work MINGW64 ~
	$ ulimit -s
	2032

	me@work MINGW64 ~
	$ ulimit -s 4096 # anything lower than the value from above

	me@work MINGW64 ~
	$ ulimit -s
	4096

	me@work MINGW64 ~
	$ bash -c "ulimit -s"
	2032

Judging by your comment, 4096 should be replaced. So here goes again:

	me@work MINGW64 ~
	$ ulimit -s 1024

	me@work MINGW64 ~
	$ ulimit -s
	1024

	me@work MINGW64 ~
	$ bash -c "ulimit -s"
	2032

And here is the same output of my 64-bit Cygwin installation (just updated
to the current [*2*] one):

	me@work  ~
	$ ulimit -s
	2032

	me@work  ~
	$ ulimit -s 1024

	me@work  ~
	$ ulimit -s
	1024

	me@work  ~
	$ bash -c "ulimit -s"
	2032

Ciao,
Dscho

Footnote *1*: I know it is confusing for Linux folks, there are two very
different classes of executables in Git for Windows: MSYS2 ones and MINGW
ones. The former implicitly link against the MSYS2 runtime, and therefore
can make use of its POSIX emulation layer, the latter do not, and
therefore they can use "only" what the Win32 API provides. For details,
see
https://github.com/git-for-windows/git/wiki/The-difference-between-MINGW-and-MSYS2
