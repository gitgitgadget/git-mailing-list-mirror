From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: git-gui console app ?
Date: Fri, 10 Aug 2007 15:31:32 +0200
Message-ID: <20070810133132.GA3770@diku.dk>
References: <20070804101058.GA520@Mac2.local> <Pine.LNX.4.64.0708041225520.14781@racer.site> <20070804115331.GA2962@Mac2.local> <20070804120342.GC9716@coredump.intra.peff.net> <20070804123834.GA3036@Mac2.local> <20070805101953.GI12507@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Colson <eco@ecocode.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 15:31:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJUaZ-0000Nf-H4
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 15:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757668AbXHJNbg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 09:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754940AbXHJNbg
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 09:31:36 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:47679 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756806AbXHJNbf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 09:31:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 5FA722781F5;
	Fri, 10 Aug 2007 15:31:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mvNNrfUmvbQJ; Fri, 10 Aug 2007 15:31:32 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 7C28E27816B;
	Fri, 10 Aug 2007 15:31:32 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A49EA6DF845; Fri, 10 Aug 2007 15:27:41 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 5E9D862DD7; Fri, 10 Aug 2007 15:31:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070805101953.GI12507@coredump.intra.peff.net>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55536>

Jeff King <peff@peff.net> wrote Sun, Aug 05, 2007:
> On Sat, Aug 04, 2007 at 02:38:34PM +0200, Erik Colson wrote:
> 
> > > By default, it will show the changes between your working tree and the
> > > index (i.e., changed but not updated). You can show the diff of "updated
> > > but not commited" with "git-diff --cached".
> > 
> > yep that is the info I would like to browse in a way git-gui does it...
> > showing a list of the files in the diff, and letting the user select a
> > file to show the part of the diff for that file.
> 
> Ah, I see. There is a status mode for tig (tig -S), but you can't jump
> to the diff of a particular file. It shouldn't be that difficult to add
> for somebody familiar with the tig codebase, but I am not such a
> somebody.
> 
> Jonas, am I right that this should be a one-liner? If you can point me
> in the right direction, I can try to take a closer look, but I'm having
> trouble following the code.

Not quite a one-liner, but I've implemented something that will show
diffs of staged/unstaged changes as well as the content of untracked
files when pressing Enter on a file in the status view. To update the
status of a file (unstaged->staged, untracked->staged, etc) you now
have to press 'u'.

Hope this helps.

-- 
Jonas Fonseca
