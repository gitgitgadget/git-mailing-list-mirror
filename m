From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2 1/3] connect.c: allow ssh://user@[2001:db8::1]/repo.git
Date: Sun, 22 Feb 2015 18:57:34 +0100
Message-ID: <54EA188E.9090601@web.de>
References: <54E8A9D0.30108@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: lists@hcf.yourweb.de,
	"sandals@crustytoothpaste.net >> brian m. carlson" 
	<sandals@crustytoothpaste.net>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 22 18:57:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPamt-0005en-Be
	for gcvg-git-2@plane.gmane.org; Sun, 22 Feb 2015 18:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbbBVR5r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2015 12:57:47 -0500
Received: from mout.web.de ([212.227.17.12]:61995 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752194AbbBVR5q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2015 12:57:46 -0500
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LbJ02-1Xf0he0lOU-00kuQR; Sun, 22 Feb 2015 18:57:36
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <54E8A9D0.30108@web.de>
X-Provags-ID: V03:K0:oK3ACsH/pw91acAzIyGwauTG4pGfICs7cccxbqCFzEzCTerxXut
 JIp1uttuAcRe63PmNY1Ia0OvUNMcQnl8tlSSKHCm9e2rJK9q4Lo4slsHRYLD1GJyiyElSXY
 xs0ESYNp24cnVbBUffXqxDKIr854JkkgplhZ3ny1q8tzKN7FVm057qdoQS/76pFvmApa3w1
 kcEjvYtC5wF4gJszops6w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264233>

(Sorry for the spam, a few things need correction already now,
and forgot cc: Brian)

On 2015-02-21 16.52, Torsten B=C3=B6gershausen wrote:
> The ssh:// syntax was added in 2386d65822c91, it accepted
> ssh://user@2001:db8::1/repo.git, which is now legacy.
>=20
> Over the years the parser was improved to support [] and port numbers=
,
> but the combination of ssh://user@[2001:db8::1]:222/repo.git did
> never work.
s/did never work/was never implemented/
>=20
> The only only way to use a user name, a literall IPV6 address and a p=
ort
s/literall/literal/
> number was ssh://[user@2001:db8::1]:222/repo.git
>=20
> (Thanks to Christian Taube <lists@hcf.yourweb.de> for reporting this =
long
> standing issue)
>=20
> New users would use ssh://user@[2001:db8::1]:222/repo.git,
> so change the parser to handle it correctly.
>=20
> Support the old legacy URL's as well, to be backwards compatible,

s/URL's/URLs/
