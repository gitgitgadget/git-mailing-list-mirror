From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: The EGIT Chronicles Issue Volume 3, Issue 1
Date: Mon, 6 Apr 2009 08:33:27 +0200
Message-ID: <200904060833.27711.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 10:17:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqk11-0006Ze-9l
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 10:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbZDFIPd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 04:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752610AbZDFIPc
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 04:15:32 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:47633 "EHLO
	pne-smtpout1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752507AbZDFIPb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Apr 2009 04:15:31 -0400
Received: from sleipner.localnet (90.232.53.138) by pne-smtpout1-sn2.hy.skanova.net (7.3.129)
        id 49CCD9F800113C1D for git@vger.kernel.org; Mon, 6 Apr 2009 10:15:28 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.27-14-generic; KDE/4.2.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115778>


A year and a thousand commits has passed since the previous issue of th=
is
newsletter.

Publicity
- The EGit plugin has passed version 0.4 some 280 commits ago and has r=
aised    more attention. Downloads are on the rise and the project gets=
 attention in blogs around the net. mostly positive, which may be surpr=
ising, since it still lacks a lot of functionality. That's encouraging.

Most interestingly, some Eclipse developers, i.e. the ones that build a=
nd contribute to the Eclipse platform, have raised interest in Git for =
source control. We have had an Eclipse proposal under development for a=
 while and finally submitted EGit for consideration as and Eclipse Tech=
nology project.  Link: http://www.eclipse.org/proposals/egit/

Egit is EPL and BSD licensed which license-wise qualifies it for inclus=
ion into the Eclipse project, unlike the nearest competitor Mercurial t=
hat cannot
be bundled with Eclipse due to the GPL.

Obviously a proposal is not the same thing as acceptance. If you are in=
terested in the project you can contribute to the discussion in the new=
sgroup available via the link above.

- Shawn's been working on Gerrit2, a code review system built on top of=
 JGit, the core of the Eclipse plugin.=20

Noteable contributions

- Last Google Summer of Code contributed push/fetch support to the plug=
in. Marek Zawirskis code is still mostly as he left it, which proves it=
 was well crafted.

- Tor Arne Westb=F8 rewrote the decorator to run faster and wit fewer b=
ugs.

Thanks to a dozen or so other people that contributed with important fi=
xes
and improvements.

The pipe
- Lots of stuff is coming. For example, a few diff engines are being co=
nsidered, a blame implementation has been demonstrated, though not full=
y ready yet. Some simple merge/cherry picking capability is included al=
ready, but without the diff/patch engine it's not as fully automated as=
 one might want yet. Gerrit2 uses it though.

Update site
- New built versions are regularly published to an update site for easy=
 installation.
- When downloading from the update site, the plugin now has a descripti=
on you can read (git shortlog) summarizing the changes since the previo=
us version.

Bug tracker/Wiki
- Bugs can be reported on http://egit.googlecode.com and there is a wik=
i too

- Msysgit issues
A lot of people choose (?) to run Git and Eclipse on Windows and there =
are some issues when using the plugin and msysgit side-by-side (and you=
 still have to for serious git use) on Windows. A serious bug was found=
 and fixed in msysgit. That was easily trigged by running Eclipse and m=
sysgit in parallel. During repack your repo could ( likely) be whacked =
and obliterated. This was fixed in version 1.6.2. There are other issue=
, but they are very minor compared to this one. All these issues aren't=
 really specific to EGit, but it tends to trigger the problems more oft=
en since it accesses the repository quite often to look for changes.

- Controversial topics
Non-ASCII filenames is an issue that comes up ever more often. JGit/EGi=
t handles this differently since the C Git way simply doesn't work cros=
s platform. Hopefully we'll be able to reconciliate soon. EGit / C Git =
is compatible between Unix (except OS X) in UTF-8 mode and Windows. For=
 other situations your mileage may vary. We store names in UTF-8 on all=
 platforms. The OSX issue here is the infamous case of decomposed Unico=
de, i.e. a letter lika =E4 gets decomposed into two unicode code points=
 on Macs. The final word on this issue has not yet been uttered.=20

-- robin
