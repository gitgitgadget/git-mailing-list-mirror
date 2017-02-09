Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DA941FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 20:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753433AbdBIUiE (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 15:38:04 -0500
Received: from mout.gmx.net ([212.227.15.15]:62509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752432AbdBIUiA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 15:38:00 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MKYLf-1cbecA1MJT-0022TF; Thu, 09
 Feb 2017 21:37:05 +0100
Date:   Thu, 9 Feb 2017 21:37:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2017, #02; Mon, 6)
In-Reply-To: <xmqqfujns2li.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702092135050.3496@virtualbox>
References: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702091319350.3496@virtualbox> <xmqqfujns2li.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:riy/cV1v/avmkyMj/ms8TarpSZ7wFtpl9f+0u6aRiIhkBrfvoFs
 Opr62PrO1YzrOfKa5uZNdJsL4GB+jTrd6/uSi+qJNdEh0Pi4a8vQdShBMC04/JBbQfosS0l
 JlQjCtszpU/HCS2zydsTow9cQvnjMZ3rCAIEzV1P2aP0mA1rkE7wuinUg2CJs6VkpYKvZXD
 5+h7lOBn+0Ful/CJmlznA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1Zfn+6Pjk3A=:eMEBUsMedlHBau0qkhY9M+
 pkMm33NDvZunyDFWT6wkH1+glBpx95L1NJ027ZVthsTTP4IMLQNmdTtVRnPAFwGXwiBe/oiU8
 p5I2kVIErjWXRN4VOShmmux0lQats/yt4Vw00KPkGHGVA3efz3a1fJEFTC5y2bcRbET4K6rrA
 O27jJ/cE06G6S2T+Yww4ERn9pQ2VK7ZRxPc8Z1Qh3VpHiJCKYWWI14+pqDYRV6YN6w/bNyCvN
 fon81w82gwA6xshCzGba1YqAXDwW5TQeeVFPC4Y4ed7GLWqVrCa30vMUeJEIVhVPTmi/+0ND0
 JhbMLUiOT6EKljJblgfjW/rtGB2yKS4x8P/+VOLcdHBCbI4CRZeYVtPqOZpwbcYlvfobzrPHl
 WTOAguthUwTJq1vPv81ENlx0PJks+3VSVWNqaIxFcDWUsB9qzKF38y9QekfWvt6pZ2QZ3xayP
 m4fWLLndkx+lOZiUPmLOepzt/v7gFUUpXkmoDNRk/0TzXah2LgDwPxp/RijFVMf3BgNtbDxrV
 cgIMPnf80kMckmq89XeP2Eya5QUy/TtDgepfnHE4+JTZ+vjfDM1hb/yHKB5Kw+zjSY5fy5TLU
 H6Q7xdM4vVkWt31fUtMMTx6CcW2+juLwUdZQKGYA7ulURM1LYQY7aJ43VnEeqncjdY1KJEmhR
 Dc1mFFQMSn4XUCO6/6akXRnm/cDUl+3c/gJGq6IJv1F+A1CthFCqN+/qu4LogvyWyj/AsckE2
 lfygEVojHzjgyhMIDPS9KkD5KVXq40GtWTYLWvm+k/XqqP3NwwXHyotAhvz2noeRVBcIAiF7l
 sxEZEHz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 9 Feb 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > (And that would have to be handled at a different point, as I had
> > pointed out, so that suggested preparation would most likely not help
> > at all.)
> 
> I did not think "that would have to be handled at a different point"
> is correct at all, if by "a point" you meant "a location in the
> code" [*1*].

Yes, I mean the location in the code.

But since you keep insisting that you are right and I am wrong, and even
go so far as calling your patch reverting my refactoring a hot-fix, why
don't you just go ahead and merge the result over my objections?

Ciao,
Johannes
