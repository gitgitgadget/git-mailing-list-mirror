From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: why doesn't "git bisect visualize" show all commit ids from the bisect
 log
Date: Fri, 20 Sep 2013 20:08:12 +0200
Message-ID: <523C8F0C.6050203@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 20 20:08:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VN57s-00026o-Us
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 20:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301Ab3ITSIS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Sep 2013 14:08:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:57890 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753135Ab3ITSIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 14:08:16 -0400
Received: from [80.171.223.22] ([80.171.223.22]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0Lyi0B-1W0NeE3ESF-016Bxe for <git@vger.kernel.org>;
 Fri, 20 Sep 2013 20:08:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130919 Thunderbird/17.0.9
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:q0yGmzCyAfXw6A9gS68XM9IJjLEhyQeb+/8Nkgp+aJEexLH9jLF
 /ZNwofH3C3NwsR44WyGbATZtScKZQwzbAzvafj9FHVd0zLiWiIWCZUZKnJcZDgmJsLgHvMG
 9xTKpU8nZCtAg2+9J5QWrkYhVqINy1ewiauD2BWSA59yt+JTZJEnrv0ksoS7cS2aCtOWInL
 N8LcR6euK2uxGYNFNuPiw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235073>

When run that command immediate after "git bisect start" somebody sees
the full commit range as defined in "git bisect start".

However running that command later after few git bisect steps" somebody
is just presented with the remaining commit interval.

Is this intended ?

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
