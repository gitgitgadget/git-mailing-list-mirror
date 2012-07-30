From: Thomas Badie <thomas.badie@gmail.com>
Subject: A new way to get a sha1?
Date: Mon, 30 Jul 2012 14:11:30 +0200
Message-ID: <jv5tln$96e$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 14:12:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svopq-00029c-8l
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 14:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab2G3MLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 08:11:52 -0400
Received: from plane.gmane.org ([80.91.229.3]:50270 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753462Ab2G3MLv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 08:11:51 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SvopA-0001gr-Lx
	for git@vger.kernel.org; Mon, 30 Jul 2012 14:11:48 +0200
Received: from gar13-1-82-229-16-131.fbx.proxad.net ([82.229.16.131])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 14:11:48 +0200
Received: from thomas.badie by gar13-1-82-229-16-131.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 14:11:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: gar13-1-82-229-16-131.fbx.proxad.net
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:14.0) Gecko/20120714 Thunderbird/14.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202535>

Hi all,

When I should fixup or squash a commit, I nearly never
remember how to get the sha1 of the commit I want to fixup.
Because sometimes HEAD~n is not enough, I make `git log`,
copy the sha1 of the right commit and paste it in my git
fixup command. So I wrote a perl script to avoid the usage
of the mouse. And after discussion with some of my friends,
this can be generalized as a generic command line interface
tool to get a sha1.

The idea is to have a perl module which run through
the log history and print 10 shortlog associated with a number
from 0 to 9, and a message below "Select commit [| 0, 9 |] or
next row ?" or this kind of message with several options.

So I ask to the community if this module is interesting for git.
It can be integrated everywhere a sha1 is requested (git rebase,
git reset, ...). IMHO, it can be an enhancement.

So, what is your opinion? Should I make this script a perl module
and integrate it in git, or should I just keep it in my own script
toolbox?

Thanks for reading and answering,

-- 
Thomas "Enki" Badie 
