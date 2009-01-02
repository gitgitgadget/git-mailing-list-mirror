From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Fri, 2 Jan 2009 19:50:03 +0100
Message-ID: <20090102185003.GA21135@chistera.yi.org>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20090101204652.GA26128@chistera.yi.org> <alpine.LFD.2.00.0901011747010.5086@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 02 19:51:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIp7L-0007sL-T8
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 19:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757869AbZABSuL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jan 2009 13:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757997AbZABSuJ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 13:50:09 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:3136
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757869AbZABSuI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 13:50:08 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 80CB0801BF8F;
	Fri,  2 Jan 2009 19:50:05 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LIp5v-0005XH-M8; Fri, 02 Jan 2009 19:50:03 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0901011747010.5086@localhost.localdomain>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104402>

* Linus Torvalds [Thu, 01 Jan 2009 17:56:13 -0800]:

> On Thu, 1 Jan 2009, Adeodato Sim=C3=B3 wrote:

> > For me, the cases where I find patience output to be of substantial
> > higher readability are those involving a rewrite of several consecu=
tive
> > paragraphs (i.e., lines of code separated by blank lines). Compare:

> I don't think that's a "patience diff" issue.

Ah, I see.

> That's simply an issue of merging consecutive diff fragments together=
 if=20
> they are close-by, and that's independent of the actual diff algorith=
m=20
> itself.

> > I'll note that in this particular case, `git diff` yielded the very=
 same
> > results with or without --patience. I don't know why that is, Johan=
nes?
> > I'll also note that /usr/bin/diff produces (in this case) something
> > closer to patience than to git.

> See above - I really don't think this has anything to do with "patien=
ce vs=20
> non-patience". It's more akin to the things we do for our merge confl=
ict=20
> markers: if we have two merge conflicts next to each other, with just=
 a=20
> couple of lines in between, we coalesce the merge conflicts into one=20
> larger one instead.

> We don't do that for regular diffs - they're always kept minimal (ok,=
 not=20
> really minimal, but as close to minimal as the algorithm finds them).

> See commit f407f14deaa14ebddd0d27238523ced8eca74393 for the git merge=
=20
> conflict merging. We _could_ do similar things for regular diffs. It'=
s=20
> sometimes useful, sometimes not.

Independently of patience diff, then, I'd very much support changes to
improve the diff I pasted.

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
Debugging is twice as hard as writing the code in the first place. Ther=
efore,
if you write the code as cleverly as possible, you are, by definition, =
not
smart enough to debug it.
                -- Brian W. Kernighan
