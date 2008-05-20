From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Git GUI vs interactive post-commit hooks
Date: Wed, 21 May 2008 01:02:04 +0200
Message-ID: <20080520230204.GA5383@atjola.homenet>
References: <c6c947f60805190348g3395f8degae81963b402856b6@mail.gmail.com> <20080519131942.GA5526@atjola.homenet> <20080520223158.GB13123@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Gladysh <agladysh@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 01:03:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyarQ-0002A7-S4
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 01:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765141AbYETXCL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 May 2008 19:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765041AbYETXCK
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 19:02:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:46543 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763939AbYETXCI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 19:02:08 -0400
Received: (qmail invoked by alias); 20 May 2008 23:02:06 -0000
Received: from i577B83C2.versanet.de (EHLO atjola.local) [87.123.131.194]
  by mail.gmx.net (mp034) with SMTP; 21 May 2008 01:02:06 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/45SZepXX4lfzac3wdtn9QcEBkmPvSEaOOVecANL
	vKmVLTu5ZlwaEj
Content-Disposition: inline
In-Reply-To: <20080520223158.GB13123@steel.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82516>

On 2008.05.21 00:31:58 +0200, Alex Riesen wrote:
> Bj?rn Steinbrink, Mon, May 19, 2008 15:19:42 +0200:
> > On 2008.05.19 14:48:14 +0400, Alexander Gladysh wrote:
> > >=20
> > > Any advice? I do want to input password for my key each time I us=
e it.
> >=20
> > For a graphical tool, you might want to use something like
> > gtk-led-askpass, which shows a window with a password prompt. SSH w=
ill
> > make use of it if SSH_ASKPASS contains its path _and_ ssh is not st=
arted
> > from a terminal. Unfortunately, the latter is probably not true for=
 git
> > gui most of the time.
>=20
> Redirect stdin from /dev/null

Does that actually work for you? It didn't work for me, because ssh the=
n
simply goes and opens /dev/tty to ask for the password.

$ ssh -V
OpenSSH_4.7p1 Debian-10, OpenSSL 0.9.8g 19 Oct 2007

Bj=F6rn
