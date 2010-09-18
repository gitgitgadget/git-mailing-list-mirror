From: Maaartin <grajcar1@seznam.cz>
Subject: Commiting unchanged tree
Date: Sat, 18 Sep 2010 08:15:11 +0000 (UTC)
Message-ID: <loom.20100918T095640-130@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 18 11:05:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwtMB-0003E6-0K
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 11:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302Ab0IRJFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 05:05:05 -0400
Received: from lo.gmane.org ([80.91.229.12]:42679 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755276Ab0IRJFE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 05:05:04 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OwtLy-00036U-S2
	for git@vger.kernel.org; Sat, 18 Sep 2010 11:05:03 +0200
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 11:05:02 +0200
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 11:05:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.61)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156442>

I thought that calling

git commit --amend -m "A message"

twice in a row should lead to an error saying "nothing to commit (working 
directory clean)", but it doesn't. Or at least, the result of the second commit 
should be the same as the result of the first one, but I keep getting a 
different hash each time

# git commit --amend -m "A message"
[master b8cf1c2] A message
# git commit --amend -m "A message"
[master 6c8ea30] A message
# git commit --amend -m "A message"
[master be318b3] A message

I wonder if everything is fine with my repo since I was doing some funny 
rebasing and filtering and I'm quite new to git.
