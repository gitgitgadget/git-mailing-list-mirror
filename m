From: Petr Baudis <pasky@suse.cz>
Subject: Re: Automatically remote prune
Date: Fri, 6 Nov 2009 01:16:19 +0100
Message-ID: <20091106001619.GE17748@machine.or.cz>
References: <43d8ce650911040242l44bbf87dm35494e04ce9039aa@mail.gmail.com>
 <7v639qi2un.fsf@alter.siamese.dyndns.org>
 <43d8ce650911041741w4b39d137ha2a1529a15256d27@mail.gmail.com>
 <7viqdpemki.fsf@alter.siamese.dyndns.org>
 <43d8ce650911050005l6d120cb0h374f3c04b3948b25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 01:16:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6CV9-0003w6-Cc
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 01:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759016AbZKFAQR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2009 19:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756462AbZKFAQQ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 19:16:16 -0500
Received: from w241.dkm.cz ([62.24.88.241]:38417 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbZKFAQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 19:16:16 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id AE3AA86201A; Fri,  6 Nov 2009 01:16:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <43d8ce650911050005l6d120cb0h374f3c04b3948b25@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132255>

On Thu, Nov 05, 2009 at 05:05:50PM +0900, John Tapsell wrote:
> 2009/11/5 Junio C Hamano <gitster@pobox.com>:
> > John Tapsell <johnflux@gmail.com> writes:
> > "what the benefits are to give this information _in the 'branch' ou=
tput_"
> > was what I meant. =A0From the part you omitted from my message:
>=20
> I omitted it just because, imho, it's not what I 'care about'.  I'm
> not trying to help advanced users (Users that _want_ to keep
> remotes/origin/* clean and users that _want_ to be careful to not los=
e
> commits are both advanced users, imho).  I'm just interested in
> reducing confusion for non-advanced users.  So either not-showing
> removed remote branches by default, or showing them but marking them
> as deleted.

Maybe, if your users want to know "what branches does the remote repo
have" instead of "what branches does my 'image' of the remote repo has"=
,
just teach them to run

	git remote show origin

instead of

	git branch -r origin

as mentioned earlier by Junio?

Of course, users would still need to realize the actual meaning of the
commands and the fact that Git _does_ keep a distinctive 'image of
remote repository', so this may not be the most intuitive solution.

--=20
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
