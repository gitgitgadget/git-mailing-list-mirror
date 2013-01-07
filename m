From: Phillip Susi <psusi@ubuntu.com>
Subject: recovering a corrupted git repo
Date: Sun, 06 Jan 2013 22:44:58 -0500
Message-ID: <50EA44BA.2030107@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 04:45:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts3eK-00080M-LN
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 04:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527Ab3AGDpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 22:45:01 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:61470 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab3AGDo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 22:44:59 -0500
X-Authority-Analysis: v=2.0 cv=VZd1zSV9 c=1 sm=0 a=C56BoFkcj+OI1kjAe8jE5A==:17 a=MtVMNMWb1ewA:10 a=uBsBa1gr-CYA:10 a=VPLoEFqtOP4A:10 a=S1A5HrydsesA:10 a=8nJEP1OIZ-IA:10 a=fxJcL_dCAAAA:8 a=JAES3IoezB8A:10 a=QfKxxUxMAAAA:8 a=3oKqOJoAxyxqoYIfBEMA:9 a=wPNLvfGTeEIA:10 a=C56BoFkcj+OI1kjAe8jE5A==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 142.196.87.46
Received: from [142.196.87.46] ([142.196.87.46:49465] helo=[192.168.1.10])
	by cdptpa-oedge03.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id CB/9D-05345-9B44AE05; Mon, 07 Jan 2013 03:44:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212875>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have not had any issue until I ran a git fsck recently, which
repored gzip and crc errors in some pack files.  git fsck does not
seem to repair the errors, only report them.  I would like to try to
rebuild my repository, without downloading any more from the origin
than I have to.  All of the commits I have added seem to still be
intact, so I assume the corruption in somewhere in the upstream
history packs.

How can I correct the errors, and fetch the corrupted upstream
history, while preserving my patches?  So far I have exported my
patches as bundles, and made a fresh clone from upstream, then pulled
the bundles back in, but there must be a better way that only fetches
the corrupted bits from upstream?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQEcBAEBAgAGBQJQ6kS6AAoJEJrBOlT6nu75tFgIAJCI+DEWDVxddEQM5qhmz1y8
3JuqjTHp7gIXmQv6WGbEIehJrRfTBudQn+Ip2jLMwavvL16oZe+cf/uuLo393Z+T
pxEcWHOtjdU/XZeQOV//R/Cfo7PY5n8wfasgFYZuFesJchInwFocTI6S5x2B9kIB
dvLonoiDQwe9JqQaoAxM0OLTWe9aj0gc3c36+WUlRgRZijUhEogYQwU8aEoa+TMq
s2p+tbaNYKocRAafQ4824DMnuQTWb+HJVU4uI1pH2yB964Urq9ELSX2jxeSRdlaH
d+AoJ8oMdymmUwPeuyivcmQQHEGGsxxgCOuLSSHh1hcxMaytZNcEkVQ6OzuGyZk=
=yUr4
-----END PGP SIGNATURE-----
