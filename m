Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F1EA2023D
	for <e@80x24.org>; Sat,  4 Mar 2017 14:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbdCDOfk (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 09:35:40 -0500
Received: from mout.gmx.net ([212.227.17.22]:56474 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751927AbdCDOfj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 09:35:39 -0500
Received: from [192.168.178.43] ([88.70.159.132]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGXV6-1cWzUU4796-00DJCA; Sat, 04
 Mar 2017 15:35:19 +0100
Subject: Re: What's cooking in git.git (Mar 2017, #02; Fri, 3)
To:     Pranit Bauva <pranit.bauva@gmail.com>
References: <xmqqh93a6iy6.fsf@gitster.mtv.corp.google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <d1c90081-5ce1-c17a-120c-3cf80e276467@gmx.net>
Date:   Sat, 4 Mar 2017 15:35:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqh93a6iy6.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Orgx1hpl8strFg4b+HvxYGsUA1OsKWwtetEnZaT/FFB/spK4AxL
 yJ9uSRjr36bOdGy5cLxUccTqiSIzqxv4Pe90OsT5KyyTALjv8GjVOILl7vdXTzRz0Pd1b16
 kqBUQIaCSwCYfAvMhJpjN7v27aflFxzMArof3u+TKcXoxJTLiUapybEakIH7Qr8xUxBh1ZA
 iYzBAfr4pBHnFsy0xEKkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/y3OPlDbLXo=:wkufBIu4JZF4ZqcVo78Z1R
 YHtkUEv76G052WtX1AbbK4ktda7GdaCaLF/lewJYIxkJq9d+qqdnlIUUdkWzBXdldvwQcieCb
 GZ4BdwkanmxIpm+ljqzTgen06GHp4ZD46ssiWO5CYC87GG1TIDrKsoIQp1jUUa2cFUU57Rw4T
 tUhSOwuctBBgigOu2ehVm1WLBG9BKz9Z72j+MfnhjbDFyV7fTKP0U9QRtU3W49jjdkRRRlUez
 NtUemVM4LMj6vsCwtvgk4eDFhXWlp7HFWx8M66OUMCuImmn84BCb7jYZ5Kqzm2Lu9Eh1D8ZFw
 wAnVrBUoTfrf9F7my0eYs3cTB7CLeEMJk3ArUaP41z3YXzHy5EeKYgMfbf1RDx46/lfDpZcpB
 BNpde+M+EurG56v3qDYFUVHMug3y4mvqBuAAiV/oB5QV2rf5fab1lbPB6mx/pepkC6rtfDlZL
 jFvmxHimtYDxbnbXQ592Se0qfJfwvpqAGCy0pgYxTWA6HQnl2/nSLu+SRJNX5bxKixPdC3Yk+
 arSYJM/vgSniRVhIIKnhV2ziOTRICIXMQjSWxZvWfdwnaE/Wchz+JDROMFCxtND4gMQClxQbH
 y3NY/t0w3iGpAVe6fajAnSXHFtacng4x3taSyqamdqPT6nGqeluOQldQmWRJZO2zH036Hcfqt
 yLWMHbfjU0Ib+j6t6OWF1TBJpl7yOB+GfJ/195ZolXSo5xqai7aB3luMXXEh0RpkES069OesW
 75juDuE8W6Si2+rFO+tKmluxyfoOPsS15KIP2iXt5X68CFvIsUtM8qjlv4Hv3eEmi8dlX3o7m
 Nth58ROWk9B5ZIaow7iiI/Bb9K9cKkJIznbju3O4UPTBucmF92ENiDbieqUZz/A/q18BnkXbX
 TYVGW9D1iNYJ7QkMcYr9wA9TyUQ7pPF4kdb7RquCVl8XGypexjVaZieXM/4QNWDZ+1jYVsFqd
 3n0NccbZ9qNe1uJ/fVdYdv836HLk3mRKZOdGJd2zZuY9IYtWTBKqGG/PeAk+mEcKiDflxxyHq
 eMA0dV7Uub9zjwzDiXaww3Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pranit,

On 03/04/2017 12:26 AM, Junio C Hamano wrote:
> --------------------------------------------------
> [Stalled]
[...]
> 
> * pb/bisect (2017-02-18) 28 commits
>  - fixup! bisect--helper: `bisect_next_check` & bisect_voc shell function in C
>  - bisect--helper: remove the dequote in bisect_start()
>  - bisect--helper: retire `--bisect-auto-next` subcommand
>  - bisect--helper: retire `--bisect-autostart` subcommand
>  - bisect--helper: retire `--bisect-write` subcommand
>  - bisect--helper: `bisect_replay` shell function in C
>  - bisect--helper: `bisect_log` shell function in C
>  - bisect--helper: retire `--write-terms` subcommand
>  - bisect--helper: retire `--check-expected-revs` subcommand
>  - bisect--helper: `bisect_state` & `bisect_head` shell function in C
>  - bisect--helper: `bisect_autostart` shell function in C
>  - bisect--helper: retire `--next-all` subcommand
>  - bisect--helper: retire `--bisect-clean-state` subcommand
>  - bisect--helper: `bisect_next` and `bisect_auto_next` shell function in C
>  - t6030: no cleanup with bad merge base
>  - bisect--helper: `bisect_start` shell function partially in C
>  - bisect--helper: `get_terms` & `bisect_terms` shell function in C
>  - bisect--helper: `bisect_next_check` & bisect_voc shell function in C
>  - bisect--helper: `check_and_set_terms` shell function in C
>  - bisect--helper: `bisect_write` shell function in C
>  - bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
>  - bisect--helper: `bisect_reset` shell function in C
>  - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
>  - t6030: explicitly test for bisection cleanup
>  - bisect--helper: `bisect_clean_state` shell function in C
>  - bisect--helper: `write_terms` shell function in C
>  - bisect: rewrite `check_term_format` shell function in C
>  - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
> 
>  Move more parts of "git bisect" to C.
> 
>  Expecting a reroll.

I guess you are short on time but I am hoping that you are still going
to send a reroll to the list (probably on top of [1]?). This is because
I would like to start to work on rerolling my bisect patches from last
year [2] ... but to avoid a mess of merge conflicts, I am waiting until
pb/bisect found its way into "next". (There were also recent discussions
on other bisect strategies [3] and it's probably only a matter of time
until a new big patchset on bisect--helper comes up...)

Cheers
  Stephan

[1]:
https://public-inbox.org/git/xmqqvarq9vzo.fsf@gitster.mtv.corp.google.com/
[2]:
https://public-inbox.org/git/1460294354-7031-1-git-send-email-s-beyer@gmx.net/
[3]:
https://public-inbox.org/git/CABEd3j8m5D=bBbUD+uzvE9c8AwdBEM79Np7Pnin-RLL=Hjq06A@mail.gmail.com/
