From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitweb: new cgi parameter: option
Date: Thu, 12 Jul 2007 12:49:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707121248530.4516@racer.site>
References: <20070708013543.GD29994@genesis.frugalware.org> <f73hhc$uo1$1@sea.gmane.org>
 <20070711230038.GN19386@genesis.frugalware.org> <200707121211.32813.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 13:49:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8xBA-0007wX-F8
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 13:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156AbXGLLtt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 07:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752954AbXGLLtt
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 07:49:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:42262 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752096AbXGLLtt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 07:49:49 -0400
Received: (qmail invoked by alias); 12 Jul 2007 11:49:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 12 Jul 2007 13:49:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/ZLd8NhU/tEI4Yu3b4wpFk+gAwZzX/gU66r+TMg
	rFTHwS/bxJH/GU
X-X-Sender: gene099@racer.site
In-Reply-To: <200707121211.32813.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52269>

Hi,

On Thu, 12 Jul 2007, Jakub Narebski wrote:

> On Thu, 12 Jul 2007, Miklos Vajna wrote:
> > Currently the only supported value is '--no-merges' for the 'rss', 'atom',
> > 'log', 'shortlog' and 'history' actions, but it can be easily extended to allow
> > other parameters for other actions.
> >
> > Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> 
> Micronit: it is unwritten (as of yet) requirement to word wrap commit
> message at 80 columns or less.

It's not really difficult:

- snipsnap -
[PATCH] SubmittingPatches: mention line wrap

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Documentation/SubmittingPatches |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 01354c2..066e284 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -9,6 +9,8 @@ Checklist (and a short version for the impatient):
 	- provide a meaningful commit message
 	- the first line of the commit message should be a short
 	  description and should skip the full stop
+	- please use no lines longer than 76 characters, since you
+	  want to send this message as email
 	- if you want your work included in git.git, add a
 	  "Signed-off-by: Your Name <your@email.com>" line to the
 	  commit message (or just use the option "-s" when
