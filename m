Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A964A2055E
	for <e@80x24.org>; Wed, 25 Oct 2017 20:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbdJYUj0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 16:39:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:54046 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751775AbdJYUjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 16:39:25 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgpmG-1dlNCA1ycq-00M055; Wed, 25
 Oct 2017 22:39:18 +0200
Date:   Wed, 25 Oct 2017 22:39:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Heiko Voigt <hvoigt@hvoigt.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] status: do not get confused by submodules in excluded
 directories
In-Reply-To: <20171025140414.GA1368@book.hvoigt.net>
Message-ID: <alpine.DEB.2.21.1.1710252238390.6482@virtualbox>
References: <244d71f47336e985ae265573b7d523cd8b3943bd.1508244305.git.johannes.schindelin@gmx.de> <xmqqo9oxkts6.fsf@gitster.mtv.corp.google.com> <20171024121536.GA88363@book.hvoigt.net> <xmqqh8uoj9s6.fsf@gitster.mtv.corp.google.com>
 <20171025140414.GA1368@book.hvoigt.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KBdRkAqj5OQnGNHnLuI8vH+x5e3TKEFg43+1xQCRsPDAYdyFA4z
 dtTVlCd5d+IACniauWvjhKUDMIcRhTx6Ij3RVuabM2jPmViMIQXxZyfWGzWUyjsqsk4abTg
 P3Z/kkhG7KdCdyg18uX7iLvCzeTZxleTl2Fl37DH/ZTWj1taZpbS+BAfY54P2k7TCzTdRxl
 +GZTnWnGbvK91Gl6/8qGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AanC5H10L/4=:fODarZALo6S5rfuwZ1zS4r
 0iRvicAiEhWFU4sAInDj73reU06KB0bpjxG6DBz3g7jkfLfAebIveNQA1sucr868J2KtHP4kK
 KIPAL9at4M3cZNyciDwYSBoGsX81XxbA0olxKwVyIY7lr3nIaAyLiOBpg2EXZw3gooDLdkxHb
 X9ztQJ+AMjukkZm4PqvIQaLk2kWkixblsWs+aYKM/EGhKovoWlRdTPceygV2rh2HITMkmGb/3
 aQpsCINM75YqHpXFCnsONxxxNiUY/hsbpJpGsoKdni2AU/HdSVTfJDpVWlI5R4XyYM8efHLGN
 yvx9yOWu1YK9PuPXC+vX+qrTVZpOxLVFw7xnfN4tgUVJZ8jqODk0cnoZV+t2y0M4BpLW0zO41
 s+jV2FkOdXu48LULKzZa9bgB9Pq4YUZzvo7jaNMi83W58agHwac7MXhXxFcQtHlULzu/8kDOt
 G5XmBQrTcT21Wg409igL+3aaAjOcBosCNDbdiOTm+HdAXLtK02ltwfKH01Z71hkrKIXdv8QU8
 bvgNZeY3VL7ZaeeFvXT4N9t0f3itNqJZqEhX+2b1UrStXT23ff60qJ3lqN0yPVr0G8sNUiQyw
 0QBzng4Fw5/tAA8I6nk8sxdefcooGvadHwQUWB7/XMCI392Xv0aOx9gw3nDmM/agUELYpI5X3
 ve0DPE7tKOj67raHZr0z70i/Wwqsd8ULj3DICWFkIuqKPUZsHRI7UJWfMHfMDjgmCy0kpY316
 3tTJxBlbMr0O3otGxj+e0IYaudxHQmtQIi0SMDwXhtznOyvCvdx3sNVLIHO2N74KtNgNfy+tY
 PL9YOj0r08iIrALFtSdFJp9P359UN2n2OcszDmRoFQCj2DRw7i/XJTl2tCLjGKKMJ8SdhGS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 25 Oct 2017, Heiko Voigt wrote:

> On Wed, Oct 25, 2017 at 10:28:25AM +0900, Junio C Hamano wrote:
> > Heiko Voigt <hvoigt@hvoigt.net> writes:
> > 
> > > On Tue, Oct 24, 2017 at 02:18:49PM +0900, Junio C Hamano wrote:
> > >> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> > >> 
> > >> > We meticulously pass the `exclude` flag to the `treat_directory()`
> > >> > function so that we can indicate that files in it are excluded rather
> > >> > than untracked when recursing.
> > >> >
> > >> > But we did not yet treat submodules the same way.
> > >> 
> > >> ... "because of that, we ended up showing <<what incorrect result in
> > >> what situation>>" would be a nice thing to have here, so that it can
> > >> be copied to the release notes for the bugfix.  
> > >
> > > Yes I agree that would be nice here. It was not immediately obvious that
> > > this only applies when using both flags: -u and --ignored.
> > 
> > Does any of you care to fill in the <<blanks above>> then? ;-)
> 
> How about:
> 
> Because of that, we ended up showing the submodule as untracked and its
> content as ignored files when using the --ignored and -u flags with git
> status.
> 
> ? But maybe Dscho also has some more information to add about his
> situation?

He has... as part of v2, a substantially more detailed commit message will
reach your inbox Real Soon Now.

Ciao,
Dscho
