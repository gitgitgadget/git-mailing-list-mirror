From: Steven Grimm <koreth@midwinter.com>
Subject: Pruning objects from history?
Date: Fri, 30 Mar 2007 19:01:27 -0700
Message-ID: <460DC0F7.1070607@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 31 04:01:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXSuM-0004CS-Hw
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 04:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933304AbXCaCBb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 22:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933305AbXCaCBb
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 22:01:31 -0400
Received: from tater.midwinter.com ([216.32.86.90]:41661 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933304AbXCaCBb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 22:01:31 -0400
Received: (qmail 16187 invoked from network); 31 Mar 2007 02:01:30 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=nJVidJzSaJ9T4xp5hn/04Z9aKAp8vf1OLHxXf5pLBngsNZjoHKJ5vOlSMHGxP3eK  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 31 Mar 2007 02:01:30 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43526>

I've imported the full history of a large project from Subversion using 
the latest git-svn. The resulting repo is huge, and I believe it's due 
in large part to a series of big tar.gz files that got checked into the 
Subversion repository by mistake early in the project's history. They 
were subsequently removed from svn, but of course git-svn grabs them and 
puts them in my local history.

Is there any way to excise those files? They are of no interest to us 
now -- they were data files for a third-party application we ended up 
not using -- and they're making git look bad in the disk usage department.

I believe this has been asked before in the context of removing 
copyrighted content from public repositories. However, I have a twist 
that may make it easier: nobody else has cloned this repository yet. I 
am free to rewrite history with no risk of messing up any downstream 
repositories, and I don't have to worry about propagating the deletions 
out to anyone. I just don't know how to do it (assuming it's doable at all.)

Thanks!

-Steve
