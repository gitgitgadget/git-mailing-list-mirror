From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH ef/msys-imap] mingw: use BLK_SHA1 again
Date: Mon, 26 Oct 2009 23:26:45 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0910262324350.4985@pacific.mpi-cbg.de>
References: <1256144691-2908-1-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.0910221942150.1263@felix-maschine> <200910222011.02737.j6t@kdbg.org> <200910222026.29885.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Oct 26 23:23:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2Xye-0004fi-T1
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 23:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741AbZJZWXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 18:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753722AbZJZWXi
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 18:23:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:51225 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753631AbZJZWXh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 18:23:37 -0400
Received: (qmail invoked by alias); 26 Oct 2009 22:23:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 26 Oct 2009 23:23:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Byjp7OxkB7pXUeIzPw01GfnIPbdVighfM4oqOLQ
	cnHJlXmOATtchZ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200910222026.29885.j6t@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131279>

Hi,

On Thu, 22 Oct 2009, Johannes Sixt wrote:

> Since NO_OPENSSL is no longer defined on Windows, BLK_SHA1 is not defined
> anymore implicitly. Define it explicitly.
> 
> As a nice side-effect, we no longer link against libcrypto.dll, which has
> non-trivial startup costs because it depends on 6 otherwise unneeded
> DLLs.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> On Donnerstag, 22. Oktober 2009, Johannes Sixt wrote:
> > ... and I have one more patch to be applied on top of the series.
> 
> Here it is. I haven't tested the MSVC aspect of the patch. I would
> appreciate feedback in this regard.

For better visibility, I pushed it to the work/msys-imap branch in 
4msysgit.git (but I could not even compile-test it today, due to lack of 
access to a Windows machine).

If nobody complains by the end of the week, I will merge it into 
4msysgit.git's 'devel' branch (I can only compile-test by then).

Ciao,
Dscho
