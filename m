From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v1 3/3] git-gui hooks for new config variable
 "diff.primer"
Date: Sun, 25 Jan 2009 19:22:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901251918230.14855@racer>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <1232904657-31831-3-git-send-email-keith@cs.ucla.edu> <1232904657-31831-4-git-send-email-keith@cs.ucla.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Keith Cascio <keith@cs.ucla.edu>
X-From: git-owner@vger.kernel.org Sun Jan 25 19:23:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR9di-0006Go-3d
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 19:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbZAYSVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 13:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbZAYSVx
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 13:21:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:60403 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750855AbZAYSVw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 13:21:52 -0500
Received: (qmail invoked by alias); 25 Jan 2009 18:21:49 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp038) with SMTP; 25 Jan 2009 19:21:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18KdTBDgMoKgSk+GIrlW6RiCNDWWzuVLZ66r668vM
	+lsM2XqZPPhZv3
X-X-Sender: gene099@racer
In-Reply-To: <1232904657-31831-4-git-send-email-keith@cs.ucla.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107075>

Hi,

On Sun, 25 Jan 2009, Keith Cascio wrote:

> git-gui hooks for new config variable "diff.primer".
> Add three checkboxes to both sides of
> options panel (local/global).
> Add a sub-menu named "White Space" to
> diff-panel right-click context menu, with
> three checkboxes.

Rather than storing the information about how to call "git diff" as 
diff.primer, why don't you store that information in a config variable 
gui.whiteSpaceMode and teach "git gui" to call "git diff" accordingly?

That would have the further advantage of not breaking other people's 
setups...

>  git-gui/git-gui.sh     |   51 ++++++++++++++++++++++++++++++++++++++++++
>  git-gui/lib/option.tcl |   57 +++++++++++++++++++++++++++++++++++++++++++----

Please submit git-gui patches without the git-gui prefix, as it makes it 
harder on the maintainer of git-gui, Shawn (who you did not Cc: BTW).

Ciao,
Dscho
