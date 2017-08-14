Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A56A20899
	for <e@80x24.org>; Mon, 14 Aug 2017 16:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752842AbdHNQoG (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 12:44:06 -0400
Received: from mout.web.de ([212.227.17.11]:55560 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751501AbdHNQoE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 12:44:04 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWB4X-1e5AzO48lN-00XIgS; Mon, 14
 Aug 2017 18:43:52 +0200
Subject: Re: Bug?: git archive exclude pathspec and gitattributes
 export-ignore
To:     David Adam <zanchey@ucc.gu.uwa.edu.au>
References: <alpine.DEB.2.11.1708131240360.15538@motsugo.ucc.gu.uwa.edu.au>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ae893c19-652d-1c8f-50ba-1242b95be84e@web.de>
Date:   Mon, 14 Aug 2017 18:43:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1708131240360.15538@motsugo.ucc.gu.uwa.edu.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:bRASPdPA73Xokqp2AW264LztC3myorEm+6G5BcxaRqMamHASFsi
 f2AnaI1KmomqDfKZbHs0nNs+vlOyY0TMJOL+FZ6biZX2xghEMD0PUFXudHfVt3x8d98IwWt
 oq7L3Ot5nJVP1LBjHnB8Uooq1KznfmQ1HBUQSf/IhKbVzkyvX3MVl2KQmJUetX6kE1zK6FB
 LfjVjqlRFBk8rjItK0U6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Wz8PBTOZJIM=:p1qCFpelgPRVDKkSViHC8V
 269ECk6X7SH1lYo046niG5cQwzFsxnC4jDZp+jqwA9GHXXDKKujh65FPsORVFjDdirXFeLoH0
 CAiZXtcO1cld9tZJE8fDaCDx+uWT0QM1AyrqiLAGvwk7DMXLIprFK7ZNgpDIDP0fwJWkSY7Wu
 /SRTVxdVOEApaKxgCEjdkVuucXlK0MHOC2KiOQTWjuRZTfxaFnQUgfa0pCVOoY7w0EecfuZIf
 Xr5BxszUDGRqZrV15AsG5n41i2bfSPhjtPNrvd1w56kiH/zieF+jBLoKq2ImBb+Khc5ExUbMN
 99v61Z6B/koy11ytfBR44dYBL8pRajfQmoo9pL/wKifKJ+Smig2jSwIVUJl3pw/z1WoGOdNhu
 L1HzVMBqBxp/94ccqf0ltmdbhSNvljSZjkFiD+6gAyuhKfI9y4jfNeP6VS+H97I8MoxIHzxRf
 fx56234Pu+XIj8VTm9Htx+7pnRVuT/z29P0qapB5nesNO3EPbMoxN5m3TCCJHrffUa8SAoRf1
 PlYfrqD1LOy3+3EOq3m/ZxDIqat96AJsN4vYvHXasBoSx2oigptjYC5YvH1GS2VlfFaBp1a/v
 L5eNc1WewqIwgTxbuCkoqdd4V9ANNalror+/RTYbr6QPjcNvDZtnG6UebGTvLxYN4Fp4I9x6V
 kXAzneBAAd9A89UtyDLlopRoniYj9/UMuiIeBKExEwsTNQy0AEGCZT8Bw3zSnf+Bka12OcwwL
 qdeZH8T3SMipR1p0L734zhKKx4N89oDaoIFBtFvUqcnCUROJJP+DL7CkmwYG3eY3tUy0pV3UZ
 qErXIw0q20SipE5C1JxjbsWJB/81kra45/9xQ+YuJIsm4GwYH0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.08.2017 um 06:53 schrieb David Adam:
> Hi all,
> 
> I think I have a bug in git (tested 2.11.0 on Debian 8, 2.14.1 on OS X and
> 2.14.1.145.gb3622a4 on OS X).
> 
> Given a repository with an export-ignore directive for a subdirectory in
> .gitattributes, `git archive` with a pathspec that excludes a different
> subdirectory produces no output file and git exits with -1 as the return
> status.
> 
> As shown:
> 
>     > git init foo && cd foo
>     Initialized empty Git repository in /Users/david/src/foo/.git/
>     > mkdir a b
>     > touch {a,b}/somefile
>     > echo "/a export-ignore" >> .gitattributes
>     > git add .
>     > git commit -m "Initial commit"
>     [master (root-commit) 53527a7] Initial commit
>      3 files changed, 1 insertion(+)
>      create mode 100644 .gitattributes
>      create mode 100644 a/somefile
>      create mode 100644 b/somefile
>     > git archive --verbose master ':(top)' ':(exclude)b*'
>     .gitattributes
>     > echo $?
>     255
> 
> If this is intended behaviour, is there any way of achieving the goal of
> excluding a subdirectory not listed as export-ignore? Using the exclude
> pathspec ":(exclude)b" produces an empty subdirectory b in the output,
> which I would like to avoid.
> 
> This is a reduced testcase; my goal is to end up with two archives, one
> containing directory b only, and one containing everything except for
> directory b - so I can't just add 'b export-ignore' to gitattributes.

Thanks for the thoughtful bug report!

The problem seems to be that archive.c::write_archive_entry() returns 0
instead of READ_TREE_RECURSIVE for directories with the attribute
"export-ignore", and archive.c::write_directory() gets caught by
surprise by that and returns -1, which ends up causing git archive to
exit with return code 255 without actually writing anything.

This should only happen if you use wildcards like "*", i.e. git archive
should behave as expected if you spell out the full name of the
directory.  Can you confirm that?

The real solution is probably to teach tree-walk.c::do_match() how to
handle attributes and then inject ":(attr:-export-ignore)" as a default
internal pathspec in archive.c::parse_pathspec_arg() instead of handling
it in archive.c::write_archive_entry().

@Duy: What do you think?

Thanks,
René
