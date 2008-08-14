From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How to show an annotated tag's timestamp?
Date: Fri, 15 Aug 2008 00:00:37 +0200
Message-ID: <20080814220037.GA3847@blimp.local>
References: <48A1E739.3010803@dirk.my1.cc>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?us-ascii?B?PT9JU08tODg1OS0xP1E/RGlya19TPUZDc3Nlcm90dF8=?= 
	<newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:02:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTktQ-0003qL-68
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755605AbYHNWA4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 18:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755880AbYHNWAz
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:00:55 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:10082 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755605AbYHNWAy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:00:54 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20xf40PVSQ==
Received: from tigra.home (Faed5.f.strato-dslnet.de [195.4.174.213])
	by post.webmailer.de (fruni mo47) (RZmta 16.47)
	with ESMTP id K00a2fk7ELc0DE ; Fri, 15 Aug 2008 00:00:51 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 4DB08277AE;
	Fri, 15 Aug 2008 00:00:51 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 10ED636D1A; Fri, 15 Aug 2008 00:00:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48A1E739.3010803@dirk.my1.cc>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92409>

Dirk S=FCsserott, Tue, Aug 12, 2008 21:40:41 +0200:
>
> Is there a way to output only when and by whom the tag
> was created (incl. the tag's messsage), i.e. the lines
> above marked with (*)?
>

    ~/linux$ git cat-file -p v2.6.27-rc3
    object 30a2f3c60a84092c8084dfe788b710f8d0768cd4
    type commit
    tag v2.6.27-rc3
    tagger Linus Torvalds <torvalds@linux-foundation.org> Tue Aug 12 18=
:55:58 2008 -0700

    Linux 2.6.27-rc3
    -----BEGIN PGP SIGNATURE-----
    Version: GnuPG v1.4.9 (GNU/Linux)

    iEYEABECAAYFAkiiPzMACgkQF3YsRnbiHLvxUACfU2zCcLV/CAWJpqvqIJSiQgRm
    9ewAnRbDZzqkDDkfJAgskpAwyTPfsFku
    =3DerLG
    -----END PGP SIGNATURE-----
