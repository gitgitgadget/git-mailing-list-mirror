From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Fri, 24 Mar 2006 12:44:10 +0000
Message-ID: <20060324124410.GB3070@linux-mips.org>
References: <20060322133337.GU20746@lug-owl.de> <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 13:44:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMleT-0000Fr-Pw
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 13:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbWCXMoW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 07:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbWCXMoW
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 07:44:22 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:45748 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S932607AbWCXMoV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 07:44:21 -0500
Received: from localhost.localdomain ([127.0.0.1]:6549 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133903AbWCXMeP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 12:34:15 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k2OCiBRI005849;
	Fri, 24 Mar 2006 12:44:11 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k2OCiB5b005848;
	Fri, 24 Mar 2006 12:44:11 GMT
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17916>

On Wed, Mar 22, 2006 at 03:39:00PM -0800, Linus Torvalds wrote:

> it's "PatchSet 104" (well, for me it is, I have a hacked cvsps, so it 
> might not be that for you), which creates the "gdb-4_18-branch", but it 
> appears that cvsps hasn't actually figured out any "Ancestor branch" for 
> that commit.
> 
> What a crock.
> 
> Anyway, it's clearly a cvsps bug (mentioning a new branch without the 
> _source_ of that branch). Equally clearly, "git cvsimport" is being an ass 
> about then failing so totally on it.
> 
> I'll try to take a look at why cvsps does that.

Last I converted CVS trees to git found that about half of the branches
were branching off from the wrong commit of the parent branch.  At that
time I decieded to just move the branch using a quick script instead of
diving into cvsps.

  Ralf
