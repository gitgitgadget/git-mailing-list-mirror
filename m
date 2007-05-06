From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: FFmpeg considering GIT
Date: Sun, 6 May 2007 14:33:59 +0200
Message-ID: <e5bfff550705060533x18f63c09rc6a742058b82f712@mail.gmail.com>
References: <loom.20070502T111026-882@post.gmane.org>
	 <20070503180016.GB21333@informatik.uni-freiburg.de>
	 <20070503200013.GG4489@pasky.or.cz>
	 <loom.20070504T143538-533@post.gmane.org>
	 <87y7k4lahq.wl%cworth@cworth.org>
	 <20070505133543.GC3379@diana.vm.bytemark.co.uk>
	 <e5bfff550705060115o60fdd637h6c7393d06f75c55@mail.gmail.com>
	 <20070506111411.GC17498@diana.vm.bytemark.co.uk>
	 <e5bfff550705060519s2c1abd7cl7ecedeb497e10e3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Carl Worth" <cworth@cworth.org>,
	"Michael Niedermayer" <michaelni@gmx.at>, git@vger.kernel.org,
	"Pavel Roskin" <proski@gnu.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun May 06 14:34:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkfwM-0005fI-Tp
	for gcvg-git@gmane.org; Sun, 06 May 2007 14:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbXEFMeE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 08:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbXEFMeE
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 08:34:04 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:56997 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbXEFMeB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 08:34:01 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1300568wra
        for <git@vger.kernel.org>; Sun, 06 May 2007 05:34:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IjRDPsxeuvcVDw0cYGYLd5uW71uvm9uVhbp7yq2lL0ttoamC0aAFBpcNeU4D53uCmlCbipdM/ull+LepYG1bODnODYzOp9REPnQbM0RlIZzTH94NoUJkiL7z0+w0fXuE5XVszcPVWHuSqF+iQVNf4CmQdM/ge5YtID7hP5lctA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FvoWzq+E8XRZRm91jNCKbWxhBIaImzJw39DhsRELnoTtwX/vq9bSTA3iAyF0Rhlg1C9dQ1/hoOzKsGEoQqLk8O8caRjTQDTpT9f4CmywiPIILrSYIKskQHL6XrSm4t9dIIdjRP2q+351L+cuCumQUK5Q/2nCZjGFxHN7Nb7LrU4=
Received: by 10.114.198.1 with SMTP id v1mr1791155waf.1178454839670;
        Sun, 06 May 2007 05:33:59 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 6 May 2007 05:33:59 -0700 (PDT)
In-Reply-To: <e5bfff550705060519s2c1abd7cl7ecedeb497e10e3b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46329>

On 5/6/07, Marco Costalba <mcostalba@gmail.com> wrote:
> On 5/6/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > On 2007-05-06 10:15:16 +0200, Marco Costalba wrote:
> >
> > > Use qgit ;-)
> >
> > Do I have to use any particular autoconf version? With
> >
>

After googling a little bit....

Please apply this patch before to run 'autoreconf -i' on a *fresh
cloned* repository

diff --git a/configure.ac b/configure.ac
index e352eba..95f45d1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -6,7 +6,7 @@ AC_INIT(qgit, 1.5.5)
 AC_CONFIG_AUX_DIR(config)
 AM_INIT_AUTOMAKE(foreign 1.8)
 AC_CONFIG_SRCDIR([src/annotate.cpp])
-AC_CONFIG_HEADER([config.h])
+AM_CONFIG_HEADER([config.h])

 # Checks for programs.
 AC_LANG(C++)


On my box it compiles the same and perhaps you can avoid the reported e=
rrors.

Please, let me know how it goes.

Marco
