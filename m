Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D0671F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 16:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935920AbcIFQa3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 12:30:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:54701 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933333AbcIFQa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 12:30:28 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LzKQf-1b3lP92jDd-014TR3; Tue, 06 Sep 2016 18:30:18
 +0200
Date:   Tue, 6 Sep 2016 18:30:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael J Gruber <git@drmicha.warpmail.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gpg-interface: reflect stderr to stderr
In-Reply-To: <18a7e2984121d988137c135ec560fee56506981b.1473167263.git.git@drmicha.warpmail.net>
Message-ID: <alpine.DEB.2.20.1609061827290.129229@virtualbox>
References: <ced7502d-0095-bd90-19e3-c14d0e4d4f07@drmicha.warpmail.net> <18a7e2984121d988137c135ec560fee56506981b.1473167263.git.git@drmicha.warpmail.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0eGiQteZKnAr5su2c+E2ZnGXK8zlBYodRdZcR34u/d579iJ36+S
 MtGySI+7+xPnC11U4UOk5MvAlsK9nNhgsYIeclmayimlz3eNoEnamnonlYPBOko3MAtO2nT
 SBYsvw+JBTUvP5D1kJne3Q4WnewV6EO4VNeybuCyOy52BD4PmWVv/7w7HeZFWj2LWfPtNHr
 iqxdg7osXQjXTVY8+MZVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1pM8QitmWOo=:wAKe/Wu/aLkWN1q2lAvG4m
 VlS20Z6Ml08RbLxgsdv1yiQU6SjyZun7tlg0eebbHzy0SO4NHguCnr/mj85VajhsuGgwYXggq
 KMTuVnBLr3JaxYeRcgKVrXk7kLdTI1N7GX6uqX7s0cOiI/o1gfk+j8yYp1C5EzH0cjDu/XbGn
 D2hvEH8w4tGN08yNP+uj+st0Fi04er9AXlgV1ek1lHrlIA+l/63rP9/nOMf56qgfqflKyCPgh
 WA5Vc4b665ME4sGLPmMmIM+QUJHajAFkaqpqC4OpSi5Bq+j6uSsEfgy3P8o1o8Iqe2mawyTXw
 UqL+7UEMBUq0Y5LCUVwayP4cvG9YUh/YetKlWv3dc2Fl5I9yviPtVvvjaYWMRJwPcOsq6lJFJ
 ZMS4QDA4AyQiWU2DaseuClvfYYuhnKQgC1T8l9AY+HruBWxwM7uEoJjUEaW2oADihc3RBoJm0
 1saHWzvbLLNlU1QpHbvQeIhiNI7AQJ+CNKegt+xxTdtSWFd2lBPilmpzXyyr+623HceM22DOx
 OC9oFtBPbXcYTjujz7+P9eX8eyt5M+Hfrba+Daz/Ivv2cAmTJYjC+jeQnjTXBiXWmsPoXZoOE
 /ACtY3xJezoKqed/x8zsJM+TVD4XxeDoAidvseozpDdQq93zMhvsj/R37GnjLbTc2oJdFRaLE
 JxCxpcVDR89A77zsPax4RVIz6MsrtiCbvbPISqsF6uccLoos8AVzbauB1ptLOdD6RQ4E0ELum
 V1lS0TgmQxIvL0zcz+Kv7o8rnltMrvVWP9KBiNSneQs2RoYBmXfM41kUYuKt2OK2efPIuVwIf
 tyobdTZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Tue, 6 Sep 2016, Michael J Gruber wrote:

> efee955 ("gpg-interface: check gpg signature creation status",
> 2016-06-17) used stderr to capture gpg's status output, which is the
> only reliable way for status checks. As a side effect, stderr was not
> shown to the user any more.
> 
> In case of a gpg error, reflect the whole captured buffer to stderr.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> A full blown approach would use --status-fd=4 or such rather than hijacking stderr.
> This would require an extension of pipe_command() etc. to handle yet another fd.

As I indicated in my patch, this is not enough on Windows. In fact, my
first version of a patch tried to do exactly what you presented here, and
all it did was make the error message a bit more verbose:

-- snip --
error: gpg failed to sign the data:
[GNUPG:] USERID_HINT <key> Johannes Schindelin <johannes.schindelin@gmx.de>
[GNUPG:] NEED_PASSPHRASE <key> <key2> 1 0
gpg: cannot open tty `no tty': No such file or directory

error: unable to sign the tag
-- snap --

This is not a fix for the issue reported on the Git for Windows, but only
half a fix.

Ciao,
Dscho
