From: Jon Loeliger <jdl@jdl.com>
Subject: URL Syntax Question
Date: Mon, 31 Mar 2008 19:58:00 -0500
Message-ID: <E1JgUp6-0002Sc-Ts@jdl.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 01 02:58:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgUpw-0006pW-3W
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 02:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbYDAA6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 20:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbYDAA6H
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 20:58:07 -0400
Received: from jdl.com ([208.123.74.7]:38101 "EHLO jdl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbYDAA6G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 20:58:06 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>)
	id 1JgUp6-0002Sc-Ts
	for git@vger.kernel.org; Mon, 31 Mar 2008 19:58:04 -0500
X-Spam-Score: -2.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78612>

Folks,

On, for example, the git-clone man page, the stated URLs
that are supported include these:

    git://host.xz/path/to/repo.git/
    git://host.xz/~user/path/to/repo.git/
and:
    ssh://[user@]host.xz[:port]/path/to/repo.git/
    ssh://[user@]host.xz/path/to/repo.git/
    ssh://[user@]host.xz/~user/path/to/repo.git/
    ssh://[user@]host.xz/~/path/to/repo.git
and:
    rsync://host.xz/path/to/repo.git/

In the first set, is the non-specified user form also supported?
That is, this form:

    git://host.xz/~/path/to/repo.git/

In the second set, is it fair to generalize and say
that they could all be respresented as this:

    ssh://[user1@]host.xz[:port]/[~[user2]/]path/to/repo.git/

Where user1 is, of course, the authorizing user and user2
is the file system accessed home directory user.

Lastly, how long before the deprecated and third class citizen,
rsync, is actually _removed_?  Or will it linger for all time?
Any plans in the works there?


And is it also true that the trailing / isn't strictly necessary?

Thanks,
jdl
