Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99EC120248
	for <e@80x24.org>; Mon,  4 Mar 2019 14:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfCDO7a (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 09:59:30 -0500
Received: from mout.gmx.net ([212.227.15.15]:36509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfCDO7a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 09:59:30 -0500
Received: from [10.49.208.72] ([95.208.59.9]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5dMm-1hC0Dw40vg-00xbVq; Mon, 04
 Mar 2019 15:59:21 +0100
Date:   Mon, 4 Mar 2019 15:59:20 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: remove the 'hdr-check' target
In-Reply-To: <c1b1c37c-5476-4dc1-9e9b-b0c7363c5ae4@ramsayjones.plus.com>
Message-ID: <nycvar.QRO.7.76.6.1903041558480.45@tvgsbejvaqbjf.bet>
References: <c1b1c37c-5476-4dc1-9e9b-b0c7363c5ae4@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HmQ2nV+MvP0hV8oIDT1gdGIgKq78HYFb8SXeyNjwICNuzqKiHLn
 XEC3MIN1Df+JeMoBXY2sNFmIIZcBjgodp1iBp1EqaapeBNsifbpQ4XFie1iqKSFJ3z2zwIM
 RagazNO4dSbaU7u2FQauJNAR+oLcHgb6g7VcpU8AE2A44RcxjQZX4iGMMCcs13dAjGTbQs/
 0Js1h5ZNtARPNc9bA/AEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ixm7B2ygdB4=:92arPkQBQ5U+LsZ1t7uFOy
 qCT17TeDhgqX8f9Q3VPU/7sqtB/TLfyEEiyJfN6+HrLe9AtCuUcS1cNs4EGlvZuVm9psdoy0T
 UNkD+GJVSiFjC/UIDiDyU3ZTup2cm5xktZ8OoLRzNOK62VniozWOi8G0VIGXmM3t3yXBeFYd8
 PTQwrzGT4Mlrr0J9xGigBeF/hWDl4x6dGZgR7k5ds3c4VzjuFCMfGaGSZwdpocfFMt98d4MCc
 P6OhHgxCyzD8/M1ZH7w0WTEOvNidzwXhQMNp2ryE9oWVLg72nsvN7wGTM+shQEyGx69rPQSBE
 FASrYnxiiVgBn2l8B7za6L93ShBg5ELOcb2q20ROJ5XNTVKG+V/uQmK21WLkCQ2K0lmh+7C+A
 hm2uRD6rYwpp2VwJ5mdhExSnro+g3TaSqWiZ20Bk6dKQpP07rT5+IaF5qsPgWFwl/S5m0RsV0
 Ur9/HTatwi403htSWOWwCdD7OUbyjA4u910Tro0I7pEZ+pijqya2AIG+2vpSITGJhlq6pBwpA
 sluW1LZK2MnfjwPp4E/BGVy0fkoXmbRohqenD9nlu0/7d++OfhEpWsgFyPfgbV93r2jcKskDp
 481clUHSJq8PhX1yG2MHF2ssat/zNhJO6NgyB31LCZDxwbBsxC66XqM+uBIJaHLxfxIpFZLn6
 Po/QzZPyGGtuVTLVXop7aPSBARoxqPVIzIRlvjoKpFiorM9VNEd6pTO/8ueEUsoJP7avFJgmM
 9vS1I4AD0II8UyvLIWODr1BEXZZkhDBRZq+TtIEthaxxd4hiOsw9murgBgI0WY2fGt8PjqEwe
 AXoOfAHuXXbCseaLBZCtIkCkiT7NxVhmGzBR63M5PqcNy59ZChYB3wlU7OvsHC851uvSP9+6u
 TnSIljwUHmRMWB03TlRsZbhW+cNl4uJ8cBYDoEy6Q8kM+SfHMlRN1C0yvqSuuWE0oFILzWMX6
 sLA5M6EL0ig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Sun, 3 Mar 2019, Ramsay Jones wrote:

> The 'hdr-check' target has proved to be costly for some developers and
> platforms, depending on the configuration, even when not using this
> target. In part, this is due to the use of $(FIND) in the definition
> of the $(LIB_H) variable. This effectively reverts commit ebb7baf02f
> ("Makefile: add a hdr-check target", 2018-09-19).

As I said elsewhere, I think it would make sense to keep this target, and
to wire it up to our CI builds.

Ciao,
Dscho

> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  Makefile | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index c5240942f2..dd3e38dc1f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1852,7 +1852,6 @@ ifndef V
>  	QUIET_MSGFMT   = @echo '   ' MSGFMT $@;
>  	QUIET_GCOV     = @echo '   ' GCOV $@;
>  	QUIET_SP       = @echo '   ' SP $<;
> -	QUIET_HDR      = @echo '   ' HDR $<;
>  	QUIET_RC       = @echo '   ' RC $@;
>  	QUIET_SUBDIR0  = +@subdir=
>  	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
> @@ -2735,17 +2734,6 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>  .PHONY: sparse $(SP_OBJ)
>  sparse: $(SP_OBJ)
>  
> -GEN_HDRS := command-list.h unicode-width.h
> -EXCEPT_HDRS := $(GEN_HDRS) compat% xdiff%
> -CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
> -HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
> -
> -$(HCO): %.hco: %.h FORCE
> -	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $<
> -
> -.PHONY: hdr-check $(HCO)
> -hdr-check: $(HCO)
> -
>  .PHONY: style
>  style:
>  	git clang-format --style file --diff --extensions c,h
> -- 
> 2.21.0
> 
