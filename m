From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: restriction of pulls
Date: Mon, 12 Feb 2007 15:13:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702121508360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702091149.12462.duelli@melosgmbh.de>
 <Pine.LNX.4.63.0702091554160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45CC941E.9030808@dawes.za.net> <Pine.LNX.4.63.0702101533060.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D07296.7070804@dawes.za.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rogan Dawes <lists@dawes.za.net>,
	Christoph Duelli <duelli@melosgmbh.de>, git@vger.kernel.org
To: Rogan Dawes <discard@dawes.za.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 15:13:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGbwE-0007QQ-T8
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 15:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbXBLONr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 09:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbXBLONr
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 09:13:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:59402 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964936AbXBLONq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 09:13:46 -0500
Received: (qmail invoked by alias); 12 Feb 2007 14:13:45 -0000
X-Provags-ID: V01U2FsdGVkX19X5ExhjANXROmNETR3G4YFFJgKj1zM6aBBZWVv3G
	NVDQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45D07296.7070804@dawes.za.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39402>

Hi,

On Mon, 12 Feb 2007, Rogan Dawes wrote:

> Johannes Schindelin wrote:
> > 
> > (my favourite:)
> > - use git-split to create a new branch, which only contains doc/. Do work
> > only on that branch, and merge into mainline from time to time.
> 
> Your third option sounds quite clever, apart from the problem of attributing a
> commit and a commit message to someone, when the actual commit doesn't match
> what they actually did :-(

This problem is not related to subprojects at all. If the commit message 
does not match the patch, you are always fscked.

> As well as wondering what happens when they check out a few more files. Do we
> rewrite those commits as well? What happens if the user has made some commits
> already? What happens if they have already sent those upstream? etc.

I think you misunderstood. My favourite option would make docs a 
_separate_ project, with its own history. It just happens to be pulled 
from time to time, just like git-gui, gitk and git-fast-import in git.git.

> I think the best solution is ultimately to make git able to cope with 
> certain missing objects.

Hmm. I am not convinced. On nice thing about git is its level of 
integrity. Which means that no random objects are missing.

> I started writing this in response to another message, but it will do fine
> here, too:
> 
> The description I give here will likely horrify people in terms of
> communications inefficiency, but I'm sure that can be improved.
>
> [goes on... and describes the lazy clone!]

AFAICT this really is the lazy clone. And it was already determined that 
it is all to easy to pull in all commit objects by accident. Which boils 
down to a substantial chunk of the repository.

But if you want to play with it: by all means, go ahead. It might just be 
that you overcome the fundamental difficulties, and we get something nice 
out of it.

Ciao,
Dscho
