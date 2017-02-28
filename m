Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04ED7201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 18:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751720AbdB1SPL (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 13:15:11 -0500
Received: from mout.web.de ([212.227.15.14]:64817 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751037AbdB1SOa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 13:14:30 -0500
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lp9kK-1c3v6g1E9s-00ereB; Tue, 28
 Feb 2017 19:06:54 +0100
Subject: Re: git diff --quiet exits with 1 on clean tree with CRLF conversions
To:     Junio C Hamano <gitster@pobox.com>
References: <20170217212633.GA24937@mcrowe.com>
 <xmqqr32wqxr6.fsf@gitster.mtv.corp.google.com>
 <20170217221958.GA12163@mcrowe.com> <20170220153322.GA8352@mcrowe.com>
 <xmqqlgt0imhe.fsf@gitster.mtv.corp.google.com>
 <20170225153230.GA30565@mcrowe.com>
 <xmqqefyjwfql.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Mike Crowe <mac@mcrowe.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <d98aa589-3e08-249d-0c88-72dbcee1a568@web.de>
Date:   Tue, 28 Feb 2017 19:06:44 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqefyjwfql.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:BeA6mv2mGlhGMz3/VusNc4+dRFXAiBzBTUmdMP2mrMiAJilecD4
 k59HTAtBJC3W1oohNHlvaxFSwGqul8N+kmOxN+riChR5pgJrwX7IcyPLioU0mlzNLpoYnki
 Vb+dwGasBjGKOP/VbB3daGXy0V+IbAxCOkyoiI8m8Nxk2FaIP+GSaHNvZwIFJWbCwCrhAgS
 3IA7V6OSZVoKBA/2YCIOw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4XUIN3SfAuk=:e10D5pb1/8x7aWUbriM+BU
 c3aGZf2PfEz8+rbYYi5Ns0dya9ycPbNTs0gg/cpmMqBDo/V1FHTdzw2S0Ny+4eMJxCdnVncRn
 /XNxsfyT9+CJlLcGHuo1/TVEi7ytCqfMXq45RDU7wW1Gy02m2EWr8keuEzXtLBf4T1nIEWFQi
 vD7JffLUwIHnyeeDuNcfaIAfqMCXsXugJ4VWxQptr7J+RwmqbyIplejh9tNFvnLVpENmVBLgE
 k0WkqLoVfop57TmbgK1pWGUhY31Ns3ggC5GTHQDCjVQE6wnsvlJ+TmPdq/7d3Y0Sarb+F/Dxz
 m79KB8KpiQiCB6aPK5sHc3TWkLkUNsroorz2pWixzkABJhC32tXCVm4P3wK4l2vjL2BkV3o90
 ZO4OkygXOmXEwJMlH61tsLswxalCwUustf+8eEXCt4gPAEVIbIgIqOz18v4bdE29HDiNk5X1l
 B2uXf3pidnF+Hh68KssmgUqVrHw1agN4y0zmH2oiNUv9N/9sHG7g1PviGGD3Y6M/iYfd4ELtK
 BdnSW9oTe0kvYSOKb+ycEi96/bwT7u4YGGo93oi6fIrzv5oi3mZyBB1LTfbsfkIVEJOKppl2M
 OcqV6S5CdRxBMb4kM15wZW4U8Ew56yvX45jmLCHI9JhVhLeT2Q3i8VKk5xzpAyLFDPEJsX3jp
 7cRrc2TEGGfk9SUDut1iRlU8UKK9sOljeEy4Xfal6modwdunbveQi5RnZfHkmBs/dryxOO1bS
 0b9RGmhxxIkfW6nCf17obafuFTRy7CakfV6zfRfWlc1Y0gYG4mW7rAnQI+PSIuXufuPZ2G8lr
 VvC+sZ6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-02-27 21:17, Junio C Hamano wrote:

> Torsten, you've been quite active in fixing various glitches around
> the EOL conversion in the latter half of last year.  Have any
> thoughts to share on this topic?
> 
> Thanks.

Sorry for the delay, being too busy with other things.
I followed the discussion, but didn't have good things to contribute.
I am not an expert in diff.c, but there seems to be a bug, thanks everybody
for digging.



Back to business:

My understanding is that git diff --quiet should be quiet, when
git add will not do anything (but the file is "touched".
The touched means that Git will detect e.g a new mtime or inode
or file size when doing lstat().

mtime is tricky, inodes are problematic under Windows.
What is easy to change is the file length.
I don't thing that we need a test file with LF, nor do we need
the sleep, touch or anything.
Would the the following work ?
(This is copy-paste, so the TABs may be corrupted)


#!/bin/sh
#
# Copyright (c) 2017 Mike Crowe
#
# These tests ensure that files changing line endings in the presence
# of .gitattributes to indicate that line endings should be ignored
# don't cause 'git diff' or 'git diff --quiet' to think that they have
# been changed.

test_description='git diff with files that require CRLF conversion'

. ./test-lib.sh

test_expect_success setup '
	echo "* text=auto" > .gitattributes &&
	printf "Hello\r\nWorld\r\n" >crlf.txt &&
	git add .gitattributes crlf.txt lf.txt &&
	git commit -m "initial"
'

test_expect_success 'quiet diff works on file with line-ending change that has
no effect on repository' '
	printf "Hello\r\nWorld\n" >crlf.txt &&
	git status &&
	git diff --quiet
'

test_done





