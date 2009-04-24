From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RESEND] git-submodule: add support for --rebase.
Date: Fri, 24 Apr 2009 08:41:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904240839400.7393@intel-tinevez-2-302>
References: <20090419233051.GA17946@dingo.bne.redhat.com> <alpine.DEB.1.00.0904201152360.6955@intel-tinevez-2-302> <20090421074540.GA7885@dingo.redhat.com> <alpine.DEB.1.00.0904211047311.10279@pacific.mpi-cbg.de> <20090423034709.GA22244@dingo.bne.redhat.com>
 <alpine.DEB.1.00.0904231119160.10279@pacific.mpi-cbg.de> <20090423230637.GE2282@dingo.bne.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 08:43:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxF7g-00027d-78
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 08:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbZDXGlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 02:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbZDXGlU
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 02:41:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:52353 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751594AbZDXGlU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 02:41:20 -0400
Received: (qmail invoked by alias); 24 Apr 2009 06:41:15 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp008) with SMTP; 24 Apr 2009 08:41:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/X+NdDpm7XGKhjqnvSk3QFWUR1PJ+BDz4My5R72F
	8qwE31/EXSydTY
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090423230637.GE2282@dingo.bne.redhat.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117415>

Hi,

On Fri, 24 Apr 2009, Peter Hutterer wrote:

> 'git submodule update --rebase' rebases your local branch on top of what
> would have been checked out to a detached HEAD otherwise.
> 
> In some cases, detaching the HEAD when updating a submodule complicates
> the workflow to commit to this submodule (checkout master, rebase, then
> commit).  For submodules that require frequent updates but infrequent
> (if any) commits, a rebase can be executed directly by the git-submodule
> command, ensuring that the submodules stay on their respective branches.
> 
> git-config key: submodule.$name.rebase (bool)
> 
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Yes, I hereby give my sign-off ;-)

> ---
> 
> > With this squashed in, I actually would not be too opposed to put this 
> > into 1.6.3, as it _is_ an improvement.
> > 
> > -- snipsnap --
> > [PATCH] To be squashed in
> > 
> > This does three things:
> > 
> > - add .gitmodules support for rebase,
> > - use --bool for the git config calls for type checking, and
> > - rename ambiguous t7404 to t7406.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Squashed in, thank you. One typo fixed in last testcase (does-not-mater ->
> does-not-matter).

I just blame it on the lousy Acer keyboard which cannot follow the speed 
of my fingers.

Thanks!

Junio, how about it? post 1.6.3 or not?  It is a well contained change, 
with little chance of breaking something, but offers a more sensible 
workflow here.

Ciao,
Dscho
