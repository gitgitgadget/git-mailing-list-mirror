From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT] Supported Eclipse version
Date: Fri, 25 Jul 2008 21:35:41 +0200
Message-ID: <200807252135.41434.robin.rosenberg.lists@dewire.com>
References: <48888A2E.4030302@gmail.com> <4889DF49.3000903@gmail.com> <20080725161652.GA21117@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marek Zawirski <marek.zawirski@gmail.com>,
	Jean-Frannnois Veillette <jean_francois_veillette@yahoo.ca>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:37:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMT6Q-0001lO-VZ
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 21:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbYGYTgX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 15:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbYGYTgW
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 15:36:22 -0400
Received: from av9-1-sn2.hy.skanova.net ([81.228.8.179]:59611 "EHLO
	av9-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbYGYTgW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jul 2008 15:36:22 -0400
Received: by av9-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id D2A0A38276; Fri, 25 Jul 2008 21:36:19 +0200 (CEST)
Received: from smtp4-2-sn2.hy.skanova.net (smtp4-2-sn2.hy.skanova.net [81.228.8.93])
	by av9-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id 8892738062; Fri, 25 Jul 2008 21:36:19 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-2-sn2.hy.skanova.net (Postfix) with ESMTP id 6700E37E42;
	Fri, 25 Jul 2008 21:36:19 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080725161652.GA21117@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90094>

fredagen den 25 juli 2008 18.16.52 skrev Shawn O. Pearce:
> Marek Zawirski <marek.zawirski@gmail.com> wrote:
> > Jean-Fran=C3=A7ois Veillette wrote:
> >>> Maybe some users (or developers) from mailing list can tell us ab=
out =20
> >>> their opinion?
> >>
> >> I think keeping comptability for one version behind the 'current' =
=20
> >> (still compatible 3.3 while 3.4 is the current) is a reasonable go=
al.
> >> 3.2 is relatively far behind, tools vendor had time to get up to d=
ate =20
> >> by now.
> >
> > Robin, Shawn, would you accept next patches using 3.3 API?
>=20
> Yes, we should be dropping support for 3.2 now and supporting only
> 3.3 and 3.4 going forward.  3.2 is ancient and anyone who is serious
> aboug using Git with Eclipse really should be on a more current
> version of the tools.

We already dropped 3.2 compatibility with the push/fetch support. That
was an accident, of course.=20

Support for 3.3 could also end ahead of schedule if we absolutely need
some feature that is only available in 3.4. We'll discuss that then, wh=
en/if
it happens. The plan is to support 3.3 until 3.5 is out (or even longer=
 if
that requires no effort).

So much for intent. We reserve the right to change our minds or make mi=
stakes
without notice.

-- robin
