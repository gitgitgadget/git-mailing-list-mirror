From: Mike Hommey <mh@glandium.org>
Subject: Re: corrupt object on git-gc
Date: Fri, 9 Nov 2007 20:07:07 +0100
Organization: glandium.org
Message-ID: <20071109190707.GA17864@glandium.org>
References: <4fe79b4b0711090538wf483ce7j89c518962e89780e@mail.gmail.com> <alpine.LFD.0.999.0711090758560.15101@woody.linux-foundation.org> <4fe79b4b0711090953h5b06f7d4l2d17972630a4d355@mail.gmail.com> <alpine.LFD.0.999.0711091000310.15101@woody.linux-foundation.org> <4fe79b4b0711091037g8c6c048h29b7d387e75d62bb@mail.gmail.com> <alpine.LFD.0.999.0711091050230.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yossi Leybovich <sleybo@gmail.com>, git@vger.kernel.org, ae@op5.se,
	Yossi Leybovich <sleybo@mellanox.co.il>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 20:09:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqZEK-0005oV-Fo
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 20:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312AbXKITJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 14:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754484AbXKITJH
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 14:09:07 -0500
Received: from vawad.err.no ([85.19.200.177]:59144 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754312AbXKITJG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 14:09:06 -0500
Received: from aputeaux-153-1-50-102.w82-124.abo.wanadoo.fr ([82.124.10.102] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IqZDq-0004z7-I9; Fri, 09 Nov 2007 20:08:56 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IqZC7-0004hM-Cz; Fri, 09 Nov 2007 20:07:07 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0711091050230.15101@woody.linux-foundation.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64251>

On Fri, Nov 09, 2007 at 10:55:03AM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 9 Nov 2007, Yossi Leybovich wrote:
> >
> > What interesting is the second part of the experiment
> > I tried to apply the same commit on this file and it leaded to different SHA1
> 
> Eh. That commit was basically corrupt, because the blob had gotten 
> removed. I don't even understand how git diff-tree gave a diff with that 
> file at all (side note: I'd also suggest you just use "git show <commit>" 
> instead of that complex and _really_ old git-diff-tree incantation).
> 
> So no, you didn't "apply the same commit". 
> 
> But if you have the diff somewhere (perhaps email archive? you sent it to 
> somebody?) or you can re-create it exactly, then..

Or maybe just from memory, by looking at the diff between the previous version
and the next version of the file.

Mike
