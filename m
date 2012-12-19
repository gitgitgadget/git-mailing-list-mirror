From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: problem with BOINC repository and CR/LF
Date: Wed, 19 Dec 2012 11:44:14 +0100
Message-ID: <50D19A7E.2070406@gmx.de>
References: <50CEF289.4040503@gmx.de> <CAH5451=FpmtGVVJ=mubE0KeD-tTVaNU96audzTRnNQh2BEEXPg@mail.gmail.com> <50CF41EB.1060402@gmx.de> <CAH5451=xiipSKrAb_DFXCW=+NAn+mnSm1zPzjhEVc8fZ2KGcnw@mail.gmail.com> <50D03D80.3090005@gmx.de> <50D05E62.7090605@web.de> <20121218164132.GC20122@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 19 11:44:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlH8e-0002x0-4l
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 11:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296Ab2LSKoT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2012 05:44:19 -0500
Received: from mout.gmx.net ([212.227.15.18]:59748 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976Ab2LSKoS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 05:44:18 -0500
Received: from mailout-de.gmx.net ([10.1.76.33]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0M6PTB-1SsSSp2pH1-00yUfu for
 <git@vger.kernel.org>; Wed, 19 Dec 2012 11:44:16 +0100
Received: (qmail invoked by alias); 19 Dec 2012 10:44:16 -0000
Received: from d221095.adsl.hansenet.de (EHLO [80.171.221.95]) [80.171.221.95]
  by mail.gmx.net (mp033) with SMTP; 19 Dec 2012 11:44:16 +0100
X-Authenticated: #5108953
X-Provags-ID: V01U2FsdGVkX18sFRdVX2QsKdg+fGd3Gx1TQNj0QcFFWsysPZMK1+
	zGJMlNBnCjs7cx
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121218164132.GC20122@sigill.intra.peff.net>
X-Enigmail-Version: 1.4.6
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211816>

On 12/18/2012 05:41 PM, Jeff King wrote:
> I could reproduce it, too, on Linux.
>=20
> The reason it does not always happen is that git will not re-examine =
the
> file content unless the timestamp on the file is older than what's in
> the index. So it is a race condition for git to see whether the file =
is
> stat-dirty.
>=20

Ah - /me was wondering why sometimes (but rarely) I could not exactly
reproduce the problem and was really wondering if the underlying file
system (ext4) would give an extra layer of trouble or not.

Thx for that explanation.


--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
