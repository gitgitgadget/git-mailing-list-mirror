From: Steven Grimm <koreth@midwinter.com>
Subject: Re: StGIT (or guilt) + git-svn?
Date: Tue, 24 Jul 2007 20:19:23 +0800
Message-ID: <46A5EE4B.7020905@midwinter.com>
References: <46A5D279.7060601@midwinter.com> <20070724112706.GA9540@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: 'git' <git@vger.kernel.org>
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 14:19:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDJMQ-00044V-DM
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 14:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbXGXMT1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 08:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbXGXMT1
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 08:19:27 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:53186
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1751821AbXGXMT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 08:19:26 -0400
Received: (qmail 20189 invoked from network); 24 Jul 2007 12:19:26 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=wjTy1oHY5C0yaQa8vkCOVdi77C30A3xyRIZBo2BIFbIb12eXIafGHQ58U8s+MXLp  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 24 Jul 2007 12:19:26 -0000
User-Agent: Thunderbird 2.0.0.5 (Macintosh/20070716)
In-Reply-To: <20070724112706.GA9540@dervierte>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53578>

Steven Walter wrote:
> That said, I'm not sure that stgit will help you with "local versioning"
> of files (I'm not even sure what you mean).  Perhaps you can elaborate
> on this point.
>   

He wants to create some files in his git-svn clone and use git to manage 
them -- checkpointing his work in progress, backing out changes, etc., 
without publishing those files to the svn repository. The files in 
question are not already in svn. But he does want to work on other files 
that *are* in the svn repository, and wants those changes to be 
committed back.

So my assumption was that he would do something like maintain his 
local-only changes as StGIT patches that never get committed to git. His 
other changes would get committed from StGIT to git, and from there he'd 
do his normal git-svn dcommit. Or maybe git-svn dcommit followed by stg 
rebase since git-svn dcommit creates new revision IDs.

In any event, now that I know it's working successfully for at least one 
person, I'll point him to stg and he can play with it a bit. Didn't want 
to lead him into a dead end. Thanks!

-Steve
