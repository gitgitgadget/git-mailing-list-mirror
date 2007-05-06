From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: FFmpeg considering GIT
Date: Sun, 6 May 2007 15:03:26 +0200
Message-ID: <20070506130326.GB19317@diana.vm.bytemark.co.uk>
References: <20070503180016.GB21333@informatik.uni-freiburg.de> <20070503200013.GG4489@pasky.or.cz> <loom.20070504T143538-533@post.gmane.org> <87y7k4lahq.wl%cworth@cworth.org> <20070505133543.GC3379@diana.vm.bytemark.co.uk> <e5bfff550705060115o60fdd637h6c7393d06f75c55@mail.gmail.com> <20070506111411.GC17498@diana.vm.bytemark.co.uk> <e5bfff550705060519s2c1abd7cl7ecedeb497e10e3b@mail.gmail.com> <e5bfff550705060533x18f63c09rc6a742058b82f712@mail.gmail.com> <20070506125938.GA19317@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>, git@vger.kernel.org,
	Pavel Roskin <proski@gnu.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 15:03:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkgOk-0001Mh-AH
	for gcvg-git@gmane.org; Sun, 06 May 2007 15:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933662AbXEFNDb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 09:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933666AbXEFNDb
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 09:03:31 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2190 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933662AbXEFNDa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 09:03:30 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HkgOc-00052A-00; Sun, 06 May 2007 14:03:26 +0100
Content-Disposition: inline
In-Reply-To: <20070506125938.GA19317@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46331>

On 2007-05-06 14:59:38 +0200, Karl Hasselstr=F6m wrote:

> Nope, no luck. I get the same error messages from autoreconf:
>
> kha@yoghurt:~/qgit> autoreconf -i
> automake: configure.ac: installing `config/install-sh'
> automake: configure.ac: installing `config/mkinstalldirs'
> automake: configure.ac: installing `config/missing'
> automake: configure.ac: installing `config/config.guess'
> automake: configure.ac: installing `config/config.sub'
> automake: Makefile.am: installing `./INSTALL'
> automake: Makefile.am: required file `./NEWS' not found
> automake: Makefile.am: required file `./AUTHORS' not found
> configure.ac: 9: required file `./[config.h].in' not found
> src/Makefile.am:30: invalid unused variable name: `nodist_qgit_SOURCE=
S'
> autoreconf: automake failed with exit status: 1

Well, actually some luck. This line was first in my previous output,
but doesn't appear with your patch:

configure.ac: 9: `automake requires `AM_CONFIG_HEADER', not `AC_CONFIG_=
HEADER'

But there seems to be more stuff to fix. :-(

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
