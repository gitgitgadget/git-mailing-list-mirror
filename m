From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH] git-clone.txt: document that pushing from a shallow
	clone may work
Date: Wed, 4 Mar 2009 23:22:24 +0100
Message-ID: <20090304222224.GA20335@chistera.yi.org>
References: <237967ef0902160200r2320687ai71e62047c3ead9ad@mail.gmail.com> <1236080017-13987-1-git-send-email-dato@net.com.org.es> <49AD1B22.6050201@viscovery.net> <20090303120856.GB15003@chistera.yi.org> <76718490903031127v7fcec124je7292c4c465208b8@mail.gmail.com> <20090304101939.GA7142@chistera.yi.org> <7vvdqp5zx9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Mikael Magnusson <mikachu@gmail.com>,
	Joey Hess <joey@kitenet.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 23:24:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LezVN-0007Gt-Jg
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 23:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbZCDWW3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2009 17:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbZCDWW2
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 17:22:28 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:3998
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbZCDWW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 17:22:28 -0500
Received: from justin (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 9CB07801C02E;
	Wed,  4 Mar 2009 23:22:24 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LezTs-0005Mv-8c; Wed, 04 Mar 2009 23:22:24 +0100
Content-Disposition: inline
In-Reply-To: <7vvdqp5zx9.fsf@gitster.siamese.dyndns.org>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112243>

* Junio C Hamano [Wed, 04 Mar 2009 02:45:54 -0800]:

> Isn't the rule more or less like:

>     If your shallow repository's history does not extend long enough =
and
>     the other repository forked before your truncated history, wyou c=
annot
>     compute the common ancestor and you cannot push out.

Ah, this is helpful, thanks for it and for the rest of the message.
Would you take a patch to include this in the git-clone manpage, maybe
with an alternative wording? Eg.:

  Pushing from a shallow repository is not supported, but works when
  you're pushing to branches with a common ancestor in your available
  history (so pushing to the remote HEAD should always work).

I *think* the sentence in brackets is correct; I put it there because i=
n
my experience is a feature a lot of people around me want.(=C2=B9)

  (=C2=B9) I realize this may seem odd, people with push access wanting=
 to be
  able to push from a shallow repository. In case somebody is intereste=
d
  in the details, there's been discussion in the debian-python lists
  about a possible move to Git. There currently exists a Subversion
  repository with a lot of packages; many people with access just work
  on a few of them, but do the typical random fix on others from time t=
o
  time. And some of them were concerned about downloading all history
  for over a hundred of repositories. (Which was another of the
  conflicting points, how it's very easy to download all the packages i=
n
  Subversion.)

Cheers,

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
