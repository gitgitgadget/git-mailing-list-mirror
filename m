From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: Re: git-annotate
Date: Sat, 25 Feb 2006 02:21:54 +0100
Message-ID: <43FFB132.8040202@iaglans.de>
References: <118833cc0602240721s1c64219y161cc0536fb361e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6DFB5969DEF1FC44AE9244C3"
X-From: git-owner@vger.kernel.org Sat Feb 25 02:23:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCo9h-0001Io-1E
	for gcvg-git@gmane.org; Sat, 25 Feb 2006 02:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWBYBX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 20:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWBYBX0
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 20:23:26 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:52754 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S964838AbWBYBXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 20:23:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id F11853FA9
	for <git@vger.kernel.org>; Sat, 25 Feb 2006 02:23:09 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 20599-04 for <git@vger.kernel.org>;
	Sat, 25 Feb 2006 02:23:05 +0100 (CET)
Received: from [192.168.100.26] (hermes.lan.home.vilz.de [192.168.100.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id D0EDA3E94
	for <git@vger.kernel.org>; Sat, 25 Feb 2006 02:23:03 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
To: GIT Mailing List <git@vger.kernel.org>
In-Reply-To: <118833cc0602240721s1c64219y161cc0536fb361e4@mail.gmail.com>
X-Enigmail-Version: 0.92.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16750>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6DFB5969DEF1FC44AE9244C3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Morten Welinder wrote:
> git-annotate ought to call usage() if it doesn't get its file.
Full Ack.

>>git annotate
> 
> Use of uninitialized value in open at
> /scratch/welinder/git/git-annotate line 40.
> Failed to open filename: No such file or directory at
> /scratch/welinder/git/git-annotate line 40.

oh yes, that was something, i slipped over today, didn't have the time
to report it myself.

additionally i got following with git-annotate --help

niv@hermes ~ $ git-annotate --help
/usr/bin/git-annotate version [unknown] calling Getopt::Std::getopts
(version 1.05 [paranoid]),
running under Perl version 5.8.8.

i don't know if that should happen so.

Nicolas

--------------enig6DFB5969DEF1FC44AE9244C3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD/7E3SlT0CowElk8RAsUkAJ0Yb4mjapJwhIbRSgmi5oiZzu/FIQCglAMM
iLSGRKSMMRql/jptOWw6dTw=
=LM85
-----END PGP SIGNATURE-----

--------------enig6DFB5969DEF1FC44AE9244C3--
