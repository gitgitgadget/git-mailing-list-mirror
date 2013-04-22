From: Thomas Rast <trast@student.ethz.ch>
Subject: Patch-to-mail notes resurrected
Date: Mon, 22 Apr 2013 11:53:42 +0200
Message-ID: <87bo96rivt.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 22 11:53:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUDRV-0006b9-V5
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 11:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518Ab3DVJxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 05:53:45 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:36642 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755485Ab3DVJxo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 05:53:44 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 22 Apr
 2013 11:53:42 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 22 Apr 2013 11:53:42 +0200
User-Agent: Notmuch/0.14 (http://notmuchmail.org) Emacs/24.2.1 (x86_64-suse-linux-gnu)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222004>

Hi,

As some might remember, I made a script that writes notes (as in
git-notes) linking patches to emails back in 2009:

  http://thread.gmane.org/gmane.comp.version-control.git/109074

I resurrected this idea the other week, using a faster implementation
(the N command in fast-import is great!) and generating better links.
I am regularly pushing the results to

  git://github.com/trast/git.git
  git://repo.or.cz/git/trast.git

branches

  notes/gmane        a link to the gmane thread view, focused on this patch
  notes/message-id   the raw message-id

Point your notes.displayRef at one or both to use them.

It still fails to match some commits, so consider this WIP, but I think
it's quite useful already.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
