From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: git silently ignores aliases of existing commands
Date: Fri, 17 Jul 2009 19:01:31 -0700
Message-ID: <BLU0-SMTP9743008F68C14C8226D07BAE1F0@phx.gbl>
References: <4A611CE1.3080709@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 04:11:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRzOP-0002gm-Gw
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 04:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326AbZGRCBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 22:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbZGRCBj
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 22:01:39 -0400
Received: from blu0-omc3-s15.blu0.hotmail.com ([65.55.116.90]:21230 "EHLO
	blu0-omc3-s15.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752046AbZGRCBi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2009 22:01:38 -0400
Received: from BLU0-SMTP97 ([65.55.116.72]) by blu0-omc3-s15.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 17 Jul 2009 19:01:35 -0700
X-Originating-IP: [96.49.109.68]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from hobo ([96.49.109.68]) by BLU0-SMTP97.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 17 Jul 2009 19:01:34 -0700
In-Reply-To: <4A611CE1.3080709@pobox.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.2; i586-redhat-linux-gnu)
X-OriginalArrivalTime: 18 Jul 2009 02:01:34.0529 (UTC) FILETIME=[AD528B10:01CA074B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123504>

On Fri, 17 Jul 2009 17:52:49 -0700
Michael G Schwern <schwern@pobox.com> wrote:

[...]
> It would be nice if git used the alias *before* the installed command.  This
> lets me fix/change default behaviors without having to come up with a new
> command.  (Another handy example:  blame = blame -w)  It doesn't do anything
> useful right now anyway.

Hi Michael,

This has been discussed a few times on the list already.   Here is one such
discussion:

http://thread.gmane.org/gmane.comp.version-control.git/112487/focus=112493

You'll see that it was decided that Git would not allow commands to be overridden
so that you could always be sure what a given command would do when you sit
down at any installation.  This is especially important for scripting but can
also be a problem for everyday usage.   You'll just have to choose a new command
name for the alternate default you want.

[...]
> PS  I couldn't find anything obvious about where to send bug reports / feature
> requests in the git man page, just "general upbringing" pointing here.  It
> would be helpful if it was a bit more clear.  None of "bug", "report" or
> "issue" pointed at anything relevant.

This list is the appropriate place for any of the issues you enumerate.

Cheers,
Sean
