Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF61C433C1
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 15:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904756195A
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 15:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCSPvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 11:51:03 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59475 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCSPud (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 11:50:33 -0400
Received: from Christian-PC.fritz.box ([109.91.254.15]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mk0BK-1m7Mho0wJc-00kPTo; Fri, 19 Mar 2021 16:50:12 +0100
Message-ID: <967d6a889f52ba0c4228264650a549bbbcbb5fea.camel@avr-fun.de>
Subject: Re: Git install crashed nearly whole System
From:   Christian Strasser <christian@avr-fun.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Fri, 19 Mar 2021 16:50:11 +0100
In-Reply-To: <YFOMylgx9paP5anv@camp.crustytoothpaste.net>
References: <8aa7be071abc23371397f72b725babc4e4e90190.camel@avr-fun.de>
         <YE5wFxE5RPew5zrJ@camp.crustytoothpaste.net>
         <b805d53740429a26413cdd4e756db29f95c98052.camel@avr-fun.de>
         <YFOA8ARUwa34tiTl@camp.crustytoothpaste.net>
         <YFOHFABji5/sDZod@coredump.intra.peff.net>
         <YFOMylgx9paP5anv@camp.crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VijrfES9G9k3dzoFgzzlOfgq4PNgp3OxgRmXnb84+beyLMILA7i
 yJoLDbV7WXhyoJfLgjaYcg2LDHXomw9SjBoxWPEFVGaeraRi/y1gSBYfiB5fP0tV5LVXFUt
 kEtbqlJM61sqXB67tRd3nTV30iX0ZEV/AM/bnQIIRGIJZb4UFRlV+FiK3m0gankCoOYsGM3
 JslYhj9xNGFK6qXNuaHQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:we7HvsC9fTU=:ILAFeARgNlQcn2XzZ4G4Ts
 SHlU/ELNs+LGpW30TjFwHN7L13ycAhyGlITLQTzWVij+qcyBgxugypfXAJGiT8M3hcsHJWkSx
 vTaPdPDSeb0H9Av0Ia0iQnnpNmU0MaHsmpf+T188X7/u+Ap9TVZPJPsAO4BAyDB+tIPWw1FgX
 TIDkAJwCD51QjXQlh3Zc/wjFJMduLZorX9U/uOxYCmCi8DkImnxcYpjs0OMtUrmZbsCWnl2qL
 cPs/9XVbgj4oC0F5rG62tZ80EKvdWgp9qkXUqxhOy51ATHGTCrwGBSUo/qEaAadQX6+eNBqq2
 4sT0HlsJfpGC0Pc4D4hx3AOUGF3TeCBiX3vOiLakdw8GG6OzkbbCvfT7JgCvLiQk3U6squDEB
 FDHrNXvaA+yXH+WqWl/01Pe0yPCqjoaZgM1Fo72ufaO6/1HHvc4jOZJ/gyt8uu7O4Hq/mHNve
 QwQiVS6OcQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

Thanks a lot for your effort. :-)

Greetings,
Christian



On Thu, 2021-03-18 at 17:24 +0000, brian m. carlson wrote:
> On 2021-03-18 at 17:00:04, Jeff King wrote:
> > On Thu, Mar 18, 2021 at 04:33:52PM +0000, brian m. carlson wrote:
> > > If everything's working for you, there's no need to change
> > > it.  It's
> > > _possible_ to install git-all and not have this problem, but
> > > because of
> > > the way modern versions of Debian and the packages in question
> > > are
> > > configured it ends up tending to have this problem by default.
> > > 
> > > In this case, it may be that git-daemon is installed but not
> > > configured
> > > to start, or it may have been removed when you reinstalled GNOME
> > > since
> > > it's not a hard dependency.
> > 
> > Yeah. I think fundamentally this is a packaging issue. It looks
> > like
> > "git-daemon-*" has been downgraded to "Suggests" in Debian
> > unstable. It
> > looks like this was done in 1:2.26.0-2 last April. From the
> > changelog:
> > 
> >     * debian/control: downgrade Recommends by git-all on git-
> > daemon-run
> >     to Suggests. The git-all package is a "batteries included" full
> >     installation of Git. Automatically running a daemon is not
> > useful
> >     to most of its users.
> > 
> > So they are already aware of and addressed the problem, but older
> > releases will still show it.
> 
> Yeah, and I think that https://bugs.debian.org/953875 has fixed the
> problem where installing runit (by using git-daemon-run) would switch
> the default init system.  So in bullseye, this will probably be
> fixed even if the daemon does get installed.
> 
> I think the person who previously maintained both Git and runit in
> Debian was busy with other things for a while, which prevented this
> issue from being fixed.  Now Jonathan is maintaining Git (and is
> doing a
> great job, especially with the next builds in experimental) and
> someone
> else has taken over runit and fixed the problem mentioned above,
> which
> occasionally caused this same problem with other packages as well.
> 
> So I think this will sort itself out in the next release, and in the
> meantime, just be careful with git-all in buster and older.

