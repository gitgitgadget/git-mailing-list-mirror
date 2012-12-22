From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: problem with BOINC repository and CR/LF
Date: Sat, 22 Dec 2012 13:31:23 +0100
Message-ID: <50D5A81B.1000306@gmx.de>
References: <50CEF289.4040503@gmx.de> <CAH5451=FpmtGVVJ=mubE0KeD-tTVaNU96audzTRnNQh2BEEXPg@mail.gmail.com> <50CF41EB.1060402@gmx.de> <CAH5451=xiipSKrAb_DFXCW=+NAn+mnSm1zPzjhEVc8fZ2KGcnw@mail.gmail.com> <50D03D80.3090005@gmx.de> <50D05E62.7090605@web.de> <20121218164132.GC20122@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 22 13:31:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmOF0-0007JV-EB
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 13:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182Ab2LVMb3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Dec 2012 07:31:29 -0500
Received: from mout.gmx.net ([212.227.17.20]:55596 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059Ab2LVMb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 07:31:28 -0500
Received: from mailout-de.gmx.net ([10.1.76.69]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MbvL6-1TUJgZ3u6A-00JLt0 for
 <git@vger.kernel.org>; Sat, 22 Dec 2012 13:31:25 +0100
Received: (qmail invoked by alias); 22 Dec 2012 12:31:25 -0000
Received: from d221135.adsl.hansenet.de (EHLO [80.171.221.135]) [80.171.221.135]
  by mail.gmx.net (mp069) with SMTP; 22 Dec 2012 13:31:25 +0100
X-Authenticated: #5108953
X-Provags-ID: V01U2FsdGVkX1+y5/t5YFCyS1tnWcl+h8IT+eYJwy14zHfgjtVIbs
	cju7T4cJl/pvKW
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121218164132.GC20122@sigill.intra.peff.net>
X-Enigmail-Version: 1.4.6
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212046>

On 12/18/2012 05:41 PM, Jeff King wrote:
> I could reproduce it, too, on Linux.
>=20
> The reason it does not always happen is that git will not re-examine =
the
> file content unless the timestamp on the file is older than what's in
> the index. So it is a race condition for git to see whether the file =
is
> stat-dirty.

/me still wonders whether this race condition is a feature or an issue
in GIT - b/c it means that 2 different people cloning the same
repository get different results.


>=20
> -Peff
>=20


--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
