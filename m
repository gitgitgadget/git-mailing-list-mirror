Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEB23203EA
	for <e@80x24.org>; Tue, 20 Dec 2016 16:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936180AbcLTQuV (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 11:50:21 -0500
Received: from mout.gmx.net ([212.227.15.15]:64735 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934237AbcLTQuT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 11:50:19 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lg0sd-1cvBOI2Ncx-00pbUw; Tue, 20
 Dec 2016 17:50:05 +0100
Date:   Tue, 20 Dec 2016 17:50:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] winansi_isatty(): fix when Git is used from CMD
In-Reply-To: <ffc6a7a0-4ae4-b755-0b09-5bcd7114a2e6@kdbg.org>
Message-ID: <alpine.DEB.2.20.1612201732160.54750@virtualbox>
References: <cover.1481454992.git.johannes.schindelin@gmx.de> <42ddc270ea04e01e899cc479063e5d602e4a4448.1481454992.git.johannes.schindelin@gmx.de> <129f000c-49c1-0e75-26b3-c96e9b442443@kdbg.org> <xmqqy3zfsq4q.fsf@gitster.mtv.corp.google.com>
 <5977e71d-da58-7cb0-bc69-343bb3a1341d@kdbg.org> <ffc6a7a0-4ae4-b755-0b09-5bcd7114a2e6@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MjjFW3bpHAUXQkUFqfPbNI/ZPmifWB+vyeHmH0Uzb3cVBmVPrym
 fEDdO2puOnZNeHo/y0N5XvDKMc6kGgusnfB1iqOo/jc2xvu+w34GUz3ZVdIDzWq+74i80Ix
 KEofRd5C2MvEmR9XV3pBjdRm87IO1BhSbRLm3Pfc2/hKyBvSxxGGDRpY4cIj27aTh8nHCZt
 PN3nfVkpJhOfczkWRNy4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q+Gc3A6tqMg=:/lm4kyVc+Mk1gpfcl54Rde
 45UhbRRs1vBb2r0HYjLLx+h3x7ETpTGqPCWYwDzyMzHNnOsppc9IPuvxHhXIQJwY74CLsiTAd
 Mn+O33OWhikPMeNPp+mIDrjtz79cYYsIejYRMq4kOkvsabwoa91lgY8+l74ggN84ikhX+iNYD
 3lDnmF/z+Q5jHejqVL9F37vTj0+/1Dlidpphe2AIkYm6O3LFV2EplLSB2Z44MbhTy5vm/UrXI
 lGgL4sNoWxamnNFqHGj7UK9bKN+LWvIdpWLmhkkr8q5MPg9Mg4Y1IIqD3EoNEEnFOCaF9S0DN
 dX6z/IBe4uwwTsNcxBJeh5gzjD4sKNCvGBR+p7tqmpSu8rGOyJD9cfPKbTavAGz5nVxDWk8hI
 xO1MIhYR23LPNvI4a/TTvmhkFMQpUT2YNc4saoPTUDgK8wGcGfyyvxiGHaiO6mobHLeI20rrU
 MBeLG0eUkt4y31FTHHRYvtxTLVpzlaZNrY4hViJ9Si8FQLzc/75li3971Jwe39hCIKUFS5kdK
 zJSNDKt4GHYK3EImCXFTMOcotXk3wf2AXz49rZT/IhG+b/f9pLv9u+lLdy/KvBCCzNiA7/zI0
 UpBX1Kk8o+5zs11SGmcrC8/PMxX/n3lnuKqjvJwRL3I+07g5n8U8V/AGL0Vq29mycUcAShI5V
 RgHZZ2hc8vf0GE2j7L9OoXfxEOYv9RtIX44xeQYkl7IP/jV+XAMRakGRxPfkGh+3s13xPx7nj
 Rcc+O2Yur0HUS0P9VTQwjh9tR03Mmus635LFwyVPziDZ/cwzdDyTM77Vjxv5Y9SyfO2tAxshj
 JV8tm5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Sun, 18 Dec 2016, Johannes Sixt wrote:

> The code in winansi.c emulates ANSI escape sequences when Git is
> connected to the "real" windows console, CMD.exe. The details are
> outline in eac14f8909d9 (Win32: Thread-safe windows console output,
> 2012-01-14). Essentially, it plugs a pipe between C code and the actual
> console output handle.
> 
> This commit also added an override for isatty(), but it was made
> unnecessary by fcd428f4a952 (Win32: fix broken pipe detection,
> 2012-03-01).
> 
> The new isatty() override implemented by cbb3f3c9b197 (mingw: intercept
> isatty() to handle /dev/null as Git expects it, 2016-12-11) does not
> take into account that _get_osfhandle() returns the handle visible by
> the C code, which is the pipe. But it actually wants to investigate the
> properties of the handle that is actually connected to the outside
> world. Fortunately, there is already winansi_get_osfhandle(), which
> returns exactly this handle. Use it.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> I was able to test the idea earlier than anticipated and it does work
> for me.

Thank you.

> diff --git a/compat/winansi.c b/compat/winansi.c
> index cb725fb02f..ba360be69b 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -586,7 +586,7 @@ int winansi_isatty(int fd)
>  		 *
>  		 * https://msdn.microsoft.com/en-us/library/f4s0ddew.aspx
>  		 */
> -		HANDLE handle = (HANDLE)_get_osfhandle(fd);
> +		HANDLE handle = winansi_get_osfhandle(fd);

That code works because winansi_get_osfhandle() is in winansi.c, where its
call to isatty() is *not* redirected to winansi_isatty(). Good.

My plan was actually to clean up the "magic" detect_msys_tty() code: it
messes with internals of the MSVC runtime that are no longer the same in
the Universal Runtime (UCRT), and hence we already had to come up with a
different way to detect an MSYS2 pipe. My preference would be to merge
that logic into winansi_isatty() and abandon the _pioinfo hack.

Let's just clean up all of this in one go.

Ciao,
Dscho
