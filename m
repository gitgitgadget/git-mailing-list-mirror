From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Centralized repository
Date: Sun, 25 Feb 2007 16:50:11 +0100
Organization: Dewire
Message-ID: <200702251650.13381.robin.rosenberg.lists@dewire.com>
References: <EF7846A2-C573-4018-B399-EBBEEE2812A4@mac.com> <200702250951.37867.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, bob <kranki@mac.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 25 18:16:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLMyv-0005ym-G4
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 18:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbXBYRQO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 25 Feb 2007 12:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752388AbXBYRQO
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 12:16:14 -0500
Received: from [83.140.172.130] ([83.140.172.130]:1975 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752376AbXBYRQO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Feb 2007 12:16:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BF583803393;
	Sun, 25 Feb 2007 18:11:10 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06568-02; Sun, 25 Feb 2007 18:11:10 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 69613802AB6;
	Sun, 25 Feb 2007 18:11:08 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <200702250951.37867.andyparkins@gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40555>

s=F6ndag 25 februari 2007 10:51 skrev Andy Parkins:
> On Sunday 2007, February 25, bob wrote:
>=20
> > Anyway, for this one repository, I would really like GIT to support
> > the CVS/SVN central repository system.  The rest of the time, I am
>=20
> In the case of subversion: you really /wouldn't/ want that model. =20
> Subversion keeps a local pristine copy in the .svn directory of every=
=20
> file.  This makes local diffs and stats fast and not require network=20
> access, but also doubles the storage requirements of your working=20
> directory.
>=20
> I've found that a packed git repository is often smaller than a full=20
> checkout of the project (it's almost scary actually - your entire=20
> project's history in less space than the project).

That doesn't apply to a repo full of (already compressed) binaries medi=
a=20
files. You cannot pack them unless the binaries are so small  that the =
wasted=20
space at the end of the last disk block is a significant amount of the =
total=20
used. You cannot diff them either, other than seeing that they are diff=
erent.=20

Besides the 4 GB mentioned isn't much nowadays. If it is annoying to ha=
ve=20
the .git directory in the same filesystem tree you can place the .git=20
directory somewhere else and drop a  symbolic link in it's place.=20

Btw, is it possible to make a full repo shallow again, by pruning =20
the "uninteresting" part of the history? That would make it possible to=
 trim=20
down the size of the local archive.=20

-- robin
