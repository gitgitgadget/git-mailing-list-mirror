Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A52051F404
	for <e@80x24.org>; Wed,  7 Feb 2018 20:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754129AbeBGUDe (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 15:03:34 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:34375 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754048AbeBGUDe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 15:03:34 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:34262 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1ejVwL-0002NB-5p; Wed, 07 Feb 2018 15:03:33 -0500
Date:   Wed, 7 Feb 2018 15:03:31 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Todd Zullinger <tmz@pobox.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: categorization, documentation and packaging of "git core"
 commands
In-Reply-To: <20180207172902.GL1427@zaya.teonanacatl.net>
Message-ID: <alpine.LFD.2.21.1802071500220.14248@localhost.localdomain>
References: <alpine.LFD.2.21.1802070801470.19185@android-a172fe96dd584b41> <20180207172902.GL1427@zaya.teonanacatl.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 7 Feb 2018, Todd Zullinger wrote:

> Robert P. J. Day wrote:

... snip ...

> > finally, from fedora, i am utterly unable to find a package that
> > provides git-archimport. pretty sure fedora used to have a
> > "git-arch" package but it's not there now.
>
> It hasn't been in Fedora since 2011.  The tla command which is
> required for git-archimport was retired, thus we removed the
> git-arch package.  The rpm changelog shows this:
>
> * Tue Jul 26 2011 Todd Zullinger <tmz@pobox.com> - 1.7.6-4
> - Drop git-arch on fedora >= 16, the tla package has been retired
>
> As does the git history for the package:
>
>     https://src.fedoraproject.org/rpms/git/c/3f0dc974fa
>
> The tla package was retired because it failed to build for
> several releases:
>
>     https://src.fedoraproject.org/rpms/tla/blob/master/f/dead.package

  huh ... well, that raises the question, if tla has been unbuildable
for that long (possibly for other distros), what is the value in
continuing to support git-archimport?

  https://www.kernel.org/pub/software/scm/git/docs/git-archimport.html

i don't really care one way or the other, but perhaps git-archimport
should be broken out as a "non-core" component of git. related post
coming shortly ...

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
