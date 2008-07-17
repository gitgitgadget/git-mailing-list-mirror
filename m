From: Theodore Tso <tytso@mit.edu>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 10:26:54 -0400
Message-ID: <20080717142654.GQ2167@mit.edu>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <487EF519.5070902@sneakemail.com> <20080717125536.GO2167@mit.edu> <487F4A9A.1090108@morch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Valdemar =?iso-8859-1?Q?M=F8rch?= <lists@morch.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 16:28:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJUSa-0006T8-Uf
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 16:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756952AbYGQO05 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2008 10:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756579AbYGQO05
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 10:26:57 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:41420 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756566AbYGQO04 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 10:26:56 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KJURb-0002Gn-JJ; Thu, 17 Jul 2008 10:26:55 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KJURa-0004kB-Ur; Thu, 17 Jul 2008 10:26:54 -0400
Content-Disposition: inline
In-Reply-To: <487F4A9A.1090108@morch.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88858>

On Thu, Jul 17, 2008 at 03:35:22PM +0200, Peter Valdemar M=F8rch wrote:
> E.g. something I seem to succeed with sometimes, but not consistently=
 is =20
> the equivalent of "svn revert -R .". "git help reset"? Yup: "git rese=
t =20
> --hard HEAD ." When I run into merge conflicts, I'll probably look at=
 =20
> such a doc again, but other than that I'll probably use man pages mos=
t.

You find quick alias to be a useful replacement for "svn revert -R
<file>" (aka "hg revert <file>" and "bg revert <file>"):

git config --global alias.revert-file "checkout HEAD --"

Once you run this command, you can now do "git revert-file <file>"
which I personally find very handy.  Sometimes I only want to revert
one file, and not all of the files in the working directory, which is
what "git reset --hard" will do.

(Note that "git revert" does something else useful, but which is not
the same as "hg revert", "bk revert" and "svn revert". Oh well, nobody
ever said DSCM's had to be consistent.)

						- Ted
