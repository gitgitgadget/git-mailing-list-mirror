From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git and OpenDocument (OpenOffice.org) files
Date: Mon, 27 Aug 2007 11:17:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708271109560.28586@racer.site>
References: <vpqk5rh5mp5.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 27 12:15:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPbdO-0001qx-08
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 12:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbXH0KPe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 06:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbXH0KPc
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 06:15:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:42018 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751852AbXH0KPT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 06:15:19 -0400
Received: (qmail invoked by alias); 27 Aug 2007 10:15:17 -0000
Received: from ppp-82-135-74-69.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.74.69]
  by mail.gmx.net (mp049) with SMTP; 27 Aug 2007 12:15:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qTGo7WC1qGCNE2/xQHKWiq6hnWg4CsVnGs9Zybw
	+vfBGRhQksE6CX
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqk5rh5mp5.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56807>

Hi,

On Mon, 27 Aug 2007, Matthieu Moy wrote:

> I found a way to use git comfortably with OpenDocument files (that is, 
> what OpenOffice.org and Koffice produce. Text, Presentations and 
> Spreadsheets).

Heh.  I had that problem, too.  I added an attribute "*.odt diff=odt" and 
the diff driver unpacks the zip and executes an xmldiff on the files.  
Since at times, it is more interesting to do a word based diff, depending 
on the environment variable WORDDIFF, my diff driver executes "git diff 
--color-words" instead.

Ciao,
Dscho
