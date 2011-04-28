From: ryanzec <basire@gmail.com>
Subject: Git and Binary Files
Date: Thu, 28 Apr 2011 08:11:16 -0700 (PDT)
Message-ID: <1304003476678-6313601.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 17:11:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFSsF-0007Dt-2P
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 17:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933027Ab1D1PLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 11:11:17 -0400
Received: from sam.nabble.com ([216.139.236.26]:46058 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932882Ab1D1PLR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 11:11:17 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <basire@gmail.com>)
	id 1QFSs8-0004MI-N2
	for git@vger.kernel.org; Thu, 28 Apr 2011 08:11:16 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172365>

I am a long time user of SVN and while it has worked for me in the past, I
always felt like there were features I wasn't using properly. Branching is
one of those features. Most of the time when I created branches, I was
really creating tags because when I created branches, I never really used
them for merging, just more to take a snapshot of the current code. When I
did have to make changes to code in one branch and merge them to another, I
always just manually merged the files because it was usually 1 or two files
and merge with SVN from what I hear is not a straight forward process. I
have recently starting using merging at work with SVN and I now really
understanding why people try to avoid it in SVN. Another thing I do in SVN
that I fell is counter productive is I only commit when I am 100% complete
with a feature. It would be great to commit things in chunks instead of one
great big change. I have had multiple times where I was like "I wish I could
go back just a little bit in time" but of course I have to go back to the
initial version which may be a week old or modify the file manually to get
back to the state I want it at (which it was I usually do).

Thankfully I have been introduced to the world of DVCS, specifically git. My
work is in the process of porting over to it and as I have been learning it,
I am wondering why I am still using SVN. Git fixes the above issues as well
as also having a number of cool little features.

Now while it fixes a lot of things there is one feature that concerns me
with trying to using it for game development projects and that is how it
handles binary files. In my day job, that is not a huge concern as I do web
development and I don't deal with many binary files that need to be
versioned. Images are the only ones and they rarely change and are not
usually that big. Game development is a different story. Game development in
general has many binary files (images, 3d assets, sound files, etc...).
Since git generally has a copy of the entire binary file for each change
that happens to it and since these assets can change quite often and
sometimes be large in size, I have a feeling that it can make the repository
of project become huge even with the compression that git does with git
pack/git gc.

Does anyone use git with game development? What is the workflow for binary
assets? Do you just store them in git (if so, are they in the main
repository or a separate repository using submodules)? If you don't include
binaries in the git repository, what tool do you use to manage binary assets
and does it work well with git?

--
View this message in context: http://git.661346.n2.nabble.com/Git-and-Binary-Files-tp6313601p6313601.html
Sent from the git mailing list archive at Nabble.com.
