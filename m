From: Daniel Quinlan <danq@brtt.com>
Subject: help with git usage
Date: Tue, 29 Apr 2008 11:37:32 -0600
Message-ID: <200804291738.m3THc2hC030601@rs40.luxsci.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 19:48:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqtvq-0002zn-Li
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 19:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228AbYD2RrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 13:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbYD2RrG
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 13:47:06 -0400
Received: from rs40.luxsci.com ([65.61.166.82]:60181 "EHLO rs40.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753290AbYD2RrF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 13:47:05 -0400
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Apr 2008 13:47:05 EDT
Received: from rs40.luxsci.com (localhost [127.0.0.1])
	by rs40.luxsci.com (8.13.1/8.13.7) with ESMTP id m3THcvU6031987
	for <git@vger.kernel.org>; Tue, 29 Apr 2008 12:38:57 -0500
Received: (from root@localhost)
	by rs40.luxsci.com (8.13.1/8.13.7/Submit) id m3THc2hC030601
	for git@vger.kernel.org; Tue, 29 Apr 2008 17:38:02 GMT
Received: (from danq@brtt.com) by Lux Scientiae SMTP Processor; Tue, 29 Apr 2008 17:38:02 +0000
X-Comment: Lux Scientiae SMTP Processor Message ID - 1209490682-8922023.45681934
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80709>

I've been trying to use git for awhile now, (and I've read a lot of  
documentation, though maybe my
comprehension has not been high enough) but there are several  
operations which I
can't figure out:

1) After cloning a repository from work at home, making some changes  
and committing them,
I use "git push" to push them back to the work repository.  The  
changes seem to make it to the
work repository (I see the commit message in git log), but I can't  
figure out how to get the
changes into the working set at work.  (evidently not merge, checkout  
or reset -- seems like it
should be merge, but)

2) I can't figure out how to get back the latest (or any other)  
version of a file I've modified (or deleted)
in the working set.  (Well, I suppose I could checkout the whole tree  
somewhere else and copy the
relevant file, but I'm hoping there's something simpler).

3) Similarly, I can't use the little context diffs I can see in git- 
gui  -- I need to see side by side comparisons;
I've become accustomed to tkdiff.  It seems like git mergetool knows  
how to do that in some restricted
circumstances, but I want to do it outside the context of a merge.

Thanks,
-- danq
