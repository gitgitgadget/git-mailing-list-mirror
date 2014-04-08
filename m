From: David Kastrup <dak@gnu.org>
Subject: Re: Handling empty directories in Git
Date: Tue, 08 Apr 2014 19:36:18 +0200
Message-ID: <87zjjvg1v1.fsf@fencepost.gnu.org>
References: <1396968442.95061.YahooMailNeo@web120806.mail.ne1.yahoo.com>
	<vpqob0blpna.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Olivier LE ROY <olivier_le_roy@yahoo.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 08 19:36:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXZwi-0005bA-7y
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 19:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbaDHRgV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Apr 2014 13:36:21 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:56386 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757465AbaDHRgU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Apr 2014 13:36:20 -0400
Received: from localhost ([127.0.0.1]:55428 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WXZwY-0007P1-Q0; Tue, 08 Apr 2014 13:36:18 -0400
Received: by lola (Postfix, from userid 1000)
	id 5DA5FE053F; Tue,  8 Apr 2014 19:36:18 +0200 (CEST)
In-Reply-To: <vpqob0blpna.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	08 Apr 2014 19:03:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245937>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> The reason would be closer to "there is a valuable reason, but not
> valuable enough to change Git to do it". It's actually not so easy to
> track directories properly. Storing them in the Git repository is
> actually possible (actually, an empty tree is a special case of this,
> and is obviously supported), but defining and implementing a decent
> behavior for each Git command wrt this is not trivial.
>
> David Kastrup gave it a try a few years ago. I don't remember exactly
> what made him give up, but it was never completed and merged.

Oh, most likely what afflicts most of my unfinished projects.  I=A0lost
focus at some point of time.  I don't remember any fundamentally
unsolvable problems, but then I don't remember much at all.  There were
some annoyances with sorting order (either regarding the sorting of xxx=
/
or . or ./ or whatever) and some other stuff.

If anybody wants to take a look at the direction of unfinished stuff,
I=A0can see whether there are some old backups with git repos in my
possession.  But I really have no idea how much of the design might hav=
e
ended up in actual comments or code, and how much on some scraps of
paper or half-committed memory, and how much of that might have been
invalidated by other scraps of paper and half-committed memory.

So there is not likely to be more than food for thought recoverable.

I'm amused that you remember me being involved with that.  I=A0think
I=A0myself had forgotten all about it until recently.  I=A0don't even
recollect what made me remember again: looking at some old repo/commit
or searching in some old mailing list archive.

--=20
David Kastrup
