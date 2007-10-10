From: Jan Wielemaker <jan@swi-prolog.org>
Subject: Re: [PATCH] git-cvsserver: added support for update -p
Date: Wed, 10 Oct 2007 16:26:53 +0200
Organization: SWI-Prolog
Message-ID: <200710101626.53303.jan@swi-prolog.org>
References: <200710101316.03633.jan@swi-prolog.org> <Pine.LNX.4.64.0710101442571.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 16:33:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfcdI-0007Am-9z
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 16:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbXJJOcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 10:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754032AbXJJOcv
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 10:32:51 -0400
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:3492 "EHLO
	smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbXJJOcu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 10:32:50 -0400
Received: from gollem.science.uva.nl (gollem.science.uva.nl [146.50.26.20])
	(authenticated bits=0)
	by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id l9AEWlrL081486;
	Wed, 10 Oct 2007 16:32:47 +0200 (CEST)
	(envelope-from jan@swi-prolog.org)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0710101442571.4174@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60503>

On Wednesday 10 October 2007 15:47, Johannes Schindelin wrote:
> Hi,
>
> On Wed, 10 Oct 2007, Jan Wielemaker wrote:
> > [PATCH] git-cvsserver: added support for update -p
> > ---
>
> Proposed alternative for the commit message:
>
> -- snip --
> The cvs subcommand "update -p <file>" is frequently used to see the
> contents of a given file in HEAD, sort of our "git show <file>".  It
> is not that hard to support it, so here it is.
>
> Commit-message-proposed-by: Johannes Schindelin <johannes.schindelin.de>
> Signed-off-by: Jan Wielemaker <jan@swi-prolog.org>
> -- snap --

Ok. I'm still a guy of ChangeLog files, which you generally needed for
CVS to keep track of a large project :-) As the CVS commit message
aren't much good anyway, I kept them short. Also for my own project I'm
considering to replace these with larger commit messages and drop the
ChangeLog files.

> P.S.: Have not reviewed the patch at all, so cannot say anything about the
> merits of it; will leave it to djpig ;-)

Don't trust my Perl; its just copy and intelligent(-ish) paste :-) Works
for me though and this isn't very complicated. Is there a test suite for
git-cvsserver?

	Cheers --- Jan
