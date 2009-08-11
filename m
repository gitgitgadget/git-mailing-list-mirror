From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bug with .git file and aliases
Date: Tue, 11 Aug 2009 10:33:02 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908111030240.4638@intel-tinevez-2-302>
References: <7f9d599f0907200654q2e068e6aq3051c122f6596053@mail.gmail.com>  <20090720152117.GB5347@coredump.intra.peff.net> <7f9d599f0908101322i46384247m303e28955f88bbb@mail.gmail.com>  <alpine.DEB.1.00.0908110101110.8306@pacific.mpi-cbg.de>
 <7f9d599f0908102037s51f0380te56463706f794c8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:33:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaqXd-0007sb-0i
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908AbZHKMdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 08:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090AbZHKMdE
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:33:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:48319 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753058AbZHKMdC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 08:33:02 -0400
Received: (qmail invoked by alias); 11 Aug 2009 08:33:03 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp027) with SMTP; 11 Aug 2009 10:33:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194gsp16g54isHMuoj6qaVwr2dKIz60BospTnbqah
	kMfOvRfcEoW8lA
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7f9d599f0908102037s51f0380te56463706f794c8a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125538>

Hi,

On Mon, 10 Aug 2009, Geoffrey Irving wrote:

> On Mon, Aug 10, 2009 at 7:05 PM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>
> > The proper fix, of course, is to avoid calling the function with the 
> > wrong path to begin with.
> 
> I'm happy that the correct fix is obvious, and apologize for missing it.

No, no, I said that it is obvious what should be fixed (you do not want 
to break perfectly valid workflows such as having a worktree set in the 
config, but overriding it via git's --work-tree option).  The fix is not 
obvious, unfortunately.

See also http://thread.gmane.org/gmane.comp.version-control.git/102269 for 
some discussion on the same topic.

Ciao,
Dscho
