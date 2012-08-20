From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: t9020 broken on pu ?
Date: Mon, 20 Aug 2012 22:56:35 +0200
Message-ID: <5032A483.4000009@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: florian.achleitner.2.6.31@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 20 22:56:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Z1v-00031n-8F
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 22:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209Ab2HTU4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 16:56:42 -0400
Received: from smtp-out12.han.skanova.net ([195.67.226.212]:58442 "EHLO
	smtp-out12.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754685Ab2HTU4j (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2012 16:56:39 -0400
Received: from wanderer.site (195.67.191.22) by smtp-out12.han.skanova.net (8.5.133) (authenticated as tboegi@telia.com)
        id 4FAE31D9014B6428; Mon, 20 Aug 2012 22:56:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:14.0) Gecko/20120713 Thunderbird/14.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203874>

t9020 from pu doesn't work for me (neither linux nor Mac OS)

I haven't been able to find out more than this:

Initialized empty Git repository in /home/tb/projects/git/git.pu/t/trash 
directory.t9020-remote-svn/.git/
expecting success:
         init_git &&
         git fetch svnsim &&
         test_cmp .git/refs/svn/svnsim/master 
.git/refs/remotes/svnsim/master  &&
         cp .git/refs/remotes/svnsim/master master.good

Initialized empty Git repository in /home/tb/projects/git/git.pu/t/trash 
directory.t9020-remote-svn/.git/
fatal: Unable to find remote helper for 'svn'
not ok - 1 simple fetch
