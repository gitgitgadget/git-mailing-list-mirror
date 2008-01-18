From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Fri, 18 Jan 2008 02:27:18 +0100
Message-ID: <200801180227.19242.robin.rosenberg.lists@dewire.com>
References: <478E1FED.5010801@web.de> <87odbkyuvq.fsf@adler.orangeandbronze.com> <alpine.LSU.1.00.0801172209080.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: JM Ibanez <jm@orangeandbronze.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Wincent Colaiuta <win@wincent.com>,
	Kevin Ballard <kevin@sb.org>,
	Jakub Narebski <jnareb@gmail.com>, Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 18 02:28:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFg1W-0000qm-7Y
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 02:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758472AbYARB1R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2008 20:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758100AbYARB1R
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 20:27:17 -0500
Received: from [83.140.172.130] ([83.140.172.130]:6945 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758076AbYARB1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 20:27:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 42A398030D9;
	Fri, 18 Jan 2008 02:27:15 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3F8e2wTPUtyl; Fri, 18 Jan 2008 02:27:14 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id AFF0C80264C;
	Fri, 18 Jan 2008 02:27:14 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <alpine.LSU.1.00.0801172209080.5731@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70946>

torsdagen den 17 januari 2008 skrev Johannes Schindelin:
> Hi,
>=20
> On Fri, 18 Jan 2008, JM Ibanez wrote:
>=20
> > If you check the standard, two Unicode codepoints (i.e. the numeric=
=20
> > value that gets stored on disk) *can* map to the same character, he=
nce=20
> > they are the same.
>=20
> As Linus _already_ pointed out, you are confusing characters with gly=
phs.
>=20
Someone is.=20

He is refering to the unicode definition of an (abstract) character.

Ch3.4 D11 - "A single abstract character may also be represented by a s=
equence
of code points=E2=80=94for example, latin capital letter g with acute m=
ay be represented
by the sequence <U+0047 latin capital letter g, U+0301 combining acute =
accent>,=20
rather than being mapped to a single code point.


-- robin
