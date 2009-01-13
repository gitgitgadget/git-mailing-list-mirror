From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-svn fails to fetch repository
Date: Tue, 13 Jan 2009 21:39:22 +0100
Message-ID: <20090113203922.GD30404@atjola.homenet>
References: <loom.20090113T145019-951@post.gmane.org> <loom.20090113T150220-345@post.gmane.org> <496CD49D.1070201@drmicha.warpmail.net> <loom.20090113T185918-397@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Vladimir Pouzanov <farcaller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 21:44:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMq4T-0006S3-CJ
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 21:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088AbZAMUjl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jan 2009 15:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754781AbZAMUjl
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 15:39:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:44445 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751163AbZAMUjk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 15:39:40 -0500
Received: (qmail invoked by alias); 13 Jan 2009 20:39:36 -0000
Received: from i577B816A.versanet.de (EHLO atjola.local) [87.123.129.106]
  by mail.gmx.net (mp070) with SMTP; 13 Jan 2009 21:39:36 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18Q8hhmhzkQql3xEfItSqHj5mTh/PO7y/FkS1qTxL
	lx4Cai/YIva1Vh
Content-Disposition: inline
In-Reply-To: <loom.20090113T185918-397@post.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105532>

On 2009.01.13 19:01:28 +0000, Vladimir Pouzanov wrote:
> Michael J Gruber <git <at> drmicha.warpmail.net> writes:
> > This is with git 1.6.1rc4 (yeah I should have updated), perl 5.8.8 =
and
> > svn 1.4.6 on Linux. Same with git 1.6.0.6, perl 5.10.0 and svn 1.5.=
4 on
> > another box. The one git-svn change between 1.6.0.4 and 1.6.0.6 sho=
uld
> > not matter because you don't have branches. What's your svn version=
?
>=20
> svn, version 1.5.5 (r34862) on OSX (where perl fails with error) and
> svn, version 1.5.0 (Release Candidate=20
> 5) on Linux
> (where perl segfaults somewhere in apr).

Is that Linux box using Gentoo? If so, try emerging subversion with -ds=
o
in your build flags.

Cloning the svn repo you mentioned works fine with
git-svn version 1.6.1.40.g8ea6a (svn 1.5.1)

(On debian sid)

Bj=F6rn
