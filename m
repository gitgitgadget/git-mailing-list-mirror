From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Mon, 6 Apr 2009 21:25:14 +0200
Message-ID: <20090406192514.GI20356@atjola.homenet>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com> <200904052358.53028.markus.heidelberg@web.de> <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com> <200904060117.24810.markus.heidelberg@web.de> <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com> <20090406032457.GA14758@gmail.com> <7v63hie4yh.fsf@gitster.siamese.dyndns.org> <871vs5kjfw.fsf@krank.kagedal.org> <7vy6ud4otd.fsf@gitster.siamese.dyndns.org> <94a0d4530904061213pabd87aj9db577aaa231945c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	markus.heidelberg@web.de
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 21:27:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LquTW-0003AF-Eg
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 21:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576AbZDFTZU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 15:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753289AbZDFTZT
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 15:25:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:55813 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752226AbZDFTZS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 15:25:18 -0400
Received: (qmail invoked by alias); 06 Apr 2009 19:25:15 -0000
Received: from i59F5A3DA.versanet.de (EHLO atjola.local) [89.245.163.218]
  by mail.gmx.net (mp041) with SMTP; 06 Apr 2009 21:25:15 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+Kmj8m9pGKPo5YGmtGzTzHWBaTiXp1JNsrrXLKzI
	TpVZ/8X0UwjEwq
Content-Disposition: inline
In-Reply-To: <94a0d4530904061213pabd87aj9db577aaa231945c@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115872>

On 2009.04.06 22:13:26 +0300, Felipe Contreras wrote:
> On Mon, Apr 6, 2009 at 9:30 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> > David K=E5gedal <davidk@lysator.liu.se> writes:
> >
> >> What do you mean? This was a suggestion for how git diff should
> >> work. I fail to see how you would need a WORKTREEANDTHEINDEX there=
=2E
> >
> > You are talking only about "git diff". =A0I am talking about the wh=
ole git
> > suite, because you have to worry about how such a proposal would af=
fect
> > other parts of the UI.
>=20
> How do currently do you something like this:
> git diff HEAD^..STAGE

git diff --cached HEAD^

The "hard" (and pretty weird) one would be "git diff STAGE..HEAD^",
which is:

git diff -R --cached HEAD^

Bj=F6rn
