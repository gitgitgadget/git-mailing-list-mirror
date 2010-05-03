From: Gelonida <gelonida@gmail.com>
Subject: how to squash a few commits in the past
Date: Mon, 3 May 2010 09:33:56 +0000 (UTC)
Message-ID: <loom.20100503T112508-677@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 03 11:40:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8s8S-0003Yv-1X
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 11:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595Ab0ECJkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 05:40:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:33191 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479Ab0ECJkF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 05:40:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O8s8B-0003UI-0N
	for git@vger.kernel.org; Mon, 03 May 2010 11:40:03 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 May 2010 11:40:02 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 May 2010 11:40:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 81.56.82.123 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100402 Ubuntu/9.10 (karmic) Firefox/3.5.9)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146224>

Hi,



I posted already a similiar question about how to squash the all the commit
hostory older than a certain commit into one commit.


This question is slightly different.


I'm having a git repository.

Suddenly I noticed, that git pull became rather slow.

The reason:
One of the team members accidentally commited a very huge file together with
some useful sources.
a few commits later he noticed his error and removed the huge file.



The plan would be:
- create a new git repository without the huge file
- let everybody clone the new repository and continue working.


I thought, that I could squash the commit adding the file, removing the file and
the commits in between into one commit.

How could I do this?


Thanks a lot for your help.
