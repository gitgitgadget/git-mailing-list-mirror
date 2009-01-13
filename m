From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Getting new branches from SVN?
Date: Wed, 14 Jan 2009 00:55:48 +0100
Message-ID: <20090113235548.GA12624@atjola.homenet>
References: <loom.20090113T234017-639@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andrew Selder <aselder@mac.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 00:57:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMt8V-0006Qx-Tf
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 00:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757839AbZAMXzy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jan 2009 18:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754980AbZAMXzw
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 18:55:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:42523 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757557AbZAMXzv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 18:55:51 -0500
Received: (qmail invoked by alias); 13 Jan 2009 23:55:50 -0000
Received: from i577B816A.versanet.de (EHLO atjola.local) [87.123.129.106]
  by mail.gmx.net (mp060) with SMTP; 14 Jan 2009 00:55:50 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/91MJOHUb9QAy9+Ncm2COD69Dlry0Vof0dSS20mc
	R81c3k8mjPmOJk
Content-Disposition: inline
In-Reply-To: <loom.20090113T234017-639@post.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105562>

On 2009.01.13 23:44:13 +0000, Andrew Selder wrote:
> Hi.
>=20
> We started using git-svn at my company and it's going pretty well so =
far.
>=20
> The only problem I have is that when new branches and tags are create=
d in SVN,
> how do I get those branches to show up in git as remote branches.
>=20
> I did the normal git svn clone -s -prefix svn/ .... and it found all =
the
> branches and tags up to that point.=20
>=20
> But since then, a couple new SVN branches and tags have been created,=
 and I need
> them to appear in my git repo.
>=20
> I'm sure I just missed something simple, but I couldn't find this.

"git svn fetch" should get them.

Bj=F6rn
