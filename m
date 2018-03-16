Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07BEA1F42D
	for <e@80x24.org>; Fri, 16 Mar 2018 11:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeCPLvj (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 07:51:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:57715 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751437AbeCPLvi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 07:51:38 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1W5x-1eceRM1DyL-00tXa9; Fri, 16
 Mar 2018 12:51:21 +0100
Date:   Fri, 16 Mar 2018 12:50:59 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        peff@peff.net, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 00/14] Serialized Git Commit Graph
In-Reply-To: <xmqq37115ggs.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803161249060.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com> <20180314192736.70602-1-dstolee@microsoft.com> <xmqq605yz8ue.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803151821270.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <xmqq37115ggs.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+XFhbNt9MWm/QOzozaxcfh00VTRXzWgEyX+4N1+QMj5+EcdyPn7
 2Hzft0WzRD+7c1iPpDqfVrCWZRYmnEP0fu+RZ/Af56EeJMoFG7hFv25FWYVZ8c6wEPMUnm+
 DgQgd7J0H7JJzthVS+CvZPWJebkTmYparWHViahG0flxewux11LQve+58dMhF8/tgZCwRDI
 yjgmGv3h1PWiCifAn0ISw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F/hOqvqNGf8=:KOzltejCE35TD6Vsvu4RJV
 2O1Xsj5AnB+I1eclHIwsGw3UqonJXXC3uDKn936T8tRgao6gDG8XrP8ygMsrJQUs+tWZzTgpZ
 OAob0E+caotSnzzuftx1NRx23EpbQ1juslv/czfrCZQhpWN3kin/I51s9PZaXJAPU3ST5gZyt
 XYdMzrEOLqf5wWZp0FEHHclJ4CAIF2xpGdFK13NAuaxvqTh5g3Hj4I4sZS+wv9nBuXem+W9JL
 dQ3zVStn2T/z5bon3ABSitCfOoGfmThM/EeMEz0/6Cp9z1kT3Jr/mSdm88aFExDO+agLuNplE
 Nr7MYiMomGlbuN/fXVkSOMu/o7dfZn/WkPmVWNRTBsOiYnQdn3OrvQmy5fgZ07my2z2GqYiqb
 ZWmYB9cFiyLgI7tbM380m8o0rHQic6yYJJm8Shq8JAl+VZh2ATtA1DSp2P9hNls+i+BQ0/gNl
 LFVhvue3eCbva3ujkB0jPpCTybD1fmVoyXfbGZAcdOF/rOEOmUY6KSsTzY7rG1n5HNmTU0Bbe
 Z5GwC+5f23sC3mghZkDIUoTIgpMdL16in8Y2nm9MvugDYroS8fJRJ1etNt+/TXYqRiqrTu1Ag
 T1fCvgfKMCKlLsjQPi50W0mxb0vag+LonLqBA09t4Xl8PXYJ/toaZLSU9tXTZVRpXFHAnoDrL
 s1Ae9aRmuSW3anE4nPQzPpyEoFUkvbVpGZsSfqS6m5sHRCPF5pUVag4pRvUtKD7Un2MxGlnfS
 4CJNRCW1pN/DBLAVb2uzkKujfvIINkRX8dDghiCNx5R39I72Bi788wtiQB2fSUM+B2lN4Mv46
 fClRW99Ieecx4TaQHbq9Jk6iHcIbnelXBgIAwHzK9FanTMRemY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 15 Mar 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Stolee, you definitely want to inspect those changes (`git log --check`
> > was introduced to show you whitespace problems). If all of those
> > whitespace issues are unintentional, you can fix them using `git rebase
> > --whitespace=fix` in the most efficient way.
> 
> Another way that may be easier (depending on the way Derrick works)
> is to fetch from me and start working from there, as if they were
> the last set of commits that were sent to the list.  "git log
> --first-parent --oneline master..pu" would show where the tip of the
> topic is.

That is not really easier. We had that discussion before. Stolee would
have to remove your Signed-off-by: lines *manually*.

I understand that it is a trade-off between time you have to spend and
that others have to spend, and since you do not scale, that trade-off has
to be in your favor.

My hope is that we will eventually collaborate more effectively using Git
itself, then those trade-offs will become a lot less involved because the
overall cost will be a lot smaller.

Ciao,
Dscho
