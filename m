From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 07/10] Teach the new infrastructure about the index and worktree
Date: Mon, 26 Nov 2007 11:44:48 +0100
Message-ID: <20071126104448.GA3936@diana.vm.bytemark.co.uk>
References: <20071125203717.7823.70046.stgit@yoghurt> <20071125205140.7823.46991.stgit@yoghurt> <874pf9bd11.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Nov 26 11:45:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwbSk-0004SR-SH
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 11:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbXKZKo4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Nov 2007 05:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753225AbXKZKo4
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 05:44:56 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3014 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396AbXKZKoz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 05:44:55 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IwbSK-0001O5-00; Mon, 26 Nov 2007 10:44:48 +0000
Content-Disposition: inline
In-Reply-To: <874pf9bd11.fsf@lysator.liu.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66063>

On 2007-11-26 09:56:42 +0100, David K=E5gedal wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > --- a/stgit/lib/git.py
> > +++ b/stgit/lib/git.py
> > @@ -95,6 +95,8 @@ class Commitdata(Repr):
> >          return type(self)(committer =3D committer, defaults =3D se=
lf)
> >      def set_message(self, message):
> >          return type(self)(message =3D message, defaults =3D self)
> > +    def is_empty(self):
> > +        return self.tree =3D=3D self.parent.data.tree
> >      def __str__(self):
> >          if self.tree =3D=3D None:
> >              tree =3D None
>
> But a Commitdata describes a Git commit, right? And not an StGit
> patch.

Yes.

> So what does it mean to say that a commit is empty? I could just as
> well mean that the tree is the null tree. I think I would have
> called this "is_nochange" or something.

Good point.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
