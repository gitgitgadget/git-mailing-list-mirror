From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Git/Mercurial interoperability (and what about bzr?)
Date: Tue, 28 Oct 2008 16:02:57 +0100
Message-ID: <vpqr660g3tq.fsf@bauges.imag.fr>
References: <ge0rla$mce$1@ger.gmane.org> <ge70nl$l6t$1@ger.gmane.org>
	<alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	<Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se>
	<alpine.DEB.1.00.0810281551040.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 28 16:09:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuqCM-0004dh-L1
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 16:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbYJ1PIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 11:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbYJ1PIU
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 11:08:20 -0400
Received: from imag.imag.fr ([129.88.30.1]:46080 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224AbYJ1PIT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 11:08:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m9SF37Rn028861
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 28 Oct 2008 16:03:07 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Kuq5y-0000Ia-2r; Tue, 28 Oct 2008 16:02:58 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Kuq5y-0001MQ-0U; Tue, 28 Oct 2008 16:02:58 +0100
In-Reply-To: <alpine.DEB.1.00.0810281551040.22125@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes Schindelin's message of "Tue\, 28 Oct 2008 15\:59\:04 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 28 Oct 2008 16:03:07 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99294>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Wasn't bzr touting it as one of their major features that they could have 
> foreign-scm remotes?  If I remembered that correctly, that might be the 
> route you want to take.

Yes, see http://bazaar-vcs.org/BzrForeignBranches . That can be
compared to git-svn for git, except that one uses the exact same
command set to interact with the remotes (i.e. you "bzr push" to an
svn repository, while you would "git svn dcommit" with git).

There are read-only implementations of Git and Mercurial foreign
branches. AFAIK, unfortunately, they're more proof of concepts than
real "production ready" plugins.

-- 
Matthieu
