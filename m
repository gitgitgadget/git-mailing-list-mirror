From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH 4/4] t5526: avoid dependency on submodule
 order
Date: Thu, 3 Feb 2011 14:26:47 -0600 (CST)
Message-ID: <alpine.DEB.1.00.1102031426110.1541@bonsai2>
References: <1296747105-1663-1-git-send-email-patthoyts@users.sourceforge.net> <1296747105-1663-5-git-send-email-patthoyts@users.sourceforge.net> <201102032108.54811.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Feb 03 21:27:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl5lb-0002J0-1u
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 21:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572Ab1BCU0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 15:26:53 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:52420 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751535Ab1BCU0w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 15:26:52 -0500
Received: (qmail invoked by alias); 03 Feb 2011 20:26:50 -0000
Received: from wid-mir-primary-delegated.net.wisc.edu (EHLO bonsai2.local) [144.92.20.210]
  by mail.gmx.net (mp015) with SMTP; 03 Feb 2011 21:26:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/hStFmcXzhAujFYQ/Zmo2VLC+I+iilmlnrT+yy7T
	aAaa6NtD2F3mpt
X-X-Sender: gene099@bonsai2
In-Reply-To: <201102032108.54811.j6t@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165994>

Hi,

On Thu, 3 Feb 2011, Johannes Sixt wrote:

> On Donnerstag, 3. Februar 2011, Pat Thoyts wrote:
> > +test_cmp_unordered() {
> > +	grep --line-regexp -f "$@" >&3
> > +}
> 
> I don't think that this is sufficiently portable.
> 
> Furthermore, just like Dscho, I'd rather prefer to know why the output 
> is not ordered as expected.

Have you seen my response where I proved that it is a fflush() issue, most 
likely with mingw_spawn()?

Ciao,
Dscho
