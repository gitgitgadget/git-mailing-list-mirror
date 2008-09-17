From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-svn checksum mismatch importing large file
Date: Wed, 17 Sep 2008 10:25:06 +0200
Message-ID: <20080917082506.GA8849@atjola.homenet>
References: <48D0B77E.7010308@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>, Eric Wong <normalperson@yhbt.net>,
	Avery Pennarun <apenwarr@gmail.com>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Wed Sep 17 10:26:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfsMh-0003Tc-Rq
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 10:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbYIQIZM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Sep 2008 04:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbYIQIZM
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 04:25:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:56507 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751144AbYIQIZL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 04:25:11 -0400
Received: (qmail invoked by alias); 17 Sep 2008 08:25:08 -0000
Received: from i577B97D3.versanet.de (EHLO atjola.local) [87.123.151.211]
  by mail.gmx.net (mp054) with SMTP; 17 Sep 2008 10:25:08 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18eXCI2E48epGknU1QNDY2Wx3EpBKWHxiW8QwGlU4
	A4O1j/TV/AAd63
Content-Disposition: inline
In-Reply-To: <48D0B77E.7010308@obry.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96074>

On 2008.09.17 09:53:34 +0200, Pascal Obry wrote:
> I get this error:
>=20
> Checksum mismatch: trunk/data
> expected: 7c59e4dd67b5a9fde6c61cada070537b
>     got: 3fcd9d077a5aa51a784a452c9d78d6e0
>=20
> To reproduce launch run.sh in attached archive.
>=20
> I have had this problem since some time now and I finally got some ti=
me
> to create a reproducer. I have reproduced this problem with yesterday
> master Git version.

Your /tmp is probably to small to hold the temporary file that git-svn
creates. At least it doesn't fail for me unless I fill my /tmp first.

This should be fixed since 29c70e0b3e3183f86f93500882177d0c74069988, at
least it got me a useful error message when I tested it back then.
Avery, any ideas?

Bj=F6rn
