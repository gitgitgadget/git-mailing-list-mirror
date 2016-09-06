Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46A11F859
	for <e@80x24.org>; Tue,  6 Sep 2016 16:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964883AbcIFQmd (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 12:42:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:57765 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934789AbcIFQma (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 12:42:30 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MBVwM-1boQyu2fVG-00AWhQ; Tue, 06 Sep 2016 18:42:22
 +0200
Date:   Tue, 6 Sep 2016 18:42:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael J Gruber <git@drmicha.warpmail.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gpg-interface: reflect stderr to stderr
In-Reply-To: <alpine.DEB.2.20.1609061827290.129229@virtualbox>
Message-ID: <alpine.DEB.2.20.1609061839370.129229@virtualbox>
References: <ced7502d-0095-bd90-19e3-c14d0e4d4f07@drmicha.warpmail.net> <18a7e2984121d988137c135ec560fee56506981b.1473167263.git.git@drmicha.warpmail.net> <alpine.DEB.2.20.1609061827290.129229@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gXHC7l35lCVT8fzfPqFcJhDcaBohBaaYKgvZ9gArlygNFbLzL0I
 UaKR5cFz9bra4Qut6Ao72AmQ7W7JseMirlXM4oG/i4n02qpB56M7TgBLgxb9hQ0X0DlHXuR
 ZEQn+G0WyceMUx7FRIGpQQk3MQ4KraF4F2vUvTGq5BWBkAtjqIulP6OWI/hMxXl5FVAO5Tt
 1tNM0NFzvnVkAUbx2Kj9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:teDQw4dWQ8M=:nYPc0Vroqu1Tcbtfd+eq7b
 0CCycGDcHdCUsLcdbk4wfFS0+94RwMrnZnFkOZiAKPvRixwhYBsDtSMSMP8myB08xG0rkTBV6
 Qo+qVPNl00RNKgQmFjJrema3QR8irjUnhGs4Gr1+LTeHy6eocQNG0yuv+KXkPR+HC7jGb5i8n
 RYdE5+XW3kuVAlcAaUrBgsNM9Ipb3HZBaMSsxFa6wEB5LIb21eJziIc8QqDQA/7IIFT+TAQIx
 51AcFPJQt70K2N/Btb/e+KgWwzgrHXurJ8bXv+fVR4BoaWqnLYBMPaTQXFQlxpIV/j8+64WlT
 6H+8aGEmr/wjB/KJ1Vxr/xd3gZLC9bJWRXT6OHqMpQKtqTQ7V01qbqYNvSSZdm+KDQh4qAbSO
 XAV4BlKsoicTk9dk2NtEhhEBII05NPnLxMoU7gqrTi+dVgW9xXIstuqk+4dDKAuLJOHcGHjBC
 2FvRQhq0/qi4C0P8G1wYX6Hje3KA7rKddl6euVDZu5/4oe6ZGefkpnGPsIF48yxunCDV4UuML
 JEgnGDaNFQRx6IHhcowpwP8Fm2Wkd8mI7oA5UciIYR3K8BcsVQUPAKVGETfjaS2gw0ItTyEb9
 2ul8R5apPNiwCHlU/icxeC9+ObBVdr9RRcUBc3y5w/19NMIAxrEB4+HEvPYofNqPkU/M4mdIc
 S+KgfzkF4hZ/VCvKZNLRhLuI02JoQS22d0IUCD4H0KXNqcH4J4MIqAZ9pFt13cQbEjy06w2kC
 uBcHDU23XWwNFNjBnFxjo2zzpqG2emWskjoK0x6XylC/u3WhtRnq6GgsJXE/Wt2oCazQLBNYJ
 TpHoRK/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Tue, 6 Sep 2016, Johannes Schindelin wrote:

> On Tue, 6 Sep 2016, Michael J Gruber wrote:
> 
> > A full blown approach would use --status-fd=4 or such rather than hijacking stderr.
> > This would require an extension of pipe_command() etc. to handle yet another fd.

For the record: I do not know whether that would work, either. So unless
we are fairly certain that it *would* work, I'd rather not spend the time.

Your original issue seemed to be that the gpg command could succeed, but
still no signature be seen. There *must* be a way to test whether the
called program added a signature, simply by testing whether *any*
characters were written.

And if characters were written that were not actually a GPG signature,
maybe the enterprisey user who configured the gpg command to be her magic
script actually meant something else than a GPG signature to be added?

Ciao,
Dscho
