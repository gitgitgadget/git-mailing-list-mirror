From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: Google Summer of Code 2011
Date: Thu, 10 Mar 2011 23:46:55 +0100
Message-ID: <20110310224654.GA13702@book.hvoigt.net>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com> <20110307194047.GA9588@book.hvoigt.net> <20110307205023.GB11764@paksenarrion.iveqy.com> <20110309215255.GA11845@book.hvoigt.net> <20110309231604.GA3903@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 23:47:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxodM-0005Bb-Lb
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 23:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab1CJWq6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 17:46:58 -0500
Received: from darksea.de ([83.133.111.250]:47475 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752898Ab1CJWq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 17:46:56 -0500
Received: (qmail 32615 invoked from network); 10 Mar 2011 23:46:54 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 10 Mar 2011 23:46:54 +0100
Content-Disposition: inline
In-Reply-To: <20110309231604.GA3903@paksenarrion.iveqy.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168863>

Hi,

On Thu, Mar 10, 2011 at 12:16:04AM +0100, Fredrik Gustafsson wrote:
> On Wed, Mar 09, 2011 at 10:52:56PM +0100, Heiko Voigt wrote:
> > Sounds promising. When I was talking about gui or submodules I did =
not
> > think about gui *and* submodules. Do you have some concrete areas y=
ou
> > would like to improve in mind?
>=20
> Many of the ideas I had was already mentioned in=20
> https://github.com/jlehmann/git-submod-enhancements/wiki/
>=20
> The ones I feel is most important for me is:
> * gitk: Add popup menu for submodules to see the detailed history of
> changes
> * Check before a push in the superproject that all submodules HEADs a=
re
> pushed
> * Showing that a submodule has a HEAD not on any branch in =E2=80=9Cg=
it status=E2=80=9D
> * Move the submodules git directories into the superproject=E2=80=99s=
 .git so that
> submodules can be created and deleted

Sounds like a good roadmap. From my viewpoint this includes enough work
for a summer. There are also enough small steps so even if only part of
this would be finished it would contain enough improvement for git.
Since this is the first time I am offering to mentor I am not that
familar how much work can be done during summer. What do others think?

(added Jens to the CC)

> With this said, I'm not familiar with the git codebase yet and does n=
ot
> have any concrete solutions. For example, I don't understand why a
> submodule doesn't get a default branch.

The familiarity with the code should not be a problem since the idea of
the Summer of Code is to allow more people to get involved into a
project.

Regarding the default branch: The short answer is that git does not
record any branchname but a specific revision using its SHA1. This is o=
n
purpose to make sure that you get exactly the code you had when you
created the commit. But a default branch has been requested many times
to make working easier. AFAIR it the consensus was that creating a
branch recursively by default would not be a good idea. But doing that =
on
explicit user request could be implemented as an option to ease users
workflow. So something like this could be discussed.

Cheers Heiko
