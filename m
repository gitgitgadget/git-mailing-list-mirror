From: Jon Loeliger <jdl@freescale.com>
Subject: Octopus?  Really?  Interesting...
Date: Fri, 04 Jan 2008 12:28:41 -0600
Message-ID: <1199471321.3133.22.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 04 19:29:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JArIa-0004A8-Rr
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 19:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbYADS3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 13:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752450AbYADS3E
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 13:29:04 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:35350 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbYADS3D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 13:29:03 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id m04ISg3Q010945
	for <git@vger.kernel.org>; Fri, 4 Jan 2008 11:28:53 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m04ISfkK002997
	for <git@vger.kernel.org>; Fri, 4 Jan 2008 12:28:42 -0600 (CST)
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69590>

Guys,

So, I brain-wedged a merge here just now
and was surprised to see that a simple
fetch-n-merge yielded an octopus merge.
I was expecting a fast-forward.  So I went
back and reviewed.  What actually happend
was this:

    $ git checkout master
    $ git fetch origin
    # check it out... looks great ... let's merge it
    $ git merge master origin/master
    merge performed by octopus.

Oh, yeah.  Duh.  I did name two branches.  Feh.

Couple questions:

    Is it ever NOT the case, that if you are on one
    branch ("master") and name it as a "to be merged"
    branch along with some others, that we can simplify
    the request by noting that it is the same as the
    current "to be merged into" target branch?

    Other than creating a log message with "merged
    by octopus", will this merge be content-identical
    to the obvious simplified merge?

Thanks,
jdl
