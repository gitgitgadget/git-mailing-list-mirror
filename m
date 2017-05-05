Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A30FE207D6
	for <e@80x24.org>; Fri,  5 May 2017 05:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755557AbdEEFyy (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 01:54:54 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:53335 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755440AbdEEFyx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 01:54:53 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wK1Ly3Fg8z5tlB;
        Fri,  5 May 2017 07:54:50 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id DAF4B29A5;
        Fri,  5 May 2017 07:54:49 +0200 (CEST)
Subject: Re: [PATCH 3/7] fixup! compat/regex: update the gawk regex engine
 from upstream
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20170504220043.25702-1-avarab@gmail.com>
 <20170504220043.25702-4-avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefano Lattarini <stefano.lattarini@gmail.com>,
        =?UTF-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>,
        "Arnold D . Robbins" <arnold@skeeve.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a4731849-048c-1b3c-11e8-94c614f8b2de@kdbg.org>
Date:   Fri, 5 May 2017 07:54:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170504220043.25702-4-avarab@gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.05.2017 um 00:00 schrieb Ævar Arnfjörð Bjarmason:
> ---
>  compat/regex/regcomp.c | 356 +++++++++++++++++++++++++++++--------------------
>  1 file changed, 209 insertions(+), 147 deletions(-)
>
> diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
> index d8bde06f1a..a1fb2e400e 100644
> --- a/compat/regex/regcomp.c
> +++ b/compat/regex/regcomp.c
> @@ -1,5 +1,12 @@
> +/*
> + * This is git.git's copy of gawk.git's regex engine. Please see that
> + * project for the latest version & to submit patches to this code,
> + * and git.git's compat/regex/README for information on how git's copy
> + * of this code is maintained.
> + */
> +
>  /* Extended regular expression matching and search library.
> -   Copyright (C) 2002-2007,2009,2010 Free Software Foundation, Inc.
> +   Copyright (C) 2002-2016 Free Software Foundation, Inc.
>     This file is part of the GNU C Library.
>     Contributed by Isamu Hasegawa <isamu@yamato.ibm.com>.
>

GNU C Library 2016? Is this GPL v3 code? that would be incompatible with 
GPL v2, I think.

> @@ -14,9 +21,20 @@
>     Lesser General Public License for more details.
>
>     You should have received a copy of the GNU Lesser General Public
> -   License along with the GNU C Library; if not, write to the Free
> -   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> -   02110-1301 USA.  */
> +   License along with the GNU C Library; if not, see
> +   <http://www.gnu.org/licenses/>.  */
> +
> ...

-- Hannes

