From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: StGIT (or guilt) + git-svn?
Date: Tue, 24 Jul 2007 15:39:16 -0400
Message-ID: <20070724193915.GA6291@filer.fsl.cs.sunysb.edu>
References: <46A5D279.7060601@midwinter.com> <20070724112706.GA9540@dervierte> <46A5EE4B.7020905@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Walter <stevenrwalter@gmail.com>,
	"'git'" <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 21:39:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDQEB-0004tt-KL
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 21:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbXGXTjY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 15:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752228AbXGXTjY
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 15:39:24 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:42203 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbXGXTjX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 15:39:23 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l6OJdG7j007125;
	Tue, 24 Jul 2007 15:39:16 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l6OJdG4F007123;
	Tue, 24 Jul 2007 15:39:16 -0400
Content-Disposition: inline
In-Reply-To: <46A5EE4B.7020905@midwinter.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53633>

On Tue, Jul 24, 2007 at 08:19:23PM +0800, Steven Grimm wrote:
> Steven Walter wrote:
> >That said, I'm not sure that stgit will help you with "local versioning"
> >of files (I'm not even sure what you mean).  Perhaps you can elaborate
> >on this point.
> >  
> 
> He wants to create some files in his git-svn clone and use git to manage 
> them -- checkpointing his work in progress, backing out changes, etc., 
> without publishing those files to the svn repository. The files in 
> question are not already in svn. But he does want to work on other files 
> that *are* in the svn repository, and wants those changes to be 
> committed back.
> 
> So my assumption was that he would do something like maintain his 
> local-only changes as StGIT patches that never get committed to git. His 
> other changes would get committed from StGIT to git, and from there he'd 
> do his normal git-svn dcommit. Or maybe git-svn dcommit followed by stg 
> rebase since git-svn dcommit creates new revision IDs.
> 
> In any event, now that I know it's working successfully for at least one 
> person, I'll point him to stg and he can play with it a bit. Didn't want 
> to lead him into a dead end. Thanks!

If I understand your scenario correctly, guilt will work just as well.

Josef 'Jeff' Sipek.

-- 
All science is either physics or stamp collecting.
		- Ernest Rutherford
