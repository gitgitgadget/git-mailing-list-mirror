From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Fri, 9 Jan 2009 16:59:07 +0100
Message-ID: <20090109155907.GA29039@chistera.yi.org>
References: <20090108195511.GA8734@chistera.yi.org> <7v7i552clz.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901091405460.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Clemens Buchacher <drizzd@aon.at>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 09 17:00:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLJmn-0003V1-95
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 17:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbZAIP7N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jan 2009 10:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbZAIP7L
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 10:59:11 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:1151
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbZAIP7K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 10:59:10 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 4252A801BF68;
	Fri,  9 Jan 2009 16:59:08 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LLJlL-0007bG-FK; Fri, 09 Jan 2009 16:59:07 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901091405460.30769@pacific.mpi-cbg.de>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105016>

* Johannes Schindelin [Fri, 09 Jan 2009 14:07:28 +0100]:

> > If we find the "common" context lines that have only blank and=20
> > punctuation letters in Dscho output, turn each of them into "-" and=
 "+",=20
> > and rearrange them so that all "-" are together followed by "+", it=
 will=20
> > match Bzr output.

> So we'd need something like this (I still think we should treat curly=
=20
> brackets the same as punctuation, and for good measure I just handled=
=20
> everything that is not alphanumerical the same):

Nice. With this patch of yours, --patience --collapse-non-alnums
produces the same output as bzr for this last test case (the util_sock.=
c
one). However, also for this last case, without --patience, diff
--collapse-non-alnums finds *no* common lines at all. Mentioning in cas=
e
you'd be interested in knowing.

Cheers,

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
- You look beaten.
- I just caught Tara laughing with another man.
- Are you sure they weren't just... kissing or something?
- No, they were laughing.
                -- Denny Crane and Alan Shore
