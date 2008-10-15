From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: Usability of git stash
Date: Wed, 15 Oct 2008 21:24:52 +0200
Message-ID: <87wsg9acfv.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 21:26:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqC0V-0007gF-It
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 21:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257AbYJOTY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 15:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754232AbYJOTY4
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 15:24:56 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:55493 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085AbYJOTYz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 15:24:55 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 5C2DE14062
	for <git@vger.kernel.org>; Wed, 15 Oct 2008 21:24:56 +0200 (CEST)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 386E31405A
	for <git@vger.kernel.org>; Wed, 15 Oct 2008 21:24:56 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98302>

I find the UI of git stash quite unfortunate.

First, I would prefer list to be the default action, so that typing
"git stash" in the hope of getting some help would not make me lose my
local changes.

When trying to recover from that scenario, I do "git stash apply" as
recommended by the "git stash" output. Now I still lost my index
state, all changes are unstaged.

The "git command subcommand" syntax seems different from other git
commands. For example, you do not delete a branch with "git branch
delete".

The default naming of stashes makes it hard to remember what I was
actually working on. Forcing me to give it a description (like branch
and commit do) would probably have saved me some time overall.

And finally, a "git stash clear" has quite far-reaching consequences.
Most other mistakes are easy to recover from, but not this one.


I offer these observations just for discussion. It has not been
possible for me to think of any backwards compatible improvements,
other than staying away from "git stash".


Cheers,
Anders.
