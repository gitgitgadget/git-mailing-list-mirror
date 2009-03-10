Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 8025 invoked by uid 107); 10 Mar 2009 09:57:48 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Tue, 10 Mar 2009 05:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbZCJJ5g (ORCPT <rfc822;peff@peff.net>);
	Tue, 10 Mar 2009 05:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753983AbZCJJ5g
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 05:57:36 -0400
Received: from poulet.zoy.org ([80.65.228.129]:44861 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753878AbZCJJ5f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 05:57:35 -0400
Received: by poulet.zoy.org (Postfix, from userid 1000)
	id 64ABA1206D7; Tue, 10 Mar 2009 10:57:29 +0100 (CET)
Date:	Tue, 10 Mar 2009 10:57:29 +0100
From:	Sam Hocevar <sam@zoy.org>
To:	git@vger.kernel.org
Subject: Re: git-p4 workflow suggestions?
Message-ID: <20090310095729.GA27280@zoy.org>
References: <20090309142108.GK12880@zoy.org> <200903100815.53847.chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200903100815.53847.chriscool@tuxfamily.org>
Mail-Copies-To:	never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Mar 10, 2009, Christian Couder wrote:
> >    I have modified git and git-p4 to a point where they are usable in
> > my work environment. I am now faced with a new problem: Perforce's
> > composite workspaces. They allow you to "mount" parts of the repo onto
> > other directories, even nonempty ones.
> 
> It looks like SVN externals. So I think you should read about "git 
> submodule".
> 
> There is this related link on the wiki:
> 
> http://blog.alieniloquent.com/2008/03/08/git-svn-with-svnexternals/

   Unfortunately submodules are considered separate repositories, so if
I have /include and /src as submodules, I cannot commit atomically to
both. Or can I? That's probably my strongest requirement.

> You may also want to search the mailing list as this subject has often been 
> discussed.

   I did skim through the archives, but couldn't find much. There was
this discussion: http://kerneltrap.org/mailarchive/git/2006/11/28/231515
where the idea of Perforce-like workspaces was apparently dismissed as
being "a mess".

Cheers,
-- 
Sam.
