From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Question about "git commit -a"
Date: Fri, 5 Oct 2007 01:03:26 +0200
Message-ID: <20071004230326.GA3092@steel.home>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com> <fe3pp3$8p1$1@sea.gmane.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Soria <sn_@gmx.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 01:03:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdZjJ-0002wN-NE
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 01:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbXJDXDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 19:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbXJDXDd
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 19:03:33 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:15277 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbXJDXDc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 19:03:32 -0400
Received: from tigra.home (Fc941.f.strato-dslnet.de [195.4.201.65])
	by post.webmailer.de (mrclete mo7) (RZmta 13.4)
	with ESMTP id 600c6cj94JYNPM ; Fri, 5 Oct 2007 01:03:27 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3557E277AE;
	Fri,  5 Oct 2007 01:03:27 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B7BA0C772; Fri,  5 Oct 2007 01:03:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fe3pp3$8p1$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAPn7A==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60019>

David Soria, Fri, Oct 05, 2007 00:34:11 +0200:
> Am Thu, 04 Oct 2007 17:38:25 +0200 schrieb Paolo Ciarrocchi:
> 
> > Hi all,
> > I was just wondering why git commit doesn't default to "-a" (yes, it's
> > another question that came up during a chat with a mercurial user) and
> > I didn't find an answer to that.
> 
> 
> in fact i do just a git-config alias.commit 'commit -a' in my repository
> 

Either you have a specially modified git (the alias expansion code) or
you just said not exactly truth. You can't alias the git commands (see
git.c's main).
