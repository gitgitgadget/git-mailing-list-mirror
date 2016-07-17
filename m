Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56FE720195
	for <e@80x24.org>; Sun, 17 Jul 2016 08:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbcGQIW4 (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 04:22:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:58400 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbcGQIWy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 04:22:54 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MY7dI-1btTkg2Yb2-00UqrU; Sun, 17 Jul 2016 10:22:34
 +0200
Date:	Sun, 17 Jul 2016 10:22:33 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Eric Sunshine <sunshine@sunshineco.com>
cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] fsck: optionally show more helpful info for broken
 links
In-Reply-To: <CAPig+cS=LVBhy1pqo2KXz-NoPZdPzkzTgV+S1Ro5+zOjDpKGPw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607171021520.28832@virtualbox>
References: <cover.1468510191.git.johannes.schindelin@gmx.de> <2cc123136b25cae12dce2a6f30fe0ba5ae8dc811.1468510191.git.johannes.schindelin@gmx.de> <CAPig+cS=LVBhy1pqo2KXz-NoPZdPzkzTgV+S1Ro5+zOjDpKGPw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:M6nNGwP1bIgTuZCq5bd2wVC0NR646yXFq4I0ht+eXSW5BZXmVFU
 ZkKZti8mR9jbOUyUBAG+7odRGjiviPMIBactNerpOWoO90A0qB3nZxiWEXoMLywEbwCMozL
 H9ZBkk5Mnp3dEKRlQHkWKLMtns8+jhDsYErRg6brcemFGdUq2H9Z/QUdwt+UFwpjE1AHM+e
 K6C0cQUJf3vRuw65UDACA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:wwvya9QS8FA=:FmB8gcE9vMjUkQmVcVAyiR
 QmfgfTQtUNJ4RyE8WPMFjBdnFNKZdctz7Pzt7IbfcqR6y1QqX6DLmZ0lSKA5EWNC/OLGH7Lqa
 d7KPTwlh2z9JRa/0ktaWAOxyp/2dNeNoBwKxwLFlFBV/lLpKsLfhdFJb1tQ3cJ7FFLddYbFM2
 jBq9Qwo+R914o7D3Cm5E1PG1A6DOzHYUa8D9Oh+DDhAjT3itOIF/WdVJEswCceRWDBHSBWDh6
 uMc5MM1V6ts5O3blmQmwqoUszlRraOpo5BKUwywgtlxBg9BYXZr5ZMy+8O1SHdZrNAp+/TtHi
 FhRHoFf5CYVaB8VhD1F0BLoIXqYJ6jZz/qmMsrgLy+WqYf4HXW9fzaL0kwesqh08Sp63pr94V
 o1uTU9ccTK131/hTs4/t+7XB+tOtRIvPI0CAH98Ktl0l7rnr8IagHv2h4AoDlF/BfhSBkjSFg
 XGyfltmSsL9nbdsBUrP8zPjosEskoB+iVyXuX8RPFhVpAB6WVxqUNvBTO51yeA18Z3LbdrM+3
 d01G5SVk1tttp2fq8/ANeYB8RgZ3RAy/qHgkKW9xELy3gcG1SfSaayZF3DaWvvlDgRT0zdaTm
 vc7gom4RYXt7CdL8tDVW6190XeRZaKu89p8yRGSlmtJScMSE43tjJviXDDfDiNwNtGr3O0lhD
 uTmDaa1La2v2zDJbXUmklA+dDdrTOxpN8MymmWNpUHcd3v/rI/66EOd+Z2VYnf5EYeTbi4ih2
 GGOr3RhNmRHJrubjU1KUa+IXoUyW3JDBQqSoN0suuVEZb/6Z6U3MY8yxGZDKn0IR48DuzoHSd
 j4AbrXs
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Eric,

On Fri, 15 Jul 2016, Eric Sunshine wrote:

> On Thu, Jul 14, 2016 at 11:30 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > When reporting broken links between commits/trees/blobs, it would be
> > quite helpful at times if the user would be told how the object is
> > supposed to be reachable.
> >
> > With the new --name-objects option, git-fsck will try to do exactly
> > that: name the objects in a way that shows how they are reachable.
> > [...]
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/builtin/fsck.c b/builtin/fsck.c
> > @@ -576,6 +598,7 @@ static struct option fsck_opts[] = {
> >         OPT_BOOL(0, "lost-found", &write_lost_and_found,
> >                                 N_("write dangling objects in .git/lost-found")),
> >         OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
> > +       OPT_BOOL(0, "name-objects", &name_objects, N_("show verbose names for rechable objects")),
> 
> s/rechable/reachable/
> 
> >         OPT_END(),
> >  };

Thanks, as always, for a set of extra sharp eyes. Will be fixed in the
next iteration.

Ciao,
Dscho
