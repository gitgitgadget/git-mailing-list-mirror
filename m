From: =?ISO-8859-1?Q?Knut_Olav_B=F8hmer?= <knut-olav.bohmer@telenor.com>
Subject: how to keeping track of cherry-pick?
Date: Wed, 21 Jan 2009 00:53:08 +0100
Message-ID: <497663E4.4000302@telenor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 01:18:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPQmp-0006rh-AM
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 01:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202AbZAUAQP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2009 19:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757148AbZAUAQO
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 19:16:14 -0500
Received: from mail48.e.nsc.no ([193.213.115.48]:44090 "EHLO mail48.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756953AbZAUAQN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 19:16:13 -0500
X-Greylist: delayed 1381 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Jan 2009 19:16:13 EST
Received: from [10.0.0.1] (ti100710a080-2364.bb.online.no [85.165.9.64])
	(authenticated bits=0)
	by mail48.nsc.no (8.13.8/8.13.5) with ESMTP id n0KNr8eL005441
	for <git@vger.kernel.org>; Wed, 21 Jan 2009 00:53:08 +0100 (MET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106547>

Hi,

We are changing from subversion to git. We used to merge revisions from
development branch to stable with svnmerge.py.

svnmerge.py can give us a list of revisions available for merging. The
result is similar to "git log --chery-pick master..dev" The difference
is that svnmerge.py operates on revision-numbers, and --chery-pick look=
s
at the diffs. The result of that is that when we get a conflict when a
patch is cherry-picked, it will still show up as "available" when I run
"git log --cherry-pick master..dev"

svnmerge.py can also mark revisions as blocked, and will not show up in
the list of available revisions.

How can I keep track of cherry-picked patches, and mark patches as
"blocked", in the same (or similar) way as I did in subversion with
svnmerge.py?

--=20
Knut Olav B=F8hmer
