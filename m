From: Chani <chanika@gmail.com>
Subject: Re: partial checkouts
Date: Sun, 24 May 2009 20:07:18 -0700
Message-ID: <200905242007.26575.chanika@gmail.com>
References: <200905231401.11651.chanika@gmail.com> <200905231726.10361.chanika@gmail.com> <32541b130905241245m7139c766v73f6fe2aeda1fcf9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1626251.8PqAF4jZmc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 05:08:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8QY3-0008G0-Kv
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 05:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbZEYDIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 23:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbZEYDIP
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 23:08:15 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:36445 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbZEYDIO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 23:08:14 -0400
Received: by rv-out-0506.google.com with SMTP id f9so945748rvb.1
        for <git@vger.kernel.org>; Sun, 24 May 2009 20:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:cc:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=dYvI5B00+CjclK+lM1A368wA5OuhUZOlWOTZs++khy4=;
        b=x4yEiumfAX7+K83UarYoj1l2T81W9faVxg8Jvs9TnKjb6dDpa4Kq8HTnuP+gENH1vn
         CH+D+GG85OmDWrR/eVpVmQOcSoeVfpeVWTIm1Cq1I0s2HTOYuffVuNLViTmJ6eIpfpzx
         RJYXdBhufe7+GjWzV2rQ80RDrr4Yp9hHHr3cc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:cc
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=gt1vTbTf9QP1XVAgfqx2RR6tZgGx0yQCS8fcBoLeT8ukJ2yeOqD9u5hxrX52Mnxyzx
         ZBCSZszTq8RG4v7l74gkEialgVUHcdambCHF6bz5nLgleN7uYptOeUbjTZTiSNrE22j/
         VVjunkbqKhLWDShZfPFtVnrWJBv/Rwt4j4aV4=
Received: by 10.143.39.13 with SMTP id r13mr2115386wfj.33.1243220894636;
        Sun, 24 May 2009 20:08:14 -0700 (PDT)
Received: from brain.localnet ([96.49.70.32])
        by mx.google.com with ESMTPS id 30sm7999937wff.29.2009.05.24.20.08.13
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 20:08:14 -0700 (PDT)
User-Agent: KMail/1.11.90 (Linux/2.6.27-ARCH; KDE/4.2.87; i686; svn-970258; 2009-05-17)
In-Reply-To: <32541b130905241245m7139c766v73f6fe2aeda1fcf9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119883>

--nextPart1626251.8PqAF4jZmc
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> >>
> >> Check out git-subtree. It can split out a subdirectory into its own
> >> repo, and re-integrate it back into the "parent" repo at a later date.
> >> git-subtree has been posted as a patch to this list a couple of times
> >> without much response, but it looks like an interesting alternative to
> >> submodules: http://alumnit.ca/~apenwarr/log/?m=3D200904#30
> >
> > looks interesting. might have been a solution until I heard about this
> > requirement to not change workflow at all. :/
>
> Here's something that might work.  Write a script that runs on a
> server somewhere.  It checks out *all* of the git-managed KDE
> components, including documentation (it's okay to do this from *one*
> place, right?).  Then it loops through all the documentation
> subdirectories and splits them out into individual projects/branches
> with 'git subtree split'.
>

I like this idea. I like the idea of git subtree in general. :)
however, we've decided to go the "copy all documentation into svn" route fo=
r=20
now (so that the translators can keep using only svn).
I'll be back when we run into the next svn-external issue (there's sure to =
be=20
more). :)

=2D-=20
This message brought to you by eevil bananas and the number 3.
www.chani3.com

--nextPart1626251.8PqAF4jZmc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoaC2cACgkQeGbAwpIS3GwcVACgwzcWQujdja3UpqVfE6P6whq4
ww4AoNdrbyEhY8RqOF2Le13vONuz5UYM
=449u
-----END PGP SIGNATURE-----

--nextPart1626251.8PqAF4jZmc--
