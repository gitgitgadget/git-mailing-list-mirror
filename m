From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git under Windows should warn or fail on entities differning only in
 case
Date: Fri, 12 Feb 2010 20:38:25 +0000
Message-ID: <8ed2af013638836aea441dc992bd403e@212.159.54.234>
References: <1265978433.7519.6.camel@chumley> <BIjfD8Ogt6D@mid.cfaerber.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: =?UTF-8?Q?Claus_F=C3=A4rber?= <gmane2010@cfaerber.name>
X-From: git-owner@vger.kernel.org Fri Feb 12 21:38:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng2Hb-0004t0-FX
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 21:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757621Ab0BLUid convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 15:38:33 -0500
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:39399 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757371Ab0BLUia (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2010 15:38:30 -0500
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 96324819C45C;
	Fri, 12 Feb 2010 20:38:28 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 6E1F8204C13;
	Fri, 12 Feb 2010 20:38:28 +0000 (GMT)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id kPFcFoOM2T+3; Fri, 12 Feb 2010 20:38:26 +0000 (GMT)
Received: from webmail.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 0BD7A1A244F;
	Fri, 12 Feb 2010 20:38:25 +0000 (GMT)
In-Reply-To: <BIjfD8Ogt6D@mid.cfaerber.name>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139743>

On 12 Feb 2010 19:19:00 +0100, gmane2010@cfaerber.name (Claus F=C3=A4rb=
er)
wrote:
> David Hagood <david.hagood@gmail.com> schrieb/wrote:
>> If you have 2 entities in a directory which have names differing onl=
y
>> in case, e.g. "foo" and "FOO", under a REAL operating system with ca=
se
>> sensitive file system semantics, this is no problem. However, under
>> Windows and their wonderful "Case preserving but case insensitive"
>> semantics, "FOO" and "foo" would be the same file,...
>=20
> Mac OS X has the same problem.

Only by default.  You can choose to use a case sensitive filesystem if =
you
wish.

> Further, it does not preserve the Unicode normalisation form.

Unfortunately you can't choose to turn this off. :(

--=20
Julian
