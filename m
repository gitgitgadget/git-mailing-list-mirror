From: tom fogal <tfogal@alumni.unh.edu>
Subject: Re: sharing git work while downstream from svn?
Date: Tue, 11 Aug 2009 17:14:38 -0600
Message-ID: <auto-000020209671@sci.utah.edu>
References: <auto-000020209577@sci.utah.edu>  <32541b130908111603v1e3f6c42peac792caf7097e0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 01:12:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb0WG-0006MP-5I
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 01:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277AbZHKXMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 19:12:31 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754383AbZHKXMb
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 19:12:31 -0400
Received: from mail.sci.utah.edu ([155.98.58.79]:42396 "EHLO sci.utah.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754292AbZHKXMa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 19:12:30 -0400
Received: from dummy.name; Tue, 11 Aug 2009 17:12:31 -0600
In-Reply-To: Your message of "Tue, 11 Aug 2009 23:03:47 -0000."
             <32541b130908111603v1e3f6c42peac792caf7097e0d@mail.gmail.com> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125617>

Avery Pennarun <apenwarr@gmail.com> writes:
> On Tue, Aug 11, 2009 at 10:55 PM, tom fogal<tfogal@alumni.unh.edu> wr=
ote:
> > This gets to be a mess when trunk changes: I'll rebase + potentiall=
y
> > fix some conflicts. =A0Other developers with some of the experiment=
al
> > patches will svn update, and get similar conflicts. =A0These might =
differ
> > in subtle ways, and now exchanging patches gets more difficult.
>=20
> Instead, do all your work in a branch *other* than the git-svn main
> branch.  When you're ready to merge your stuff into svn, do:
[snip]
> This basically results in a *single* commit getting sent to svn,
> rather than the batch of all the git commits you've been working
> on.  Most svn users don't care about this, because they lose all that
> granularity whenever they merge a branch anyhow.

=2E.. but I, as a git user forced to live in an svn world, *do* value a=
ll
of that history.  When I find a bug a month later, I want git-bisect
to be useful.  Further, when I'm reviewing sets of changes in a search
for some particular change, I want to be able to skip over large sets
of patches simply by looking at the first line of a commit log.  If I
squash all that history down, I have to wade into the patch itself.

-tom
