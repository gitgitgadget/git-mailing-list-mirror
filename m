From: Norbert Preining <preining@logic.at>
Subject: Creating something like increasing revision numbers
Date: Sun, 18 Oct 2009 23:41:58 +0900
Message-ID: <20091018144158.GA9789@gandalf.dynalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 18 16:48:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzX3T-0004Sa-3D
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 16:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657AbZJROsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 10:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754645AbZJROsG
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 10:48:06 -0400
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:59155 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754642AbZJROsF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 10:48:05 -0400
Received: from rsd-f52.jaist.ac.jp
	([150.65.47.160] helo=localhost ident=Debian-exim)
	by mx.logic.tuwien.ac.at with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <preining@logic.at>)
	id 1MzX3F-0006BK-6j; Sun, 18 Oct 2009 16:48:07 +0200
Received: from norbert by localhost with local (Exim 4.69)
	(envelope-from <preining@logic.at>)
	id 1MzWxL-0002iB-5Q; Sun, 18 Oct 2009 23:41:59 +0900
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130595>

Dear all,

(please Cc)

I am managing some of my projects with git and I am quite happy about it.

There is another project I am working that is quite big, the subversion
checkout is about 14Gb. Doing svn up is a pain, it has to open tens of
thousands of files and directories traversing the whole tree, trashing
the fs cache and taking ages.

My idea was to move to git, from what I read it should be more capable
in handling these type of projects.

Now, there is one show-stopper I see. From our repository we create a
set of "packages", and the maximum of the "last-changed" revisions of
the contained files determine the "version" of the package. This 
guarantees that any change in a file will increase the revision number
of the package (some tricks for removals have to be done). This is necessary
since we are distributing the packages from servers and the version number
pf a package determines whether it should be upgraded (well known concept).

Now my question, is there any way to set up something similar with git?

My idea is that git - like subversion - could (if asked to) count each
commit (global to the repository, irrelevant of the branch) and give it
a version number. Since we all will use a bare repository on a server
and pull/push from/to there, I think that something similar could be possible.

So, before I delve into more gitty-nitty conversion, let me know if
there is any chance for that, or we should stay with subversion.

Thanks a lot and all the best

Norbert

PS: for those interested, it is TeX Live: www.tug.org/texlive

-------------------------------------------------------------------------------
Dr. Norbert Preining                                        Associate Professor
JAIST Japan Advanced Institute of Science and Technology   preining@jaist.ac.jp
Vienna University of Technology                               preining@logic.at
Debian Developer (Debian TeX Task Force)                    preining@debian.org
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
YONKERS (n.)
(Rare.) The combined thrill of pain and shame when being caught in
public plucking your nostril-hairs and stuffing them into your
side-pocket.
			--- Douglas Adams, The Meaning of Liff
