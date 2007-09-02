From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: Buffer overflows
Date: Sun, 02 Sep 2007 19:39:28 +0200
Message-ID: <46DAF550.70300@etek.chalmers.se>
References: <1188502009.29782.874.camel@hurina> <3f4fd2640708301435s7067137cp5db6334af844158a@mail.gmail.com> <7vtzqg7jrn.fsf@gitster.siamese.dyndns.org> <200709021542.31100.johan@herland.net> <46DAF039.2000208@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Reece Dunn <msclrhd@googlemail.com>,
	Timo Sirainen <tss@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Sep 02 19:40:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRtQW-0001Sv-Pu
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 19:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627AbXIBRjc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Sep 2007 13:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752419AbXIBRjc
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 13:39:32 -0400
Received: from anubis.medic.chalmers.se ([129.16.30.218]:39568 "EHLO
	anubis.medic.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbXIBRjb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 13:39:31 -0400
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by anubis.medic.chalmers.se (Postfix) with ESMTP id 5B1DADA80;
	Sun,  2 Sep 2007 19:39:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.6) Gecko/20070804 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <46DAF039.2000208@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57371>

Ren=E9 Scharfe wrote:
> And don't forget that we have our very own string library, viz.
> strbuf.c, which could see more use.
>=20
> That said, I agree that bstring looks well thought out.  It's also qu=
ite
> large (lots of functions, lots of code where a bug might lurk).  Hmm.
>=20
> Now if only someone could demonstrate the advantages of using bstring=
 in
> git by posting a nice patch.. :-P
>=20
> Ren=E9

I'm currently working on rewriting builtin-mailinfo.c to use bstring.=20
I'll hopefully have a proof-of-concept ready today or tomorrow.

/Lukas
