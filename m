From: =?utf-8?q?K=C4=81rlis_Repsons?= <k@11.lv>
Subject: What happens in this example case?
Date: Tue, 6 Apr 2010 09:13:53 +0000
Message-ID: <201004060913.56760.k@11.lv>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5724661.4GxF4TDRGX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 06 11:14:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz4rG-00024C-Qn
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 11:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240Ab0DFJN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 05:13:59 -0400
Received: from [85.15.210.5] ([85.15.210.5]:48183 "EHLO pasts.trikata.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751804Ab0DFJN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 05:13:59 -0400
Received: from keeper.loca (unknown [85.15.210.9])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pasts.trikata.com (Postfix) with ESMTPSA id C7AE26ED29
	for <git@vger.kernel.org>; Tue,  6 Apr 2010 12:17:47 +0300 (EEST)
Received: from station.localnet (station [192.168.7.93])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by keeper.loca (Postfix) with ESMTPSA id 7331D14F4D1A
	for <git@vger.kernel.org>; Tue,  6 Apr 2010 09:13:57 +0000 (GMT)
User-Agent: KMail/1.12.4 (Linux/2.6.32-gentoo-r7-2010-03-28; KDE/4.3.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144120>

--nextPart5724661.4GxF4TDRGX
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,
it would be good if someone explained how is git doing things internally when:

1.
mkdir dir; cd dir; git init; echo -e "A\na\nA" > file; git add .; git commit -a -m comm1

2.
echo -e "A\nb\nA" > file; git commit -a -m comm2;


I want to understand how those three letters are stored in each of the
two cases and how can the contents of file be recovered from .git
archive, say, after git reset --hard <commit-hash>?

(is git storing just the position of change for 'b' and 'b' in the second
case? why is $(git cat-file -p) showing all three letters for the respective
objects in both cases?)

--nextPart5724661.4GxF4TDRGX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAku6+1QACgkQHuSu329e3GGIAwCgw+F+pDWcq/4P00ZTTQCnTeF1
HO0An3b85V5V6Knoi7E+E1sRRoJ6dVHR
=bP7S
-----END PGP SIGNATURE-----

--nextPart5724661.4GxF4TDRGX--
