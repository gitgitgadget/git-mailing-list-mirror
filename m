From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Suggestions for gitk
Date: Thu, 17 Nov 2011 06:53:41 +0100
Message-ID: <4EC4A165.2060002@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Nov 17 06:58:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQuzL-0006yo-Nx
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 06:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182Ab1KQFyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 00:54:10 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34352 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab1KQFyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 00:54:09 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.133] (p54BEBB0A.dip.t-dialin.net [84.190.187.10])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pAH5rfQT000412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 17 Nov 2011 06:53:42 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185571>

I use gitk every day and love it.  I have a few suggestions that IMO
would make it even better.  Please note that I've been collecting these
ideas for a while, and they are only small niggles about an excellent tool.

1. Add a "HEAD" button

Frequently I want to jump to the HEAD revision after having moved around
in the history for a while.  Since HEAD is not always at the top of the
revision list, I do this by typing "HEAD" into the "SHA1 ID" field.  Is
there a better way already?  If not, I think it would be very convenient
to have a small "HEAD" button near that field that causes gitk to jump
there.

2. Option to check out new branch

After I "Create new branch", I often want to check out the new branch
(the equivalent of "git checkout -b BRANCH REV").  So it would be
convenient if the dialog opened by right-clicking on a commit and select
"Create new branch" offered the option to check out the newly-created
branch.  For example, it could have a third confirmation button "Create
and check out", or it could have a tick box "Check out new branch".

3. Allow "Branches: many (N)" to be expanded

There is some limit above which the commit window doesn't list the
branches that contain the commit, but instead displays "Branches: many
(N)".  But sometimes one wants to know anyway.  For example, the field
could be a link that one could click on to open a dialog box listing all
of the branches containing the commit.

In fact, a tabular format would often be more convenient than the
current format (which is hard to skim through due to its horizontal
layout and often scrolls off the right side of the screen) even if there
are only a few branches, and the same applies to "Tags", "Precedes",
etc.  So perhaps this dialog could be made available in all cases, even
if the branches/tags/etc are expanded in the commit summary.

4. Hide "commit" part of window

When I'm trying to get an overview of the history, I am often not
interested in the commit summary.  So it would be great if there were a
hotkey to hide the "commit" part of the window and allow the "log" part
of the window to use the whole surface.  This would be like
Thunderbird's "F8" key (which I also use all the time), so if this
feature is implemented you might consider using "F8" for it.

5. Tab completion in "SHA1 ID" field

It would be wonderful if the SHA1 ID field supported some kind of tab
completion for branch names, similar to that offered by the git mode for
bash.  Currently it is painful to type a long branch name into this field.

6. Display "git log" command line

I assume that gitk is using something like "git log" to generate the
list of commits that it displays.  The "git log" command line can be
configured quite flexibly using the "F4" dialog.  So flexibly, in fact,
that I often wonder what options it is passing to "git log".  I think it
would be cool if gitk would display the "git log" command line that
corresponds to the options currently selected in the "F4" dialog.

7. Tags squeeze out commit message in the "log" window

If a commit has a tag, the tag is listed next in the first column of the
"log" window, pushing the first line of the commit message off to the
right.  If a commit has multiple tags, it can easily happen that the
tags push the commit's log message completely out of the window.  There
is no scrollbar, so there is no way to see the commit message in this
situation.

The inability to read the commit message is not such a problem, because
one can select the commit and see the commit message in the bottom part
of the window.  More frustrating is that in this situation, it is
impossible to get to the menu that is normally accessed by
right-clicking on the commit message.

So perhaps the menu could also be made available elsewhere, for example
by right-clicking on the blue dot on the "graph" part of the display,
and/or by right clicking on author and date associated with the commit.


I don't know tcl/tk; otherwise I'd try to make some of these changes by
myself...

Thanks for listening,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
