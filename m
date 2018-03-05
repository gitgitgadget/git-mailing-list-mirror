Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A8701F404
	for <e@80x24.org>; Mon,  5 Mar 2018 17:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeCERaH (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 12:30:07 -0500
Received: from mout.gmx.net ([212.227.17.21]:36133 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbeCERaG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 12:30:06 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlqNY-1eJqAI0dWa-00ZLyp; Mon, 05
 Mar 2018 18:29:58 +0100
Date:   Mon, 5 Mar 2018 18:29:56 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     phillip.wood@dunelm.org.uk, Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
In-Reply-To: <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803051812330.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com> <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com> <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net> <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:goCqZyrDoAvYKkgfLCPD92bVUpbP91PA7Usv1I2Ek8bSgTmTwaZ
 VtHdeKru65qStgjwp3rRP0JU9DIOg270PicsWKP4pSym721+xA6qFCUoYAJ1gU6SNTmrPWh
 zpwfZOZXXwzkTODH8HfnG+U/FjZiYdljnmBDWF8QGtdG4ASlWc97yxkTNhwzt4lbYUMLHur
 5BIuNDbcQ+ux960IXm4yA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+smDwABje8Y=:SIGlzbzlGtpyUAeqvyBiUL
 CrJOYK2OlAkNlKwllUPxwk+Z4spHv7A8I0hhJLpWFZbDoYHYWFMwW/S1LEnRXfcuxmkZMfCXW
 7iKxkqtlf0g8F4nKBPr2JnGaJLw3k5Eu4Cpq8F3Yg2/CZn499yitIZhe5V2kJq5Q/TY8Ufn8y
 V+9nBsHq+TOP5khVl07UukN03uMgIUyXml741UzQTmfhPE0lUu/s/lvOBhFjytOX9kSZJwrAl
 BRti80MIvKvlBZEJwPqmD0+2te128hjUSxX9WejeMnMvg58LtweSZ0G1pT4+yO/XGg58T/WCT
 aXNGrRGqZJZWse8dQZL3NRv9xCLZCg4oz7Y0D7RJBQczBG+hspqmcrBWnh9cNxNm2JiKb/ms2
 KfghDwiqM1PQ0AVW4q1W/Y9mvVoAQiBUrYZstSsu1bhfnOcvF2VGfjyCYiAUBRPFrdGzttykU
 tNBZFePb3mrIZ8FlJC4ZB+WdTGgS5IT7e+WjPHTYMLEOkDkjm3/z8BUyk1dm4vsVePKZ8FZ4M
 Rzwic00lDCwk0MumHnsSzdzs3gCajw89LZWCFGS2iFFHqJoMCND9NzPMfNbeXnA4M9RbBf7rD
 N8pHM97drSGk/qAkSt0ncvMpv8o95iVnycFlciYfL+OaQWe6ra4aZJKV7mcA8PhLBUunOwrVE
 SWKiFtk3EpHTELtP44N0IW+v2dfze9mO4HIWxjic1kjv35zKxIDfJBD8otlRIPnmnxMnWHBcx
 ugjzhGH5zrbLwecA1/RhP3SUakrrtoYW6yKlZGl3D/rB6Co6Mvfxpj9aG5h+LHlCNIWY9aktk
 MqI3FsJtDGV2OFZ4wVn8BefMQEQFO6kN4IOFcikun8LskQtduu70/+cQdyYZ1Ip3nAKSWdG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Sat, 3 Mar 2018, Igor Djordjevic wrote:

> By the way, is there documentation for `git merge-recursive` 
> anywhere, besides the code itself...? :$

I am not aware of any. The commit message adding the command is not very
illuminating (https://github.com/git-for-windows/git/commit/720d150c4):

    Add a new merge strategy by Fredrik Kuivinen.

    I really wanted to try this out, instead of asking for an adjustment
    to the 'git merge' driver and waiting.  For now the new strategy is
    called 'fredrik' and not in the list of default strategies to be tried.

    The script wants Python 2.4 so this commit also adjusts Debian and RPM
    build procecure files.

Digging through https://public-inbox.org/git/ during that time frame comes
up with this hit, though:

https://public-inbox.org/git/20050907164734.GA20198@c165.ib.student.liu.se/

which is still not a good documentation of the algorithm. You can probably
dig further yourself, but I think I can describe it very quickly here:

To merge two commits recursively, you first have to find their "merge
bases". If there was an obvious branch point, then that is the merge base.
But when you start a branch off of master, then work a bit, then merge
master, you already have two merge bases.

The trick about the recursive merge is to reduce the number of merge bases
iteratively to one. It does that by taking two merge bases, and performing
a recursive merge on them, which generates a "virtual" commit, the
condensed merge base. That one is then merged recursively with the next
merge base, until there is only one left.

A recursive merge of two commits with exactly one merge base is simply a
three-way merge.

I vaguely remember that there was something funny about the order in which
order you want to process the merge bases: if you did it in one
(chronological) direction, it worked beautifully, in the other direction
it would generate tons of merge conflicts or something like that.

Ciao,
Johannes
