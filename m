Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A87082070C
	for <e@80x24.org>; Wed,  6 Jul 2016 15:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922AbcGFPcx (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 11:32:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:58854 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754070AbcGFPcx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 11:32:53 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MgtWa-1ayuFB2Krw-00M4Xm; Wed, 06 Jul 2016 17:32:46
 +0200
Date:	Wed, 6 Jul 2016 17:32:42 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2016, #01; Fri, 1)
In-Reply-To: <xmqqinwivng4.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607061732070.6426@virtualbox>
References: <xmqqmvm0vry4.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607021306320.12947@virtualbox> <xmqqinwivng4.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:B6fiDvyvs+eALlLt6w1nxmx3AOiKwEMDCXyng52YJGu5WM50AKf
 PxLWhTf00rNy8IXqz1QyUDCZRTlYsThYJzkYWgvs4Tj/xATgYpZEPNqdGiYsdtaYzgLV628
 UsefxwY2mqr3lK8vuH9FoBgMt1+WxRNa+gaua3p7xYspObOouoo0VFuXNPYVyYUm1riz9fT
 ORIjvi1rS3SJ7A7lum/1g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:kb/I0bv0+r8=:sm6XvQkmnN0TbmDwGSyVIj
 Y3lYqWHnjGmVhnt5xoPv1O+yRJQ3Sh1KjKyntJc8UkuTMdt/DpE+UV6j0J8bZR9wiqI4NbrDQ
 vqgDTaUlSRD8ynwSQXhoiHQI2yEOfSXSRl6Kikw0fgk1lk+09x4hYYOKFHJ5ahbhjwxSRr7eX
 61KffoF1fG31u6GP4JNswjLB97md0A2g59+xKwB+7HwmownU29HaRKkSHsi96wIVUEVcNDEUF
 nlGYyd/UAS6KZtovn+X4042cTx6ulzdJ6PYUHb8okzt43pMlLgXhsLWweCvQY1tD91Hf8qazF
 +ocXLR1uV8AtYbHd9yuijJe+YnIOkbbP3Vny+awXAT/EcpMEj5ykVeAkEsTutfivHfZhd8AcE
 +A4cICAE1ipLviyYd/qUE9N8NA98LHoRAGdOK74KnYlN/4Au32Yg/dOmAXN+is6UgL5xZFrah
 L8PLFFNU2HXzPleJ5wENq0qi98bSl2cWtptxhg0wtQJV6wkkK+JUBS9V7V/1N/q1zXdBAtclX
 4rZZtix2k+JZB0UbsVX/Hpcub2M6da2945BgllAPjWq9LwuIimImogT9T7aLVb0V6kiVb19W1
 Pl9YCO5eM7i3oFS+LN7hDXI/RZtHulDnTVrkkykYoifVQIn5RIYoykoW2Y4J7P266izrk/E6g
 2bzo+Kk2mFcfc2582ByqMBqd5alGWkk2kUKOLowLB67gy5A/E8rMpH4nQ9fp+WK+PhxYjxW+s
 jtnBSEYlSJaFDBqgzMCqNBl5BUZp/FKIm430AGgC2ZH++8eDl71GFj2NJ5O6AgQzf3kDpT/Bg
 /o6PYVZ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 6 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 1 Jul 2016, Junio C Hamano wrote:
> >
> >> * jc/t2300-setup (2016-06-22) 1 commit
> >>   (merged to 'next' on 2016-06-28 at 62b902a)
> >>  + t2300: "git --exec-path" is not usable in $PATH on Windows as-is
> >> 
> >>  Portability fix for Windows.
> >> 
> >>  Will merge to 'master'.
> >
> > Would you mind cherry-picking this onto `maint`, too? I just noticed
> > that the test suite does not pass here because `maint` has fe17fc0
> > (t2300: run git-sh-setup in an environment that better mimics the real
> > life, 2016-06-01).
> 
> s/cherry-pick/merge/;
> 
> You'd notice I was prepared if you did "git log maint..jc/t2300-setup" ;-)

I missed that ;-)

> > While at it, it would be nice if this patch:
> >
> >> * js/mingw-parameter-less-c-functions (2016-06-20) 1 commit
> >>   (merged to 'next' on 2016-06-28 at e673c65)
> >>  + mingw: let the build succeed with DEVELOPER=1
> >> 
> >>  Some platform-specific code had non-ANSI strict declarations of C
> >>  functions that do not take any parameters, which has been
> >>  corrected.
> >> 
> >>  Will merge to 'master'.
> >
> > ... also found its way into maint; This would make it easier for me to
> > backport fixes (as I started to rely on DEVELOPER=1 to warn about issues).
> 
> Likewise.
> 
> I'm sure I'll forget, so if you can please remind me a few weeks
> after these are merged to 'master'.

I am sure I will forget, too, but I'll try my best not to!

Thanks,
Dscho
