From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Again with git-svn: File was not found in commit
Date: Tue, 21 Apr 2009 11:02:31 -0700
Message-ID: <20090421180231.GB16642@dcvr.yhbt.net>
References: <747CFDA3-AC27-44EB-A69C-BF9C29B05A31@kineticode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David E. Wheeler" <david@kineticode.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 20:09:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwKKy-0004P8-1P
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 20:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146AbZDUSCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 14:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754954AbZDUSCd
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 14:02:33 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57215 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742AbZDUSCc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 14:02:32 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0470D1F79F;
	Tue, 21 Apr 2009 18:02:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <747CFDA3-AC27-44EB-A69C-BF9C29B05A31@kineticode.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117145>

"David E. Wheeler" <david@kineticode.com> wrote:
> After around 30 hours of the fan running full tilt on my MacBook Pro,  
> creating 343 branches (yeah, we have a lot of tags), `git svn` exited  
> with this error:
>
>     bricolage/branches/rev_1_8/lib/Bric/App/ApacheConfig.pm was not  
> found in commit
>     e5145931069a511e98a087d4cb1a8bb75f43f899 (r5256)
>
> This seemed strange to me, so I had a look at SVN:
>
>     svn list -r5256 http://svn.bricolage.cc/bricolage/branches/rev_1_8/lib/Bric/App/ApacheConfig.pm
>     ApacheConfig.pm
>
> So the file *is* there in that revision. I had been running 1.6.1.2, so I 
> upgraded to 1.6.2.2 and ran `git svn fetch` again to see if it would pick 
> up where it left off, but it returned the same error (please don't tell 
> me I have to start over!).

Interesting.  I finally managed to reproduce it over the weekend.  I'll
try to look into it later tonight.

-- 
Eric Wong
