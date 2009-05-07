From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re:
Date: Thu, 7 May 2009 21:56:09 +0200
Message-ID: <20090507195609.GA17395@atjola.homenet>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <81b0412b0905071118q46eb98b0k20f148e6a179a81f@mail.gmail.com> <D47BEC5B0D55467894A05B6219127126@caottdt504>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 'Alex Riesen' <raa.lkml@gmail.com>, git@vger.kernel.org
To: Bevan Watkiss <bevan.watkiss@cloakware.com>
X-From: git-owner@vger.kernel.org Thu May 07 21:56:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M29i6-00080J-Rk
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 21:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbZEGT4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2009 15:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752217AbZEGT4M
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 15:56:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:41052 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751154AbZEGT4L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 15:56:11 -0400
Received: (qmail invoked by alias); 07 May 2009 19:56:10 -0000
Received: from i59F5A028.versanet.de (EHLO atjola.local) [89.245.160.40]
  by mail.gmx.net (mp042) with SMTP; 07 May 2009 21:56:10 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19w/n4oAUZwEjquQhuAqX5zuyTAvTaXcliiolRfMf
	Uh2fwQbfMTl5Lv
Content-Disposition: inline
In-Reply-To: <D47BEC5B0D55467894A05B6219127126@caottdt504>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118518>

[Please don't top-post...]

On 2009.05.07 14:48:20 -0400, Bevan Watkiss wrote:
> From: Alex Riesen [mailto:raa.lkml@gmail.com]=20
> > 2009/5/7 Bevan Watkiss <bevan.watkiss@cloakware.com>:
> > > It's the looking for local changes I'm trying to avoid. =A0Doing =
a
> > > reset still goes over the tree, which isn't helpful.
> >=20
> > The stat(2) is slow? Then try setting core.ignoreStat (see manpage
> > of git config) to true: git config core.ignorestat true and read
> > below.
>
> Still took 11 minutes.

IIRC, to see the effects of core.ignorestat, you need to have updated
all files once. So you might need, for example, "git checkout -f HEAD"
(not sure if a plain checkout is enough) once first, and then the futur=
e
"git checkout $something" should be faster.

Bj=F6rn
