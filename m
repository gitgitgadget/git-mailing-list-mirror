From: Phillip Susi <psusi@ubuntu.com>
Subject: Why does git stash create two commits?
Date: Mon, 30 Jan 2012 13:20:43 -0500
Message-ID: <4F26DF7B.7050109@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 19:20:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrvqU-0000iv-Rn
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 19:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000Ab2A3SUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 13:20:46 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:33757 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab2A3SUp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 13:20:45 -0500
X-Authority-Analysis: v=2.0 cv=TqVkdUrh c=1 sm=0 a=/DbS/tiKggfTkRRHPZEB4g==:17 a=seg9fo12g4kA:10 a=zPi0CIm2bxAA:10 a=S1A5HrydsesA:10 a=8nJEP1OIZ-IA:10 a=xe8BsctaAAAA:8 a=P2LobAHjrPaaAyTP_OwA:9 a=wPNLvfGTeEIA:10 a=/DbS/tiKggfTkRRHPZEB4g==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.78.168.186
Received: from [67.78.168.186] ([67.78.168.186:54104] helo=[10.1.1.230])
	by cdptpa-oedge03.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 51/07-20593-C7FD62F4; Mon, 30 Jan 2012 18:20:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
X-Enigmail-Version: 1.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189389>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

git stash makes two commits, one that has no changes from the base,
and one to stash your changes in.  Why?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPJt97AAoJEJrBOlT6nu75G1cH/1qXXMFBPr5vGZbPXCCgG4eG
nmTVlVjxa9Wk52rY/o3NfrgDrftuKIeMdjrFxe/hOsuU37rfMUpWlGa6wtwOIgHL
Cm2s/+PssrOwpajb+v3h+0vqZGNULaxPNpApDjB4JWTxNs86aCV/+zkzoqNjO8y4
OfAZnzqe03BJmPjldvygswD0RMvRvBuHyGRVhTgATcc89yZmihFxCNyekHdVUSvD
zVIUgyUj1vlSRDnSJrtARbKR3JZQeTtN6rMLIOxN0T3iOkltMWFGMoVbJ23kiUyD
LuMSNMrBvvkEU6g6czqQNNyreSut/b1r1ZTt/pvF0qDWUE5CZ9Qhgs6Xz7prtWs=
=Yp0K
-----END PGP SIGNATURE-----
