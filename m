From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Thu, 18 Feb 2010 10:10:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002181009440.20986@pacific.mpi-cbg.de>
References: <20100215225001.GA944@book.hvoigt.net> <7vwryet2cw.fsf@alter.siamese.dyndns.org> <7vocjpnc5v.fsf@alter.siamese.dyndns.org> <7vljetlx8r.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1002160914140.20986@pacific.mpi-cbg.de> <7viq9wzq8g.fsf@alter.siamese.dyndns.org>
 <20100217224330.GB8029@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 10:04:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni2J3-00043u-JF
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 10:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078Ab0BRJEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 04:04:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:35726 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753022Ab0BRJEB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 04:04:01 -0500
Received: (qmail invoked by alias); 18 Feb 2010 09:03:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 18 Feb 2010 10:03:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/AGADqi8/jHm21Zlq7Ml+mSWPmQ+2GT6hmitED2
	fHZWR/dUWCzW7a
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100217224330.GB8029@book.hvoigt.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58999999999999997
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140305>

Hi,

On Wed, 17 Feb 2010, Heiko Voigt wrote:

> On Tue, Feb 16, 2010 at 03:59:43PM -0800, Junio C Hamano wrote:
> > -- >8 --
> > Subject: Fix use of mutex in threaded grep
> > 
> > The program can decide at runtime not to use threading even if the support
> > is compiled in.  In such a case, mutexes are not necessary and left
> > uninitialized.  But the code incorrectly tried to take and release the
> > read_sha1_mutex unconditionally.
> > 
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > Acked-by: Fredrik Kuivinen <frekui@gmail.com>
> 
> Just to be sure I just tested this one as well. If you like you can add 
> a:
> 
> Tested-by: Heiko Voigt <hvoigt@hvoigt.net>

I have pushed the commit (at least the second-last :-) to 4msysgit's devel 
already (in the vain hope to release a Git for Windows on Tuesday...)

Ciao,
Dscho
