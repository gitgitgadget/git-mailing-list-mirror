From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RESEND] git-submodule: add support for --rebase.
Date: Mon, 20 Apr 2009 11:55:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904201152360.6955@intel-tinevez-2-302>
References: <20090419233051.GA17946@dingo.bne.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 20 11:57:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvqFm-00074f-6W
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 11:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646AbZDTJz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 05:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754539AbZDTJz5
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 05:55:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:57301 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754517AbZDTJz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 05:55:57 -0400
Received: (qmail invoked by alias); 20 Apr 2009 09:55:55 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp003) with SMTP; 20 Apr 2009 11:55:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1929EkmxrJ2cBjI7s8X+uUF6igEPKtuYK7SEqoT3t
	pAMibDMBpOqdXT
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090419233051.GA17946@dingo.bne.redhat.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116957>

Hi,

On Mon, 20 Apr 2009, Peter Hutterer wrote:

> 'git submodule update --rebase' rebases your local branch on top of what would

This line is so long that it got wrapped in my mail program.  But it is 
even worse: we would like to show this in an 80-column display with a 
4-space indent, so it would be nice if you could rewrap to 76 columns (I 
even use 72 columns, because it looks nicer).

> Original thread died after discussions about the wording in the man 
> page, last reviewer comment being:
>
> "You can really rebase only onto a commit.  And the index is not a 
> commit, so I do not like the wording (not even in the rebase man page).
> 
> But let's see what other reviewers say... :-)"

I take this as a sign that other reviewers (if any) agree with me ;-)

> I'm still unsure about whether to change the wording (it currently uses 
> the same terms as git-rebase and the rest of the git-submodule man 
> page). Please let me know what to do to get this patch done.

AFAIR I gave an alternative wording, am I wrong?

So I'd prefer a repost with rewrapped commit message and reworded man page 
modifications.

However, I could imagine that Junio does not want to take this patch right 
now, as we are deep in -rc mode for the upcoming 1.6.3.  Junio?

Ciao,
Dscho
