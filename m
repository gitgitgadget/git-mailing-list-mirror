From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH] Add a commit.signoff configuration variable to always
	use --signoff.
Date: Sat, 27 Dec 2008 19:40:01 +0100
Message-ID: <20081227184001.GA31893@chistera.yi.org>
References: <1230296219-16408-1-git-send-email-dato@net.com.org.es> <20081227190819.7257932a@neuron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Sat Dec 27 19:41:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGe6f-0005fo-VE
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 19:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbYL0SkF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 13:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbYL0SkF
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 13:40:05 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:4386
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbYL0SkE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 13:40:04 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id DF552801BF66;
	Sat, 27 Dec 2008 19:40:02 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LGe4w-0008JE-10; Sat, 27 Dec 2008 19:40:02 +0100
Content-Disposition: inline
In-Reply-To: <20081227190819.7257932a@neuron>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104013>

* Jan Kr=C3=BCger [Sat, 27 Dec 2008 19:08:19 +0100]:

> I think it might be a good idea to allow overriding the config variab=
le
> in the other direction, i.e. a --no-signoff option to commit. Otherwi=
se,
> for example, rebase would have no way of suppressing the S-o-b lines =
in
> rebased commits (and you might want to not automatically sign off
> commits you rebase).

Good catch.

--no-signoff exists already, so maybe git-rebase should just use it?

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
Man is certainly stark mad; he cannot make a flea, yet he makes gods by=
 the
dozens.
                -- Michel de Montaigne
