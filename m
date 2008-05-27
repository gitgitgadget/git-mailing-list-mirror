From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] git-what: explain what to do next
Date: Tue, 27 May 2008 11:53:43 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805271151430.30431@racer>
References: <1211877299-27255-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-626774316-1211885625=:30431"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 12:54:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0wp4-0003cR-2c
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 12:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756369AbYE0Kxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 06:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756253AbYE0Kxi
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 06:53:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:35618 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755556AbYE0Kxh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 06:53:37 -0400
Received: (qmail invoked by alias); 27 May 2008 10:53:36 -0000
Received: from R4c6b.r.pppool.de (EHLO racer.local) [89.54.76.107]
  by mail.gmx.net (mp018) with SMTP; 27 May 2008 12:53:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19S7wF2z5FSF2YJTo5VOpZV3TWnA9J/bsKI8UoHzp
	U/inORooSevuja
X-X-Sender: gene099@racer
In-Reply-To: <1211877299-27255-1-git-send-email-sbejar@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83002>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-626774316-1211885625=:30431
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 27 May 2008, Santi Béjar wrote:

> In case you don't know the next step, if it is "git commit",
> "git commit --amend", "git rebase --continue" or something else.

We had a patch similar to this already, but I think that the right 
approach is _not_ to teach the single commands to explain their state, but 
to make a new script guessing the current state.  AFAIR we have something 
like that in the completions already, as an (optional) prompt.

However, I think it would make sense to push for that 
.dotest,.git/.dotest-merge -> .git/rebase change _before_ having anything 
like git-whazzup.sh.

Ciao,
Dscho
--8323329-626774316-1211885625=:30431--
