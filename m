From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: CVS -> SVN -> Git
Date: Thu, 19 Jul 2007 21:18:12 +0200
Message-ID: <469FB8F4.5090902@fs.ei.tum.de>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>	 <469804B4.1040509@alum.mit.edu> <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 21:50:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBc0i-0006Z3-Tn
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 21:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938176AbXGSTuA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Jul 2007 15:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938778AbXGSTpB
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 15:45:01 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:33746 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S939659AbXGSTo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 15:44:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 29F49280A2;
	Thu, 19 Jul 2007 21:18:13 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mm2OJGo8C3yG; Thu, 19 Jul 2007 21:18:12 +0200 (CEST)
Received: from sweatshorts.home.corecode.ath.cx (85-218-11-169.dclient.lsne.ch [85.218.11.169])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id AB316280A1;
	Thu, 19 Jul 2007 21:18:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (X11/20070627)
In-Reply-To: <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53030>

Martin Langhoff wrote:
> On 7/14/07, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Incidentally, now that cvs2svn 2.0.0 is nearly out, I am thinking ab=
out
>> what it would take to write some other back ends for cvs2svn--turnin=
g
>> it, essentially, into cvs2xxx.  Most of the work that cvs2svn does i=
s
>> inferring the most plausible history of the repository from CVS's
>> sketchy, incomplete, idiomatic, and often corrupt data.  This work
>> should also be useful for a cvs2git or cvs2hg or cvs2baz or ...
>=20
> Great to hear that. I'm game if we can do something in this direction
> - surely we can make it talk to fastimport ;-)

In this context I suggest looking at fromcvs [1], my cvs->otherscm conv=
erter.  Right now it does git + hg (and sqlite for queries), but it pro=
bably is easily extensible for other targets.

> Does cvs2svn handle incremental imports, remembering any "guesses"
> taken earlier? Last time I looked at it, it had far better logic than
> cvsps, but it didn't do incremental imports, and repeated imports don=
e
> at different times would "guess" different branching points for new
> branches, so it _really_ didn't support incrementals

fromcvs will also handle incremental imports.  If not, please tell me a=
nd I will try to fix it.

cheers
  simon

[1] http://ww2.fs.ei.tum.de/~corecode/hg/fromcvs/

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +=
++      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \
