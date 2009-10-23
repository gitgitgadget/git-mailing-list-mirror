From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [cvsimport] Import CVS repository from a specified date or branch name
Date: Fri, 23 Oct 2009 22:10:08 +0200
Message-ID: <m2k4ylq3bz.fsf@igel.home>
References: <4AE160BC.5000608@vipco.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Klaus =?utf-8?Q?R=C3=B6del?= <klaus.roedel@vipco.de>
X-From: git-owner@vger.kernel.org Fri Oct 23 22:10:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1QSy-0005r7-Dy
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 22:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159AbZJWUKI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Oct 2009 16:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753122AbZJWUKI
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 16:10:08 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:37726 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111AbZJWUKG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 16:10:06 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id C5ACF1C1579F;
	Fri, 23 Oct 2009 22:10:10 +0200 (CEST)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id 3BF289021B;
	Fri, 23 Oct 2009 22:10:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id v+TXgt6ztRCj; Fri, 23 Oct 2009 22:10:09 +0200 (CEST)
Received: from igel.home (DSL01.83.171.152.41.ip-pool.NEFkom.net [83.171.152.41])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Fri, 23 Oct 2009 22:10:09 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id DA9D310C4CB; Fri, 23 Oct 2009 22:10:08 +0200 (CEST)
X-Yow: I'm EMOTIONAL now because I have MERCHANDISING CLOUT!!
In-Reply-To: <4AE160BC.5000608@vipco.de> ("Klaus =?utf-8?Q?R=C3=B6del=22's?=
 message of "Fri, 23
	Oct 2009 09:52:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131125>

Klaus R=C3=B6del <klaus.roedel@vipco.de> writes:

> I have a very large and old (serveral years) cvs repository and I wan=
t to
> import this in git.
> For my work it is not nessecary to import all the revision history fr=
om
> the cvs repository.
> It is engough to import only the revisions from a specified date or b=
ranch
> name of the cvs repo.
>
> Is this possible with git-cvsimport?
> If yes, how?

You may be able to do that by passing the right arguments to cvsps.
=46rom cvsps --help:

  -d <date1> -d <date2> if just one date specified, show
     revisions newer than date1.  If two dates specified,
     show revisions between two dates.
  -b <branch> restrict output to patch sets affecting history of branch

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
