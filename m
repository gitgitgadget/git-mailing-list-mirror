Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A640AC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A236613E7
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhFJOYv convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 10 Jun 2021 10:24:51 -0400
Received: from mut-mta1-se01b-zose1-fr.yulpa.io ([185.49.22.247]:51147 "EHLO
        mut-mta1-se01b-zose1-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230488AbhFJOYt (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Jun 2021 10:24:49 -0400
X-Greylist: delayed 1181 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jun 2021 10:24:49 EDT
Received: from [185.217.155.54] (helo=mut-zose1-mta-hub-outweb01a-fr.yulpa.io)
        by mut-mta1-se01b-fr.yulpa.io with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matthieu.moy@matthieu-moy.fr>)
        id 1lrLH0-000PD3-CJ; Thu, 10 Jun 2021 16:03:08 +0200
Received: from localhost (localhost [127.0.0.1])
        by mut-zose1-mta-hub-outweb01a-fr.yulpa.io (Postfix) with ESMTP id D567BC0EF8;
        Thu, 10 Jun 2021 16:03:05 +0200 (CEST)
Received: from mut-zose1-mta-hub-outweb01a-fr.yulpa.io ([127.0.0.1])
        by localhost (mut-zose1-mta-hub-outweb01a-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6Tk6-NHf6XoA; Thu, 10 Jun 2021 16:03:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mut-zose1-mta-hub-outweb01a-fr.yulpa.io (Postfix) with ESMTP id 2D1BEC0F06;
        Thu, 10 Jun 2021 16:03:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mut-zose1.yulpa.io
Received: from mut-zose1-mta-hub-outweb01a-fr.yulpa.io ([127.0.0.1])
        by localhost (mut-zose1-mta-hub-outweb01a-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y78LomeJ_Fm2; Thu, 10 Jun 2021 16:03:05 +0200 (CEST)
Received: from zose-store11.web4all.fr (zose-store11.web4all.fr [10.101.13.41])
        by mut-zose1-mta-hub-outweb01a-fr.yulpa.io (Postfix) with ESMTP id F4025C0EF8;
        Thu, 10 Jun 2021 16:03:04 +0200 (CEST)
Date:   Thu, 10 Jun 2021 16:03:04 +0200 (CEST)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Elijah Newren <newren@gmail.com>
Message-ID: <1554066605.61418500.1623333784687.JavaMail.zimbra@matthieu-moy.fr>
In-Reply-To: <877dj22fly.fsf@evledraar.gmail.com>
References: <pull.977.git.1623313765122.gitgitgadget@gmail.com> <877dj22fly.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] multimail: stop shipping a copy
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF89 (Linux)/8.8.15_GA_3980)
Thread-Topic: multimail: stop shipping a copy
Thread-Index: 8UmyICAFRlDrwn25D7ougG9T9ll3Fw==
X-Originating-IP: 185.217.155.54
X-yulPa-Domain: mut-zose1.yulpa.io
X-yulPa-Username: 185.217.155.54
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.217.155.54@mut-zose1.yulpa.io
X-yulPa-Outgoing-Class: ham
X-yulPa-Outgoing-Evidence: Combined (0.12)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT/1V4CmmMTVf8FwWHPoeKulPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5yQjexTtlmymV+xi79keHPxA7x/QEF6miwe6wqECmRy+8OG
 Nf1Fo2VTmfbm65KbNw51OzNTkEkyI1Jjcv0k345MsoCaIk/P6xeJoQi/AU+4AW4KbNAaaCvFi+lg
 tv0PeP/a0SZJ7ortTriB/Phu05/DCR0q1Z/I4eH9B1xR4YgM9xqU4slMuZzrs+tT2mKwxPnLjlV5
 cBkg2E15FOz6ftN7lYw140f3591IjYh259zyTCZUPGRkGZbm3/2UDupFLsWaJsvBnk+tAbmnYgF9
 2FCsBcTaduYwulQTLJz9aeZvqiBM/UV5EAVEw6mkcmYRpOzmLK/QANIM7sX3L9bTb3c30Pt8ocdu
 zh57oiIh5VIJb1/+vIgka+4FOShOoZ3m7qaEUCviaS0t0WJXqjhsaw0IyyBw5hLCdgddneKYuFKS
 4P9UJ754NhFEEOf6aAzYtTyyfxK4iKcUPX7JCeaCI9Nw1zQtLTNPdyKAqnXUTerx1YmSEp4iFuKA
 pilqBZWiJicirIuw/++O/o3churN542n8Nn/2TLlfz7ibiBnj9D8HfYtQLYQpwUf7KSftolpBstk
 V1u1ql12/tVG1nBSlza3BaBldjaj1+vhII7uaMy67bmXThWsKXvSCfd3222lYH703be02AN0SJxC
 n15qY5waTprKF3BtcOkgFWV817PeV60jiD6XqsJZtjQxlyCdsezWUITaTD7+rV1AhSY2qqjWhKHM
 ZMgZkLwzvpC4bhgo1w5u7MlMPcJdmszkw9cSAWscsO1ib7S1x+yVYDiaKSP0luEQowjaup0/Q2e/
 fMrB8U16fja4lA21sbHz5yJf4WvnDq/3bR0wrBvPnE07I0NKTh8D/fZeI9w8CWdjMuEcDiWqvXhJ
 chk5jfDCmPKlUENSOYE66SFhT6NVrQT/pWDnH2BItqYH/1C2S9VtzK9rbcrW1ENIxeYUVa6S/bQe
 GUMIPhNjaxV43BtKlykuwv4TafnCRpB1wyqTi749ASgh/Y/p/WbLuZFyVkpvagLXEg9+UQvDTilb
 OBqY+/Zon3xkUsl+Panl58ybCfWuwwt2PYUd1sHKnHeyYVXDFjxe3lbdkZRVQfEMBL65E83ZZjde
 lWbUYHSfWR4OS5PQAvw2OFk9SJqKJVt6zKpxPOqtgZg=
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ævar Arnfjörð Bjarmason" <avarab@gmail.com>:

> On Thu, Jun 10 2021, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> > The multimail project is developed independently and has its own project
> > page. Traditionally, we shipped a copy in contrib/.
>
> > However, such a copy is prone to become stale, and users are much better
> > served to be directed to the actual project instead.
>
> Let's CC its maintainer / other people who've actively contributed to
> it. I've taken the liberty to do that.

Thanks.

> It seems to me that the state is that we're on the 1.5.0 release, and
> upstream hasn't cut a new release.

Yes. In practice, I am no longer a user of git-multimail.py (my use of Git
moved from some self-hosted repo on a server accessible through SSH to some
more black-box hosting like GitLab where I can't use it anymore), and I
receive very few pull-requests and issues, so the project is essentially
stalled. Not dead, but probably just good enough so no real evolution
happen these days.

> The upstream maintainer(s) are active contributors to git,

Actually, I used to, but it's been a while since I contributed to Git. I've
been busy with other stuff, and I'm struggling to find time to come back.

Michael used to be the maintainer, but completely left the project after I
took it over.

> so the risk of this becoming stale seems low.

This part is still true: sending the patch to Git is part of my release
checklist, I'm unlikely to forget.

That said, the benefit of keeping a copy in git.git is debatable, and
probably low. I have no objection in removing it, i.e. applying Dscho's
patch.

> Having written a system in the past that made use of git-multimail.py
> (and sourced it from git.git's copy) I'd think a better direction would
> be to keep this and modify githooks(5) to actively recommend it over the
> older and less featureful post-receive-email script.

I'm all for recommending it in githooks, but this can be done by pointing
to GitHub's URL instead of a local path. Actually the sample script could
look like

# Fetch git-multimail.py from https://github.com/git-multimail/git-multimail/
# adapt and uncomment the following line:
#exec /path/to/git_multimail.py

Cheers,

-- 
Matthieu Moy
https://matthieu-moy.fr/
