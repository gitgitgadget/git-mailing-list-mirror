From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git repository size vs. subversion repository size
Date: Sat, 5 Apr 2008 02:18:09 +0200
Message-ID: <20080405001809.GA3101@atjola.homenet>
References: <1086fb5f0804041502s7ab12202y3b0ec3640425eff@mail.gmail.com> <20080404221728.GA30728@atjola.homenet> <p06240810c41c6e0993c1@[63.138.152.125]> <20080405000141.GA23633@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Bannasch <stephen.bannasch@deanbrook.org>,
	git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 05 02:19:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jhw7h-0007wR-SF
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 02:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbYDEASN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Apr 2008 20:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbYDEASN
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 20:18:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:55823 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750832AbYDEASM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 20:18:12 -0400
Received: (qmail invoked by alias); 05 Apr 2008 00:18:10 -0000
Received: from i577BB809.versanet.de (EHLO atjola.local) [87.123.184.9]
  by mail.gmx.net (mp014) with SMTP; 05 Apr 2008 02:18:10 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+UAopziReUEjS06LDqOqA2bljCewDjVLGJsnwpLO
	9r2aAmCyRrl3x9
Content-Disposition: inline
In-Reply-To: <20080405000141.GA23633@dervierte>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78828>

[Stephan, please stop dropping me from Cc:, thanks]

On 2008.04.04 20:01:41 -0400, Steven Walter wrote:
> On Fri, Apr 04, 2008 at 07:49:24PM -0400, Stephen Bannasch wrote:
> > I'm just fooling around with git so far but I found a huge space sa=
vings=20
> > after running git gc. Here are the rough numbers:
> >
> > svn repo on server:        1GB
> > svn repo checked out:      2GB
> > git svn clone after gc:  384MB
> >
> > That's saving the full history in git -- about 13000 revisions.
>=20
> git-gc is such an important step in importing a repository from svn.
> Why doesn't git-svn take this vital step automatically?

Starting from 1.5.4 (IIRC) git-svn will repack every 1000 revisions (by
default). That won't give you a reeeeally tiny pack but OTOH it won't
take ages to do the repacks either.

Bj=F6rn
