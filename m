From: Steven Walter <stevenrwalter@gmail.com>
Subject: git-svn stomps on user properties
Date: Thu, 20 Mar 2008 13:01:08 -0400
Message-ID: <20080320170108.GA27194@dervierte>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Cc: normalperson@yhbt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 18:02:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcO9K-0008LP-PN
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 18:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757781AbYCTRBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 13:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756008AbYCTRBP
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 13:01:15 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:48414 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757781AbYCTRBO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 13:01:14 -0400
Received: by an-out-0708.google.com with SMTP id d31so254245and.103
        for <git@vger.kernel.org>; Thu, 20 Mar 2008 10:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        bh=WDQNubPprimtBjUm6Vnp+h1+tH16EvHFv58sGaGM/QU=;
        b=A/5J8+Lh4Wy9uagQzQTs2WK+wceYFtcp9OtTgNAC/IdPmohBkO5I6l7k8a9KATC7Fq3mfF/zUhBafU1PIFy1ysmqdg+lY59fSJdAe6ElBJrNzQZRCvrVb85oeXSOEMDhgLyBumIYr2ucfSOejpZ7HDboRx3Y/wJPCCXZQnyifp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=p6Hdrp9+1NAU4yMboDsEtfCNwJbzuX3xv8pik3pgPGt251PiPmGNrG5Ipp6M+P4t7+L9wZ+SudWmo/G1HgUzE5fd00Bsj+vBcpJvH6M//zPX3Lda3fI9yEy7xuyaJC69HTLeGGAlsj990RKLSxUn+o6dc2E0J19Hg/3rQ5JQowU=
Received: by 10.100.140.1 with SMTP id n1mr5547663and.99.1206032473480;
        Thu, 20 Mar 2008 10:01:13 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [76.177.32.143])
        by mx.google.com with ESMTPS id 7sm2548933agd.25.2008.03.20.10.01.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Mar 2008 10:01:09 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 2F05E1333BE; Thu, 20 Mar 2008 13:01:07 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77674>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm using git-svn to track an upstream subversion repository.  This
upstream repository has several "user" SVN properties (i.e., not in the
svn: namespace).  A recent git-svn dcommit resulted in one of these
properties being reverted.

Here's what happened.  I started a git-svn dcommit of 3 very large
commits.  In between commits 2 and 3, a commit was made by another
person that changed one of our user properties.  When git-svn sent the
third commit, it also reverted the property to its value before the
other's user's change.

Why did that happen?  Surely it isn't expected behavior.  Glancing
through git-svn, I don't see anywhere that it deals with properties
directly, outside of svm/svnsync properties.

Thanks for any help or insight you can provide
--=20
-Steven Walter <stevenrwalter@gmail.com>
Freedom is the freedom to say that 2 + 2 =3D 4
B2F1 0ECC E605 7321 E818  7A65 FC81 9777 DC28 9E8F=20

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH4phT/IGXd9wono8RAp2TAJ9XSndMhMih/3KG3eUPgIJ7MixJgQCeKf3x
TkIvv0xmZ0PqqTq2uZu+Lng=
=SfjG
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
