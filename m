From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: How to set git commit timestamp
Date: Sun, 6 May 2007 21:51:11 +0200
Organization: Dewire
Message-ID: <200705062151.40261.robin.rosenberg.lists@dewire.com>
References: <Pine.LNX.4.64.0705061759210.8165@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Sun May 06 21:52:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkmm0-00047d-6F
	for gcvg-git@gmane.org; Sun, 06 May 2007 21:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174AbXEFTvz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 15:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755179AbXEFTvz
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 15:51:55 -0400
Received: from [83.140.172.130] ([83.140.172.130]:29381 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755174AbXEFTvz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 15:51:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id F20418027F7;
	Sun,  6 May 2007 21:45:49 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10653-04; Sun,  6 May 2007 21:45:49 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id AC9F3802655;
	Sun,  6 May 2007 21:45:49 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0705061759210.8165@bianca.dialin.t-online.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46368>

s=F6ndag 06 maj 2007 skrev Guido Ostkamp:
> Hello,
>=20
> does somebody know a method to specify a timestamp for a 'git commit'=
?
>=20
> I am writing a tool to convert from another SCM to git and need to re=
play=20
> all checkins. I know how to set the log message and the author, but t=
here=20
> appears to be no command option for the timestamp (Mercurial for exam=
ple,=20
> has a 'hg commit -d date <file>' syntax for this).

If you are writing a converter then you should really use the plumbing=20
commands rather than porcelains like git-commit and in particular you s=
hould=20
look at git-fast-import for a  really fast methord of importing (and pa=
cking)=20
objects.

-- robin
