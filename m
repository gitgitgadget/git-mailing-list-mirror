From: =?ISO-8859-2?Q?Tajti_=C1kos?= <akos.tajti@intland.com>
Subject: git-http-backend with hooks
Date: Sat, 26 May 2012 16:11:55 +0200
Message-ID: <4FC0E4AB.5050103@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 26 16:12:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYHj6-0001X5-3K
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 16:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307Ab2EZOMF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 May 2012 10:12:05 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:53690 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab2EZOME (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 10:12:04 -0400
Received: from [192.168.1.101] (92-249-245-66.pool.digikabel.hu [92.249.245.66])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MK8bx-1SZelj148D-0021YJ; Sat, 26 May 2012 16:12:02 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; hu; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
X-Provags-ID: V02:K0:LjLl9mh3pfybRq/94iizCTtVprRDEuJlM9WqvK+oy2j
 Qi9MYJ5CEGSbzUfFc5wmV1+AFGVHC9Xae35MGzaAw+jFWRM3rj
 zdRBfOwPvczHMavVqiuOa+mmvVsLLDZ/Who3hxFtAfn6s9LEZD
 gH3SIV1+EY/LuY5Hc7r1gJam2vBXsr1Oo8Pmw5BrqFxf0T0tk+
 6yzvbrZpk1jcJmmwXpQR2yUkDkVRp2+C1RAahZ6IXcxvPYu+Wg
 G/CVuiW5VvsGUDiUkcd3wL59zlDrjsIDBe7YtJwHQEJPDPRMoc
 ooHiZaZkmGc9yY1knYPGa9qcaywDPlmshWYXJmwXRvIaBuyWw0
 6ZjR00rZYVXBc8D/1zUw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198563>

dear list,

we wrote a script that is basically a proxy before git-http-backend. Al=
l=20
git requests go through this and if some criteria is true then they're=20
passed to git-http-backend. We also have hooks in our repositories. The=
=20
problem is that in some cases we don't want the hooks to run. Is it=20
possible to somehow tell git-http-backend that the hooks shouldn't be r=
un?

thanks in advance,
=E1kos tajti
