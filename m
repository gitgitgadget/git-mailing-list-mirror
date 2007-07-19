From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: CVS -> SVN -> Git
Date: Thu, 19 Jul 2007 21:15:23 +0200
Message-ID: <469FB84B.2010909@fs.ei.tum.de>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Jul 19 21:45:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBbvr-0004lQ-3V
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 21:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966050AbXGSTo7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Jul 2007 15:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbXGSTo6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 15:44:58 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:33741 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S939542AbXGSTo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 15:44:56 -0400
X-Greylist: delayed 1835 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jul 2007 15:44:56 EDT
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 2A383280A0;
	Thu, 19 Jul 2007 21:15:24 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jq9F-tIgPgU7; Thu, 19 Jul 2007 21:15:23 +0200 (CEST)
Received: from sweatshorts.home.corecode.ath.cx (85-218-11-169.dclient.lsne.ch [85.218.11.169])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id BA22F2809F;
	Thu, 19 Jul 2007 21:15:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (X11/20070627)
In-Reply-To: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53029>

Julian Phillips wrote:
> Has anyone managed to succssfully import a Subversion repository that=
=20
> was initially imported from CVS using cvs2svn using fast-import?
>=20
> It looks like cvs2svn has created a rather big mess.   It has created=
=20
> single commits that change files in more than one branch and/or tag. =
It=20
> also creates tags using more than one commit.  Now I come to try and=20
> import the Subversion history into git and I'm having trouble creatin=
g a=20
> sensible stream to feed into fast-import.

Did you try first converting the old CVS repo to git and then adding th=
e svn changes?  That might give you much better results.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +=
++      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \
