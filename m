From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW binary installer available
Date: Wed, 7 Feb 2007 16:05:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702071559340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45C9E470.7030609@xs4all.nl>
 <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jan Nieuwenhuizen <janneke@gnu.org>
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Feb 07 16:06:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEoMh-0003YS-Ti
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 16:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161351AbXBGPFl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 10:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161350AbXBGPFl
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 10:05:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:49544 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161351AbXBGPFk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 10:05:40 -0500
Received: (qmail invoked by alias); 07 Feb 2007 15:05:39 -0000
X-Provags-ID: V01U2FsdGVkX19lMCElvldlaOF0qCPJu4jQRUoeKTapVlDbHBkY0T
	d57Q==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38928>

Hi,

On Wed, 7 Feb 2007, Johannes Schindelin wrote:

> On Wed, 7 Feb 2007, Han-Wen Nienhuys wrote:
> 
> > I don't actually have a windows copy, so it's basically untested.
> > However, I did succeed in running rev-list in wine.
> 
> I played a little with it. IMHO it makes no sense to use it without a 
> bash, and without less.

Side note: Since "ln <src> <dest>" in MinGW is really a copy, not a hard 
link, this gets rather big (44M here).

Which makes me think if we should just disallow the "git-<builtin>" on 
Windows, since sooner or later, Git will no longer be used from the 
command line on Windows.

And another thing hit me there: Are you sure that all works well if you 
change the install path from "C:\Program Files\Git" to something else?
Without explicitely setting GIT_EXEC_PATH?

Ciao,
Dscho
