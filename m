From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-svn: Finding the svn-URL of the current branch in git
Date: Sat, 18 Aug 2007 23:18:25 +0200
Message-ID: <20070818211825.GA18252@diana.vm.bytemark.co.uk>
References: <46B8BA03.1030809@gmx.de> <20070807205543.GB27703@xp.machine.xx> <20070816082110.GB16849@muzzle> <7vir7eh7mc.fsf@gitster.siamese.dyndns.org> <20070818090913.GA13936@soma> <85fy2hupui.fsf@lola.goethe.zz> <7vmywpcg63.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>, Eric Wong <normalperson@yhbt.net>,
	Matthias Kleine <matthias_kleine@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 23:19:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMVhV-0001Tt-1X
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 23:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbXHRVSv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 18 Aug 2007 17:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754647AbXHRVSv
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Aug 2007 17:18:51 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1759 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbXHRVSu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2007 17:18:50 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IMVgf-0004n9-00; Sat, 18 Aug 2007 22:18:25 +0100
Content-Disposition: inline
In-Reply-To: <7vmywpcg63.fsf@gitster.siamese.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56114>

On 2007-08-18 03:04:20 -0700, Junio C Hamano wrote:

> David Kastrup <dak@gnu.org> writes:
>
> > git-svn makes it possible for me to keep the mess that is git to
> > myself, and only expose others to the _results_ of my work with
> > it.
>
> Very well put. It is not just svn but I privately use git on top of
> cvs managed project for exactly this reason.

I use git (and git-svn, and StGIT) on top of our Subversion repository
at work for this reason too: git lets me rewrite recent history until
it's pretty, while svn considers history totally immutable (barring a
dump+filter+reload of the whole (central) repository).

However, I object to the insinuation (in David's post, if not yours)
that "history in git is a mess" because it's mutable. git lets you set
the policy for each of your branches: either allow history editing (to
be able to fix embarrassing mistakes), or don't (to let people rely on
history to not change under their feet). This is strictly better than
Subversion, which forces you to adopt the latter policy.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
