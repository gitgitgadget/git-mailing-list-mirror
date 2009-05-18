From: jake varghese <jake@orgsync.com>
Subject: Git screwup with reset
Date: Mon, 18 May 2009 09:58:11 -0500
Message-ID: <9D569322-6A7B-4447-962C-0C740945E227@orgsync.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 17:04:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M64Oc-0002He-79
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 17:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbZERPEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 11:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbZERPEo
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 11:04:44 -0400
Received: from outbound-mail-156.bluehost.com ([67.222.39.36]:44017 "HELO
	outbound-mail-156.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751140AbZERPEn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 May 2009 11:04:43 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 May 2009 11:04:43 EDT
Received: (qmail 3286 invoked by uid 0); 18 May 2009 14:58:05 -0000
Received: from unknown (HELO box198.bluehost.com) (69.89.25.198)
  by outboundproxy5.bluehost.com with SMTP; 18 May 2009 14:58:05 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=orgsync.com;
	h=Received:Mime-Version:Content-Transfer-Encoding:Message-Id:Content-Type:To:From:Subject:Date:X-Mailer:X-Identified-User;
	b=eXn67eSQhKA/BjcqhlXYemNBZ5u3YO8HEeUA+Vd/coVB/EjJEOb8xIjcs4Hnun+ZEPQtoUd7hVhX2begGTIKyYEp+nTRWBpCO23SNqRm2JKWKqdV6OZJPVa7u3OgPWZ8;
Received: from [24.174.13.6] (helo=[192.168.1.2])
	by box198.bluehost.com with esmtpa (Exim 4.69)
	(envelope-from <jake@orgsync.com>)
	id 1M64I1-0006On-6j
	for git@vger.kernel.org; Mon, 18 May 2009 08:58:05 -0600
X-Mailer: Apple Mail (2.753.1)
X-Identified-User: {1074:box198.bluehost.com:orgsyncs:orgsync.com} {sentby:smtp auth 24.174.13.6 authed with jake@orgsync.com}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119446>

Hi All,

I really screwed up.  I had about 2 weeks worth of code I was working  
on that got reset right out before commit.

Here's what happened.

1.  I coded for 2 weeks and didnt commit or add anything (yes, i  
know, real stupid)
2.  I was attempting to commit today and added the files.
3.  I realized a couple of files were added that i didnt want and  
werent being matched to the gitignore because i spelled them wrong.   
I fixed the gitignore file but the files still showed up, Im guessing  
because i used "git add ." before.
4.  Then i ran git reset --hard because i just wanted to undo the  
add.  Clearly this was where everything fell apart.
5.  I lost 2 weeks worth of code.

That's basically how it happened.


When I run git fsck --lost-found i get a whole bunch of dangling  
objects.  If I run git show on those objects it shows me the code  
that was lost.  Anyone know of a way to get this stuff back.  I tried  
rebasing and merging and neither worked.




Thanks in advance,


Jake Varghese
OrgSync Inc.
866.ORG.SYNC
jake@orgsync.com
www.orgsync.com
