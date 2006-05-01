From: Pavel Roskin <proski@gnu.org>
Subject: Re: More qgit defects
Date: Sun, 30 Apr 2006 22:20:35 -0400
Message-ID: <1146450035.7879.26.camel@dv>
References: <1145484284.22097.10.camel@dv>
	 <e5bfff550604220416v592128fcj25185bbda3b4e493@mail.gmail.com>
	 <1146115210.30763.40.camel@dv>
	 <e5bfff550604270026q68ba8a4clfaf1b274a5b312cf@mail.gmail.com>
	 <1146163863.5133.37.camel@dv>
	 <e5bfff550604281021k60e0c0ebk7a89eb0c9c569c2a@mail.gmail.com>
	 <1146383451.12323.41.camel@dv>
	 <e5bfff550604300111n6db883d5w98c863efaab15b00@mail.gmail.com>
	 <1146389204.12323.90.camel@dv> <1146390144.13634.9.camel@dv>
	 <e5bfff550604300313n5ebe84f7nf42c88789efe1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: ydirson@altern.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 01 04:20:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaO1y-0004Gf-3x
	for gcvg-git@gmane.org; Mon, 01 May 2006 04:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWEACUq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 22:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWEACUq
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 22:20:46 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:10402 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750702AbWEACUq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 22:20:46 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FaO1k-0000sN-P9
	for git@vger.kernel.org; Sun, 30 Apr 2006 22:20:44 -0400
Received: from proski by dv.roinet.com with local (Exim 4.61)
	(envelope-from <proski@dv.roinet.com>)
	id 1FaO1b-0002ff-O5; Sun, 30 Apr 2006 22:20:35 -0400
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550604300313n5ebe84f7nf42c88789efe1@mail.gmail.com>
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19369>

Hello, Marco!

On Sun, 2006-04-30 at 12:13 +0200, Marco Costalba wrote:
> Throwing in the tabs is a *very* big change, but, just to discuss....I
> agree on the note that in qgit we have three different approaches:
> fixed frames (revisions, file tree, affected files), detachable frames
> (patch) and separate windows (annotations).
> 
> This is a bit strange and could give an odd GUI feeling.

Agreed.

> I like the tab idea because it's clear and simple and fixes the 'many
> approaches' problem.

I'm glad you liked my idea!  And thank you for copying to the list.
qgit is meant for most git users, and they should have their voices
heard.

> What I would suggest is, at least at first step,
> do not change the main view and have only three tabs:
> 
> Tab1: Main view with revisions, file tree (hide able), affected files.
> Tab2: Patch view with patch stat and diffs
> Tab3: File history + file content/annotation view

Absolutely.  It's easier to make changes incrementally than to rewrite
everything and hunt bugs for months.  This change alone would make it
easier to work with qgit.

Once qgit can deal with more than one patch view and more than one file
view, this would provide the fix for qgit's "jumpiness".  Mere selection
of objects in listboxes shouldn't affect other tabs.

> In other words just put the frames/windows as are now in browse able
> tabs. In this way main view still gives a good amount of information
> without requiring changing the tab and the tabs are reserved for 'big
> space' needed infos only.

That would be great.  I'm eagerly waiting for new commits to test :-)

-- 
Regards,
Pavel Roskin
