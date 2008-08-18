From: Peter Waller <peter.waller@gmail.com>
Subject: Merging repositories and their histories
Date: Mon, 18 Aug 2008 09:46:14 -0700 (PDT)
Message-ID: <19035412.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 18:47:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV7tV-0006cj-5I
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 18:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466AbYHRQqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 12:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755457AbYHRQqQ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 12:46:16 -0400
Received: from kuber.nabble.com ([216.139.236.158]:56353 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755453AbYHRQqP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 12:46:15 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1KV7ry-0004Fb-J8
	for git@vger.kernel.org; Mon, 18 Aug 2008 09:46:14 -0700
X-Nabble-From: peter.waller@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92717>


I have three repositories, A, B and C. I wish to bring them together to only
one repository (.), where they are in a directory called ./Archive, so..
./Archive/{A,B,C}. Then I plan at a later date to move files arbitrarily
from ./Archive/{A/B/C}/Something and into ./Something{A/B/C}. (A lame
example, but illustrates what I want to do).

I would like ./SomethingA (etc) to have their complete histories from the
old repository. I thought I would do this with the subtree mechanism
described at
http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html,
but I have had little luck getting it to work as I desired.

Firstly, I create a new repository with git init, then I "remote add A",
"merge" and "readtree". This immediately leads to two copies of A's files,
in ./Archive/A/Files and ./Files. The files in Archive/A do not have any
history.

Then if I do this with B, the files do not appear in ./, but again they do
not have their history. I have tried using git log --follow -M, but this
does not seem to help. I have tried numerous other ways of doing this, but
none seem to work.

I thought I would get around my problems doing the merge, then moving the
files - this works for A, but when I move on to B, the files are not in ./,
so I can't move them. If I read-tree some files, git status/commit shows
them as 'new files' and does not seem to recognize them as old files with a
long history.

Any help would be appreciated on this problem.

Thanks in advance,

- Peter
-- 
View this message in context: http://www.nabble.com/Merging-repositories-and-their-histories-tp19035412p19035412.html
Sent from the git mailing list archive at Nabble.com.
