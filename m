From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: gitk doesn't always shows boths tags in "gitk tag1..tag2"
Date: Tue, 29 Jan 2013 20:40:34 +0100
Message-ID: <510825B2.6070805@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 20:41:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0H3G-0001zp-5c
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 20:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217Ab3A2Tkk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2013 14:40:40 -0500
Received: from mout.gmx.net ([212.227.15.19]:54545 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913Ab3A2Tkj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 14:40:39 -0500
Received: from mailout-de.gmx.net ([10.1.76.27]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MKwO6-1U0H2r03GK-000633 for
 <git@vger.kernel.org>; Tue, 29 Jan 2013 20:40:37 +0100
Received: (qmail invoked by alias); 29 Jan 2013 19:40:36 -0000
Received: from e177120189.adsl.alicedsl.de (EHLO [85.177.120.189]) [85.177.120.189]
  by mail.gmx.net (mp027) with SMTP; 29 Jan 2013 20:40:36 +0100
X-Authenticated: #5108953
X-Provags-ID: V01U2FsdGVkX19bJtsSIwBbVtwNBJEaY9k9xe1vn8EW4PnMMGznWk
	5OIbJCjTNFqGMX
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130111 Thunderbird/17.0.2
X-Enigmail-Version: 1.5
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214963>

=46or a cloned BOINC git tree :

$> git clone git://boinc.berkeley.edu/boinc.git

the following 2 commands shows both starting and ending revisions :

$> gitk client_release_7.0.41..client_release_7.0.42
$> gitk client_release_7.0.43..client_release_7.0.44

however this command doesn't show the tag "client_release_7.0.44" :

$> gitk client_release_7.0.44..client_release_7.0.45

Now I'm wondering whether this is a side effect of the developer model
of BOINC or an issue in gitk ?


--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
