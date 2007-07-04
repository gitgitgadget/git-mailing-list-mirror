From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] stash: end commit log with a newline
Date: Wed, 4 Jul 2007 09:44:44 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070704074444.GA5687@informatik.uni-freiburg.de>
References: <20070703085906.GA4963@lala> <7vodiskb3d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, nanako3@bluebottle.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 09:44:59 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5zXm-0006mW-GY
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 09:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294AbXGDHow convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 4 Jul 2007 03:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754545AbXGDHow
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 03:44:52 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:35684 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753346AbXGDHov (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jul 2007 03:44:51 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1I5zXe-0000Aw-9R; Wed, 04 Jul 2007 09:44:50 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l647ijnu005732;
	Wed, 4 Jul 2007 09:44:46 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l647iir8005731;
	Wed, 4 Jul 2007 09:44:44 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>, nanako3@bluebottle.com
Content-Disposition: inline
In-Reply-To: <7vodiskb3d.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51576>

Junio C Hamano wrote:
> I noticed another thing.  The entries shown in "git stash list"
> look like this:
>=20
> stash@{0}: js/stash: e1d32c1... Teach git-stash to "apply --index"
> stash@{1}: master: 5be6007... Rewrite "git-frotz" to "git frotz"
> stash@{2}: master: 36e5e70... Start deprecating "git-command" in favo=
r of "git command"
> stash@{3}: master: 3b0d999... Merge branch 'jo/init'
>=20
> But each of the stash is _not_ about these commits, but is about
> some change that happens to be on top of them.
>=20
> So risking to make it a tad longer, how about doing this on top?
>=20
> -	git update-ref -m "$msg" $ref_stash $w_commit ||
> +	git update-ref -m "WIP on $msg" $ref_stash $w_commit ||

I like that.  I already wondered about that, too.  But not as much as
thinking about an alternative.

So:

Acked-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3Dgravity+on+earth%3D
