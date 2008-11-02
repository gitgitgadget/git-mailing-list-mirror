From: Francis Galiegue <fg@one2team.net>
Subject: Re: git-cvsimport BUG: some commits are completely out of phase (but cvsps sees them all right)
Date: Sun, 2 Nov 2008 23:31:13 +0100
Organization: One2team
Message-ID: <200811022331.14048.fg@one2team.net>
References: <200811022203.41092.fg@one2team.net> <f299b4f30811021421w2ef43792l7514ab3a0506077a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tomi.pakarinen@iki.fi
X-From: git-owner@vger.kernel.org Sun Nov 02 23:33:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwlVl-0004b6-K1
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 23:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbYKBWcU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Nov 2008 17:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753098AbYKBWcU
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 17:32:20 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:42653 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752937AbYKBWcU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Nov 2008 17:32:20 -0500
Received: from erwin.kitchen.eel (unknown [90.63.13.131])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id AC9E392C011;
	Sun,  2 Nov 2008 23:32:06 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <f299b4f30811021421w2ef43792l7514ab3a0506077a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99883>

Le Sunday 02 November 2008 23:21:44 Tomi Pakarinen, vous avez =E9crit=A0=
:
> CVS's branch does not appear on cvsps's output, until you do a commit
> to it. git-cvsimport
> relies on cvsps and can not do much about this...
>

Well, there's another file that cvsps generate (in $HOME/.cvsps) that h=
elps=20
here and that is named ":<method>:<method_args>:#path#to#cvsroot#module=
name."=20
This file contains the needed information. As far as I can see though,=20
git-cvsimport does not use it.


> Last problem may arise, if you try to do incremental imports from cvs=
 to
> git. For incremental imports you must start import from same location=
 in
> cvs each time.
> If you have made first import from beginning of history, sequent
> imports must start
> from there too. Otherwise cvsps will renumber patch sets.
>

The plan would be to convert all modules in one go, with no one committ=
ing in=20
the meantime, so that's not a problem.

I'll try and dig a little deeper into git-cvsimport and see if I can ma=
ke it=20
use this information...

--=20
fge
