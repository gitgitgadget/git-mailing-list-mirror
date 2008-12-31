From: Daniel Barkalow <barkalow@iabervon.org>
Subject: RE: for newbs = little exercise / tutorial / warmup for windows and
 other non-sophisticated new Git users :-) [Scanned]
Date: Wed, 31 Dec 2008 11:00:28 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812311039370.19665@iabervon.org>
References: <BB5F02FD3789B54E8964D38D6775E718242D38@ALTMORE-SVR.altmore.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Jeff Whiteside <jeff.m.whiteside@gmail.com>,
	git@vger.kernel.org
To: Conor Rafferty <conor.rafferty@altmore.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 31 17:01:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LI3W4-0005Ce-8J
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 17:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874AbYLaQAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 11:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755531AbYLaQAa
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 11:00:30 -0500
Received: from iabervon.org ([66.92.72.58]:47015 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755495AbYLaQAa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 11:00:30 -0500
Received: (qmail 23292 invoked by uid 1000); 31 Dec 2008 16:00:28 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Dec 2008 16:00:28 -0000
In-Reply-To: <BB5F02FD3789B54E8964D38D6775E718242D38@ALTMORE-SVR.altmore.local>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104278>

On Wed, 31 Dec 2008, Conor Rafferty wrote:

> And you would be wrong, IMHO.  Many people have untracked files or
> directories in their working directory ('cause they are working there)
> that they don't want deleted willy-nilly.  Build files, modifications
> that should be on a different branch, etc.  There's another thread
> active on the list complaining that git removes too much from the
> working tree.
> 
> ** An SCM should be able to cope with both use cases. In fact I make it
> easy for the SCM by deleting EVERYTHING from the working directory,
> before calling git-checkout.

In this case, git thinks you actually meant to delete those tracked files, 
and does its best to not undelete them unless you ask it to get them back. 
Git is very careful not to lose your changes, which is very nice most of 
the time, but means that you can't make changes and expect git to lose 
them.

	-Daniel
*This .sig left intentionally blank*
