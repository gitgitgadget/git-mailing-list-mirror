Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4008420387
	for <e@80x24.org>; Thu, 20 Jul 2017 08:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934229AbdGTISv (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 04:18:51 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37947 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933880AbdGTISr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 04:18:47 -0400
Received: by mail-wm0-f54.google.com with SMTP id w191so19620831wmw.1
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 01:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bPfTKciZ1uqXlDOkFeZ4THiSfjR2Hx4/6UYy3MF0ESg=;
        b=snMti1NaYsUczqruDLzvBoLiArEbs20l6JrJg57Su7rAqO3WORVo9X14HKHW5tlUJF
         DkbRS6SXO8Tt55OD5gjciwCzIiXo7MJYNQJJGX8P0LUxWJETatgzhYNQUHfdkeBIJbaw
         asbo+/6I2K6XYubbD6WclZOaF58lpFIa7sEdA+q6dpVHbsN5WBUgM7i5ZUk8UKmHW0tb
         WxNGwLn7QzCJaij9KWZgeCJFUqZG8F6gDl1rmJYxxvlfkwDN0x+qAhfgtU5nx7JqUrXO
         ehh0rhnWwYEVE7N4bWLiaTJ0Ff0P4PuYmD5HMGkWbmGqrSwwTRx501Pj/pxFuaUgl9DE
         mmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bPfTKciZ1uqXlDOkFeZ4THiSfjR2Hx4/6UYy3MF0ESg=;
        b=V4j7vGsG/WknKwCa9p8PJM3QCsG6yrxXHMbWimGYSUsfTNQm9vBvFfHcNIDDHrW+fc
         UTbL2ZUjuVj4WpCmz21YPBV6qtgKnjdors6GWiqHVnWInvldKgOy1abtj5EBSObgo8xa
         I/STLmF/ATD0zJDbMkB9FUrqzTmwv5ovdklD/GRzlnzVwPu5CHSPblnDQL+GrH3vJVX2
         BMLVC2F8L4AL2fZIvemhDuIH/7dlUhrz68ufAct6eABgzZLiXfv4PkWjekp6l3PHrlAT
         wbjHyDXv97qAhgvHGRnmFgfIzHgjr6Vm5fULvb1+qjt+WCzoT2YjIdVHa7guc3aucIBO
         z/gQ==
X-Gm-Message-State: AIVw1122mDViEkf1fJztysD4ipR0XW1o3WWdGbQai+n1VIHvvGZeMTMx
        Hac1SjT9KoLlysLi3IY=
X-Received: by 10.28.4.148 with SMTP id 142mr1639628wme.9.1500538726593;
        Thu, 20 Jul 2017 01:18:46 -0700 (PDT)
Received: from rempc0k844e.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id m123sm1776198wmb.3.2017.07.20.01.18.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jul 2017 01:18:46 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Reducing redundant build at Travis?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170714153224.6qnupcsa3pkig76k@sigill.intra.peff.net>
Date:   Thu, 20 Jul 2017 10:18:45 +0200
Cc:     Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4BB4EDA1-58A5-45AD-8BEC-1CB06CDC23DD@gmail.com>
References: <xmqqeftlz0dv.fsf@gitster.mtv.corp.google.com> <CADJMNYmGR8Ti0S77y2ykPdSZB68DrBb8O0wfX6PaezV1+j2bnw@mail.gmail.com> <xmqqiniwt35e.fsf@gitster.mtv.corp.google.com> <20170714122401.uahk2fzvcjj3nwve@sigill.intra.peff.net> <xmqqbmonrrvr.fsf@gitster.mtv.corp.google.com> <20170714153224.6qnupcsa3pkig76k@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 14 Jul 2017, at 17:32, Jeff King <peff@peff.net> wrote:
>=20
> On Fri, Jul 14, 2017 at 07:54:16AM -0700, Junio C Hamano wrote:
>=20
>>> The "git test" script[1] uses this strategy with git-notes as the
>>> storage, and I've found it quite useful. I don't think we can rely =
on
>>> git-notes, but I think Travis gives us some storage options. Even =
just a
>>> best-effort cache directory would probably be sufficient (this is an
>>> optimization, after all).
>>=20
>> We do seem to use some persistence to order prove tests already, but
>> I do not think it helps the common case, where my end-of-day push
>> pushes out 'maint' and 'v2.13.3' at the same time, because the push
>> is made with "git push --follow-tags $there maint master next pu"
>> and the new tag happens to be at 'maint'.  It would be nice if
>> Travis runs were sequential, but I often observe that it creates
>> jobs for these multiple branches and tags pushed at the same time,
>> and start running a few of them.
>=20
> Ah, right, I didn't think about how these are racing. You'd need =
storage
> which allows some kind of atomic operation to "claim" the tree as a
> work-in-progress (and anybody who loses the race to get the lock would
> have to spin waiting for the winner to tell them the real status).
>=20
> I don't know if Travis's cache storage is up to that challenge. We =
could
> probably build such a lock on top of third-party storage, but things =
are
> rapidly getting more complex.

I think we shouldn't go there because of the complexity. I reached out
to TravisCI and asked about the "hash build twice" problem [1]. =
Unfortunately,
I got no response, yet. The issue could also be considered a feature as =
you
could perform different actions in your TravisCI configuration based on
the branch name.

I think Junio's original suggestions for the Windows build makes a lot
of sense because it saves Dscho's compute resources:

--- a/ci/run-windows-build.sh
+++ b/ci/run-windows-build.sh
@@ -12,6 +12,12 @@ test -z "$GFW_CI_TOKEN" && echo "GFW_CI_TOKEN not =
defined" && exit
BRANCH=3D$1
COMMIT=3D$2

+if TAG=3D$(git describe --exact-match "$COMMIT" 2>/dev/null)
+then
+	echo "Tip of $BRANCH exactly at $TAG"
+	exit 0
+fi
+
gfwci () {
	local CURL_ERROR_CODE HTTP_CODE
	CONTENT_FILE=3D$(mktemp -t "git-windows-ci-XXXXXX")


However, I don't think we need to do the same for the builds that
use TravisCI resources. If they would be concerned about that then=20
they wouldn't build the same hash twice in the first place.

- Lars


[1] https://twitter.com/kit3bus/status/885902189692112896

