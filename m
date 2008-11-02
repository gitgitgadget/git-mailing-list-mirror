From: 13ren <melbourne.research@gmail.com>
Subject: commit takes 8 secs; but instant when offline - can I fix this?
Date: Sun, 2 Nov 2008 06:08:14 -0800 (PST)
Message-ID: <1225634894605-1445352.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 02 15:09:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwdeB-0002KO-3T
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 15:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbYKBOIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 09:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbYKBOIR
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 09:08:17 -0500
Received: from kuber.nabble.com ([216.139.236.158]:35208 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441AbYKBOIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 09:08:16 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1Kwdck-0004vt-Jk
	for git@vger.kernel.org; Sun, 02 Nov 2008 06:08:14 -0800
X-Nabble-From: melbourne.research@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99843>


Hi all,

With the network plugged in, git-commit takes 8 seconds.

When I unplug the network, commit is instant...

I confirmed this with a fresh test directory, just adding an extra line to
the file "test" for each commit:

> git init
Initialized empty Git repository in /home/user/gitexpt/.git/
> vi test
> git add *

> date; git commit -a -m "add minor change"; date
Mon Nov  3 00:31:02 EST 2008
Created commit 9b845a2: add minor change
 1 files changed, 2 insertions(+), 0 deletions(-)
Mon Nov  3 00:31:10 EST 2008

> date; git commit -a -m "add test, without network"; date
Mon Nov  3 00:46:00 EST 2008
Created commit dd02a69: add test, without network
 1 files changed, 3 insertions(+), 0 deletions(-)
Mon Nov  3 00:46:00 EST 2008

> git --version
git version 1.5.6.3

Anyone know why is git-commit so slow? Or if there I can anything to change
this?

I'd assumed the slowness was normal, since I'm new to version control. I've
googled and searched mailing lists, but haven't found this. Could be just my
installation (or others make the same assumption?)

Many thanks for any help... I'm going a little crazy here.


-- 
View this message in context: http://n2.nabble.com/commit-takes-8-secs--but-instant-when-offline---can-I-fix-this--tp1445352p1445352.html
Sent from the git mailing list archive at Nabble.com.
