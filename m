From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Forcing --no-ff on pull
Date: Tue, 09 Dec 2008 01:34:00 -0800
Organization: Slide, Inc.
Message-ID: <1228815240.18611.48.camel@starfruit.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YV5v5lmPnvfJSFXXGodP"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 10:35:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9z06-0006pX-9Q
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 10:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbYLIJeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 04:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbYLIJeF
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 04:34:05 -0500
Received: from mx0.slide.com ([208.76.68.7]:43468 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566AbYLIJeE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 04:34:04 -0500
X-Greylist: delayed 1901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Dec 2008 04:34:04 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=C
	6VPWw/b7IFE7dAtEe+Q7d4wZtE3tkS+OKnydAEigG8=; b=Ye3ETk1v6k1ab6lIm
	t5EVbL/schumxn/jkdVRfEkEjnRMr/vkHbrhykKZdFe/DFLH9WgRVTRznu4qLV51
	Jdk8UMaOU4pB1Fuc3t/QR7yBKMcUV+qfvmgAKzLwymSVjDDg3x4rqID9u+YPEKRJ
	kgFw/srwD52JE/JNRAw2Yft9xE=
Received: from nat3.slide.com ([208.76.69.126]:44423 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1L9yyg-0003wH-FW
	for <git@vger.kernel.org>; Tue, 09 Dec 2008 01:34:02 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 6FF24A6F0002
	for <git@vger.kernel.org>; Tue,  9 Dec 2008 01:34:02 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.146
X-Spam-Level: 
X-Spam-Status: No, score=-3.146 tagged_above=-10 required=6.6
	tests=[AWL=-0.647, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l8vGxKUJjJU7 for <git@vger.kernel.org>;
	Tue,  9 Dec 2008 01:34:02 -0800 (PST)
Received: from [10.12.0.194] (unknown [10.12.0.194])
	by calculon.corp.slide.com (Postfix) with ESMTP id 38803A6F0001
	for <git@vger.kernel.org>; Tue,  9 Dec 2008 01:34:02 -0800 (PST)
X-Mailer: Evolution 2.22.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102611>


--=-YV5v5lmPnvfJSFXXGodP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

While I'm in the email writing mood tonight, I figured I'd ask this
question.

We've recently moved a giant tree with a number of developers over to
Git from Subversion. One of the biggest stumbling points we have right
now is the concept of a "fast-forward", insofar that it's "screwed" us a
couple times (see: people not RTFM'ing then crying that Git is broken
because they cannot RTFM ;))

The most common use-case involves a user merging a project branch into a
stabilization branch (`git checkout stable && git pull . project`) in
such a way that no merge commit is generated. Of course, without
thinking they'll push these changes up to the centralized repository.
Not 15 minutes later they realize "ruh roh! I didn't want to do that"
and become very frustrated that they have to resort to asking for help
or hand-reverting N number of commits.=20

Is there a header macro I can define or a config option I could define
to make --no-ff on `git pull` implicit instead of explicit? Making sure
we are always generating merge commits as a "just-in-case" safe guard
about merge-happy developers who think after hitting enter? :)


Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--=-YV5v5lmPnvfJSFXXGodP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkk+O4gACgkQFCbH3D9R4W+fbACfUid9Q4VpuzCt2SW8EEDtGdD9
rl4An1sz+xtIcNV2p0Lx+sBQR4Y+VVQt
=btG8
-----END PGP SIGNATURE-----

--=-YV5v5lmPnvfJSFXXGodP--
