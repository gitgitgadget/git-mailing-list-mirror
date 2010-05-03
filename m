From: Gelonida <gelonida@gmail.com>
Subject: how to delete the entire history before a certain commit
Date: Tue, 04 May 2010 00:23:55 +0200
Message-ID: <hrnidr$etm$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 00:24:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O943i-0000Ph-E2
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 00:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758806Ab0ECWYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 18:24:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:57148 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758575Ab0ECWYH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 18:24:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O943Y-0000Lg-Ka
	for git@vger.kernel.org; Tue, 04 May 2010 00:24:04 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 May 2010 00:24:04 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 May 2010 00:24:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146263>

Hi,

I noticed, that this post never arrived :-( . So here again.



We have a git repository, whose size we want to reduce drastically due
to frequent clone operations and a slow network connection.


The idea is following:

* archive the git repository just in case we really have to go back in
history.


create a new git repository, which shall only contain last month's activity.

all changes before should be squashed together.
It would be no problem if the very first commit remains unmodified.


I made some attempts with
git rebase -i


but I always encounter errors.
Example error is a cherry pick which can't be applied.


Is git rebase the correct way to delete en entire history section or are
there smarter ways to do this? (e.g. create a new repository with last
months state as starting point and some 'magic' to replay from this
point on with all branches and merges_



thanks for any suggestion.
