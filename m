From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: Re: Makefile: Another "make" command is used when going into
 SUBDIR perl
Date: Tue, 8 Apr 2014 23:34:49 +0000
Message-ID: <20140408233449.GA21148@rhi.hi.is>
References: <20140405231039.GA26578@rhi.hi.is>
 <534165AD.3040606@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 09 01:47:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXfk1-0004Oa-TB
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 01:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756353AbaDHXrl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Apr 2014 19:47:41 -0400
Received: from fenja.rhi.hi.is ([130.208.165.103]:36353 "EHLO fenja.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756224AbaDHXrk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 19:47:40 -0400
Received: from smtp.hi.is (smtp.hi.is [130.208.165.149])
	by fenja.rhi.hi.is (8.13.8/8.13.8) with ESMTP id s38Nlc6G012649
	for <git@vger.kernel.org>; Tue, 8 Apr 2014 23:47:38 GMT
Received: from katla.rhi.hi.is (katla.rhi.hi.is [130.208.165.1])
	by smtp.hi.is (8.14.4/8.14.4) with ESMTP id s38NlbVl002565
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 8 Apr 2014 23:47:38 GMT
Received: from katla.rhi.hi.is (localhost [127.0.0.1])
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4) with ESMTP id s38NYo0J021235;
	Tue, 8 Apr 2014 23:34:50 GMT
Received: (from bjarniig@localhost)
	by katla.rhi.hi.is (8.14.4+Sun/8.14.4/Submit) id s38NYnuv021234;
	Tue, 8 Apr 2014 23:34:49 GMT
Content-Disposition: inline
In-Reply-To: <534165AD.3040606@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245970>

On Sun, Apr 06, 2014 at 04:33:17PM +0200, Ren=E9 Scharfe wrote:
> Am 06.04.2014 01:10, schrieb Bjarni Ingi Gislason:
> >Package: git-1.9.0
> >
> >   Another make command is used in the Makefile when it enters subdi=
r
> >PERL.
> >
> >   The used "make" command is a link in my home directory to
> >"/usr/sfw/bin/gmake".  Other make commands are "/usr/ccs/bin/make" a=
nd
> >"/usr/xpg4/bin/make".
> >
> >My PATH variable has these directories in this order
> >
> >$HOME, /usr/sfw/bin, /usr/xpg4/bin and /usr/ccs/bin
> >
> >   The used variables for make are
> >
> >CPPFLAGS=3D-I/usr/local/ssl/include
> >NO_GETTEXT=3DYesPlease
> >NO_TCLTK=3DYesPlease
>=20
> Try adding "MAKE =3D /usr/sfw/bin/gmake".
>=20
  I used "gmake" instead of "make" in my script.  I later compiled
"make-4.0" and this bug did not show itself there.  "gmake" was version
3.81.

--=20
Bjarni I. Gislason
