From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Problem with a push
Date: Tue, 12 Jun 2007 15:15:04 -0500
Message-ID: <1181679304.12616.30.camel@ld0161-tx32>
References: <Pine.LNX.4.64.0706111632050.4406@www.mintpixels.com>
	 <alpine.LFD.0.98.0706111556160.14121@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0706111832070.4830@www.mintpixels.com>
	 <alpine.LFD.0.98.0706111727240.14121@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: plexq@plexq.com, Git List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 22:15:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyClu-0001cM-2y
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 22:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744AbXFLUPT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 16:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755523AbXFLUPS
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 16:15:18 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:59967 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbXFLUPR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 16:15:17 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l5CKF5mq021616;
	Tue, 12 Jun 2007 13:15:05 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5CKF4El025889;
	Tue, 12 Jun 2007 15:15:04 -0500 (CDT)
In-Reply-To: <alpine.LFD.0.98.0706111727240.14121@woody.linux-foundation.org>
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49995>

On Mon, 2007-06-11 at 19:40, Linus Torvalds wrote:
> That said, I don't think that's necessarily the right answer in the longer 
> run. It's how git people do things, but it's not necessarily the *best* 
> way of doing things. I think the better solution in the longer term is to 
> simply improve how "git push" works:
> 
>  - we should probably do the same kinds of .git/config file entries for 
>    pushing as we do for fetching, and just get rid of the old implicit 
>    model, and instead have a nice refspec pattern model for what gets 
>    pushed instead.

Yeah, the other day I was baffled briefly by the fact that
I added a remote to my config using "git remote add ..."
with the intent of using it for pushing to a publishing site.
I forgot that it set up fetch only refs.

Maybe a new "--push" flag to 'git remote add --push ..."
to indicated the intended flow direction for a remote?

> anyway, I think the _proper_ thing to do would be to associate each 
> [remote] entry in the config file with a "push" refspec pattern, the way 
> we do for "fetch" already.

nod

jdl
