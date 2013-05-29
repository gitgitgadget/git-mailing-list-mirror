From: Erik de Castro Lopo <mle+tools@mega-nerd.com>
Subject: Retrieving a file at a before a specified commit
Date: Wed, 29 May 2013 16:47:35 +1000
Organization: Erik Conspiracy Secret Labs
Message-ID: <20130529164735.5489ab47953406745d9034ef@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 08:55:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhaHu-0006Am-Ez
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 08:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935048Ab3E2GzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 02:55:04 -0400
Received: from hendrix.mega-nerd.net ([203.206.230.162]:52984 "EHLO
	hendrix.mega-nerd.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934396Ab3E2GzD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 02:55:03 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2013 02:55:03 EDT
Received: from rollins.mnn (pharoah-vpn [10.9.8.2])
	by hendrix.mega-nerd.net (Postfix) with SMTP id 76958106DF9
	for <git@vger.kernel.org>; Wed, 29 May 2013 16:47:35 +1000 (EST)
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225763>

Hi all,

I have a commit like this:

    commit 4d77a3cee01db0412956d40875c79f51ac745acc
    tree 3443c9f633114c3bd2e015453a8c55a171e62b53
    parent 340d808ade8a79857bec40770f0eb4f98224c53d
    author ....
    committer .....

which modifies file A/B/C (ie specifically does not add, but changes
an existing file in the repo).

I would then like to retrive the version of the file A/B/C before
commit 4d77a3cee by using the parent commit 340d808a:

   git show 340d808ade8a79857bec40770f0eb4f98224c53d:A/B/C

which works for most files/commits I try this with, but doesn't work
in one particular case.

Questions:

- Is my understanding of the above git command incorrect?
- Is this a corrupt repo? Is there some way to check?
- Is there some explaination of why I can't get the previous version
  of that file?

Appreciate any light that could be shed on this.

Cheers,
Erik
-- 
----------------------------------------------------------------------
Erik de Castro Lopo
http://www.mega-nerd.com/
