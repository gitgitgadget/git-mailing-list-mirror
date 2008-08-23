From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: nicer frontend to get rebased tree?
Date: Sat, 23 Aug 2008 11:56:27 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808231152250.3363@nehalem.linux-foundation.org>
References: <20080822174655.GP23334@one.firstfloor.org> <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org> <20080822182718.GQ23334@one.firstfloor.org> <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org> <20080823071014.GT23334@one.firstfloor.org>
 <alpine.LFD.1.10.0808230853170.3363@nehalem.linux-foundation.org> <20080823164546.GX23334@one.firstfloor.org> <20080823181827.GA15993@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 23 20:58:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWyJF-0007KV-W3
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 20:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbYHWS4h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Aug 2008 14:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbYHWS4h
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 14:56:37 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60272 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751562AbYHWS4g (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Aug 2008 14:56:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7NIuSiq013508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 23 Aug 2008 11:56:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7NIuRmD028570;
	Sat, 23 Aug 2008 11:56:27 -0700
In-Reply-To: <20080823181827.GA15993@atjola.homenet>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.429 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93471>



On Sat, 23 Aug 2008, Bj=F6rn Steinbrink wrote:
>=20
> So, how would you make it less obscure and unobvious then the current
> method? The current method would be:
>=20
> git fetch linux-next
> git checkout linux-next/whatever
>=20
> Which seems neither obscure nor unobvious to me...

One thing that I admit we haven't done is _document_ this in some obvio=
us=20
place.

When you know git, it's really fairly obvious and straightforward. But =
for=20
somebody who doesn't, then _all_ the documentation is really about=20
well-maintained trees that don't rebase. We very much discourage rebasi=
ng,=20
and none of the docs even really talk about how to handle it.

The linux-next tree in general is I think not as useful as people think=
 it=20
could be. _I_ think it's been sold as something much bigger and more=20
useful than "it's a tree where you see conflicts early, but you can't=20
actually really _use_ it for anything".

So part of it is not even necessarily about _git_ documentation, but ab=
out=20
the documentation for some of the trees that use git, but that aren't=20
really meant for others to then use.=20

		Linus
