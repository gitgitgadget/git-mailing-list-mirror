From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git blame date output format configurable, a la
 git log
Date: Fri, 20 Feb 2009 14:40:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902201434460.6302@intel-tinevez-2-302>
References: <1235136252-29649-1-git-send-email-eletuchy@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, marius@trolltech.com,
	Eugene Letuchy <eugene@facebook.com>
To: eletuchy@gmail.com
X-From: git-owner@vger.kernel.org Fri Feb 20 14:42:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaVdk-0007iv-Dd
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 14:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbZBTNk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 08:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287AbZBTNk1
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 08:40:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:51696 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751676AbZBTNk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 08:40:26 -0500
Received: (qmail invoked by alias); 20 Feb 2009 13:40:24 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp015) with SMTP; 20 Feb 2009 14:40:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18rP7AbR28ri1HysixpZbyJuMnZ0gbBGyCEitVxd2
	CJyEs+98Gydzd1
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1235136252-29649-1-git-send-email-eletuchy@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110843>

Hi,

Disclaimer: if you are offended by constructive criticism, or likely to 
answer with insults to the comments I offer, please stop reading this mail 
now (and please to not answer my mail, either). :-)

Still with me?  Good.  Nice to meet you.

Just out of curiosity: why Cc: Marius?  I would have expected Junio, Git's 
maintainer.

May I suggest the commit subject to say "as for git log"?  I mistook "a la 
git log" for a change in the way git-blame works...

On Fri, 20 Feb 2009, eletuchy@gmail.com wrote:

> From: Eugene Letuchy <eugene@facebook.com>
> 
> Adds the following:

We try to use the imperative form; from my experience it makes for an 
easier read: "Add the following:"

>  - git config value blame.date that expects one of the git log date
>    formats ({relative,local,default,iso,rfc,short})
>  - git blame command line option --date-format expects one of the git
>    log date formats ({relative,local,default,iso,rfc,short})
>  - documentation in blame-options.txt
>  - git blame uses the appropriate date.c functions and enums to
>    make sense of the date format and provide appropriate data
> 
> The tests pass. The mailmap test needed to be modified to expect iso
> formatted blames rather than the new "default".

IMHO the "The tests pass." should be removed.

Other than that, nicely done!

Ciao,
Dscho
