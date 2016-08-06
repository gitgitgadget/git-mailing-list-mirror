Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18B2E1F859
	for <e@80x24.org>; Sat,  6 Aug 2016 23:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbcHFXSS (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 19:18:18 -0400
Received: from mout.gmx.net ([212.227.15.18]:52789 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbcHFXSR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2016 19:18:17 -0400
Received: from misery ([80.109.83.31]) by mail.gmx.com (mrgmx003) with ESMTPSA
 (Nemesis) id 0MegbQ-1buE7t2JCq-00OGic; Sat, 06 Aug 2016 11:41:29 +0200
Date:	Sat, 6 Aug 2016 11:40:27 +0200
From:	Stefan Tauner <stefan.tauner@gmx.at>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: Un-paged commit messages in git filter-branch's commit-filter?
In-Reply-To: <20160801232429.mb43wxev5lyhxyiw@sigill.intra.peff.net>
References: <0McmFl-1aux6M2oV7-00Hv9A@mail.gmx.com>
	<20160616095947.GA15988@sigill.intra.peff.net>
	<0MTjMy-1buKad2Fg8-00QUQV@mail.gmx.com>
	<20160801213631.2ttdlermxw2wbnbi@sigill.intra.peff.net>
	<0LzskF-1bGAH81g5T-014za7@mail.gmx.com>
	<20160801232429.mb43wxev5lyhxyiw@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-ID: <0M0gcI-1bFxtH2ZLy-00usFU@mail.gmx.com>
X-Provags-ID: V03:K0:BhA0QfUQZ1XYBcUhz1DlIpoX/9f+Mdpql3eFuHyDXDvkVfCgDWm
 kloSmoxu1cSfMCVdjlE3RXfy+tanbsJCOWPP4MSZF+pCxE89yWpWMGerKqZ1mv42XtK0EQc
 OR20fQ+oGe4+0E2XOSV5aS7MEB/VajEE9e/4J/NFhVg11RXTh7tun3Cnh5SImgwtbvUM8+x
 M+CZunclyvd+moq24yF7w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:52GqqgwwcfY=:qXm5E80QKxw7Hkx1AfZgSo
 pXXxUT4J+YWH+z0GFL/tKINkmH5mGWA43uYGeU/2Tr4aSxfdU7KbnI5CKZIj/EGOS0B7zPT4k
 vn3vRbcggtD5rtQZGDK3fDmPVOeflUC7rQJGUmecYy/fdCJn8+3XDZO889mS9ze+LmyHizUcA
 b4nTuytFokxqDr0rwm2Uu3Pgb5R5cCu0xIy03gqydFsqAw009Yeejnrex7dljqO/0YByjwLHY
 9dN8Yckxpsvf1hYbUOVBXkDKIiCOro+av4xUu7873W3eUMHtyuK5TkxjeWMIs/LxLKtNlNbV5
 H2MsJqM5weyIgPQZYDwKNPgTkrU5v5OM7ErXY9OS88cKq+Okm3MGzaLZO9oT3X00yZIZcHlPf
 oTn4426aIaNZ4DgqlL5aiDZxi2W0Dd4N4CtJqWsWmZvYcdtUob0twbxy/zN5f8VDUthqc4Wdn
 5HC07vkEiPHyxsUnZY1gzRG9cEkpQZ/kGlQLbvsMf11zxRSR66fEERIRciud6GStEe87BAtgf
 Q6bEs1auEgzlHis3VeSXXVH3TUpUZUUmAzvPiWH35VtQZOrlMMHiUgpSbp87EEqzeSgmnGYyw
 viHtaiHt3A9Izfkt0nzELLde5XfcaJ2KQaBO4NdzcfFCQw1VJvAsGfpGnZAEqUNYVqPuJZ7Pi
 N/kEchFEC/WcVhZKF9rmU7YENR6G5wAprYiM5XIs+O43y4MQ55Kq7E+kzRWc74CVr/bPSPQHH
 YFXXlwA6qttwQoxQ8A5Wd6s4sgshGPn9BxSKRx/urFfZmFQShuyW4HXoRLtX3jZEZ0sgf5Y/Z
 LSTmttr
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, 1 Aug 2016 19:24:29 -0400
Jeff King <peff@peff.net> wrote:

> So could it be that your lines actually _are_ broken in the git objects,
> but "%s" and other tools try to salvage them as a single subject?

YES! :)
Thanks so much! I was apparently ignoring this trivial explanation
because I was too much persuaded that the actual commits had missing
line breaks and only something in git was adding them. But it is
actually the other way around as you said: the few commands that print
the overlong lines are those that rely on %s. gitg for example parses
the output of the following:
git show --num-stat --pretty="format:%s%n%n%b%n\x01"
I was not aware that %s lumps lines together if it does not find a
proper subject on the first line.

I can work with that now. Thanks again!
-- 
Kind regards/Mit freundlichen Grüßen, Stefan Tauner
