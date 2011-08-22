From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: git svn --stdlayout 's little quirk.
Date: Mon, 22 Aug 2011 16:11:38 +0100 (BST)
Message-ID: <1314025898.45043.YahooMailClassic@web29503.mail.ird.yahoo.com>
References: <4E521AD3.4040204@drmicha.warpmail.net>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, madduck@madduck.net,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Aug 22 17:11:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvWAE-0002rV-In
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 17:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123Ab1HVPLm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Aug 2011 11:11:42 -0400
Received: from nm10-vm0.bullet.mail.ird.yahoo.com ([77.238.189.90]:33320 "HELO
	nm10-vm0.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751480Ab1HVPLk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 11:11:40 -0400
Received: from [77.238.189.231] by nm10.bullet.mail.ird.yahoo.com with NNFMP; 22 Aug 2011 15:11:39 -0000
Received: from [212.82.108.249] by tm12.bullet.mail.ird.yahoo.com with NNFMP; 22 Aug 2011 15:11:39 -0000
Received: from [127.0.0.1] by omp1014.mail.ird.yahoo.com with NNFMP; 22 Aug 2011 15:11:39 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 134272.83589.bm@omp1014.mail.ird.yahoo.com
Received: (qmail 47296 invoked by uid 60001); 22 Aug 2011 15:11:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1314025899; bh=yOkmfIl+No2uQEIwXDYUpkKw5he6N5Vx7az4N7rvN+Q=; h=X-YMail-OSG:Received:X-RocketYMMF:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=E5Yu6xjtnFm9admF0BPdIxYkAqOHPaIhbK7sUtDXWmSI/Nb5RPhn6xhBYwXLrusTFNq88Oh6j/3jAkOr9kS1PlbUYbsdiTzPiTy9sHu8HCBUUdaeSTv5KxfWAgkWbGPEGeGq0kxaPOJahiF/+Wr5HHzNK8RGQGNm0GWvFlp38gU=
X-YMail-OSG: XCv9wUwVM1mXYGafWkwmbEOozSj9K2NEI2J7eLP3WkFwTWB
 pgPZns6CMB2GYWs9441yD2PJnKbilpucTfI3p_tzm7g5q7wb19qbmMPkPFC.
 gOkaZ40.W1LRe2SJTGZCx0Ap3NkGY2vBMeSinvy3o5ZsE2Ttbgf640ZKnSnQ
 RynnMml_fflAqc_7LoekY0Y4ojyFymO5YIBt5f_RinUNL6mPjzlX_KI92_HW
 orcVlkc8veT6NI5XkSWJT7I4ZFJtAQV0d0hGthH9VGbGageGZL4zYQUzDVzJ
 lz3vDckaRt8Ppj6tjBSsal7Fgmi1Vobsk_9TU5_ZdDkcixQHlXK31RyUWE.2
 GbTihbdOlUbDuTrM0BRphkgCOvSQfsm0rGnqDJKq4wL18cBRlC0rHGBjEg4W
 ntqJbRUnS23M_bV7ehOTpqejBsON5EB88XYujXhkNhNGIqLvh_6rFBaB4djW
 Dzz6RMQiGz.S4FAOFkPJglYL9DjAXjlQFOjuSEmswRiVzqMD8qIF3zy5.
Received: from [81.101.129.153] by web29503.mail.ird.yahoo.com via HTTP; Mon, 22 Aug 2011 16:11:38 BST
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/14.0.4 YahooMailWebService/0.8.113.315625
In-Reply-To: <4E521AD3.4040204@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179865>

--- On Mon, 22/8/11, Michael J Gruber <git@drmicha.warpmail.net> wrote:

> Hin-Tak Leung venit, vidit, dixit
> 21.08.2011 11:38:
> > --- On Sat, 20/8/11, Eric Wong <normalperson@yhbt.net>
> wrote:
> >=20
> >>> I think I found a small bug in git 1.7.6.
> Having
> >> "trunk" at the end of
> >>> the url in combination of --stdlayout is
> wrong, but it
> >> looks like that
> >>> git-svn tries to cope, but doesn't go try far
> enough:
> >>>
> >>> Doing this:
> >>> ----------------
> >>> git svn clone --stdlayout http://quick-settings.googlecode.com/sv=
n/trunk/
> >> android-quick-settings
> >>
> >> --stdlayout expects the "root" path of the code
> you're
> >> interested
> >> in (not necessarily the SVN repository root, but
> in this
> >> case they
> >> could be the same).
> >>
> >> Try the following instead:
> >>
> >> git svn clone --stdlayout \
> >>=A0=A0=A0http://quick-settings.googlecode.com/svn
> >> android-quick-settings
> >=20
> > I know this is the correct way - what I meant was
> that, having "trunk" at the end is wrong but git-svn appears
> to try to correct it automatically, but haven't quite
> succceeded.
>=20
> It is not trying to do that at all. git-svn is trying to
> figure out what
> the "base path" is in an svn repo which possibly hosts
> multiple repos,
> and that is what the message reports.

Okay... thanks for clarifying that. Maybe it could try to be clever? Af=
terall, --stdlayout isn't compatible with a URL ending in "trunk" (or h=
aving 'trunk' as part of the URL). Just a suggestion.

Hin-Tak
