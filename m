From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Distributed code review discussion
Date: Sat, 10 Jan 2015 10:54:54 -0800
Message-ID: <20150110185453.GL9044@odin.tremily.us>
References: <CAH5CKOqSc2qLZwhCrafYkXMvLmRxKeA_7OO+WzM2FQwKS9F3cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CykseNgfyvuYXqns"
Cc: git@vger.kernel.org
To: Matus Faro <matusfaro@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 19:57:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YA1Dj-0007p5-6R
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 19:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbbAJS5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 13:57:04 -0500
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:44282 "EHLO
	resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750770AbbAJS5D (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jan 2015 13:57:03 -0500
Received: from resomta-ch2-20v.sys.comcast.net ([69.252.207.116])
	by resqmta-ch2-10v.sys.comcast.net with comcast
	id eJx11p0032XD5SV01Jx2Dh; Sat, 10 Jan 2015 18:57:02 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by resomta-ch2-20v.sys.comcast.net with comcast
	id eJv01p00T152l3L01Jv14x; Sat, 10 Jan 2015 18:55:02 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 71CF2157CD18; Sat, 10 Jan 2015 10:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1420916094; bh=Nmya1uQfrJgLZ03Hg8GH5pcs6RIIF/62jQQ+8Dlh/pE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UgA4Bao9e11U3BRBhSRbt1zl/6CyheIjduSxJlzP0vwJk/6KZulV41u0jJiSCfVee
	 gbqU8PBql6aP3CTrN0jLVm3RqAsmrxyQTrzXCnBwwsAEGvB33XcznFi7SSGkfIXcdZ
	 auLJp+kvl/QCzBre5HvJdjg+2WPE5S7bUIz26o88=
Content-Disposition: inline
In-Reply-To: <CAH5CKOqSc2qLZwhCrafYkXMvLmRxKeA_7OO+WzM2FQwKS9F3cQ@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1420916222;
	bh=J1Ob9ZwWHLwBds/j2ieUUIZ7MViZilBPZx7VJ/22Tjs=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=On6sbllMgMkaQOAVTPNFtH1/ArGgX+nU0aSNwGGtdWqQGjixrSWzXWzoGv1ljeVL/
	 7OgjZOFLco0/5ooVjTbpX9jlXOpQWdb0in+VbMAX5LZAh15Hw5prx62DsDOVF4NWKV
	 jfxjB9qoCKGfpykWWPiO53PGd4Lhq2KsuqWvk4qeOVrYk3jHh385EKS5CIRCu9ga8R
	 XJ1DtrP2pU1aurxBm7iamiXlOccCs57vt7EPyBEavNw+KAIs3QAvILfQ0j/hEVyF0u
	 3hExzjIdNWD3ll3liz9kBXUSxdc1yPCvDcK0/AgLWSi8Txn7PbcW1UmdwK1WinfsYo
	 4SyJf102Y9aCw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262270>


--CykseNgfyvuYXqns
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2015 at 01:05:35PM -0500, Matus Faro wrote:
> What I mean is a distributed code review system where a merge
> request along with review comments would be stored within the git
> repository and allowed to be pushed and pulled between repository
> clones. This would allow users to retain the code review history
> without relying on centralized or proprietary third party solutions.

You can do this today with pull-requests and code review happening in
email, since you just have to distribute the mail archives to have a
record of pull-requests and code review discussions (e.g. notmuch
posts an mbox of it's list archives [1]).  For better usability, you
have a few more options borrowing from the notmuch workflow:

* Index messages in notmuch [2] (like notmuch does) and tag them so
  you know what branches are waiting on review [3] or author feedback
  [4].
* Use nmbug [5] to collaborate on tagging and distribute tags to
  interested parties.

Things I've been thinking about doing =E2=80=9Cat some point=E2=80=9D:

* Use ssoma [6] or my ssoma-mda Python port [7] to store the list
  archives in Git using this format [8].  I'd like to teach notmuch to
  read messages directly from the ssoma archive, which would let you
  replace the mbox archive with something that's easier to collaborate
  on than an mbox archive (e.g. for removing duplicates or fixing
  typos).  If all interested parties are using ssoma-style storage for
  the archives, you don't have to worry about =E2=80=9Coops, I didn't mean =
to
  hit send=E2=80=9D types of errors, since it's easy to patch the archive
  itself.
* Provide a web-UI for browsing the archive and manipulating tags, so
  folks don't need to install Git / notmuch / ssoma to get involved in
  patch review.  I'd still have them submit comments via email, but
  you could have the web-app send email for them if you have
  anti-email users ;).

Cheers,
Trevor

[1]: http://notmuchmail.org/archives/notmuch.mbox
[2]: http://notmuchmail.org/
[3]: http://nmbug.tethera.net/status/#Review
[4]: http://nmbug.tethera.net/status/#Moreinfo
[5]: http://notmuchmail.org/nmbug/
[6]: http://ssoma.public-inbox.org/README
[7]: http://git.tremily.us/?p=3Dssoma-mda.git
[8]: http://ssoma.public-inbox.org/ssoma_repository.txt

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--CykseNgfyvuYXqns
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUsXV8AAoJEG8/JgBt8ol8ZPsP/jHdAjp+C9gHfSmXh1o+Yc6Y
YqtINZLnn+L+mvAgGquJ9blqogLTFqseLnKh1dL/Jkv6hC8smJPYL/sEbI/Lq4Qz
hS2GIpwAJigma/OM4qXnZMonyZY/BLncFN+zJMYMcIecBm1FLLJeDSfIQb5B6biI
bjN+MttB3pRT3Ib0+kPtD574iVgqHw2mkBAJHbKY4i+h65U/Rli5GIoUpuJKA2nl
S4vwcPWxNmDNQQKx8IaO4U/B6t2qSOh1IrKyrkunDY/HRzskwVU7Qg00YlIpGZWJ
HcaKLSkJcwKReb0oZqWdG+5UYc80Uqyl38FqX9xErpAhmlFERZqxiElM72KhS0iR
Q1LZnklc+FtFrkxfgKbA1mpvMKMbCUMyhtp1cOQaGD4PmNT0+rzugJO1tnM2Hal8
+DpQJIq483DzA3YXR3ZC+z8i4POaI8qnlIYPf2CdizEnLi04ybTzSxjKZ7vFhTDl
ENVlDRDhicyg+nGvwCrekSdhJqCy/hcqfIGi/TBR1tY6PHncJS8S7I19wA7gQUhf
D9MxKUzdzmnO6lqbhEcKZjCFDUmxB26hHCb2BWquYyANEOa7/uVG02dPRAnA4sRh
7wzf8cL08tFDPtJHHXaQ/ZQn8f2tXelE8CVqdaPFtbBYXWqcVTC1Vi3bjjGLfj5t
YchTca+ExgDf+SsNQ5MH
=wOwG
-----END PGP SIGNATURE-----

--CykseNgfyvuYXqns--
