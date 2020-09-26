Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E365C2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 18:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B667D2151B
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 18:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QHKZrzcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgIZSet (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 14:34:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:40607 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgIZSet (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 14:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601145281;
        bh=agfwQvUhb02UmMhJTBzGx98ODt2eTeFSp7f72AxZoxY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QHKZrzcmdSy4a31L9d7cressINvg8P4mYCrUulXILRVULwEsrYPJ3eQrqH1SUvL4n
         YKYUm9zvu1kbcAYkJN5I6CitZ/jxm6qtuh+LSMrXJGBimFz7vUEn0aVyqwKW+71in7
         4X+nJ6V83iIfixDBI/08aWC+6KK18IWlAIY9kN/s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([89.1.213.116]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wll-1kSWNs2185-012ENG; Sat, 26
 Sep 2020 20:34:41 +0200
Date:   Sat, 26 Sep 2020 06:29:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Inclusive naming, part II
In-Reply-To: <20200921222458.GB3533110@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2009260629120.50@tvgsbejvaqbjf.bet>
References: <pull.734.git.1600279853.gitgitgadget@gmail.com> <pull.734.v2.git.1600725687.gitgitgadget@gmail.com> <20200921222458.GB3533110@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PWtFuPJKfrb9TiBDJNlGuoNiW6BxgIYtHBwnJu8w9gDW1m8x0Ey
 OQ2FjdsVJBY4g4jO0XCbrCM10qmkr/5TpQO1PfDsa7EFoUH+Q15daZ8sexNZRv5VQkO8CBk
 nVLjA1AR0gUkrASn0/eyXvMVl2Q13JMwSXltI0TqSrqnB7UvHMi/oux16OiY/pM5yjnk/Qc
 WgI4Roax1FCYtKKs9j6MA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ghljdYU2jIg=:7X4dYOyUsmeA+g4KaJitOY
 az8B1U80JCh1oaQ75+j6TVbXtcEIemi3VlXbjo4m27JYEXqBSb+YDq+ULvYJhWUe3wiiu8N2P
 BKElxLBTQpAilmpnMh6o0z065jMYPf/VTYhTUXdp2XeHhCcCxy8SL1KKyjGuW5eOLjIMtAfPm
 oPC3PJ5TM6J920ikpJ8DkFtPQhPJ/OWMPqueC6imK5o8QVQ8wYlqefcttpZ/oRkIEMuDYNQy1
 7lgKdGTeGRmaMr9JjCAx1UCnfYj6BxnJt18CY9zqdEn1VDzG9f4oxv68n8RYSB32r3xSgYBA+
 hr9rvBNWW9c9adV1YTEHgGtUSLcYVct56k+Of10lAiDA1GeJ29VS4FAk8mCVsHGrD90a2tEIn
 fqnVSSklLaH7/1b6SrgTphnY2XrApGBcBbmaabz9QiQTU2jdw8ThobAA52QnM+0U5bkIymV5S
 q1et81+PToXhiQB0yCKFxb49YqWryKCupfXBm7WII7UBsV6GjpQanCb5QM4lfCmFBqnv0rKb3
 JnKBO1YlHKwemc6x1zPX5InNELP6XpaD7jrGspjVNj4TNzdjkEjdcWEq+dLG61C8nRYmgjOtD
 gzQaghzpf3FeStLJBM2+EUBOzfuC7AO0LBG9RJr3LEmXzBbIWvUcLZJ3EUV804N39M8tZ5Lej
 w7SYU/SgoAUzOycuhYA2L3v3lyUEiCLJ+dYs/BBAgQEEv/oUk8PW/Ot0q3VhKc00gQ8gN7lE6
 5hEm7fsZnP7rj+XNFNjlccuDtUvje0rUmKMpOsHdgYRUaCa5JSn75pMh088t2aWZnyG7VST61
 fy8oS8KQ31yj81Zu4e6y+izirn77EoZZWea6qn93EE1QHCNWDEI0ZvEPt5GULikivEH7eDr4n
 cLJbcM37/Jfw29vnrVy00cu6P4wUij9IQfqOYETdDVxNvNBIu5KPHZtKDiJ/ml2KozZZXUKU+
 xfQM3lWuLwMCCzRFcxKPYJubuaDdR3qY1X2sJ5FVzWYVNeT8iusEpaxVt6hvUqJdiSsbDtCCB
 0svhflQbk3N/90Wy4xvXBiAwrtb3xuB74qZ/7BluGo2crlwFhtzN6D+65pOjJZBdyvYyQgX2F
 fnvR9t+YmFx55wKz23Ftclq/6Y3qe0ddimclfcepunpk9lIQLsYNwnWgewkqFCHK+Fa/Z2Bu0
 YpZDGBGDyno2+8Mzww5Hn23uxG9adriW1iEnW7imrlxYOO7oB2B48JYiVFl8y/r2QTHK1LgV8
 xdkTVJNtF1NfwTihNLOImFgOA96h3TX2XRBzQJg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 21 Sep 2020, Jeff King wrote:

> On Mon, Sep 21, 2020 at 10:01:21PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > Changes since v1:
> >
> >  * Instead of using the name primary for the adjustments to
> >    t/test-terminal.perl, we follow Python's lead (which uses the
> >    parent/child nomenclature).
> >  * The changes to t3200 no longer use variations of the name main as b=
ranch
> >    names; Instead, the renamed branches are independent from any curre=
nt or
> >    future default branch name.
>
> Thanks, I think that does look nicer. Shouldn't the latter bullet apply
> to most of the ones in patch 4, though?
>
> I wonder if they should simply be "s/master/topic/" instead of
> "s/master/main".

Yes! I did that in 4/5. In 5/5, we need a branch name that starts with the
same two letters as `maint`, though. I amended the commit message
accordingly.

Thanks,
Dscho
