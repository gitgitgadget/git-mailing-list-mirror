From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: RFC: "git config -l" should not expose sensitive information
Date: Thu, 20 Dec 2012 17:20:49 +0100
Message-ID: <50D33AE1.4020604@gmx.de>
References: <50CF039A.7010800@gmx.de> <20121220150408.GD27211@sigill.intra.peff.net> <20121220154915.GA5162@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 17:21:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlirw-00074Q-6y
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 17:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241Ab2LTQUz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Dec 2012 11:20:55 -0500
Received: from mout.gmx.net ([212.227.17.20]:56791 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114Ab2LTQUy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 11:20:54 -0500
Received: from mailout-de.gmx.net ([10.1.76.69]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MQ9FN-1TgTo713fX-005HPB for
 <git@vger.kernel.org>; Thu, 20 Dec 2012 17:20:52 +0100
Received: (qmail invoked by alias); 20 Dec 2012 16:20:51 -0000
Received: from f054055243.adsl.alicedsl.de (EHLO [78.54.55.243]) [78.54.55.243]
  by mail.gmx.net (mp069) with SMTP; 20 Dec 2012 17:20:51 +0100
X-Authenticated: #5108953
X-Provags-ID: V01U2FsdGVkX19yRDZHXn5yLF2NR2w78lg8cCRKURODLKqCSh40WA
	Fm6lzOxhBGdQuq
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121220154915.GA5162@pug.qqx.org>
X-Enigmail-Version: 1.4.6
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211904>

yep - understood


On 12/20/2012 04:49 PM, Aaron Schrab wrote:
> At 10:04 -0500 20 Dec 2012, Jeff King <peff@peff.net> wrote:
>> The problem seems to be that people are giving bad advice to tell
>> people to post "git config -l" output without looking at. Maybe we
>> could help them with a "git config --share-config" option that dumps
>> all config, but sanitizes the output. It would need to have a list o=
f
>> sensitive keys (which does not exist yet), and would need to not jus=
t
>> mark up things like smtppass, but would also need to pull credential
>> information out of remote.*.url strings. And maybe more (I haven't
>> thought too long on it).
>=20
> If such an option is added, it is likely to cause more people to thin=
k
> that there is no need to examine the output before sharing it.  But, =
I
> don't think that the sanitizing could ever be sufficient to guarantee=
 that.
>=20
> Tools outside of the core git tree may add support for new config key=
s
> which are meant to contain sensitive information, and there would be =
no
> way for `git config` to know about those.
>=20
> Even for known sensitive keys, the person entering it might have made=
 a
> typo in the name (e.g.  smptpass) preventing it from being recognized=
 as
> sensitive by the software, but easily recognizable as such by a human=
=2E
>=20
> There's also the problem of varying opinions on what is considered as
> sensitive.  You mention credential information in URLs, but some peop=
le
> may consider the entire URL as something which they would not want to
> expose.
>=20
> I think that attempting to do this would only result in a false sense=
 of
> security.
>=20


--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
