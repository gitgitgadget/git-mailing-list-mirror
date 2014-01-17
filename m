From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: [PATCH 0/6] Make 'git help everyday' work -> relnotes
Date: Fri, 17 Jan 2014 12:59:10 +0100
Message-ID: <52D91B0E.6080000@atlas-elektronik.com>
References: <1389309192-5748-1-git-send-email-philipoakley@iee.org> <xmqqppo090m7.fsf@gitster.dls.corp.google.com> <52CFACBB.7000805@atlas-elektronik.com> <F11CD558C63947F9B4AA75501D2F9F62@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Jan 17 12:58:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W484Q-0005Io-1T
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 12:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbaAQL6i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 06:58:38 -0500
Received: from mail96.atlas.de ([194.156.172.86]:24580 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbaAQL6h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 06:58:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id BBBDC10798;
	Fri, 17 Jan 2014 12:58:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3KqyL3qZKomZ; Fri, 17 Jan 2014 12:58:35 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Fri, 17 Jan 2014 12:58:35 +0100 (CET)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id BB3A527169;
	Fri, 17 Jan 2014 12:58:34 +0100 (CET)
Received: from [10.200.54.97] (10.200.54.97) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server (TLS) id 8.3.279.5; Fri, 17 Jan
 2014 12:58:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <F11CD558C63947F9B4AA75501D2F9F62@PhilipOakley>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240595>

Am 16.01.2014 22:14, schrieb Philip Oakley:
> From: "Stefan N=C3=A4we" <stefan.naewe@atlas-elektronik.com>
> [...]
>>
>> I'd really like to see 'git help relnotes' working as well...
>>
>> Stefan
>=20
> Stefan,
>=20
> Were you thinking that all the release notes would be quoted verbatim=
 in=20
> the one long man page?
>=20
> Or that it would be a set of links to each of the individual text fil=
es=20
> (see the ifdef::stalenotes[] in git/Documentation/git.txt)?
>=20
> The latter allows individual release notes to be checked, but still=20
> leaves folks with a difficult search problem if they want to find whe=
n=20
> some command was 'tweaked'.
>=20
> Obviously, any method would need to be easy to maintain. And the=20
> RelNotes symlink would need handling.

'git help relnotes' should show the current release note with
a link to the previous.

And 'git help git' should link to the current release note.


Stefan
--=20
----------------------------------------------------------------
/dev/random says: We now return you to your regularly scheduled flame-t=
hrowing
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6=
e696b2e636f6d'.decode('hex')"
