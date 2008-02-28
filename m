From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/9] Make setup_work_tree() return new prefix
Date: Thu, 28 Feb 2008 15:53:48 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802281552530.22527@racer.site>
References: <cover.1204130175.git.pclouds@gmail.com>  <20080227163902.GA28058@laptop>  <alpine.LSU.1.00.0802281130140.22527@racer.site> <fcaeb9bf0802280502m2cfc967bt792be98d81a2996@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 16:55:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUl61-0002kW-AL
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 16:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759988AbYB1PyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 10:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759285AbYB1PyV
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 10:54:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:36579 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758723AbYB1PyU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 10:54:20 -0500
Received: (qmail invoked by alias); 28 Feb 2008 15:54:18 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp023) with SMTP; 28 Feb 2008 16:54:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Yix5lkYqYd5oIFjMinJCna8YpwFOwmW52bZngdB
	hiQmykiBM5tlI0
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0802280502m2cfc967bt792be98d81a2996@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75416>

Hi,

On Thu, 28 Feb 2008, Nguyen Thai Ngoc Duy wrote:

> On Thu, Feb 28, 2008 at 6:30 PM, Johannes Schindelin 
> <Johannes.Schindelin@gmx.de> wrote:
>
> > I am sorry, but with all these intrusive changes, I get a very uneasy 
> > feeling.  As uneasy as with the original series, which I tried to fix 
> > up, not really succeeding.
> 
> In constrast I feel good :) To me setup_git_directory*() at the end look 
> really nice. No chdir() all over the place (temporary chdir() for 
> detecting .git does not count). It also gives a chance to get rid of 
> worktree to commands that do not care about worktree at all.

Well, I'll have to review your patches in depth, then.  Which will take 
some days, because I wanted to submit builtin-remote first.

Ciao,
Dscho

