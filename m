From: Gelonida <gelonida@gmail.com>
Subject: simple example for git hooks
Date: Fri, 03 Sep 2010 00:41:31 +0200
Message-ID: <i5p96s$u7q$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 03 00:41:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrITh-00007M-9o
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 00:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590Ab0IBWln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 18:41:43 -0400
Received: from lo.gmane.org ([80.91.229.12]:34576 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053Ab0IBWlm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 18:41:42 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OrITU-0008TE-Os
	for git@vger.kernel.org; Fri, 03 Sep 2010 00:41:40 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 00:41:40 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 00:41:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100713 ""
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155217>

Does anyone have a simple example of a git pre-commit hook


I have difficulties finding understandable tutorals about git hooks.




What I am looking at is basic examples about


precommit hooks
================

- how get the commit comment and check it's contents
- how to get list of modified files

The issue I'm currently blocked with is rather simple.

I'd like to get a list aof all
new or modified file names, such, that I can check, that for  example
all .h files contain a project specific header.


As soon as I have the file names I should be able to proceed.


How could I do this best from a shell script.





Is there any clear documentation about hich git commands I'm allowed to
use during a trigger script and which ones I can't



Lateron I would be interested to implement a small server script, that
refuses a git push in case, that the most recent commit in a branch
would contain .h files without a certain header text




thanks for your help
