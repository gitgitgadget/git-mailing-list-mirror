From: PaV <pav@aster.pl>
Subject: Git setup for kernel in-house development + mainstream submissions?
Date: Sun, 01 Feb 2009 22:25:55 +0100
Message-ID: <49861363.1000104@aster.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 01 23:14:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTkZk-0000VL-S7
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 23:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbZBAWM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 17:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbZBAWM3
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 17:12:29 -0500
Received: from mail1.aster.pl ([212.76.33.23]:38107 "EHLO mail1.aster.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419AbZBAWM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 17:12:28 -0500
X-Greylist: delayed 2790 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Feb 2009 17:12:28 EST
Received: from [85.222.120.101] (101-mo5-13.acn.waw.pl [85.222.120.101])
	by mail1.aster.pl (sendmail) with ESMTP id C52733C694
	for <git@vger.kernel.org>; Sun,  1 Feb 2009 22:25:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090106)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108011>

Hello,

I would like to kindly ask for suggestions how to setup and use git in a
company that performs in-house kernel development (drivers mostly) for
its own devices and would like to occasionaly submit patches for mainstream.

I've come up with a short list of use cases/requirements (possibly not
exhaustive, any suggestions here as well please?):

1) a way to separate development of in-house code (various drivers)

2) a place to merge everything done in-house and provide current
development snapshot for internal use

3) something that tracks the current mainstream tree, to be merged with
(3) ocassionaly (or (2)?)

4) a simple way to select changes (which may be as small as only parts
of any of the drivers), format them and submit for upstream merge.
Preferably, if possible, prepare those series of patches and store them
for later use (immediate submission might not be possible and might not
be done at all).

5) (more?)


So the proposed setup might be:
(1) - in-house devel could be done on separate branches for each driver
(2) - a master branch (on the main server) for in-house snapshots and
distribution
(3) - a separate tracking branch for mainstream
(4) - now this is hard.
The main problems are how to create, how to diff and how to manage those
patches (stgit?) and what to do when mainstream gets updated, etc...

So ideas are: rebase and/or stgit/quilt. Or/and maybe topic branches,
creating new branches for each new kernel version for each driver,
copying the old branch and rebasing?
This is the most important part for which I'd like to ask for suggestions...

Any other suggestions are of course also welcome, my experience in git
is small and I might have missed things.

Thank you!
Paul
