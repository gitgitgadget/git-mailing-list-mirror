From: Norbert Preining <preining@logic.at>
Subject: Re: Creating something like increasing revision numbers
Date: Mon, 19 Oct 2009 03:33:20 +0200
Message-ID: <20091019013320.GD17397@gamma.logic.tuwien.ac.at>
References: <20091018144158.GA9789@gandalf.dynalias.org> <alpine.LNX.2.00.0910181727130.32515@iabervon.org> <20091019004447.GC11739@gamma.logic.tuwien.ac.at> <alpine.LNX.2.00.0910182045580.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Oct 19 03:33:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzh7p-0004eR-2Q
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 03:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbZJSBdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 21:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbZJSBdR
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 21:33:17 -0400
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:46634 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbZJSBdR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 21:33:17 -0400
Received: from gamma.logic.tuwien.ac.at ([128.130.175.3] ident=Debian-exim)
	by mx.logic.tuwien.ac.at with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <preining@logic.at>)
	id 1Mzh7h-0001lN-3T; Mon, 19 Oct 2009 03:33:21 +0200
Received: from preining by gamma.logic.tuwien.ac.at with local (Exim 4.69)
	(envelope-from <preining@logic.at>)
	id 1Mzh7g-0004iP-UK; Mon, 19 Oct 2009 03:33:21 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910182045580.14365@iabervon.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130635>

Hi Daniel,

On So, 18 Okt 2009, Daniel Barkalow wrote:
> > - how would one access this "sequence" number on the server
> 
> There isn't currently anything built in that counts up like that; however, 
> it shouldn't be too hard to add something, because the reflog gets an 
> entry at the same times the sequence number would increase. In fact, you 

Ok.

> > - is there a way to determine at which of this "sequence" numbers a specific
> >   file has been changed last?
> 
> There isn't a built-in way, but you can find the current hash for a 
> filename with "git ls-tree -r <branch> <filename>", and find the hash as 
> of N changes ago with "git ls-tree -r <branch>@{<N>} <filename>". You're 
> looking for the smallest N where they don't match. (And you probably 
> don't want to be a binary search or the like, because that might miss that 

That sounds like we cannot use that, because we have to do that for about
80k files and that on each (at least daily) rebuilt. That is not feasable.

Again thanks for your helpful comments!

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining                                        Associate Professor
JAIST Japan Advanced Institute of Science and Technology   preining@jaist.ac.jp
Vienna University of Technology                               preining@logic.at
Debian Developer (Debian TeX Task Force)                    preining@debian.org
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
BRUMBY
The fake antique plastic seal on a pretentious whisky bottle.
			--- Douglas Adams, The Meaning of Liff
