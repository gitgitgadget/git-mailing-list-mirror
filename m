Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 813631FDEA
	for <e@80x24.org>; Mon,  8 May 2017 10:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754297AbdEHKtn (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 06:49:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:63250 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754243AbdEHKtm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 06:49:42 -0400
Received: from virtualbox ([95.208.59.245]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIdTM-1d9s5o0iM4-002GVI; Mon, 08
 May 2017 12:49:36 +0200
Date:   Mon, 8 May 2017 12:49:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] Abide by our own rules regarding line endings
In-Reply-To: <xmqqd1bldyke.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705081248020.146734@virtualbox>
References: <cover.1493728172.git.johannes.schindelin@gmx.de> <xmqqpofp9p1r.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1705041129170.4905@virtualbox> <xmqq60hgacjp.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1705042038150.4905@virtualbox>
 <xmqqd1bldyke.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:91duxnIo01XGUntsUewZUXXcxoaoAxf43VF8lT11a1AD/cSo4pi
 j9rqzNzZ7ovSjnnBAE0FYLb+P4sl8SOxzfhkyXggv0UvCWuQjd9FX50um1mA2cg/vG/wD88
 411sQI3eUQihclVXe83QO5YyemXvo3g/u79FTe3+LBmUhGyD81Fyiqaoh5qm0O19k6nAjAk
 81ftyvkv46BP/GafJ38nw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VKt2LNxR8Pw=:0hXC8fGb4CACTkkZMRbvzW
 kWtKbLW89hBH6ba0ukHH8lbFeLVYaPmosNhCYaezN9t/3+odW07and5KliOlpfwAqQxn3Xmp3
 D2j5/idXt+806u/AUc2NA1nD1GdQPpv/Knyjv1h3hikz6ubtAGc5KVlPovINpMSzq6RLhzdp2
 IBo+P+WEpR+2IARUTKcx0XQCyq8ZY5sNZ/ELM1Y8mOB5cjPRFA+zUGS083jZN5XRhtWjTOkJq
 gVlK0kD2LAU5bxG7a/CbFNjd7GyRssYKsvB/tlRPbaIyj+uj+6ZnMQ2JkTKx0OkeH0erObDZA
 a5H5+EnvZvfTGrGvYz8Nt97z9EePFEh8EC0IY1dWomKRGWpE4T1c584W/srfQLKd7K5b/PDCc
 mQgk1Ph6SiMVG4nLjEFyFxlVDoTbrp1aA6ftKGY+BkqS8j2H0PCKqS1F1wYv1N4HigzRJb69F
 qBCGjLlE9i46+4THtq0gXgS4BJbCDtL0DN67KkH/DR/+zsDmSu7AU2aREK9L3BLbSuUdIxs4B
 GsOG/hkI6pw9rBQ1OftTpghSWjU7OGL+3pCx/DrMSMWAZZPNpE5sIlMH8kkVWgAyF+xo5Ydnh
 EPMn95ArTHqj11DanabH4O5ajM7VWvxzQL6t3YlVTcVU6cy4eJNCW+zYPretBIyq4QZ2RWzk9
 fICkC8zazm+1vkFH+HvRfmCWHGEx/zPbUdRNAwC/x8JbXjGWsRvMGifMnyUkR1mt7o6txGJKf
 dKzy1saD0OCuHiaupSiH5aIyF3OG0sO+8rYVTVEd3aZL2u2Y8MDeofX0kJwYTXDnKLoQIEF/6
 mc0Ql4h
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 7 May 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Let me repeat myself:
> 
> Don't.

I had to. You did not understand me.

> Instead, read through what you are responding to the end before start
> typing a byte.  In case you didn't do that, in the end I agree with the
> direction of the series ;-).

And I am still convinced that you do not understand me. At least on the
point that I tried to repeat in a different way, in an attempt to help you
to understand me.

What makes me so convinced that you do not understand me? The part of your
mail that you assumed I did not read. (Disclaimer: I did read it.)

Ciao,
Dscho
