From: Markus Korber <korbse@gmx.at>
Subject: Revert git push
Date: Thu, 10 Jan 2008 14:15:20 +0100
Message-ID: <6zve61q0t3.fsf@odpc25.int.ondemand.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 10 14:21:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCxLB-0000GF-1R
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 14:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453AbYAJNUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 08:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549AbYAJNUI
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 08:20:08 -0500
Received: from main.gmane.org ([80.91.229.2]:42977 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154AbYAJNUG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 08:20:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JCxKE-000228-D8
	for git@vger.kernel.org; Thu, 10 Jan 2008 13:20:02 +0000
Received: from 212.186.216.185 ([212.186.216.185])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 13:20:02 +0000
Received: from korbse by 212.186.216.185 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 13:20:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 212.186.216.185
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:JmeEC/6ySUsP9zeY8CojNcxIKmU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70069>

Hi,

I've got two local git repositories, linux and mplayer, where I push to
from a local directory.  Now I accidentally pushed from mplayer into the
linux repository (via a not updated URL[1]).  Is it somehow possible to
revert this push if nobody has pushed something since my last pull from
the linux repository?

(Or can I just copy the .git/objects/ directory over to the repository?)

,----[ .git/remotes/mplayer [1]]
| URL: /prj/gitroot/linux
| Push: +master:master
`----

,----[ git push mplayer ]
| updating 'refs/heads/master'
|   from 94545baded0bfbabdc30a3a4cb48b3db479dd6ef
|   to   9085d919f7954ad629447157f054e55230513936
| Generating pack...
| Done counting 3240 objects.
| Deltifying 3240 objects...
|  100% (3240/3240) done
| Writing 3240 objects...
|  100% (3240/3240) done
| Total 3240 (delta 774), reused 0 (delta 0)
| refs/heads/master: 94545baded0bfbabdc30a3a4cb48b3db479dd6ef -> 9085d919f7954ad629447157f054e55230513936
`----

Regards,
Markus Korber
