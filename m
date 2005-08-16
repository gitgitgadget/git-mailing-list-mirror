From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git 1.0 Synopis (Draft v4)
Date: Tue, 16 Aug 2005 17:31:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508161730120.11105@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <20050729082941.GD32263@mythryan2.michonline.com>
 <200507312215.j6VMFeqn030963@laptop11.inf.utfsm.cl>
 <20050815045546.GA7001@mythryan2.michonline.com> <7vr7cv7p61.fsf@assigned-by-dhcp.cox.net>
 <20050815065833.GE7001@mythryan2.michonline.com> <7v7jen6545.fsf@assigned-by-dhcp.cox.net>
 <20050815080218.GG7001@mythryan2.michonline.com> <7vhddr397g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508151453100.21501@iabervon.org> <7vy872fiin.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463794688-1434691266-1124206283=:11105"
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 17:36:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E53PX-00063y-Ia
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 17:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965268AbVHPPb0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 11:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVHPPb0
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 11:31:26 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:16549 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965268AbVHPPb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 11:31:26 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D532CE25E1; Tue, 16 Aug 2005 17:31:24 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BA2C899B9A; Tue, 16 Aug 2005 17:31:24 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8E6F799B92; Tue, 16 Aug 2005 17:31:24 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D3F91E25E1; Tue, 16 Aug 2005 17:31:23 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy872fiin.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794688-1434691266-1124206283=:11105
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

On Tue, 16 Aug 2005, Junio C Hamano wrote:

>   - Are all the files in Documentation/ reachable from git(7)
>     or otherwise made into a standalone document using asciidoc
>     by the Makefile?  I haven't looked into documentation
>     generation myself (I use only the text files as they are);
>     help to update the Makefile by somebody handy with asciidoc
>     suite is greatly appreciated here.
> 
>     Volunteers?

The attached script reveals:

git-unpack-objects.txt is not reachable from git.txt
git-cvsimport-script.txt is not reachable from git.txt
git-send-email-script.txt is not reachable from git.txt
git-rename-script.txt is not reachable from git.txt
tutorial.txt is not reachable from git.txt
git-show-index.txt is not reachable from git.txt
cvs-migration.txt is not reachable from git.txt
diffcore.txt is not reachable from git.txt
git-ls-remote-script.txt is not reachable from git.txt
git-apply.txt is not reachable from git.txt
git-diff-stages.txt is not reachable from git.txt
pack-protocol.txt is not reachable from git.txt

Ciao,
Dscho

---1463794688-1434691266-1124206283=:11105
Content-Type: APPLICATION/x-perl; name=check.pl
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.63.0508161731230.11105@wgmdd8.biozentrum.uni-wuerzburg.de>
Content-Description: 
Content-Disposition: attachment; filename=check.pl

IyEvdXNyL2Jpbi9wZXJsCgpvcGVuZGlyIERJUiwgIi4iOwpAZmlsZXM9KCk7
CndoaWxlKGRlZmluZWQoJF89cmVhZGRpciBESVIpKSB7CglpZigvXiguKilc
LnR4dCQvKSB7CgkJcHVzaCBAZmlsZXMsICRfOwoJfQp9CmNsb3NlZGlyIERJ
UjsKCiVlZGdlcz0oKTsKCmZvcmVhY2ggJGYgKEBmaWxlcykgewoJbXkgJWN1
cnJlbnRfZWRnZXM9KCk7CgoJb3BlbiBGSUxFLCAiPCIuJGY7CgkkbGluZW5v
PTA7Cgl3aGlsZSg8RklMRT4pIHsKCQkkbGluZW5vKys7CgkJbXkgJGJhY2t1
cD0kXzsKCQl3aGlsZSgvbGluazooLio/KVxbKC4qPylcXSguKikkLykgewoJ
CQkkXz0kMzsKCQkJIyBjaGVjayBjb25zaXN0ZW5jeQoJCQlpZigkMSBuZSAi
JDIuaHRtbCIgJiYgISQxPX4vOlwvXC8vKSB7CgkJCQlwcmludCAiJGY6JGxp
bmVubzogbGluayB0YXJnZXQgZG9lcyBub3QgbWF0Y2ggbmFtZSAoJDEgIT0g
JDIpXG4iOwoJCQl9CgkJCW15ICR0eHQ9JDE7CgkJCSR0eHQ9fnMvXC5odG1s
Ly50eHQvOwoJCQkkY3VycmVudF9lZGdlc3skdHh0fT0xOwoJCX0KCQkkXz0k
YmFja3VwOwoJCXdoaWxlKC9pbmNsdWRlOjooLio/KVxbLio/XF0oLiopJC8p
IHsKCQkJJF89JDI7CgkJCSRjdXJyZW50X2VkZ2VzeyQxfT0xOwoJCX0KCX0K
CWNsb3NlIEZJTEU7CgoJJGVkZ2VzeyRmfT1cJWN1cnJlbnRfZWRnZXM7Cn0K
CnN1YiBnZXRfZWRnZV9sZW5ndGggKCQkKSB7CglteSAkdGFnPSRfWzBdOwoJ
bXkgJHRhZzI9JF9bMV07CglteSAkdGFnMzsKCglmb3JlYWNoICR0YWczIChr
ZXlzICV7JGVkZ2VzeyR0YWcyfX0pIHsKCQlteSAkZGlmZj0kZWRnZXN7JHRh
Z30tPnskdGFnMn0rJGVkZ2VzeyR0YWcyfS0+eyR0YWczfTsKCQlpZighZGVm
aW5lZCgkZWRnZXN7JHRhZ30tPnskdGFnM30pCgkJIHx8ICRlZGdlc3skdGFn
fS0+eyR0YWczfT4kZGlmZikgewoJCQkkZWRnZXN7JHRhZ30tPnskdGFnM309
JGRpZmY7CgkJCWdldF9lZGdlX2xlbmd0aCgkdGFnLCR0YWczKTsKCQl9Cgl9
Cn0KCiR0YWc9ImdpdC50eHQiOwpmb3JlYWNoICR0YWcyIChrZXlzICV7JGVk
Z2VzeyR0YWd9fSkgewoJZ2V0X2VkZ2VfbGVuZ3RoKCR0YWcsJHRhZzIpOwp9
CgolbWFpbl9lZGdlcz0leyRlZGdlc3skdGFnfX07CmZvcmVhY2ggJGYgKEBm
aWxlcykgewoJaWYoIWRlZmluZWQoJG1haW5fZWRnZXN7JGZ9KSkgewoJCXBy
aW50ICIkZiBpcyBub3QgcmVhY2hhYmxlIGZyb20gJHRhZ1xuIjsKCX0KfQoK

---1463794688-1434691266-1124206283=:11105--
