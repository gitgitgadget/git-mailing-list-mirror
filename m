From: Phillip Susi <psusi@ubuntu.com>
Subject: gitk and reflog
Date: Mon, 23 Mar 2015 22:21:44 -0400
Message-ID: <5510CA38.9010806@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 03:22:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaETk-00061Q-Bb
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 03:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbbCXCV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 22:21:59 -0400
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.232]:47423 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752284AbbCXCV6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2015 22:21:58 -0400
Received: from [72.238.77.169] ([72.238.77.169:38272] helo=[192.168.1.142])
	by cdptpa-oedge01 (envelope-from <psusi@ubuntu.com>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 68/20-21837-83AC0155; Tue, 24 Mar 2015 02:21:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
X-RR-Connecting-IP: 107.14.168.118:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266174>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Why does gitk -g master not work?  I would expect gitk to load up the
master branch reflog and show each of the previous heads that master
has transitioned through, but it doesn't.  Instead I have to run gitk
master@{1} master@{2}, etc, and then, while it shows each of the
previous heads, it doesn't label them.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJVEMo4AAoJENRVrw2cjl5RVXUIAKcp7UTV6sfgquW7YJEZAXqO
KPS0kdpVwS2rJN5RNuRHEYlFPDgM7sm3gicXpEpksGQnS6CsR3fCgpQXb9GZRHgR
q/fh9E0BvLTjWzxBip7Y5Ojb+cgyAUw1/Y2Pewq9Cb3Vb+DOokh9JHKSVa/7Y/+8
7UBGMM8xc2ac0JUbYK2Jaq3Koq8uHjSg8IidzYxDrxFKxnt2ZW2ArAAIyEdSTYd6
12uGFQN+NM6ZK3I8gviGhXi+sI3FhosUDBjjCqMtgt0Wp4mRWZwxmE9rkAA0/5re
R74IxcgXnezVCeX3GrrgzsSBnPVXF+UnvZX0KqDuhMnNw+qFACXTVVOW5U+V2Jo=
=M49Q
-----END PGP SIGNATURE-----
