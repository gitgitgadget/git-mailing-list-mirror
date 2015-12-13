From: rohit gupta <roborohitgupta75@gmail.com>
Subject: query regarding git merge
Date: Sun, 13 Dec 2015 17:55:59 +0000 (UTC)
Message-ID: <loom.20151213T185500-631@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 13 19:01:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8AxK-0006ef-HI
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 19:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbbLMSA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 13:00:58 -0500
Received: from plane.gmane.org ([80.91.229.3]:44632 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136AbbLMSAH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 13:00:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1a8AwG-0004Na-Qk
	for git@vger.kernel.org; Sun, 13 Dec 2015 19:00:05 +0100
Received: from static-235.222.96.14-tataidc.co.in ([static-235.222.96.14-tataidc.co.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 19:00:04 +0100
Received: from roborohitgupta75 by static-235.222.96.14-tataidc.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 19:00:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 14.96.222.235 (Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.80 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282337>

Hi,
I am confused with git merge working.

Suppose I have these 3 files in master branch-
a.txt
b.txt
d.txt

I create a branch, add c.txt to it and commit. So its final contents 
are-
a.txt
b.txt
c.txt
d.txt

Then, I checkout master branch, delete a.txt, add e.txt and commit. So 
final contents are-
b.txt
d.txt
e.txt

Now when I merge branch in master,
its result is-
b.txt
c.txt
d.txt
e.txt

Now suppose in branch, a.txt was needed for its working. And in master 
branch's latest commit a.txt was removed because maybe it wasn't needed 
or it was introducing bugs.
Now, git merge removes that a.txt
So now branch functionality wouldn't work. 
Isn't that wrong??
