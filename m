From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Commit f5bbc322 to git broke pre-commit hooks which read stdin
Date: Tue, 4 Mar 2008 10:45:12 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803041044120.22527@racer.site>
References: <0tableanpe.wl%bremner@pivot.cs.unb.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org, 469250@bugs.debian.org
To: David Bremner <bremner@unb.ca>
X-From: git-owner@vger.kernel.org Tue Mar 04 11:47:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWUfP-0005BI-ML
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 11:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbYCDKqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 05:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbYCDKqA
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 05:46:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:35701 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751123AbYCDKp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 05:45:59 -0500
Received: (qmail invoked by alias); 04 Mar 2008 10:45:57 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp045) with SMTP; 04 Mar 2008 11:45:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18M4nx8SOMMTs6vY6IgBbDJZjmXpIJqN9xWFN0pGv
	hPdNAA+GYy1e/m
X-X-Sender: gene099@racer.site
In-Reply-To: <0tableanpe.wl%bremner@pivot.cs.unb.ca>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76061>

Hi,

On Tue, 4 Mar 2008, David Bremner wrote:

> It looks like line 435 of builtin-commit.c disables stdin for hooks 
> (with the disclaimer that I first looked at the git source ten minutes 
> ago).
> 
> 	   hook.no_stdin = 1
> 
> I'm not sure if this was by design, but just so you know, this breaks 
> people's hooks.  In particular the default metastore pre-commit hook no 
> longer works.  I didn't find anything relevant in the docs [1].

Pardon my ignorance, but what business has metastore reading stdin?  There 
should be nothing coming in, so the change you mentioned should be 
correct, and your hook relies on something it should not rely on.

Ciao,
Dscho

