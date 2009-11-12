From: =?ISO-8859-1?Q?Lu=EDs_Sousa?= <llsousa@ualg.pt>
Subject: Idea for git-touch
Date: Thu, 12 Nov 2009 16:15:07 +0000
Message-ID: <4AFC348B.4000202@ualg.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 12 17:45:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8cng-0003RN-IK
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 17:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbZKLQpY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 11:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752955AbZKLQpY
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 11:45:24 -0500
Received: from smtp3.ualg.pt ([193.136.224.6]:40177 "EHLO smtp3.ualg.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280AbZKLQpX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 11:45:23 -0500
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Nov 2009 11:45:23 EST
Received: from localhost (smtp3.ualg.pt [127.0.0.1])
	by smtp3.ualg.pt (Postfix) with ESMTP id D10521685A
	for <git@vger.kernel.org>; Thu, 12 Nov 2009 16:15:25 +0000 (WET)
Received: from smtp3.ualg.pt ([127.0.0.1])
 by localhost (host.domain.tld [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 32172-06 for <git@vger.kernel.org>;
 Thu, 12 Nov 2009 16:15:24 +0000 (WET)
Received: from [193.136.224.174] (unknown [193.136.224.174])
	by smtp3.ualg.pt (Postfix) with ESMTP id 9A3C716781
	for <git@vger.kernel.org>; Thu, 12 Nov 2009 16:15:24 +0000 (WET)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
X-Virus-Scanned: Maia Mailguard 1.0.2a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132781>

Hi all,

I have been using GIT for several time and I love it.

I normally do commits when something works or on the end of the day,=20
just to record what have doing. On other day, when I consider that is=20
done/working I do a rebase -i squashing everything on one commit. The=20
date of that commit will be preserved and is the date of the first=20
commit. Then I do a git-reset HEAD~1, git-add . and git-commit with the=
=20
same message to have the current date.

A nice functionality was a git-touch that did the commands before.

Best regards and keep the good work,
Lu=EDs Sousa

P.S.: While writing this message I realize that is easy to accomplish a=
=20
git-touch doing a bash script, but probably is a good idea to share.
