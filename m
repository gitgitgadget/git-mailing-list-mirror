From: Remi Vanicat <vanicat@debian.org>
Subject: Re: git + unison
Date: Sun, 02 Dec 2007 19:13:10 +0100
Message-ID: <87y7cd7yo9.dlv@vanicat.homelinux.org>
References: <vpqd4tpgepj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Dec 02 19:13:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IytJv-0002v0-C7
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 19:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562AbXLBSNP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2007 13:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754411AbXLBSNP
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 13:13:15 -0500
Received: from sp604001mt.neufgp.fr ([84.96.92.60]:39639 "EHLO Smtp.neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753846AbXLBSNO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Dec 2007 13:13:14 -0500
Received: from vanicat.homelinux.org ([77.198.160.187])
 by sp604001mt.gpm.neuf.ld
 (Sun Java System Messaging Server 6.2-5.05 (built Feb 16 2006))
 with ESMTP id <0JSF009ALP9ZND10@sp604001mt.gpm.neuf.ld> for
 git@vger.kernel.org; Sun, 02 Dec 2007 19:13:11 +0100 (CET)
Received: from moi by vanicat.homelinux.org with local (Exim 4.68)
	(envelope-from <remi.vanicat@laposte.net>)	id 1IytJW-0003QK-7R; Sun,
 02 Dec 2007 19:13:10 +0100
In-reply-to: <vpqd4tpgepj.fsf@bauges.imag.fr>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: remi.vanicat@laposte.net
X-SA-Exim-Scanned: No (on vanicat.homelinux.org); SAEximRunCond expanded to
 false
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66804>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Hi,
>
[...]
Note that I do use I do use both unison and git, but I don't use
unison on git repository (I use git to synchronize git repository).

> So, at the moment, I have both unison and git. My fear is that unison
> touches the content of the .git/ directories. So, for example, if I
> commit on one side, and commit something else on the other side, I'll
> get unison conflicts at least on .git/refs/heads/master and
> .git/index, and resolving the conflict in favor of either side leads
> to dangling objects whith important content.

Well, at least with my configuration, when a file have been change on
both side, unison offer the possibility to transfer one way or the
other or to do nothing. I believe that if this happen, the correct
procure is to use git tool to merge (as git is better for merging
than unison, even more when we are speaking about git repository)

>
> What I'm doing right now is that I try to make sure I don't run uniso=
n
> when trees have diverged, which is not really satisfactory since 1) I
> can be wrong, and a miss-synchronization could lead to data-loss, and
> 2) that means not really taking advantage of unison.

Well, as I've already said, I use unison in an interactive way, so if
a file have been changed in both side, unison say it, ask me what to
do. So I can choose to do nothing, and to stop unison right away to
use a better tool for this task.





--=20
R=C3=A9mi Vanicat
