From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: Append ampersand to Target of lnk files created
 by  do_cygwin_shortcut.
Date: Mon, 9 Mar 2009 21:13:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903092109360.6358@intel-tinevez-2-302>
References: <530ac78e0903091022s2585231br9ef11d91851250f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Phil Lawrence <prlawrence@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 21:17:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgluq-0001kt-Iw
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 21:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbZCIUPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 16:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbZCIUPi
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 16:15:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:58167 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753451AbZCIUPh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 16:15:37 -0400
Received: (qmail invoked by alias); 09 Mar 2009 20:13:26 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp008) with SMTP; 09 Mar 2009 21:13:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LDnkd/S+L0vVBzjcsngDfSRjIdgzFV9h86FzK6C
	n5Ni/mn097vszj
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <530ac78e0903091022s2585231br9ef11d91851250f4@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112735>

Hi,

On Mon, 9 Mar 2009, Phil Lawrence wrote:

> >From 5fddc9b7bfa0dfb8d2c1c0eb59ae9208ff72540d Mon Sep 17 00:00:00 2001
> From: Phil Lawrence <prlawrence@gmail.com>
> Date: Thu, 5 Mar 2009 17:56:58 -0600
> Subject: [PATCH] Append ampersand to Target of lnk files created by
> do_cygwin_shortcut.  Allows shell window to close after starting
>  Git GUI as a background process.
> 
> ---

A few comments.

Usually we try to use that subject as the subject of the mail, and we also 
try to keep the subject shorter than 77 characters (so that "git log" on 
an 80-column display does not need to wrap lines).

Also, we like authors to provide Signed-off-by: lines.

Now, with the technical stuff out of the way: are you not changing 
behavior?  It seems that Linux users expect an program called by a menu 
item to block the application until the program returns, so that an error 
can be caught.

Maybe the expectation is different on Windows?  But then, we'd still like 
to catch errors and warn the user about it, right?

Ciao,
Dscho
