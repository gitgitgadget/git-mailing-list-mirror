From: Tim Guirgies <lt.infiltrator@gmail.com>
Subject: Re: Created branch in wrong place... how to fix?
Date: Wed, 1 Jun 2011 22:52:19 +1000
Message-ID: <20110601125217.GB25353@Imperial-SSD-Overlord>
References: <BANLkTingMK3Zv6NZdFAiLXZzJpSZYZmjQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Wed Jun 01 14:52:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRkuT-0004Pg-ID
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 14:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061Ab1FAMwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 08:52:25 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:43124 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab1FAMwY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 08:52:24 -0400
Received: by pxi2 with SMTP id 2so3714893pxi.10
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 05:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=qk8+rv6lTJwpxRYUbrc37TK2HNjdlhyWBZpEivadbUI=;
        b=dfTDcUKW0OXytbP9vyIV5Lu3UTjb7VCP/jVbureqnVMHpPuDT5VuDGB9QxoRwnurVv
         1gNiqpqbzjpDArHtyw3QpdZVuHz5+LoKr6KO5S5legYUN/rZMrUj2BuqcBeEHwq4O9LN
         m1ANN2gG0Q6UxOKQy/7xT6bJ0qe/Z1vTY3N7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xF5ehhVNGcy46H6tIat6wP9bDn0LFDdisqvoEBxy1DGBWd1Zo7Ny5xOzgQKqxmA+b8
         TQNv7FA9ZpHrQaVL2Rtb61AeJ7LeBwQIdkcF9rbMMUJIHcsKhIKEdR4CSg2fk03QOyPd
         P0/sxcYSWYLz4y71aQUgJPl4XIxDDe4M0EV1I=
Received: by 10.68.27.71 with SMTP id r7mr2364403pbg.385.1306932743913;
        Wed, 01 Jun 2011 05:52:23 -0700 (PDT)
Received: from overlord.imperial.fleet (27-32-25-138.static.tpgi.com.au [27.32.25.138])
        by mx.google.com with ESMTPS id p5sm1051541pbd.28.2011.06.01.05.52.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 05:52:23 -0700 (PDT)
Received: from tim by overlord.imperial.fleet with local (Exim 4.76)
	(envelope-from <tim@imperial-ssd-overlord>)
	id 1QRkuJ-00072D-Ai; Wed, 01 Jun 2011 22:52:19 +1000
Content-Disposition: inline
In-Reply-To: <BANLkTingMK3Zv6NZdFAiLXZzJpSZYZmjQA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174865>


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 01, 2011 at 01:47:12PM +0100, Howard Miller wrote:
> Hi,
> I created a branch in a project and did a series of commits. I now
> discover that I really wanted to make all those changes against a
> completely different branch of the same project. There shouldn't be
> any issues as the branch introduces entirely new files (no changes to
> existing code).
> I'm struggling to see a way to do this without loosing the history.
> Some Google'ing suggests 'rebase --onto' but I'm struggling to see how
> this works or if it is appropriate. Any pointers much appreciated :)
> Thanks.

"git rebase" is indeed what you want to do.  Simply put, it takes all
your commits and rebases them somewhere else; i.e., makes them sit on
top of a different commit.  See "git help rebase" for a more detailed
explanation.

Of course, if you've already pushed and people have pulled from you,
you'll have problems; see the "recovering from upstream rebase" section
in "git help rebase".

You'll also want to do "git rebase -i".  The "-i" option ensures that
you can review what commits will be rebased, and even rearange, leave
out, or edit commits.

Good luck.

--=20
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org   - against proprietary attachments

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJN5jYBAAoJEGNoa2q+dzQWO3MP/3JJ5Gcsojmy7rjQONkduLGq
RTA09c6WtH4SvSqq3l0R9/n8+5D3MsfG3Ahi7ukjhyHbVwJ3qrqgJJTKO6OFmojz
c9RR6lo0w2S2EbzegZRPMBsNxb6q3VJGbe2mcAnaarQJ+QqoVBOJB4Mm9szFGXPA
ngTy+XL2AbB2tsYStOz98MFyt6TpK7ibo6faUFmbj+Ov8tvzajHvPMV14O4dCza1
kqCrP1TIhjk14Uv0tW1IV7eFo0npfyq1kgwZygfRko8kCbDTFBdKklaelvtTbCS+
yNqUcN5jY6a9PcLYcx2pi9EBe3xBsJ4R/YvMmobWH9umrQ/R1tp9ffPs8Ap76KO5
d0hoO/VHHPXTLxPL2R1L8eGOBqA2gSWotW2N2K123jCWWKTyqUo1FT4tcElWzoXy
SnUC/hB5u30N7syJ9T2o8UN6uS9IY2iUvJipYbRzT86VVhshrKSjqJVGucYOiOxq
7He+EIAUOgZXSt93pHetHe04U97WiSbcmGrUmypXpnNwG8c+8p0yVa7/M9MhyB7a
FIeOgqHPrJOvlZLh6ssMPFEopVDJx83D3EYakTySakrsoI5OwF/KhD3HykvLagke
KnB7QU8kjb8pwWmngQvGATISf34a1781nPQ7vmnPFgADnxFOVo7hJ+GNaJXIDuEb
l+wWNoZ5s3xixrluVSYx
=5xQk
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
