From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Commit-ish shortcut for immediate parent range
Date: Sun, 22 Oct 2006 21:17:45 +0100
Message-ID: <200610222117.45766.andyparkins@gmail.com>
References: <200610221548.42048.andyparkins@gmail.com> <Pine.LNX.4.64.0610221017180.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1703573.4MdI1Whr0W";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Oct 22 22:20:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbjny-0007e5-DO
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 22:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWJVUUS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 16:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWJVUUS
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 16:20:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:4636 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750821AbWJVUUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 16:20:16 -0400
Received: by ug-out-1314.google.com with SMTP id o38so1100637ugd
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 13:20:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id;
        b=fn8HX+m4pA5IWIMXCZeCzQsmMb34C69oEwt61iEFgY8l6wiHku+10UMz3tJXCX4fnOoJI70NIkCjtVeYxx9xqco9toBL6T04QnMqXJoCbq+JQaVNaPl4O5smeK526+ffNWA4bV66ROaiGaCHGLBWiIDqZUjS+sTDz0MkfJR2sv0=
Received: by 10.66.252.4 with SMTP id z4mr6034448ugh;
        Sun, 22 Oct 2006 13:20:15 -0700 (PDT)
Received: from ?192.168.7.102? ( [82.0.29.64])
        by mx.google.com with ESMTP id u1sm3039386uge.2006.10.22.13.20.14;
        Sun, 22 Oct 2006 13:20:15 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0610221017180.3962@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29783>

--nextPart1703573.4MdI1Whr0W
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 2006, October 22 18:25, Linus Torvalds wrote:

> Umm. That's not actually a very sensible operation. It's only sensible in
> the special case of "diff", and for that special case, what we do is to
> actually just say that the _command_ is special, not the range.
>
> It's called "git show".

You're entirely correct, that that is what I was looking for in that=20
particular case.  However, the reason I raised it as a question was that I=
=20
was poking around with git (which I'm enjoying immensely by the way - it=20
really is as perfect an SCM as I have ever used) and in short succession did

git-diff X^..X
git-log X^..X
git-format-patch X^..X

I imagined that I would eventually stumble on other git commands where I wo=
uld=20
want to do this operation again.  I'm sure I will have picked an incorrect=
=20
command in each case, however, they all did exactly what I wanted so I=20
stopped looking for the "right" command :-)


Andy

=2D-=20
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com

--nextPart1703573.4MdI1Whr0W
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFO9HpwQJ9gE9xL20RAr6qAJ9UVuY1uWNN488DUEl7/WfKnshYvwCg0DZl
RdwJGQh23ZIkjU1DcW/FPMA=
=CWcw
-----END PGP SIGNATURE-----

--nextPart1703573.4MdI1Whr0W--
