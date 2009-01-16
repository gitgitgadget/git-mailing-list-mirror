From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: Confusing text in git-prune.txt
Date: Fri, 16 Jan 2009 18:02:17 +0100
Message-ID: <20090116170217.GA14855@chistera.yi.org>
References: <20090116165013.GA14196@chistera.yi.org> <4970BC25.7020007@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 18:05:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNs6k-0001DG-7q
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 18:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbZAPRCW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 12:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754479AbZAPRCV
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 12:02:21 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:2736
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbZAPRCU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 12:02:20 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id D04B8801C0E0;
	Fri, 16 Jan 2009 18:02:18 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LNs5J-0003uV-Uh; Fri, 16 Jan 2009 18:02:17 +0100
Content-Disposition: inline
In-Reply-To: <4970BC25.7020007@viscovery.net>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105978>

* Johannes Sixt [Fri, 16 Jan 2009 17:56:05 +0100]:

> Adeodato Sim=C3=B3 schrieb:
> > From git-prune.txt:

> >     [...] prunes all unpacked objects unreachable from any of
> >     these head objects from the object database. In addition,
> >     it prunes the unpacked objects that are also found in packs by
> >     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >     running git-prune-packed.

> > How can "unpacked objects" be "found in packs"?

> An object can exist more than once in the database. prune-packed remo=
ves
> the loose (unpacked) instance of the object if it also available in a=
 pack.

Ah, thanks, that explains everything.

I read the manpage for git-prune-unpacked, but I didn't manage to figur=
e
it out. It may have helped if instead of saying:

    git-prune-packed - Remove extra objects that are already in pack fi=
les

it would have said:

    git-prune-packed - Remove loose objects that are already in pack fi=
les
                              ^^^^^

By stating that those objects are "extra", we're losing the information
of where are they. And by reading that synopsis, one can already infer
they are "extra".

Cheers,

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
                                 Listening to: Radiohead - Bodysnatcher=
s
