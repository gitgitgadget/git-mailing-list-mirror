From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH] gitk: fix the display of files when filtered
 by path
Date: Thu, 15 Dec 2011 10:24:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1112151023280.2615@bonsai2>
References: <87hb14wg4l.fsf@fox.patthoyts.tk> <CAJDDKr6rVaX_=SZZeEAs950yuNDvi8sOkzrUK7LnCrK6MYfscg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Git <git@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
	msysGit <msysgit@googlegroups.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 10:24:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb7YI-0003Pa-0y
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 10:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756186Ab1LOJY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 04:24:29 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:49773 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752934Ab1LOJY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 04:24:27 -0500
Received: (qmail invoked by alias); 15 Dec 2011 09:24:25 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO client.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp003) with SMTP; 15 Dec 2011 10:24:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18P9wlY/D0Pxxo8INHPP891HeGCD3fPFzhq1l+Iw2
	k/lARRWVD+x+Ju
X-X-Sender: gene099@bonsai2
In-Reply-To: <CAJDDKr6rVaX_=SZZeEAs950yuNDvi8sOkzrUK7LnCrK6MYfscg@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187201>

Hi,

On Wed, 14 Dec 2011, David Aguilar wrote:

> On Tue, Dec 13, 2011 at 8:50 AM, Pat Thoyts
> <patthoyts@users.sourceforge.net> wrote:
> > Launching 'gitk -- .' or 'gitk -- ..\t' restricts the display to files
> > under the given directory but the file list is left empty. This is because
> > the path_filter function fails to match the filenames which are relative
> > to the working tree to the filter which is filessytem relative.
> > This solves the problem by making both names fully qualified filesystem
> > paths before performing the comparison.
> >
> > Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> 
> Wonderful!

Thanks for reminding me that I did not yet apply and push. Did so now.

Thanks, Pat, for fixing this bug!
Dscho
