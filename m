From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: email address handling
Date: Fri, 1 Aug 2008 15:49:43 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808011543500.6819@nehalem.linux-foundation.org>
References: <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org> <20080801124550.26b9efc0.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org> <20080801131127.20b3acfd.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org> <20080801132415.0b0314e4.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org> <20080801135421.5ca0f6af.akpm@linux-foundation.org>
 <7vvdykqub6.fsf@gitster.siamese.dyndns.org> <20080801145804.85041bbd.akpm@linux-foundation.org> <20080801221539.GA8617@mit.edu> <20080801152720.56dbff09.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011531290.6819@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:51:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP3TH-0005HF-BT
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 00:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbYHAWuh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2008 18:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbYHAWuh
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 18:50:37 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58823 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751201AbYHAWug (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 18:50:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71MnivM013990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Aug 2008 15:49:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71MnhTk007942;
	Fri, 1 Aug 2008 15:49:43 -0700
In-Reply-To: <alpine.LFD.1.10.0808011531290.6819@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.411 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91118>



On Fri, 1 Aug 2008, Linus Torvalds wrote:
>=20
> 	S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>

Btw, poor guy is _really_ screwed. He'd show up as

	"=3D?utf-8?q?S=3D2E=3DC3=3D87a=3DC4=3D9Flar?=3D Onur" <caglar@pardus.o=
rg.tr>

which must really hurt.

Can you not see how STUPID it would be to say that the name should be=20
shown as an email encoding requires it?

Really. Just admit that you were wrong. The fact is, asking for rfc2822=
=20
encoding in logs etc is a HORRIBLY HORRIBLY stupid thing to do.

What you really want was just something you could cut-and-paste into yo=
ur=20
mailer. Which actually means that the only special character is probabl=
y=20
",", and your claims of how bad the design was that it didn't leave the=
=20
total mess that rfc2822 is was actually not true, and was based on simp=
ly=20
not knowing how nasty the real world is...

Quote frankly, If I had one of the Finnish special characters in my nam=
e,=20
I'd piss on your grave if you suggested that. Try to guess what somethi=
ng=20
like

	 =3D?ISO-8859-15?Q?Linus_T=3DF6rnqvist?=3D <torvalds@linux-foundation.=
org>

is supposed to be.

			Linus
