From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Add a 1-second sleep to git-cvsexportcommit test
Date: Tue, 24 Jul 2007 10:38:31 +0200
Message-ID: <46A5BA87.50105@fs.ei.tum.de>
References: <7vk5ssqdy0.fsf@assigned-by-dhcp.cox.net> <200707240223.54228.robin.rosenberg.lists@dewire.com> <46A5B43E.3030700@fs.ei.tum.de> <200707241033.36509.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jason Sewall <jasonsewall@gmail.com>, git@vger.kernel.org,
	raa.lkml@gmail.com
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 10:38:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDFug-0004R0-Ks
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 10:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756476AbXGXIif convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Jul 2007 04:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754301AbXGXIif
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 04:38:35 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:40711 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756717AbXGXIie (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 04:38:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id E41982814E;
	Tue, 24 Jul 2007 10:38:32 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id nwj9BW2uokB4; Tue, 24 Jul 2007 10:38:32 +0200 (CEST)
Received: from sweatshorts.home.corecode.ath.cx (85-218-11-202.dclient.lsne.ch [85.218.11.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 6DB7528149;
	Tue, 24 Jul 2007 10:38:32 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (X11/20070627)
In-Reply-To: <200707241033.36509.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53535>

Robin Rosenberg wrote:
>>> Since the sleep is per invocation of cvsexportcommit it won't hurt
>>> too much since it is rarely invoked on a huge number of git commits=
=2E
>> The question also is, why does this happen on two sequential invocat=
ions of cvsexportcommit, but not on two cvs commits done by cvsexportco=
mmit?  This should look the same to cvs, no?
>=20
> I reread my post here... My last sentence was a comment to the patch
> and not the sleep in CVS.

Yes, I realize this.  Still, I wonder the same:  why is this needed *pe=
r invocation of cvsexportcommit* and not *per invocation of cvs*?  Seem=
s unintuitive to me, or I didn't read the patch good enough.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +=
++      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \
