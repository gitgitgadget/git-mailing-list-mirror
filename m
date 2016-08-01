Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A53CE1F858
	for <e@80x24.org>; Mon,  1 Aug 2016 01:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbcHABho (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 21:37:44 -0400
Received: from mout.web.de ([217.72.192.78]:53374 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805AbcHABhm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2016 21:37:42 -0400
Received: from [192.168.2.11] ([156.34.81.190]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MPHC8-1bPeRu348e-004Rzg; Mon, 01 Aug 2016 03:37:31
 +0200
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] t7063: work around FreeBSD's lazy mtime update feature
From:	=?utf-8?Q?Torstem_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: iPad Mail (12F69)
In-Reply-To: <20160730182005.14426-1-pclouds@gmail.com>
Date:	Sun, 31 Jul 2016 22:37:28 -0300
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"e@80x24.org" <e@80x24.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <6955746D-E47E-4BB8-AB0E-44D461E67AD6@web.de>
References: <20160718223038.GA66056@plume> <20160730182005.14426-1-pclouds@gmail.com>
To:	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-Provags-ID: V03:K0:NA5DFR42Nix3lfz25OuhFx7tvWTGGtCNfU6xDCyzcW0w77I6kGh
 5gVkp1oWLVku6OQ1gRGt8auX+N9Wy0oNK3cKaZ7YHOAmlTVttkQk/QcX8jpNi7bv37ytBf1
 /jGYV47d0kAvzOFdXwSb7pGRPXq033ZTRBLFVLdEq3mJ9aOJUNuUdrrfA6lb8+Gyp5w+zVk
 01lUWBBKIpYKSXyVsnPMw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:C1qaS5u9z8Q=:Mi2sQz2fC30KD+koliDWKv
 bxQsL8C/A047NIIPwx47N6v6uhL9PEnzQFIwz/fWMWHcfO6tbmvjPhFudMPHMYGmAX8j6l5Gd
 7AOU0JVg6mO+wgeHenriYkJi+tKagaFJWGR8HYlvRq5pEl4udWuwp9oTxwf857gOXxbPg3R18
 ZanLSzxB2R6uFQIpd5NhjRDhd72/6IO8o0y1l3qQ/lS+loQOP/DaWo1oLCS/wSDlQoQ3DnvJ+
 XZ1CMm0NBM/VSefp7AH6tXXQmwWtxHWsUnPW3lQk40TpLL+A6rMaqU8ndBmhD2IGbX/KzCLnv
 SMLyOUHVtf+CCBd2KaDWhHE/xBrYofdSalZQPQW4VzpqsSNCHOEqXC+DiQRGdcHHupWJx7CKQ
 ggVkxetgf8iqb6/ReGN3K400VMfrgRWRp5mW8h3auWKp1AuoUxaN8y1RQkzVnYr4GlYcaX31p
 b7kHFryzqpG8RcZbsgJyNQDlSHjphgVx83+FP7WP8QOQFrVkMgiojqKJIiHyRCGWKC1KMAAe5
 s3RWy/5D/Ag/5I8Gf4QhQ/GrbQnxmlyXklNLDluJASJfOQt9Ee9bFlDumcxCOxIWKco55GKws
 1lGPYzSZ54UA8JN0sl5mtALD76Td5jDpxGNW0Bdh5cFoUTdZnN1dVFKPGSzEutYjJOSJXjSlr
 xLAG7pDABxJickv7YtSw71yIAjv2i/sUhkqNtroxXtIBHzGEhAWaLBbTISt25DY3q0h85b6f7
 ZegjVB/DJB2HYwaENuH4E3N6byBF6GbrVMzGC2YTn7DY+BOlVjPab8slZHKzH7D75pKlJO++d
 U+/zaiY
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org





> Am 30.07.2016 um 15:20 schrieb Nguyễn Thái Ngọc Duy <pclouds@gmail.com>:
> 
> Let's start with the commit message of [1] from freebsd.git [2]
> 
>    Sync timestamp changes for inodes of special files to disk as late
>    as possible (when the inode is reclaimed).  Temporarily only do
>    this if option UFS_LAZYMOD configured and softupdates aren't
>    enabled.  UFS_LAZYMOD is intentionally left out of
>    /sys/conf/options.
> 
>    This is mainly to avoid almost useless disk i/o on battery powered
>    machines.  It's silly to write to disk (on the next sync or when
>    the inode becomes inactive) just because someone hit a key or
>    something wrote to the screen or /dev/null.
> 
>    PR:             5577 [3]
> 
> The short version of that, in the context of t7063, is that when a
> directory is updated, its mtime may be updated later, not
> immediately. This can be shown with a simple command sequence
> 
>    date; sleep 1; touch abc; rm abc; sleep 10; ls -lTd .
> 
> One would expect that the date shown in `ls` would be one second from
> `date`, but it's 10 seconds later. If we put another `ls -lTd .` in
> front of `sleep 10`, then the date of the last `ls` comes as
> expected. The first `ls` somehow forces mtime to be updated.
> 
> t7063 is really sensitive to directory mtime. When mtime is too "new",
> git code suspects racy timestamps and will not trigger the shortcut in
> untracked cache, in t7063.26 (or t7063.25 before this patch) and
> eventually be detected in t7063.28
> 
> We have two options thanks to this special FreeBSD feature:
> 
> 1) Stop supporting untracked cache on FreeBSD. Skip t7063 entirely
>   when running on FreeBSD
> 
> 2) Work around this problem (using the same 'ls' trick) and continue
>   to support untracked cache on FreeBSD
> 
> I initially wanted to go with 1) because I didn't know the exact
> nature of this feature and feared that it would make untracked cache
> work unreliably, using the cached version when it should not.
> 
> Since the behavior of this thing is clearer now. The picture is not
> that bad. If this indeed happens often, untracked cache would assume
> racy condition more often and _fall back_ to non-untracked cache code
> paths. Which means it may be less effective, but it will not show
> wrong things.
> 
> This patch goes with option 2.
> 
> PS. For those who want to look further in FreeBSD source code, this
> flag is now called IN_LAZYMOD. I can see it's effective in ext2 and
> ufs. zfs is questionable.
> 
> [1] 660e6408e6df99a20dacb070c5e7f9739efdf96d
> [2] git://github.com/freebsd/freebsd.git
> [3] https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=5577
> 
> Reported-by: Eric Wong <e@80x24.org>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> This is only of those commits that commit messages are more important
> than the patch itself. One of the good notes about directory mtime,
> if we start to use it in more places in git.
> 
> t/t7063-status-untracked-cache.sh | 4 ++++
> t/test-lib.sh                     | 6 ++++++
> 2 files changed, 10 insertions(+)
> 
> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
> index a971884..08fc586 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -419,6 +419,10 @@ test_expect_success 'create/modify files, some of which are gitignored' '
>    rm base
> '
> 
> +test_expect_success FREEBSD 'Work around lazy mtime update' '
> +    ls -ld . >/dev/null
> +'
> +

the term FREEBSD may be too generic to point out a single feature
in an OS distributution.
Following your investigations, it may even be possible that
other systems adapt this "feature"?

How about
LAZY_DIR_MTIME_UPDATE
(or similar)

