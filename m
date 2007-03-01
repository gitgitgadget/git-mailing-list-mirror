From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: Memory overrun in http-push.c
Date: Thu, 1 Mar 2007 08:13:24 +0300
Message-ID: <20070301051323.GG57456@codelabs.ru>
References: <20070228151516.GC57456@codelabs.ru> <200702281541.41164.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 06:13:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMdbt-0007Gt-4M
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 06:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbXCAFNe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 1 Mar 2007 00:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbXCAFNd
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 00:13:33 -0500
Received: from pobox.codelabs.ru ([144.206.177.45]:64549 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932645AbXCAFNd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 00:13:33 -0500
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HMdbc-000GOz-GA; Thu, 01 Mar 2007 08:13:28 +0300
Content-Disposition: inline
In-Reply-To: <200702281541.41164.andyparkins@gmail.com>
X-Spam-Status: No, score=-2.1 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_05
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41036>

Andy, good day!

Wed, Feb 28, 2007 at 03:41:38PM +0000, Andy Parkins wrote:
> On Wednesday 2007 February 28 15:15, Eygene Ryabinkin wrote:
> > --- http-push.c.orig=9A=9A=9A=9AWed Feb 28 15:15:01 2007
> > +++ http-push.c=9AWed Feb 28 15:15:21 2007
> > @@ -1295,7 +1295,7 @@
>=20
> A patch for git that wasn't made with git.
>=20
> Don't take this the wrong way Eygene, but why?

Because I am trying to set up Git repository to be used over HTTPS,
but it is failing now: seems like CURL library provokes the SIGSEGV.
The actual patch was made for the FreeBSD ports, so I've used plain
old 'diff -u'.

As Johannes pointed out, old habits are still alive. And when some
tool serves me the right way, I am happy with it. To make the patch
with Git I should create repository, hack there, merge it to the
=46reeBSD port, install and so on. A bit boring, do not take me wrong ;=
))
--=20
Eygene
