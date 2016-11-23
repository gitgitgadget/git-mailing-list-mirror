Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A635F1FF30
	for <e@80x24.org>; Wed, 23 Nov 2016 22:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933205AbcKWWBu (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 17:01:50 -0500
Received: from mout.gmx.net ([212.227.17.20]:61257 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932909AbcKWWBt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 17:01:49 -0500
Received: from virtualbox ([89.204.155.1]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0ML6XF-1c9waW2dxh-000ITu; Wed, 23
 Nov 2016 23:01:29 +0100
Date:   Wed, 23 Nov 2016 23:01:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] difftool: add a feature flag for the builtin vs
 scripted version
In-Reply-To: <alpine.DEB.2.20.1611231824530.3746@virtualbox>
Message-ID: <alpine.DEB.2.20.1611232259090.68520@virtualbox>
References: <cover.1479834051.git.johannes.schindelin@gmx.de>  <598dcfdbeef4e15d2d439053a0423589182e5f30.1479834051.git.johannes.schindelin@gmx.de> <1479912693.5181.27.camel@kaarsemaker.net> <alpine.DEB.2.20.1611231824530.3746@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hqPWgNl+e0PPRk2g0n3i7R7VvHpOX2RxUsBgT6afRUkmKpPA6E4
 bgHOybsruSDBqKzcthJLayIRL7GkE+bZuGPmj4sCSyWXD68ERASUAoa8MyntxOxCJvCzJbp
 hvuKhq1KimMoKt57SscSwqjcakScA0Y3QivgDu76+xUWvNGVojKic6Bs8kc3NY4ZDuX0VFy
 ySR6kvZi1ieAWDMak6ohg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+vQJoa+rZRE=:xBmMMzwa4KXzO1DTBNJhD3
 SCR1hCX1PlULDWgjeA+Qx3C8P1fRFqajqzhalLTKH+VV7YMq6q3fG1zyzu8KStZ5hQlN1jixB
 qYQRf41AvBtfcHDIfGMZjfCTn6XR5n+2lgF02rZkmmOT3s3RGhKMsTNaUZ7HtTM1GSxE71Kd7
 u5Hi9MWwjEE2b5VLrv0HoCdHykrCRrx1SbmXm7W+T/TvUYONZ+hX/X0JMibWvQMxqPHf5q5g0
 D2OG7s366G+3ut+Dy0ZqhnfV4teYBUek6BloEyx4ltRfQ1Gzfy6oVi9etrRlVRD9kSZYpHySE
 K5+DESzSRkZwMyG7wCmCzWQhkM7c2VYZpHvZWCdWIJbCHk3VVojIkXoMdQKlcUmminUiQaOUi
 hsEQ0NtkhOuLrybogcYzdxlKTznP9kKvj+CZWM5LicsOMi/Ft684+WFsZHjB8CmEHmmiQyofR
 3DvIIgjGsAIsce3/PEMoMPopBz8n2rG74vgTmCCildfZn2WfEqyo/5k0xupbTTHnXCyariJ1P
 +ONMkXxIfBpVvlb9FZIcFz0U5lJUd2nSWrA9jZP+Iv4rbHF3o6SdtQHY/6wnRa7bLTMJieB4X
 XS2zKZ9E7eMY04U/h+208pCOFrhNzYDkA6Pern2tt0XIBBp2lCkUby769cSO6cDOkOf9Bo+em
 EAvshxJREre6HJtCxLVCOWklg5A9rjjgbDIl8gIUE1u8ayfZjklhHZwHMm0FVlo+5iniAh/XL
 1lTdJtDX9jLhy+ZNX5WAUciYqOUrXF0/e0iz1qEF+s48lZiaZfRkQ2UFPsabaGHcTmfvt91H8
 8JJLjuA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dennis,

On Wed, 23 Nov 2016, Johannes Schindelin wrote:

> On Wed, 23 Nov 2016, Dennis Kaarsemaker wrote:
> 
> > On Tue, 2016-11-22 at 18:01 +0100, Johannes Schindelin wrote:
> > > The original idea was to use an environment variable
> > > GIT_USE_BUILTIN_DIFFTOOL, but the test suite resets those variables, and
> > > we do want to use that feature flag to run the tests with, and without,
> > > the feature flag.
> > > 
> > > Besides, the plan is to add an opt-in flag in Git for Windows'
> > > installer. If we implemented the feature flag as an environment
> > > variable, we would have to modify the user's environment, in order to
> > > make the builtin difftool the default when called from Git Bash, Git CMD
> > > or third-party tools.
> > 
> > Why is this not a normal configuration variable (as in git config
> > difftool.builtin true or something)? It doesn't make much sense to me
> > to introduce a way of configuring git by introducing magic files, when
> > a normal configuration variable would do just fine, and the GfW
> > installer can also set such variables, like it does for the crlf config
> > I believe.
> 
> I considered that. Adding a config setting would mean we simply test for
> it in git-difftool.perl and call the builtin if the setting is active,
> right?
> 
> The downside is that we actually *do* go through Perl to do that. Only to
> go back to a builtin. Which is exactly the thing I intended to avoid.

Okay, I reconsidered. Junio's comment about how git-am did it made me
rethink the issue: I need not keep the name "difftool" for the script. So
what I do now is rename the Perl script to git-legacy-difftool and always
read the config in the builtin difftool, handing off to the legacy
difftool unless core.useBuiltinDifftool=true.

This is an easy way to do it, and a portable and clean blueprint for
similar feature-flags in the future.

Ciao,
Johannes
