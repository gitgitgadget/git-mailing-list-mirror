Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 843031F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 19:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934650AbeGFTV6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 15:21:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:38415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934389AbeGFTV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 15:21:57 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lz0aC-1gExmZ1bpA-014Dz0; Fri, 06
 Jul 2018 21:21:51 +0200
Date:   Fri, 6 Jul 2018 21:21:35 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Subject: Re: ag/rebase-i-rewrite-todo, was Re: What's cooking in git.git (Jun
 2018, #07; Thu, 28)
In-Reply-To: <xmqq601smexy.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807062117170.75@tvgsbejvaqbjf.bet>
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807031438240.75@tvgsbejvaqbjf.bet> <xmqq601smexy.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PL5/cEnQ5uIED8+CIGFk73NQcuHAsDVJFa9gKPRbNZ5lNGjFIlE
 VRHdlxYuAEXRep6Fke22SZ/zewR3k2yQca6G3XWMAGktSSFdUwc/fUX9irjyi52Kfg2Ee9L
 GQ6svz/vGRcjJABEDMXgBLNRazdKEn5csef72WdyxyWHCMKkf9P84bdtODIf+fkA+seFqw+
 9pAPbbsTAeZaxzXrbIrjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:R8i2+fH5rdY=:1om38R+hChvzdsqWNDaIlV
 BVA9di2Ci4b0jI+iaSSmB/aZD5acW21GcLdFu9TQ0ZoweTr768OwYMP1FuVjNSXLizKlzzAUb
 eT/WsZKTKfZB1vMcZRPgwbB1RE8HhB5C5lC1XQpBuc7hWHP6lgaaV6OKV2XiQSCPpvhRt31VY
 P6Lz5rVuXksBxFXnb7yEQfVus8iBjUrM3orkuq7rkzmz2VA7t1ZVG+DUk/rKzljelrg8ZfJO/
 2q2jvh7uuXR/9OGILS1Bmkt5hDjtOgq2mUOqUEjjEh588ctG4XCysMq/oJDe5kjLjmIiC6kzV
 M0lHMfJoSYAn3F28LqMFuxoRMs9cL1ZVy+ElvBurlOseOfKW/YD9OgDoVIimXz29phX/mXLrG
 g0DX2DpAGWnYgSYcU3eixwbljoYjSPG7DWMh1N6O0m+5lTdlNJiAUN6+djlgNaxk48pQeYQwo
 FghYyv+8DEmOXJ9STbpk1hHYrNB8F0ioG+YWQY0ET3W7C3hfsUSYJNukTrcwdpzqhxZkU6dNQ
 GURCu4w0pFd3Iyq7fS7FHo4FPrVL7I60jhH7bhTKlYB5/4sFbRbGQUc/dn1g1PDlO+1gDRyxd
 v67KfXVP2zWR6oUTDOiBH0i10lrv9EBml+//kllD9clYe2o8mpCVjimB12o559imjLbR41BpK
 whOgKhmO9zHE0JF/9rEn1ttAqOP/H+0YWzqyFR2EdkTJDai639apy/Ucnh2q6oxAdX6UQoAz7
 ua5z1Bs8e9wvubvY2fJjVlhhHHjKJd6Yd1ZyiKgKRluarzZYd6awZmVQwXQI/wO/QX4bli6ix
 Ni5NOqh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 6 Jul 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I would *strongly* encourage you to allow Alban to go back to the small,
> > incremental patch series he sent before, because it will make it
> > *substantially* easier to not only review, but also develop, and for
> > you to merge.
> 
> An organization in which you can make sure that the order of dependency
> and which ones have been updated since previous rounds are clear, even
> to those who are looking from the sidelines ("these 4 patches are to
> replace patch 3, 7 and 8 from the previous round" is already hostile to
> late reviewers and doing so without a pointer to the archive is even
> worse---a full reroll with the unchanged ones marked below the
> three-dash lines would be perfect), would be good.  A random collection
> of seemingly separate but actually interdependent topics is very hard to
> work with with limited mental bandwidth.
> 
> Once the core of _a_ topic hits 'next', we can go incremental (because
> by definition things get quiet and require small updates by then), but
> not before.
> 
> I think the 7 patches in ag/rebase-i-in-c are more or less in good
> shape, modulo the issues pointed out on the list yet to be addressed,
> which I do not think require redesign.  Which is good.

You do understand that with your proposed "let's just roll them up into
one big patch series, and just add freely whatever you need on top", these
7 patches (3 of which I reviewed I think four times on the list now, and
more times on GitHub, which is quite taxing on my time) will be soon
joined by 6 more patches: https://github.com/git/git/pull/518

Of course, at that point I will have to look through those 7 patches
again, if only to verify that yes, they are still the same.

And Alban is not sitting on his hands, either.

So after reviewing those 13 patches, which undoubtedly will not be
integrated into `next` under the premise that they are still in flux, they
will most likely be joined by another dozen patches until the interactive
rebase is rewritten completely in C. After which time, I will have
reviewed the first 3 patches over 15 times.

I wish there was a better way.

Ciao,
Dscho
