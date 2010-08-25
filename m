From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Bug report: %h for abbreviated hashes broken after 1.7.1
Date: Wed, 25 Aug 2010 08:16:44 +0200
Message-ID: <20100825061643.GB2938@atjola.homenet>
References: <AANLkTinR6_DFD_MbFRbtyJKPhZG1Os0ro=4TcC2h_xZo@mail.gmail.com>
 <20100825041440.GH11619@burratino>
 <AANLkTi=+tGLfs-t6+fjRu68Mt76dJw4sbNCoO9q9+uyp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: "Todd A. Jacobs" <tjacobs@si2services.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 08:16:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo9I6-0006Vw-II
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 08:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039Ab0HYGQt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 02:16:49 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:42949 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751380Ab0HYGQs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 02:16:48 -0400
Received: (qmail invoked by alias); 25 Aug 2010 06:16:46 -0000
Received: from i59F5723D.versanet.de (EHLO atjola.homenet) [89.245.114.61]
  by mail.gmx.net (mp071) with SMTP; 25 Aug 2010 08:16:46 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/DnTBUBaDD8XBQuJW1LOlVokQgqMbHPHzjHVd4G5
	my7qdKUgxTEjfd
Content-Disposition: inline
In-Reply-To: <AANLkTi=+tGLfs-t6+fjRu68Mt76dJw4sbNCoO9q9+uyp@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154424>

[Added Jonathan back to Cc...]

On 2010.08.25 01:07:28 -0400, Todd A. Jacobs wrote:
> On Wed, Aug 25, 2010 at 12:14 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
> > $ git log --oneline v1.7.2.2..35039ced9296786bc0971bf5385c0d6f6ea5e=
a1e
> > 35039ce archive: abbreviate substituted commit ids again

That shows that the commit is not in the tag's ancestry.

> Tag v1.7.2.2 is almost a month after 35039ce, so I'm not sure where
> you're going with that, either. It should definitely be part of the
> 1.7.2.2 tarball, but the problem persists.

Maybe it should be, but it isn't. With non-linear histories, commit
dates don't tell you whether one commit is an ancestor of another
commit.

Bj=F6rn
