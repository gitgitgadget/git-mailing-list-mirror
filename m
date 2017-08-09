Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4B2208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 21:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbdHIVfK (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 17:35:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:62604 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751958AbdHIVfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 17:35:09 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LrvWY-1dV7uD393e-013eCn; Wed, 09
 Aug 2017 23:34:55 +0200
Date:   Wed, 9 Aug 2017 23:34:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     gitster@pobox.com, git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH] t1200: remove t1200-tutorial.sh
In-Reply-To: <20170809212253.27597-1-sbeller@google.com>
Message-ID: <alpine.DEB.2.21.1.1708092334420.11175@virtualbox>
References: <xmqqh8xh8fcb.fsf@gitster.mtv.corp.google.com> <20170809212253.27597-1-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wR5zWcIztmxCmO2pv8dKxT+72n3ToeWbFlW29cweRQJL6bV2921
 Tg1ZEJGyVU5sC9R+E7COP8BTF+D53mbHScfXS+Y/oVpiaFQbCRaWW4YxH7X/Rea3UEPoFQu
 /P/h4nL3lJdjNpxLO3rVgjGSfw9gxAgOTzcryTMppJewXakyIyeX4gFOZ6dpgOL7mfVyOGT
 uUvU6rSwEUNYli326QBJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gUmoZ9lpgls=:L/KIi2V10PAqZXb6hSD/sS
 JiX2G5IhL6dUFJcrJaCki9sa33u67zgSFfva0pWgW6mW5ahVIQm0C/teVUeNuG5xNACcSU7vt
 roLeXZYqnitbd/dH2w4MirwY/Izh8iPy1geAxsnhFLI/H27HwVsObdhmnUeklMmTO82mok8AU
 rHGQUn9k0sd1ZJU6OzXwbKPtKwYE4+kJEaOiupYoSvRx0IcB+Q29SjRu7ChguquoDQ3bqM0Jv
 6w7crhJNxdM3eMU7Uw6luB/Lx+cdB3C92B5Ctc8ka3hwn5JuK7iEsBTXPFewsKtNG23muA8AQ
 thv4EuhmeXr/QBfJ0blwjVqv3f8ZP+kt6ujL7bRAcrlsIn1vF8my9X/ItIAaGELC0yboGEBmv
 sXuBsorQJEYPrWmCmFIWzYxQbuCas4/Ii70EmZ4goGrWvsp5vU9ibrBe4FZunFdnOJg6noe0a
 HW/Ry9sTzoxTNNStQAPlaBzG+x3t7zG0167xrC1FVy2/mIpkNDgSNyBH33CSt+5rifLmrf/w1
 jY9KvlkxZWJgG0T4cYOn+cQpqCpgH1bFS7QmmOlIpINZ0c/zzUb2ivR4xXPjJq8NoV8JAEM+I
 Kb0m6iTvIw9DrKnYxq0kZwAZPIR0Fc6OY7fjUT3nz3s9/BrrZYQAdw/fNPLKDVxkUcUy5JuON
 JucWkT94BpC+byLEPiI1T08WDTaYs9aT3JIuhpnXd95TGvBusARDpjEhEjmaJnOvZrGgQ2W2C
 6jEoxLTetHKj8RX8TBTxP7T1yGXnxOr3MS+jxzJYs0a1hnf4CCbcUvyh2bvC6QCaf7BWoeUe0
 VQQVf1jsV+c06zx5fnNcBmHUJYRInP29zJ84Invbe0xAGF2Lqw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 9 Aug 2017, Stefan Beller wrote:

> v1.2.0~121 (New tutorial, 2006-01-22) rewrote the tutorial such that the
> original intent of 2ae6c70674 (Adapt tutorial to cygwin and add test case,
> 2005-10-13) to test the examples from the tutorial doesn't hold any more.
> 
> There are dedicated tests for the commands used, even "git whatchanged",
> such that removing these tests doesn't seem like a reduction in test
> coverage.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

ACK,
Dscho
