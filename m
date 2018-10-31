Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10A611F453
	for <e@80x24.org>; Wed, 31 Oct 2018 11:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeJaUHr (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 16:07:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:60613 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbeJaUHr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 16:07:47 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M936L-1gPFya0ptF-00CP2j; Wed, 31
 Oct 2018 12:10:05 +0100
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M936L-1gPFya0ptF-00CP2j; Wed, 31
 Oct 2018 12:10:05 +0100
Date:   Wed, 31 Oct 2018 12:10:17 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Chris Webster <chris@webstech.net>, gitgitgadget@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Use correct /dev/null for UNIX and Windows
In-Reply-To: <xmqqbm7awsvr.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810311206230.4546@tvgsbejvaqbjf.bet>
References: <pull.59.git.gitgitgadget@gmail.com> <8159cbd1b8025f33fb9d0e254db1a3c2a066f853.1540923993.git.gitgitgadget@gmail.com> <xmqqsh0mwwah.fsf@gitster-ct.c.googlers.com> <CAGT1KpWoGD0xgTrC-+X1WqY_M=2arYbs4ZX6Nnj-zHK6mgu+nw@mail.gmail.com>
 <CAGT1KpWC_+=u7fCzQJsU8d_gSQzE5rsx46cTXogvaRPHZ1iiHw@mail.gmail.com> <xmqqbm7awsvr.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:j2OvsGJtOXWn5l6JYaTxizxSKxVm4QmoEuz0gipzM58G7e97M7K
 CZLL3tMwbuEZzx+Yfq8M/tglozGo67XONFt1k2eSFzGr8TRKo1EsQsAKkasj+fPDxN62x2I
 1N+TZurfNhC6WliqvjK+vFdJ81gmHVzzyReK7M2l4xccJIM+/JtT/pc6iDIpmaaJsqSo+14
 8oyS3fA9YGbjBrCd8gnxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:R8wDZ2ujTbg=:LSMWdQk/4APbzHqIlIYkTL
 tCrj6JGSSGrGx3XZm//vMgvBkjE2IhHPtvGKlAKcVVUnKRKgicjbpaRLFnY1Bb9kndbaxJWDU
 4GWITxOPZcfVoClEkivcOjjMNG3cnVVEdVR2i9DiGeXm9A+3dCaggxATV06quITfVfZI6RGuV
 v+sJnLqZf2BNHXM6rGp5md+DfLceYpKkfLOSJPPLbd5j/w8GW2YUyyd3hUVqamRoDOLsYZM8S
 ckB0vD/26Jf3kYga4I9hPbQknfCPfKbz3VWjd4ciZ7/LYUyG/C68EnVhTUeZwPqTEG43+0WEh
 DAwa2mUZYknWgCGevMq9yzfv48CVvtjIEonwTtabB1vdP18/yY0siCaUAhfa7Kbl4qPzPIygc
 2RnzbCassdlEUl38eXjT0r5czPOL5W+P+AAvjnJcXK0EAGfrMQvn7At7qeac3mtPaI4VxkL4w
 SUjiHxKzXDRdnkr/Ttpcy8SsULiAeirNa/0yFjQaGIapVhTLgV6VSyh5zBk5TqYQc6YMR3+qi
 IaO0enhe54+9VKY4+bxr3L8KlyuDlsPqcu/uFfjUBfl65TnZTzqwOO74SOMfgYApzkINZya3E
 7l/r5R9UljozGSstfG9N2+/TOZ6Wcs02Q+8KVk7gM/+Cc0R/aMegZyIcniITYf5XHMm9xdji7
 Sj4mqY9vZMhJkC5GygQpnpF9p9LuVTeheTKowL3YrVA6wlZoTP2vYHV3yWzqPKZLC/lFKnPl+
 JY21qMNztpMpO9CqLny8qzFDfeoyWKgZ0zZAkYzQin8j6gRWpgEAgMCBEhpSqnqjIy8E8Sr4O
 fN8R9vosHvkATTCdrJm//qEAMb6UtK8jOHXKDHrYlx3WfRPwK0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 31 Oct 2018, Junio C Hamano wrote:

> Chris Webster <chris@webstech.net> writes:
> 
> >>> > Use File::Spec->devnull() for output redirection to avoid messages
> >>> > when Windows version of Perl is first in path.  The message 'The
> >>>
> >>> Dscho, "Windows version of Perl is first in path" somehow feels
> >>> contradicting with what one of the topics I saw from you were trying
> >>> to enforce (or, at least, "set as the supported configuration").
> >>>
> >>> I am guessing that the Perl you are building and shipping with Git
> >>> for Windows would yield what the shell that ends up running the
> >>> scriptlet `git config --get-color $key` prefers when asked for
> >>> File::Spec->devnull(), and nothing will break with this patch even
> >>> if that is "/dev/null", but I thought I'd double check.
> >>>
> >>> Thanks.
> >>>
> > This problem originally showed up in the
> > https://github.com/so-fancy/diff-so-fancy project, which has a copy of
> > DiffHighlight.pm.   That project allows diffsofancy (perl) to be run
> > from the command line without requiring the bash environment ((well ,
> > sort of) including the associated perl).
> 
> Thanks for additional comments.  
> 
> In any case, Windows is not my bailiwick, so I'll hope that the
> above comments from you would help Dscho in his response and wait.
> I know use of File::Spec->devnull() won't hurt POSIX folks so making
> sure this won't break Git for Windows is the primary thing I woudl
> worry about this patch.

Indeed, the patch in question regards something I consider outside Git for
Windows' realm. As Chris said, you can run this script from a PowerShell
prompt, without any Git Bash (and without Git's Perl) involved.

I am fine with this patch, as long as the author name is fixed to match
the name in the Signed-off-by: footer ;-) [*1*]

Ciao,
Dscho

Footnote *1*: This patch came in via GitGitGadget, and if I had infinite
amounts of time, I would probably implement some rudimentary pre-checks,
such as: does the Author: header match the first Signed-off-by: footer, is
the commit message wrapped correctly, does the oneline have a prefix and
continues lower-case, etc. And GitGitGadget would then point out the
issues, possibly even try to fix them and push up the fixed commits.

If anybody agrees with these goals and is curious enough to dive into some
Typescript programming, I'd be very happy to guide that person through
implementing this ;-)
