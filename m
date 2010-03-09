From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: core.autocrlf considered half-assed
Date: Tue, 9 Mar 2010 10:29:20 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003091028440.7596@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.1003060018170.20986@pacific.mpi-cbg.de> <20100307092701.GC31105@dpotapov.dyndns.org> <alpine.DEB.1.00.1003081225280.14277@intel-tinevez-2-302> <20100309072412.GF31105@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	torvalds@linux-foundation.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:27:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyX5-0001Do-LH
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879Ab0CIJWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 04:22:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:32964 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753731Ab0CIJWE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 04:22:04 -0500
Received: (qmail invoked by alias); 09 Mar 2010 09:22:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp051) with SMTP; 09 Mar 2010 10:22:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+QueoZ4VeQsbICbvtev2uiOTeeg1hsuVK2gjtX4p
	Fx0jjRNyZnQwwP
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100309072412.GF31105@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141796>

Hi,

On Tue, 9 Mar 2010, Dmitry Potapov wrote:

> On Mon, Mar 08, 2010 at 12:29:01PM +0100, Johannes Schindelin wrote:
> > 
> > Easiest example:
> > 
> > $ git clone -n git://repo.or.cz/git.git html-docs
> > $ cd html-docs/
> > $ git config core.autocrlf true
> > $ git checkout -t origin/html
> > $ git status
> 
> As Junio explained in another mail, it was intentional to have all HTML 
> files with CRLF, because they are supposed to have that ending on all 
> platforms. What is missing, however, is .gitattributes, which would tell 
> to Git that we do not want to autocrlf conversion for HTML files.

That is just papering over the real culprit: Git checks something out. 
This should be clean. But then Git says it is not.

Ciao,
Dscho
