From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 09/13] Honour the refspec when updating refs after 
 import
Date: Wed, 4 Nov 2009 16:30:07 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911041624401.14365@iabervon.org>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>  <1257364098-1685-10-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0911041601170.14365@iabervon.org> <fabb9a1e0911041321i1ccec898r53ddafb9405c6331@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 22:30:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5nQq-00078s-Jc
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 22:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758205AbZKDVaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 16:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758183AbZKDVaD
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 16:30:03 -0500
Received: from iabervon.org ([66.92.72.58]:36091 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756838AbZKDVaD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 16:30:03 -0500
Received: (qmail 765 invoked by uid 1000); 4 Nov 2009 21:30:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Nov 2009 21:30:07 -0000
In-Reply-To: <fabb9a1e0911041321i1ccec898r53ddafb9405c6331@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132152>

On Wed, 4 Nov 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Wed, Nov 4, 2009 at 22:20, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > That's not true for "git pull <url> <branch>"; we do want the remote ref,
> > but it doesn't have a local peer. I think going straight to the refspec
> > command is the right answer.
> 
> Can you clarity what you mean with "the refspec command"?

Whatever it is that lets the helper tell the transport code where in the 
helper's private namespace to look for refs. I'd been thinking the helper 
would advertize the "refspec" capability, and the transport code would 
call the "refspec" command in order to get the helper to report that; but 
then I actually only said that the helper reports refspec, and not 
proposed a name for the command.

	-Daniel
*This .sig left intentionally blank*
