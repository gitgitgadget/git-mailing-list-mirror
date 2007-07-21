From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sat, 21 Jul 2007 19:52:01 +0200
Message-ID: <46A247C1.4000902@fs.ei.tum.de>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site> <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr>    =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.0707181004330.=04?=
	=?ISO-8859-1?Q?=0427353@woody.lin?= =?ISO-8859-1?Q?ux-foundation.or?=
	=?ISO-8859-1?Q?g>?= <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <851wf2bcqy.fsf@lola.goethe.zz>    =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.07072=0402135450.?=
	=?ISO-8859-1?Q?27249@woody.linu?= =?ISO-8859-1?Q?x-foundation.org?=
	=?ISO-8859-1?Q?>?= <alpine.LFD.0.999.0707202154220.27249@woody.linux-foundation.org> <85odi69vgt.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707210832180.27249@woody.linux-foundation.org> <85tzrxslms.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 19:52:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICJ7m-00013M-7d
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 19:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbXGURwH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Jul 2007 13:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752563AbXGURwG
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 13:52:06 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:45253 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374AbXGURwF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 13:52:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 57B50280DC;
	Sat, 21 Jul 2007 19:52:02 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id EddQiZ2jR4ca; Sat, 21 Jul 2007 19:52:02 +0200 (CEST)
Received: from sweatshorts.home.corecode.ath.cx (85-218-11-227.dclient.lsne.ch [85.218.11.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id E7731280C7;
	Sat, 21 Jul 2007 19:52:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (X11/20070627)
In-Reply-To: <85tzrxslms.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53177>

David Kastrup wrote:
> But I also want to have directories represented within git, because
> not doing so leads to awkward problems.  And the proper way as I see
> it is _not_ to mess with trees and stick them with "stay when empty"
> flags or similar.  This messes up the whole elegance of git's flat
> name space.  The proper way is to create a distinct object that
> represents a physical directory.  We don't need to represent the
> contents of it: those are already tracked in the flat namespace fine,
> with trees serving as an implementation detail.
>=20
> All we need to represent is ".".

What I still don't get is:  How do you carry this information about "th=
is directory should not be removed" from one checkout to the next commi=
t?  When creating a .gitignore, this file exists in the workdir.  Of co=
urse you add some data to the index to stage it.  But how does this wor=
k with your "." "file"?  You can't put that in the filesystem.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +=
++      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \
