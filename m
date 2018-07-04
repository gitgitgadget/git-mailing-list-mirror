Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 197B11F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 13:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753203AbeGDNKA (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 09:10:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:60491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753106AbeGDNKA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jul 2018 09:10:00 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4o41-1gJt8E1goX-00yuX0; Wed, 04
 Jul 2018 15:09:51 +0200
Date:   Wed, 4 Jul 2018 15:09:34 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tobias Klauser <tklauser@distanz.ch>
cc:     git@vger.kernel.org, gitster@pobox.com, dana <dana@dana.is>,
        Wink Saville <wink@saville.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH] git-rebase--{interactive,preserve-merges}: fix formatting
 of todo help message
In-Reply-To: <1530706658-20519-1-git-send-email-tklauser@distanz.ch>
Message-ID: <nycvar.QRO.7.76.6.1807041505000.75@tvgsbejvaqbjf.bet>
References: <1530706658-20519-1-git-send-email-tklauser@distanz.ch>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8AJwa48/lB+P1SFwW0oHzWHVAM3em+M00XxRDZ3BbJJeLpLX6TK
 7p68/7zrkRQCF3Kh9m+pJi1uX29ag/QqWwgxnWQ9jyRychTnJ64VZt96fMCVPqumi5AURuU
 CfGvAl3SSbSVvtz8A2nys7KO72c5QLcWlKjcZ/X0mMVR7VIk8IM1c9RyFifcU0fyD1QjncE
 NS9awqp0dBUpqwFpvIEgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TVkWJF6O4t0=:CZ5x5i0Jz1yGgbJL6mIWmD
 O9Cjc+R6dULr6C4n1EY/uGAQfyezxvS0yccnADQivJao+z1jr4KPvA0tBQ3tr6EhSNCLGWJmw
 i7L4KgA8RvNgfey+pBRvx2vKGcmhU6xZO69mzSwdqMn/ARQ11iaWBbKj003b8+CYg8LAe2+ve
 lY5UAtWsSSENEOk5y9GxlOT+k1MGttw5zIjlA8Yv60IxzRxpRYHDnfiSFN3//0Itqwipvdg74
 QlyFNSwvYxdFChla0SKW3v7uP2kjVUweLwauUH959pB2fwYx6Ka6mWU00tSv1CbJTj/TBhZ5x
 m/SNvCGToPDRZsj5pTHCjKw9VlbWGBsS9XKxc2yXqEu2JWjtU8ctDUGkwmkNjL4Ikb5NrOKzJ
 3YNhxnf0FEgu8eGh8Ykqxt0Lnd//ue1gBD0Ompb/acL8qH5VGa/y6MS8wwlWRRRi+svgzG51O
 cPm0i+i4Yf9JBIHN3f0L2Pznlcapx7GN3QK8CdS8/DYBibIyCY4K9tWlVnlnBp/h56xwhGgRK
 2VqO443eJZmWE2dx/fJlTJBQxFhWVlKPX7SAm1Oqc5xr2UR5RjOCW3db/7wKVmVbeVq76CpqR
 HFOWSIE4IJDy2FI4cdbHzPNouOQsA7875XiZmnOj1xX0/UQmeuvBVr9RKjeSCL1AHLF7DMFtF
 u0asuCsV+qFj2WkW8pNttgmrHt9QjNVQPfEfFt+H8UcVrMczCg2Nkcwl4ep5/oYvX5H/IdxnQ
 0G8JKGr3r9XIzFQHGeE/1dz0nYgTilHC8PIW9VwgCzpnDS0DQetkudJeSObTsRJW8K8M8zonG
 s7RLCKM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tobias,

On Wed, 4 Jul 2018, Tobias Klauser wrote:

> Part of the todo help message in git-rebase--interactive.sh and
> git-rebase--preserve-merges.sh is unnecessarily indented, making the
> message look weird:
> 
>   # These lines can be re-ordered; they are executed from top to bottom.
>   #
>   # If you remove a line here THAT COMMIT WILL BE LOST.
>   #
>   #       However, if you remove everything, the rebase will be aborted.
>   #
>   #
>   # Note that empty commits are commented out
> 
> Remove the extra lines and trailing indent to make it look as follows:
> 
>   # These lines can be re-ordered; they are executed from top to bottom.
>   #
>   # If you remove a line here THAT COMMIT WILL BE LOST.
>   #
>   # However, if you remove everything, the rebase will be aborted.
>   #
>   # Note that empty commits are commented out
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Thank you for this contribution!

Funnily enough, the same fix had been provided here:
https://public-inbox.org/git/614F0C12-7173-48BD-9212-71AD6FBBDAA7@dana.is/
although only for `git-rebase--interactive.sh`.

In that thread, we agreed that it overlaps too much with a GSoC project,
and that that project already addresses the same problem by way of
rewriting that part in C (and therefore we decided it would be better to
go with those patches).

However, your patch also covers this:

>  git-rebase--preserve-merges.sh | 4 ++--

I completely missed that in the earlier patch.

Junio, this gets an ACK from me, could you apply the
`git-rebase--preserve-merges.sh` part selectively, please?

Ciao,
Johannes
