From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Re: To page or not to page
Date: Fri, 2 May 2008 10:00:40 -0400
Message-ID: <20080502140040.GI18081@yugib.highrise.ca>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <7vlk2txn8n.fsf@gitster.siamese.dyndns.org> <8C3474E2-3A4F-44E8-B301-C36939C7BA11@sb.org> <807E185B-BEE5-4AAF-8DF4-EE597681D61C@wincent.com> <20080502123656.GA2680@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Cc: Wincent Colaiuta <win@wincent.com>, Kevin Ballard <kevin@sb.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 02 16:20:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrw7a-0005xQ-8N
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 16:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761168AbYEBOTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 10:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761316AbYEBOTe
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 10:19:34 -0400
Received: from yugib.highrise.ca ([205.150.199.213]:35786 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbYEBOTd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 10:19:33 -0400
X-Greylist: delayed 1132 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 May 2008 10:19:33 EDT
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id 573CB111E39;
	Fri,  2 May 2008 10:00:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080502123656.GA2680@sigill.intra.peff.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81001>


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Jeff King <peff@peff.net> [080501 00:00]:
> On Fri, May 02, 2008 at 12:34:10PM +0200, Wincent Colaiuta wrote:
> 
> > But evidently given that there has been so much backlash against the  
> > patch the only way to keep everyone happy will be to make this  
> > configurable.
> 
> Agreed.
> 
> But I wonder why there seems to be such a split between people who
> clearly have short git-status output, and those who have long git-status
> output.
> 
> I keep my "untracked files" list tidy. IOW, I always get:
> 
>   $ git status
>   # On branch master
>   nothing to commit (working directory clean)
> 
> and if I don't, then I should be taking some action to commit things,
> clean them up, or add them to my .git/info/exclude file. Do other people
> generally carry around a lot of cruft that "git status" reports?

I like the change.  I don't usually have long git status output; I
manage my .gitignore and $GITDIR/info/exclude religously.  But in
those cases, the pager has no affect (LESS=FRSX), so it doesn't bother
me.

But sometime I have done something which affects a lot of files.  Either
on purpose, or by accident, and suddenly git status has lots of output.
And I'm usually not thinking git status will have reams of output and
at that time, I really like *not* having to re-run the command with -p
or | $PAGER.

a.


-- 
Aidan Van Dyk                                             Create like a god,
aidan@highrise.ca                                       command like a king,
http://www.highrise.ca/                                   work like a slave.

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFIGx6IuVxNPsxNPScRAgJEAKCcp62BiK0LJMVThdUyQoD24INdEQCgkZaw
YooWyEXvhgEq4bR1q39OTTE=
=udJn
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
