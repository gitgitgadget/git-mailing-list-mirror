From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-rebase.txt: Mention that --whitespace cannot be used
 with interactive rebase.
Date: Fri, 13 Feb 2009 00:51:45 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902130050420.26370@racer>
References: <20090212102119.1de19087@crow> <7veiy3i61g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:53:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXlMx-0003jR-HQ
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 00:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761432AbZBLXvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 18:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753178AbZBLXvx
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 18:51:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:49027 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760215AbZBLXvw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 18:51:52 -0500
Received: (qmail invoked by alias); 12 Feb 2009 23:51:49 -0000
Received: from pD9EB2494.dip0.t-ipconnect.de (EHLO noname) [217.235.36.148]
  by mail.gmx.net (mp060) with SMTP; 13 Feb 2009 00:51:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ht6pQuFAhS/W8sBMg1h5d6+iXDQKef2zyLV5VGO
	PMXQhNgoT/0BJ7
X-X-Sender: gene099@racer
In-Reply-To: <7veiy3i61g.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109684>

Hi,

On Thu, 12 Feb 2009, Junio C Hamano wrote:

> Mark Burton <markb@ordern.com> writes:
> 
> > Signed-off-by: Mark Burton <markb@ordern.com>
> > ---
> >  Documentation/git-rebase.txt |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > index 3d6d429..60582a4 100644
> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -246,6 +246,7 @@ OPTIONS
> >  --whitespace=<nowarn|warn|error|error-all|strip>::
> >  	This flag is passed to the 'git-apply' program
> >  	(see linkgit:git-apply[1]) that applies the patch.
> > +	Not supported when using the --interactive option.
> 
> So is it "not supported when using", or "incompatible with"?
> 
> If the option is silently ignored, it is former, and we have a bug.  If
> the program refuses to work then it is the latter.

The program outputs the usage and dies when -i and --whitespace (or for 
that matter, -C) are passed.

Ciao,
Dscho
