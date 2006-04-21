From: Bob Portmann <bportmann@yahoo.com>
Subject: git-log produces no output
Date: Fri, 21 Apr 2006 10:20:01 -0700 (PDT)
Message-ID: <20060421172001.44441.qmail@web60325.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Apr 21 19:20:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWzId-0003tA-L4
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 19:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWDURUE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Apr 2006 13:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWDURUD
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Apr 2006 13:20:03 -0400
Received: from web60325.mail.yahoo.com ([209.73.178.133]:51389 "HELO
	web60325.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751340AbWDURUD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Apr 2006 13:20:03 -0400
Received: (qmail 44443 invoked by uid 60001); 21 Apr 2006 17:20:01 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wSTvsXPbJ5k8hVcCTO/6t9teFGO5KE8K36t+smgK0DBBXdWYPuP9D7mDiAYwt1Sfo8beL8XyZFyq/DZfW8D+s2UjHpb1EqK9mtxIKQ2nf8WWu8EOhlbAxkaJAze7woAZKbHI0FkM2bVU4Wkx8miYS/mCvyQC4kqFRbUZHDhVo/s=  ;
Received: from [140.172.241.92] by web60325.mail.yahoo.com via HTTP; Fri, 21 Apr 2006 10:20:01 PDT
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19021>

I am just starting out with git and have a noob question about got-log.
 I cannot get any output out of it and am wondering if I am using it
correctly or it is broken.  As I understand it, git-log should just
print out the log messages but not the changes, whereas git-whatchanged
will print out both.  But while git-whatchanged works, git-log never
does.  I have a trivial example below which shows what I mean.  But I
get the same result using my real archives and out of git.git as well.

Thanks,
Bob

PS I'm using git 1.3.0 and have tried this on both Mac OS X and Linux
with the same results.

Trivial example:
git-test> mkdir test-log
git-test> cd test-log
test-log> git-init-db
defaulting to local storage area
test-log> echo "Hello World" >hello
test-log> git add .
test-log> git commit -a -m 'One line hello'
Committing initial tree 117c62a8c5e01758bd284126a6af69deab9dbbe2
test-log> echo "Hello World 2" >>hello
test-log> git commit -a -m 'Two line hello'
test-log> git whatchanged -p
diff-tree 9a4d7602fff052b6796c2862edddd11ae2e45d08 (from
a38306518c5e5e8eb630c02Author: Bob Portmann <portmann@xxxx.xx.xx>
Date:   Fri Apr 21 10:56:11 2006 -0600

    Two line hello

diff --git a/hello b/hello
index 557db03..514e5c5 100644
--- a/hello
+++ b/hello
@@ -1 +1,2 @@
 Hello World
+Hello World 2
test-log> git log
test-log> 

As you can see git log produces no output.  I've tried it with other
options with the same result.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
