From: Faheem Mitha <faheem@faheem.info>
Subject: corrupt repos does not return error with `git fsck`
Date: Wed, 20 May 2015 21:47:15 +0530 (IST)
Message-ID: <alpine.DEB.2.11.1505202142540.9343@orwell.homelinux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 18:23:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv6mU-0003wd-6a
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 18:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112AbbETQXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 12:23:38 -0400
Received: from rs145.luxsci.com ([64.49.212.113]:46063 "EHLO rs145.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753943AbbETQXh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 12:23:37 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 May 2015 12:23:37 EDT
Received: from orwell.homelinux.org (triband-mum-59.183.39.181.mtnl.net.in [59.183.39.181])
	(authenticated bits=0)
	by rs145.luxsci.com (8.14.4/8.14.9) with ESMTP id t4KGHl7J007934
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 20 May 2015 12:17:50 -0400
Received: from faheem (helo=localhost)
	by orwell.homelinux.org with local-esmtp (Exim 4.84)
	(envelope-from <faheem@faheem.info>)
	id 1Yv6gP-0004s5-AW
	for git@vger.kernel.org; Wed, 20 May 2015 21:47:25 +0530
X-X-Sender: faheem@orwell.homelinux.org
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
X-Lux-Comment: Message t4KGHl7J007934 sent by user #87163
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269470>


Hi,

Clone the repos https://github.com/fmitha/SICL.

Then

     git show 280c12ab49223c64c6f914944287a7d049cf4dd0

gives

     fatal: bad object 280c12ab49223c64c6f914944287a7d049cf4dd0

But

     git fsck

gives

     Checking object directories: 100% (256/256), done.
     Checking objects: 100% (49356/49356), done.

So `git fsck` does not return an error, though the repos is corrupt. This 
may be of interest to the developers.

Please CC me on any reply, I'm not subscribed to the list. Thanks.

                                             Regards, Faheem Mitha
