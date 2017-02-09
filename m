Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E782C1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 22:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753980AbdBIWkG (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 17:40:06 -0500
Received: from mout.gmx.net ([212.227.15.18]:65373 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752817AbdBIWkF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 17:40:05 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSutp-1d1Q3r31pV-00Rs9P; Thu, 09
 Feb 2017 23:32:26 +0100
Date:   Thu, 9 Feb 2017 23:32:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2017, #02; Mon, 6)
In-Reply-To: <xmqqk28znhtx.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702092329440.3496@virtualbox>
References: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702091319350.3496@virtualbox> <xmqqfujns2li.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702092135050.3496@virtualbox> <xmqqk28znhtx.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7ujqL3ZYPaLjZUE8OiCv98V1TxH6Gg0yIazz71ku0FnpnEj7Wyl
 jh0/McvxRJJabDWwn3ZLpug5GYSBuiJYadFCHtUoDufp6IM4UGjFV+cmUbFJicmWCVFe4xC
 M0WoRYvjeI//SAT6UTDYp5A6/MyRw0I2rFb5Rriv6ImP9P9mY09GRhXc6+CJL9ucuJYCmr4
 Togv7pEO9lIH62ww8kN5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aWb5BhUty0E=:7ntg/a3sUDTUt7TlhBjLRd
 eRta8euR0fgGYg9tyz+7n7MUVYzl3KEAA+PvI26BJvpn87dfS8OWPPI8yv2hcBiWUK0Tf5MTj
 uqjB+dgbBjT0v6xkDDVS7Vwa8QA6BMuFzaQ5s2W30SR8MSQwrQ6pLIupHmFeNZB5OgMgyyrXE
 fnnMug1CePWfaw89RRZJwDD+nYvpZl6Ict64YZi6898aD9j3Kv3xIXFJQggyVDY9kJNEJ+c/i
 o/Mr4ucWQ/10aGPLw3McRd0EFtV5A4IDFFq5WxFBKThWDiTvjzhcJt7MUb1NqpngJxRamIqHr
 IyoEORyruG8bfj798XKKDZ4Nxc88ddE+ACF3tMDcLa27Q7Y0+evzkqCbCstj89W7OU+sBMWGE
 +32yiRQ9h+51Od7djc512VvKAE3vUn6mWgyih2gzoFdiOcFywAkR48TrN5jYzaPh5kZodbpbZ
 0VlgQ5vmadhRQvzkH3UaZWHGFyy9M8CKQL4s+eUtBSzAaTNyGriRjQBCI4GoGVEm33ItnCqYo
 rD4lFDSvZIG1qveQJdcqj+DrpmwzPL/B2TUB72dYDcPPI9X0CL78RVbdmUptJZCx/J1a+JMuM
 /4HBDATi4IEn1UThH4RBrXxfOXKMgMD/gIig1kHABSZHtXBR6NbZMPhKZa++XUFqQn5ld/TRq
 fnOONwOkTO331s4/En6dv2PM1t/JReTYAx9HZdVxv/ikPg2fLOIZOquW4zv2Vn0b1yyw6GVo8
 +bXq5nXt+Qz+mE3vhpqZ8cr33Mm65zhMnh4kSSjOkrbW0oDbIrlQoVUVw46kkliJGXX3b5Rev
 OUZADir
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,


On Thu, 9 Feb 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > ... and even go so far as calling your patch reverting my refactoring
> > a hot-fix, why don't you just go ahead and merge the result over my
> > objections?
> 
> At this point, you are simply being silly.

How is it that this patch cannot be applied when, and if, that
hypothetical config setting is introduced?

Maybe I am dense here, but I would really like to know why this
preparatory patch must be applied *now*, when there is nothing to prepare
for.

> Isn't "Putty is not a command but is also handled as if it is a valid
> implementation of SSH" a bug?

If you think it is a bug to handle an ssh command called "putty" as if it
were plink, sure. I do not think there is a valid use case, but hey.

Ciao,
Johannes
