From: Miles Bader <miles@gnu.org>
Subject: setting up tracking on push
Date: Fri, 06 Mar 2009 12:07:29 +0900
Message-ID: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 04:12:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfQTb-0004is-8k
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 04:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbZCFDHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 22:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752154AbZCFDHk
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 22:07:40 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:46349 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbZCFDHj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 22:07:39 -0500
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n2637E8w020427;
	Fri, 6 Mar 2009 12:07:29 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay21.aps.necel.com with ESMTP; Fri, 6 Mar 2009 12:07:29 +0900
Received: from dhlpc061 ([10.114.112.181] [10.114.112.181]) by relay11.aps.necel.com with ESMTP; Fri, 6 Mar 2009 12:07:29 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 6DE7C52E26F; Fri,  6 Mar 2009 12:07:29 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112372>

[...sorry if this is a dup -- my previous attempt didn't seem to take...]

Is there an "easy" way to set up tracking for a branch which starts out
locally, and is eventually pushed to a remote?

E.g., I create a new local branch "grognul", and then later propagate it
to my remote site using:

  git push origin grognul

That works great (creating origin/grognul), but to set up tracking, I
currently edit .git/config (not insanely difficult, but vaguely
annoying).  This is as opposed to a branch which starts out remotely,
and is pulled, where one can just use "git branch --track" or "git
checkout --track" (or use a config option to do so by default).

I vaguely feel like I should be able to do:

  git push --track origin grognul

[I do this particular action -- creating a branch locally and then
pushing it to origin -- very very often, thus my desire for a handy
option.]

What do other people think?

-miles

--
Inhumanity, n. One of the signal and characteristic qualities of humanity.
