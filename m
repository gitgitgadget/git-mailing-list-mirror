From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git merge --no-commit <branch>; does commit
Date: Sat, 15 Dec 2007 20:37:41 +0100
Message-ID: <20071215193741.GB3021@steel.home>
References: <alpine.LSU.0.99999.0712132151080.5326@castor.milkiway.cos> <81b0412b0712131319h63609810m593f0e552d02a83c@mail.gmail.com> <alpine.LSU.0.99999.0712132224280.5606@castor.milkiway.cos> <20071214074925.GA3525@steel.home> <alpine.LSU.0.99999.0712151905280.4341@castor.milkiway.cos>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Sat Dec 15 20:38:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3cpr-0001cv-RV
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 20:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbXLOThq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 14:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755979AbXLOThq
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 14:37:46 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:64641 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbXLOThp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 14:37:45 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtozW3g==
Received: from tigra.home (Faa31.f.strato-dslnet.de [195.4.170.49])
	by post.webmailer.de (mrclete mo21) (RZmta 14.6)
	with ESMTP id 6069cbjBFHA8FK ; Sat, 15 Dec 2007 20:37:42 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 153DC277AE;
	Sat, 15 Dec 2007 20:37:42 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id F0B6156D22; Sat, 15 Dec 2007 20:37:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.0.99999.0712151905280.4341@castor.milkiway.cos>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68410>

Michael Dressel, Sat, Dec 15, 2007 19:14:48 +0100:
>> Maybe. Or maybe you misunderstood the meaning of --squash, which also
>> is not a merge.
>
> Since "git merge --squash <branch>" does a merge of <branch> into the 
> working tree why would you not call it a merge?

Because merge, in Git language, means connection histories. That one
just mixes the text. That's different operation, kind of editing a
file.

> Anyway that was what I wanted. Merging <branch> (a topic branch) into my 
> current branch (the main branch) but being able to create commits that are
> more suitable for keeping in the history of the current branch than the
> commits I created during developing on <branch>.
> Would you recommend a different way of doing this?

I would not recommend doing it at all. If I must, I'd rather use
git-rebase -i (interactive rebase).
