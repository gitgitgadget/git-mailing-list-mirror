From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Creating a patch set with git-format-patch
Date: Thu, 10 Apr 2008 12:56:10 +0200
Message-ID: <20080410105610.GB29742@atjola.homenet>
References: <d0383f90804100151s6ffde16al6035116c27c9cb3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ian Brown <ianbrn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 12:57:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjuSg-0002Zs-6Q
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 12:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662AbYDJK4O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Apr 2008 06:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754625AbYDJK4O
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 06:56:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:46068 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751605AbYDJK4N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 06:56:13 -0400
Received: (qmail invoked by alias); 10 Apr 2008 10:56:11 -0000
Received: from i577B94B7.versanet.de (EHLO atjola.local) [87.123.148.183]
  by mail.gmx.net (mp032) with SMTP; 10 Apr 2008 12:56:11 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18e7lB/5ooe2r4nurAXeW5oJwYbumskXTpa3OiItP
	l4TaPkdBrjKg6M
Content-Disposition: inline
In-Reply-To: <d0383f90804100151s6ffde16al6035116c27c9cb3a@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79205>

On 2008.04.10 11:51:59 +0300, Ian Brown wrote:
> Hello,
>   I have a question regarding creating a patch set with git-format-pa=
tch:
> I had downloaded a git repository of the Linux kernel.
>=20
> I intend to  make a change in two files: net/ipv4/route.c and
> include/net/dst.h and send a
> patch set of two patches for review.
> Now I want to create this  patch set of two pathces correctly;
> First patch for net/ipv4/route.c and second for include/net/dst.h.
>=20
> what should I do ?

Just create a branch for you work, then start working and creating
commits. In the end, you'll get one patch for each commit, so group you=
r
work in the commits just as you want it to appear in the patches.

Then, create the patches with:
git format-patch <options> master

That will create patches for all commits that are in your branch, but
not in master. Finally, you can use either git send-email or your
favourite mbox-capable MUA to send the patches.

HTH
Bj=F6rn
