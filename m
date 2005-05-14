From: Zack Brown <zbrown@tumblerings.org>
Subject: speeding up cg-log -u
Date: Fri, 13 May 2005 23:19:14 -0700
Message-ID: <20050514061914.GB14353@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat May 14 08:24:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWq4Q-0008LH-3t
	for gcvg-git@gmane.org; Sat, 14 May 2005 08:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbVENGYG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 02:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVENGYG
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 02:24:06 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:59792 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S262591AbVENGYD
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 02:24:03 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DWpzW-0004Xr-D9
	for git@vger.kernel.org; Fri, 13 May 2005 23:19:14 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi folks,

I notice that cg-log takes a -u parameter, that lets you restrict the log
entries that are displayed, to match the argument you give it. So

cg-log -uKH

shows all the logs where Greg KH played a part.

Currently cg-log handles this by grabbing all the log data from git, and
then grepping through it.

Would it be faster to handle this on the git side, telling git to only
retrieve the logs that match the specified query? If feasible, this might
speed up various web interfaces into git repositories.

Be well,
Zack

-- 
Zack Brown
