From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make builtin-reset.c use parse_options.
Date: Sun, 2 Mar 2008 16:32:18 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803021631210.22527@racer.site>
References: <47C98472.8000002@gmail.com>  <7vir05x2di.fsf@gitster.siamese.dyndns.org> <1b46aba20803020437p2a5128a5wfee3e98c32c1a610@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 17:34:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVr8U-0002dr-Ix
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 17:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbYCBQdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 11:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753480AbYCBQdQ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 11:33:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:34414 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752804AbYCBQdE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 11:33:04 -0500
Received: (qmail invoked by alias); 02 Mar 2008 16:33:02 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp047) with SMTP; 02 Mar 2008 17:33:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/n4f07NYTnOfN1eMq4UDgcoAxsztd0VMSDZcl9ok
	p3fX6/lBtQZTuR
X-X-Sender: gene099@racer.site
In-Reply-To: <1b46aba20803020437p2a5128a5wfee3e98c32c1a610@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75803>

Hi,

On Sun, 2 Mar 2008, Carlos Rica wrote:

> On Sun, Mar 2, 2008 at 3:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Carlos Rica <jasampler@gmail.com> writes:
> >
> >  > Signed-off-by: Carlos Rica <jasampler@gmail.com>
> >
> >  Hmmm.  "git reset -h" now defaults to --hard?
> >
> >  It somehow feels a bit risky for new people.  I dunno.
> >
> 
> Option -h just prints the options and exits.

>From the original patch: 

+               OPT_SET_INT(0, "hard", &reset_type,
+                               "reset HEAD, index and working tree", HARD),

It might be that I am misreading something, but I gather that Junio missed 
that there is no short option here.

Junio, am I right?

Ciao,
Dscho

