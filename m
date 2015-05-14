From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] mergetools: add winmerge as a builtin tool
Date: Thu, 14 May 2015 23:24:13 +0200
Message-ID: <1431638653-9356-1-git-send-email-szeder@ira.uka.de>
References: <CAHGBnuPDSdCyVNM+Gagang1Cf9yw0Tyios45i6pnZSSzaJJC2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	David Aguilar <davvid@gmail.com>,
	Phil Susi <phillsusi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 23:24:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt0cC-00039I-Ht
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 23:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103AbbENVYT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2015 17:24:19 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35916 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964934AbbENVYT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2015 17:24:19 -0400
Received: from x590c510f.dyn.telefonica.de ([89.12.81.15] helo=localhost)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1Yt0c3-0005kK-2G; Thu, 14 May 2015 23:24:16 +0200
X-Mailer: git-send-email 1.9.5.msysgit.0
In-Reply-To: <CAHGBnuPDSdCyVNM+Gagang1Cf9yw0Tyios45i6pnZSSzaJJC2Q@mail.gmail.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1431638656.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269101>


> On Wed, May 13, 2015 at 5:22 PM, Johannes Schindelin <johannes.schind=
elin <at> gmx.de> wrote:
>=20
> > In my tests, "$PROGRAMFILES(X86)" did *not* work:
> >
> >     $ echo "$PROGRAMFILES(X86)"
> >     bash: syntax error near unexpected token `('
>=20
> Interesting. In both MSYS1/2 Git Bashes I get on Windows 7 64-bit:
>=20
> $ echo "$PROGRAMFILES(X86)"
> C:\Program Files (x86)(X86)
>=20
> So it seems to resolve only the $PROGRAMFILES part and appending the
> literal "(X86)". Not sure how to tell Bash that "(X86)" is part of th=
e
> variable name.

It would be ${PROGRAMFILES(X86)}, but POSIX says that variable names ca=
n
only contain alphanumeric characters and underscores, and Bash adheres
when it complains about it in Johannes' example above.  Not sure whethe=
r
there is a clever escaping that could make it work, I couldn't find any=
=2E


G=E1bor
