Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FFAF20954
	for <e@80x24.org>; Mon,  4 Dec 2017 16:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754272AbdLDQIM (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 11:08:12 -0500
Received: from mout.gmx.net ([212.227.17.20]:61175 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753165AbdLDQHw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 11:07:52 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lqm3a-1f09iZ1G5a-00eNFc; Mon, 04
 Dec 2017 17:07:41 +0100
Date:   Mon, 4 Dec 2017 17:07:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v2 0/9] rebase -i: add config to abbreviate command
 names
In-Reply-To: <20171203221721.16462-1-liambeguin@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1712041707050.98586@virtualbox>
References: <20171127045514.25647-1-liambeguin@gmail.com> <20171203221721.16462-1-liambeguin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JLLC4Ibc+5kMKsarnYV/Dhj0l+Dk3tSJcVzo+2zDzBQVyXnpxTX
 6S3RjwHko2FDMzlqOMHmjlNDotMN6j1LuDG6DmFAc2J3Yt8BmVke6AJ5HC4dw+jk7DaQFKy
 FBKygN2RT5goappmZ7/nDlhexXdY+/MWJKuYGigyG6r/nVUuujYCb2heZ0FdN9n3ntAAkQp
 AW3rgETqIdXOnc/6cneHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DrUj7XV5kPY=:E1hPEn64MhUuk2SRlj+7NR
 0ajgEbDRLtgEB7/CEQP/khhWBcJo6jI07jyfmPneQm+3j2EYz8ZJ8VJCfJzbOJxFDlVVbymcG
 +TTo7tmkOCpseHUP/aruyuAddlUjVS8632uSANlSU1JjgIlvmA8uQe7NgdX3bp9tc/M0x0251
 sx36Swk+oQm2trNGe30oVc7nJafJPugZPHCU0qoO8v1pxeE62TocHZQ07M3wTN1vzPGYu42bG
 gZUFRRYGt5GbA8cvFeXFxWuIUEqSljx7OGaKBmByMd81LUS61+Ej/E+mHIs2EkLuKCN6Dazp2
 NfxkHMFyx1cwM6hF92bdFKrnfHIS6eMTgtjFyy/8wf6/49A+UyiYVPNqDQOPCnz1rM9iERmnC
 ARFIAjybBDTCgqmv+RaCqcKWVdcKg4Se+CfOiTlxXYbu+6W+nrn+vqP6lAWUWA6p4qb2Ga3od
 dIhv12oTMGzjV2gGnlR9VFPOMjZx7gUB4p8yIJk7j11YshzBxRRdZFva4DdVA/SRZQpDxUTeG
 +aOCU2aDQZMH3X7k2w7Ox7LMTndyfSK3CGzsNbLVSQrq3PKi5OMdCFvf+TXKObgJx3jAGjlUu
 Rk7I0N0pgAwhwHIFq3swR+vWmjEw1flC5sC9I/DzU98AgieWUFJjy8EeOa722PgL7WuI+8wAM
 lT5UQTjuF37Ls5INiqNC644E0/TxT188gx4ebcwuknyoLL3XZpbbyfya4ju0pQ2qG9XMAHJ5S
 VUvD35VvWvGA/MTuEDztI/c4khKAYyFSxvD5xnmqUOJwTnAsHVyMkHQQQHiaSF8uz+65yZa1d
 w6TaAMrH2affchFFgXiBMd/VR9t0NEoTCuaqaku6cp3WmxckX4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Sun, 3 Dec 2017, Liam Beguin wrote:

> This series will add the 'rebase.abbreviateCommands' configuration
> option to allow `git rebase -i` to default to the single-letter command
> names when generating the todo list.
> 
> Using single-letter command names can present two benefits. First, it
> makes it easier to change the action since you only need to replace a
> single character (i.e.: in vim "r<character>" instead of
> "ciw<character>").  Second, using this with a large enough value of
> 'core.abbrev' enables the lines of the todo list to remain aligned
> making the files easier to read.
> 
> Changes in V2:
> - Refactor and rename 'transform_todo_ids'
> - Replace SHA-1 by OID in rebase--helper.c
> - Update todo list related functions to take a generic 'flags' parameter
> - Rename 'add_exec_commands' function to 'sequencer_add_exec_commands'
> - Rename 'add-exec' option to 'add-exec-commands'
> - Use 'strbur_read_file' instead of rewriting it
> - Make 'command_to_char' return 'comment_char_line' if no single-letter
>   command name is defined
> - Combine both tests into a single test case
> - Update commit messages

Looks very nice already! I offered a couple of comments/suggestions, but
nothing major.

Thank you,
Johannes
