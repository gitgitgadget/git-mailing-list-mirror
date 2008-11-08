From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [question] git svn fail to fetch GCC source due to index
	mismatch
Date: Sat, 8 Nov 2008 21:34:08 +0100
Message-ID: <20081108203408.GF3563@atjola.homenet>
References: <4914A413.80301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: dennis <dennis.yxun@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 21:35:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyuWv-0000H4-N2
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 21:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbYKHUeO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2008 15:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbYKHUeO
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 15:34:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:47185 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751412AbYKHUeN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 15:34:13 -0500
Received: (qmail invoked by alias); 08 Nov 2008 20:34:11 -0000
Received: from i577B86C4.versanet.de (EHLO atjola.local) [87.123.134.196]
  by mail.gmx.net (mp047) with SMTP; 08 Nov 2008 21:34:11 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+2Q6E6voi275di0LjxoszScqmicjLFglfEj4xK/B
	94VilqL11+XQ2Z
Content-Disposition: inline
In-Reply-To: <4914A413.80301@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100422>

On 2008.11.08 04:24:51 +0800, dennis wrote:
> HI:
>    I have problem when use git svn fetch command to
> retrieve the GCC source code.
> It says index mismatch, then  abort,  any suggestion?
>=20
>  =20
> $git svn fetch
> Index mismatch: 98ba56dbceddf50ebfab9e4649e9b1b1a319b377 !=3D
> 4f40f4619690f89454614be0eba63d584d25523e
> rereading 19e22aa4cbc9f7e3667243481f33c859e3bba358
> Found possible branch point: svn://gcc.gnu.org/svn/gcc/trunk =3D>
> svn://gcc.gnu.org/svn/gcc/trunk, 130802
> Initializing parent: git-svn@130802
> Found branch parent: (git-svn) 9a08076e1ad241080838d547f64a2a9aceb083=
ca
> Index mismatch: 4f40f4619690f89454614be0eba63d584d25523e !=3D
> 98ba56dbceddf50ebfab9e4649e9b1b1a319b377
> rereading 9a08076e1ad241080838d547f64a2a9aceb083ca
> Following parent with do_switch
> Malformed network data: Malformed network data at
> /usr/libexec/git-core/git-svn line 2340
>=20
> $git branch -a
> git-svn
> git-svn@130802

ad0a82bae: git-svn: Always create a new RA when calling do_switch for s=
vn://

According to the commit message, that fixed a problem that caused the
"Malformed netword data" error. It's in git v1.6.0.3, so if you have an
older git version, try upgrading.

HTH
Bj=F6rn
