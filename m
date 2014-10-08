From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH v4] MinGW(-W64) compilation
Date: Wed, 8 Oct 2014 15:58:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410081553320.990@s15462909.onlinehome-server.info>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org> <alpine.DEB.1.00.1410081139330.990@s15462909.onlinehome-server.info> <20141008105901.GA9433@seldon>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Wed Oct 08 15:58:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbrl7-0001Zo-Sw
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 15:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756293AbaJHN6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 09:58:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:62902 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755848AbaJHN6W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 09:58:22 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MPZuP-1XXD3L2gMb-004khX;
 Wed, 08 Oct 2014 15:58:18 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20141008105901.GA9433@seldon>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:AWbxrAW7eFJ84fuwWuYK0M+tQlpr/fDDgCeNSHRQjhyds8dM40K
 jkamJ+QTY72vEsdN5REdxdBGSZPZ8C3g0mqBiguM1aq5JHAGiFxDxz+2XifwjfkhipSBb6c
 9YeXz+vB9eI5tDSVp0k+hu65OXsjVTPGwy7OUGrJ8KJXCxIJLUWqLXmZuOL1zWiFiHC8ykQ
 u/J1gAzehjLDhnCy8t6Cg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Marat,

On Wed, 8 Oct 2014, Marat Radchenko wrote:

> On Wed, Oct 08, 2014 at 11:40:17AM +0200, Johannes Schindelin wrote:
> > To make it easier to review and substantially easier to work on this patch
> > series with Git, I opened a pull request on GitHub:
> >
> >       https://github.com/msysgit/git/pull/264
> >
> 
> 1. I fail to see how using a tool that doesn't send emails about review
>    comments is *easier* than just sending emails.

You probably missed how I commented on exact lines without you having to
guess from the quoted context what part of your patches I am talking
about.

You probably also missed the fact that comments on rewritten commits
automatically drop out of sight, decluttering the set of comments and
making it obvious which comments have not been addressed yet.

And finally, you probably also missed the fact that the official Git fork
for Windows was asked to review your patches because Junio defers
Windows-specific stuff to us. And as you refused to work against our
integration branches (yes, we have two, because we are working towards
switching to a more sustainable development environment, something you
already mocked successfully), we had to rebase your work onto two
branches, which is also substantially easier to do using GitHub rather
than via mails.

But I get it: you want to roll your own thing and not help us review it
let alone make use of it. That's fine, we'll manage.

> 2. Please, do not hijack patchset discussion by moving it from git@ ML to 
>    GitHub comments.

I mistook your work on Git and the fact that you have an account on GitHub
for your willingness to collaborate on this effectively. My mistake, I
apologize!

> 3. And I repeat, my goal is to push this stuff in git.git,
>    not in msysgit.git, not in git-for-windows.git, not in msys2.git, not in other
>    4k+ forks on GitHub.

Yes, your objection is noted.

Junio, we'll take it from here, don't worry.

Ciao,
Johannes
