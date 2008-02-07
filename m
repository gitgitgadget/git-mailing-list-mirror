From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Re: Applying patches from gmane can be dangerous.
Date: Thu, 7 Feb 2008 09:50:36 -0500
Message-ID: <20080207145036.GM26016@yugib.highrise.ca>
References: <20080205211044.GP26392@lavos.net> <7vodatqu6w.fsf@gitster.siamese.dyndns.org> <20080207133208.GT26392@lavos.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Magne Ingebrigtsen <larsi+gmane@gnus.org>
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 15:51:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN85o-0006TO-Qc
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 15:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbYBGOui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 09:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755245AbYBGOui
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 09:50:38 -0500
Received: from yugib.highrise.ca ([205.150.199.213]:46275 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbYBGOui (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 09:50:38 -0500
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id BFD61111E3A;
	Thu,  7 Feb 2008 09:50:36 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080207133208.GT26392@lavos.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72952>


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Brian Downing <bdowning@lavos.net> [080207 07:32]:
> On Wed, Feb 06, 2008 at 08:14:31PM -0800, Junio C Hamano wrote:
> > This is really sad.  gmane gives us a clean threaded interface
> > (both in web and newsreader), and it never forgets. Whenever I
> > need to refer somebody to an old discussion, I can give an URL
> > to it and allmost all the discussion messages are there with a
> > single paste and clicking around.  It has been an indispensable
> > service to me ever since I started reading the git list with it.
> > It is really a shame that I have to prevent picking up patch
> > messages from it with the above hook.
> > 
> > I am wondering if other development communities had a similar
> > issue already, and if so how they are dealing with it.
> 
> Gmane didn't start doing this until recently.  Maybe they can stop it on
> a group-by-group basis?  Every post to git@vger is archived elsewhere
> with unmangled email addresses anyway...
> 
> "We understand why you're doing this, but it hurts us greatly.  Please
> stop."

Gmane has always done the "hide the real email" address on groups that
request it.  The git group does *not* request it, but the msysgit group
*has* requested it.

Note that I dont ahve any inner circle knowledge of gmane, but I have
used it for ages, and watched the gmane discuss for as long.

One of the "nice" things about gmane is that it follows thread/lines/etc
across groups as the discussions move.  They do this because the only
store a single copy of the message (based on message-id), and link it to
the groups  (after all, it is a news store).  But because of that single
copy of a message, if the 1st group/list a message comes in for is set
to hide the email addresses, I beleve the stored copy gets its addresses
munged.

If you look at the message Junio referenced, it hit gmane first from the
msysgit list (@google), not the git list (@vger).  So when the git@vger
mail came in with the same message-id, it simply linked it to the
already stored message

Basically, we have to convince groups that are commonly "overlapping"
git@vger on gmane not to choose hiding the emails.  In this case, the
msysgit group.

a.

-- 
Aidan Van Dyk                                             Create like a god,
aidan@highrise.ca                                       command like a king,
http://www.highrise.ca/                                   work like a slave.

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFHqxq8uVxNPsxNPScRAvtjAJ9JHLqAn38azmN5f4a8zqiYoBdSeACgh9zo
5rNG9I4DG0mTzJ6/UlvYPSM=
=M7y5
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--
