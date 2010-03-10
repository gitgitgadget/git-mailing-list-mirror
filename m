From: MALAISE Pascal <malaise@magic.fr>
Subject: Re: wishlist: git gui not listing untracked files in unstaged list
Date: Wed, 10 Mar 2010 20:57:03 +0000 (UTC)
Message-ID: <loom.20100310T214108-45@post.gmane.org>
References: <loom.20100310T203316-38@post.gmane.org> <7vaaugrlqs.fsf@alter.siamese.dyndns.org> <20100310200728.GD21994@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 10 21:58:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpSyY-0002d5-Be
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 21:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757147Ab0CJU5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 15:57:48 -0500
Received: from lo.gmane.org ([80.91.229.12]:60515 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757057Ab0CJU5s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 15:57:48 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NpSyC-0002EA-Ju
	for git@vger.kernel.org; Wed, 10 Mar 2010 21:57:32 +0100
Received: from fon31-1-78-224-49-155.fbx.proxad.net ([78.224.49.155])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 21:57:32 +0100
Received: from malaise by fon31-1-78-224-49-155.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 21:57:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 78.224.49.155 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.18) Gecko/2010021501 Ubuntu/8.04 (hardy) Firefox/3.0.18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141919>

I am not saying that the ignore lists don't work. They certainly work very well.
I am just looking for a behavior of git-gui like "git status -uno" and
"git ls-files", which both don't attempt to scan untracked files.

My problem is that my build makes a lib_Linux/ and a bin_linux/ subdirectory
of my source dir - I could declare them in a gitignore, OK.
But my build also makes a symlink for each <exe> from bin_Linux/<exe> to . 
and I don't want to declare these links one by one in an ignore list.

I this is too problematic or un-natural for git-gui I will see if can generate
a .gitignore automatically in each source dir. In my makefile I have the list
of <exe>.

Regards 
