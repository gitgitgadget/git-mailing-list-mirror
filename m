Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C6A20286
	for <e@80x24.org>; Fri, 15 Sep 2017 10:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbdIOKbn (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 06:31:43 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:51059 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdIOKbm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 06:31:42 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue004 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0LvNjj-1dRTvh0XQJ-010bfn; Fri, 15 Sep 2017 12:31:34 +0200
Subject: Re: [PATCH 1/2] test-lib: group system specific FIFO tests by system
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <alpine.DEB.2.21.1.1709141440510.4132@virtualbox>
 <4482ae18370f3e759bf98f71e15eaab19fdd009a.1505400392.git.git@grubix.eu>
 <alpine.DEB.2.21.1.1709150020070.219280@virtualbox>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <a159230a-d406-c772-13f0-f82a36faf763@grubix.eu>
Date:   Fri, 15 Sep 2017 12:31:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1709150020070.219280@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:nWMnAtTd/tTTcB3K/xiES9BwquSaDskX1VTjzdEbKAaUvtCaCUU
 S26Cfy2NvIvejF9VWDtBBFtS19/RaFT+V+0YlH0Vn7f3VHDqIuEe71bokDrXxVYqAizlBSj
 66N+cYl/w8crXlVRAV5wdpVvl+YP/nkkciwSXVAv9VnRQBKpCs1bK0sxkhu48L8dnRuR6Jj
 F7L02bgE2uVyD3Jzt4fnw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l6e7aj+YOMk=:X7JD1P8PgpXnvPEfW1D4N2
 coaGJcNMGMM0VPIJtauGIZQpMe443QNoZ795tDuHoDRhHIUKGA0KpqHTbsRrgtlgh1MffpBGI
 e8X0hYyHvm8damWTNP3RyqKz2dTlqc9Qzh9XPmP3Ap7QbGzSUhbcM2SFR0K49WZLJlRIZPBgK
 s9aP47RDv351hQqSY7wP5qMqSDbNnaFqScmC778RCPDWs2I5BWy3fRtjJSEvPK3EwC1F2WwlA
 3kPcw7OEWsBoMYEw5zjOA66UzfRSosLwVM0Rf/Gyf4BrEeZgiB0u/8Tp9IoN7MqS/brPyMhwh
 fSF6mjH34QquCTbbjZY6LCQSnXfBddjAtgtToihcgfC9MxXE+MELhjfpPdfUCdMIvu9GBOrAN
 JJMGfDZBourwxwltHtSmZ4jOcg7HEQXJjjuRDKVg8jYlYKon+5pSE6A16ppUwPAreHtSRAACj
 MiCst7Gpaba0RQV6aOj6MK8tqt5w1NusoWFlr7D8l+0RP4Nb+i1E+6TrkZGiUcvXWaA4mE/UE
 BqkpMC4Ylk8eFvtGFuIiC7IAkj6jSwWpwKXoLqGjQzg34Zt2YcmjhbXnOGqVCUgQityWyoZCO
 FfIxcq7+vZ5ayPLRxqlKnf4PPMer3qxE5eTrgsDeBhnrcqCjTCjCS1VW+FxSuOjiwPgn+8lNz
 ESUHAcHVeKU85xIvYmxZ5JPDhj1GNi2DK4088aZBfLAWfBStR2q+0sNDp0R9Hy6OlyCn8trWA
 GiQhAOGfu1FzWlqFwTmjHo6T2CeEvzEoJ55KSlHRbTdwTMlsBPRzKN0nz/c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin venit, vidit, dixit 15.09.2017 00:21:
> Hi Michael,
> 
> On Thu, 14 Sep 2017, Michael J Gruber wrote:
> 
>> test-lib determines whether a file-system supports FIFOs and needs to do
>> special casing for CYGWIN and MINGW. This separates those system
>> specific settings from those at more central place.
>>
>> Set mkfifo()  to false in the central system specific place so that the
>> same test works everywhere.
> 
> The mkfifo() emulation of Cygwin seems to work, no? I think it works even
> in MSYS2, but not in MINGW.
> 
> So maybe this patch should affect only the MINGW arm?

I only reorganised the code, so in that sense the patch does not affect
any system ;)

If indeed mkfifo works on CYGWIN than a separate patch should remove the
exclusion of CYGWIN; alas, I can't confirm (I wish MS still had the old
academic alliance programme).

Michael
