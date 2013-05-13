From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Mon, 13 May 2013 15:57:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1305131542210.30808@nerf07.vanv.qr>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	Christian Stimming <stimming@tuhh.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	Ralph Haussmann <ralph@scanmyfood.de>, git@vger.kernel.org,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 13 15:57:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbtGE-0008BC-Nt
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 15:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342Ab3EMN5v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 May 2013 09:57:51 -0400
Received: from ares07.inai.de ([5.9.24.206]:60282 "EHLO ares07.inai.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830Ab3EMN5u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 09:57:50 -0400
Received: by ares07.inai.de (Postfix, from userid 25121)
	id 997E996A1582; Mon, 13 May 2013 15:57:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by ares07.inai.de (Postfix) with ESMTP id 8004096A10BB;
	Mon, 13 May 2013 15:57:47 +0200 (CEST)
In-Reply-To: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224143>


On Monday 2013-05-13 14:54, Thomas Rast wrote:
>As I am sure you are all aware, there are two main religions as to how
>one can translate technical material into German: leave the technical
>terms mostly in English, or translate them to an appropriate
>corresponding word.  I'll denote them G+E and Ger, respectively.

The problem is that there are often no technical equivalent terms
in Ger, leaving you only with Eng which are paraphrased (in more
or less detail) in the German-language manpages.

"treeish" is one of those. The literal translation would be "baumig",
"b=C3=A4umlich". This is strange in German and at best only used by kid=
s.
In the SYNOPSIS section of e.g. git-ls-tree(1), you can get away with
"baum=C3=A4hnlich", but in flowtext (prose), the sane choices are, for
example:

	git-ls-tree erfordert als ersten nicht-Options-Parameter...

	~... einen "tree-ish", d.h. eine Referenz, aus der sich ein
	Baum-Objekt ableiten l=C3=A4sst.

	~... eine zu einem Baum-Objekt f=C3=BChrende Refernz

	~... eine Baum-Objekt-Referenz
	(dies kann auch ein Commit sein, da jedem Commit genau ein
	Baum-Objekt zugeordnet ist)


>My vote is G+E.

Essentially, so is mine. German terms will be used where such have
been used in prior computing (B=C3=A4ume have been used in the 90s too,
so that term is fine, for example). Stash however is something that
could be seen as something that has had its first appearence in Git,
with no corresponding native German term, in which case we should
do it roughly like Wikipedia, that is, provide a German equivalent,
but only for the introductory sake:

	Der Stash (dt: Versteck) bezeichnet einen Bereich ...

afterwards which the meaning of stash is at most re-recognizable
in the verb:

	... mit `git stash` wird der aktuelle Zustand im Stash
	weggespeichert.

That's my common-world use.

>glossary for git's de.po is [2].  I have no idea what Sven and Ralph d=
o.
>Perhaps a github wiki page would be fine for everyone?

A single wiki page might not suffice; we may need as much as one
wiki page per term, so that there is ample visual space to record
each person's comments and justification for choosing a particular
German translation. (Just look at my go at "treeish" above, for
example.)
