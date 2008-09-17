From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-svn checksum mismatch importing large file
Date: Wed, 17 Sep 2008 12:07:59 +0200
Message-ID: <20080917100759.GA11718@atjola.homenet>
References: <48D0B77E.7010308@obry.net> <20080917082506.GA8849@atjola.homenet> <48D0D03B.4040108@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>, Eric Wong <normalperson@yhbt.net>,
	Avery Pennarun <apenwarr@gmail.com>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Wed Sep 17 12:09:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KftyG-0005TB-2n
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 12:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbYIQKIH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Sep 2008 06:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbYIQKIG
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 06:08:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:41935 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751463AbYIQKIF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 06:08:05 -0400
Received: (qmail invoked by alias); 17 Sep 2008 10:08:01 -0000
Received: from i577B97D3.versanet.de (EHLO atjola.local) [87.123.151.211]
  by mail.gmx.net (mp047) with SMTP; 17 Sep 2008 12:08:01 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18N8E1jlOcN/DrIAzSeJa7vEcilfjC/FD5RGfWLkT
	1bq4I4OsfdsUJv
Content-Disposition: inline
In-Reply-To: <48D0D03B.4040108@obry.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96081>

On 2008.09.17 11:39:07 +0200, Pascal Obry wrote:
> > Your /tmp is probably to small to hold the temporary file that git-=
svn
> > creates. At least it doesn't fail for me unless I fill my /tmp firs=
t.
>=20
> Hum probably, I did not thought about this given the error message!

Yeah, I only came up with the idea because of the previous breakage,
otherwise I'd not have guessed that either :-)

> > This should be fixed since 29c70e0b3e3183f86f93500882177d0c74069988=
, at
> > least it got me a useful error message when I tested it back then.
> > Avery, any ideas?
>=20
> I'm using Git on master. This commit is there, the error message is n=
ot
> that useful on my side :)

Yeah, I tested with yesterday's master as well, thus I was asking Avery
if he has any clue of what's going on. Should probably have mentioned
that...

> Anyway, what's the best option? Is there a way to specify another tmp
> directory to use with git-svn?

Looks like the code honors the TMPDIR environment variable, but I didn'=
t
actually try that.

Bj=F6rn
