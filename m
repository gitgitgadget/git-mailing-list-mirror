Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7FCF1F453
	for <e@80x24.org>; Tue, 30 Apr 2019 22:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfD3WZm (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 18:25:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:44071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbfD3WZm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 18:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556663137;
        bh=5keiZxSCchT95Rf4Vwno4mWJLq7hSpUTLxo2m3zF0HY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WbqAxR+wBUf8KUVF6iXXid+kwapwwL7M4OAZNtAMDjySj5OSUKIa4oM7ixJfUtmmW
         tbqEA4yJmeVPkbFTkmVh+Hpr6SDe9VDEL+8i0gFqoCl2Ls1UpzdEFZ0MFXeOJ7AtaM
         exoCTWk2rUfZyV7hkJyNqOJekF44126X7c+GSc78=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm6F-1hXSl137c3-00GM1g; Wed, 01
 May 2019 00:25:37 +0200
Date:   Tue, 30 Apr 2019 18:25:35 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] rebase: fix garbled progress display with '-x'
In-Reply-To: <20190430142556.20921-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904301819540.45@tvgsbejvaqbjf.bet>
References: <20190430142556.20921-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-52271464-1556663136=:45"
X-Provags-ID: V03:K1:cqlAX7ASr+dN1B+Fb/fzapgkNq2lqOlsmgYQ+X2Qr/Zk/hWczBf
 vgKSkzxiOC405VL1vkTfpETBJcTuba4DLgL/MXsI8X5nHsxq78WywtbKtixsnmC9QJ3pBOO
 /rM90dNasV7Xxb5PxoQxe53HnwlU4EAc0XJ9sKSYYNO/D9Fusgg5TAVTBOq2xHQHD3ZEKAz
 vmXgcHzFds5wCsEJs65ow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ehYG0UVN5qE=:EwELXb6UJypaCA3ErXdGvD
 +z5p7BDdasHDZTCz2paww9aZpJXj0w9+z9UX8NdtJOMxyXHhjCKXTwN3+rCmJciCz4/3K15Gr
 GNIry4fqU36qQEVgE+koJY6uW2oFm0eZhL7gFV+ld+3bA1SjEh2OwvuDjJxRpp3hQuBZlYVxX
 jZqTNCBZNGylw2eNOeVvlqv+Ex7YMxUn+XjCR+SDD0lo7Iu3TDiRoHMRxiyAoe6FAnzgM+Zas
 DruJw08uCT6MlQ3FiRmJ+nffz3LmM549XQZCuYnBDqPCNDoznClh21KI0/dvIC2VNQhX+nj6p
 7mQw7NYANgoYa0u+ZephXX0RK8nfBmVIK59Vgwf3cp53Zb7uzVVnNQW6UWQWIxqmHj0BjsF6r
 6HcVXEHNNCOyfs5af+11tm9YE88DxhYEHqd7VFXDUSlDeEpEV81cm0ueAyF/K12XpWg6ShftM
 XlyZZlaDHzvGbDSQHEbYSL7Nn2UzZc0Hy4jxdwmj4X16NYsjaksPF3XZBG0mhikx1UQtIp4iE
 6efk9KjYxYSF+i+Cm8yUOYYeFXDcEwU0bfECXkit79QADTjkEQDBpl8kl0vQzHSzIl14A/FPF
 Ashb+AnH+R6uDKEYf0FQjln5VwPXpNyHuhLx1K9J19JKnBgePWrl6+uCfpDlxvOWZpngZizgY
 b2n3CfOgbMqAuoTZJXVyd3UNZTWPs53ZKdmKe03b0bzTQ+VxpT6wU2fezmU8CXDch/3OPaUVr
 IPM1SJR7HcQZQNcOJhAD/hn+XlL8T2bTxTATDr8MxoQvuRAQjhaIfRJBl8fEQwKKfN+jLC8EQ
 IeY3lSoya3e0u+RCRc/PBLVbhEw6x2Pb9mxF+N8/MT35lzUCFsCyERteNjNjXFnQBCvIO16za
 MWmwiOK6NOS3beo/CTBQSC3jgRzGf2VHDCQuKUigeMDIP9nBIcp2w9trduQxxatSuSPJ/p8bb
 MXdYU6+YsYQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-52271464-1556663136=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 30 Apr 2019, SZEDER G=C3=A1bor wrote:

> When running a command with the 'exec' instruction during an
> interactive rebase session, or for a range of commits using 'git
> rebase -x', the output can be a bit garbled when the name of the
> command is short enough:
>
>   $ git rebase -x true HEAD~5
>   Executing: true
>   Executing: true
>   Executing: true
>   Executing: true
>   Executing: true)
>   Successfully rebased and updated refs/heads/master.
>
> Note the ')' at the end of the last line.  It gets more garbled as the
> range of commits increases:
>
>   $ git rebase -x true HEAD~50
>   Executing: true)
>   [ repeated 3 more times ]
>   Executing: true0)
>   [ repeated 44 more times ]
>   Executing: true00)
>   Successfully rebased and updated refs/heads/master.
>
> Those extra numbers and ')' are remnants of the previously displayed
> "Rebasing (N/M)" progress lines that are usually completely
> overwritten by the "Executing: <cmd>" lines, unless 'cmd' is short and
> the "N/M" part is long.
>
> Make sure that the previously displayed "Rebasing (N/M)" line is
> completely covered up by printing a terminal width worth of space
> characters.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>

Makes sense.

> This issue has already been present in the scripted rebase as well.
>
> As far as I could tell, if any other rebase instruction prints a
> message, then that tends to be so long (including abbreviated commit
> OIDs and whatnot) that they practically always overwrite that
> "Rebasing (N/M)" progress line (well, except, perhaps, when rebasing
> billions of commits at a time?).
>
>  sequencer.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index 546f281898..c2e4baa90e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3631,6 +3631,12 @@ static int pick_commits(struct repository *r,
>  			int saved =3D *end_of_arg;
>  			struct stat st;
>
> +			if (!opts->verbose)
> +				/*
> +				 * Fully cover the previous "Rebasing (n/m)"
> +				 * progress line.
> +				 */
> +				fprintf(stderr, "%*s\r", term_columns(), "");

IIRC there are terminals (`cmd.exe`?) that would advance to the next row
automatically when printing the exact number of columns in a row. So this
would not work.

But isn't there an ANSI sequence that we can use?

*clicketyclick*

Yes: https://github.com/git/git/blob/v2.21.0/editor.c#L101 (introduced in
https://github.com/git/git/commit/abfb04d0c7#diff-cdeec438beb851e450b94a11=
db9ab7edR89)

So maybe we should do the same here, i.e.

	fputs("\r\033[K", stderr);

Ciao,
Dscho

>  			*end_of_arg =3D '\0';
>  			res =3D do_exec(r, arg);
>  			*end_of_arg =3D saved;
> --
> 2.21.0.1181.g24122a4251
>
>

--8323328-52271464-1556663136=:45--
