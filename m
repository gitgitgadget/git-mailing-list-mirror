From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5 v2] Introduce the .gitfile
Date: Mon, 18 Feb 2008 13:31:45 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181330030.30505@racer.site>
References: <1203331463-13857-1-git-send-email-hjemli@gmail.com>  <alpine.LSU.1.00.0802181214400.30505@racer.site> <8c5c35580802180456s75c9f857of1f727aca4673374@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 14:32:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR672-00075l-SZ
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 14:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760624AbYBRNcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 08:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760745AbYBRNcA
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 08:32:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:60977 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760317AbYBRNb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 08:31:58 -0500
Received: (qmail invoked by alias); 18 Feb 2008 13:31:56 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 18 Feb 2008 14:31:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DXVE3G7BDaVXaLH9bl/IeapClwReazQK+2b3kdo
	aYNMAsFOfHH7u1
X-X-Sender: gene099@racer.site
In-Reply-To: <8c5c35580802180456s75c9f857of1f727aca4673374@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74285>

Hi,

On Mon, 18 Feb 2008, Lars Hjemli wrote:

> On Feb 18, 2008 1:17 PM, Johannes Schindelin 
> <Johannes.Schindelin@gmx.de> wrote:
> > On Mon, 18 Feb 2008, Lars Hjemli wrote:
> >
> > > The patch-series has been reordered and updated according to 
> > > comments on the earlier series.
> >
> > It would be easier on a stupid reviewer like me, if you summarised 
> > what you changed.
> 
> Ok, I'll keep that in mind next time, and here's a quick summary (from
> the top of my head) of this series vs. the previous:
> * patch 1 and 2 are swapped, since the changes to git-sh-setup.sh can
> be applied onto master regardless of the rest of the patch series
> (while the other patches still rely on 1/5).
> * git-sh-setup.sh is simplified even further, and relies on
> git-rev-parse to produce the error message when no gitdir can be
> found.
> * read_gitfile_gently() is moved from environment.c into setup.c since
> it now invokes is_git_directory().
> * read_gitfile_gently() will gently ignore a 'missing' .git or a .git
> which isn't a regular file, but die()s on all other errors.

Thanks.

> > In the case of patch "1/5 => 2/5", I would even have appreciated an 
> > interdiff...
> 
> Sorry, but I don't think I understand what you mean by interdiff.

The tool interdiff of patchutils is really nice: you can visualise what 
would be the diff between the state after applying the first patch, and 
the state after applying the second patch, without applying anything at 
all:

	$ interdiff <patch1> <patch2>

Ciao,
Dscho
