From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH (GIT-GUI BUG)] git-gui: use of undeclared variable in
 handle_empty_diff
Date: Sun, 5 Apr 2009 23:35:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904052334470.10279@pacific.mpi-cbg.de>
References: <0337ff5648e5e0dc583e255a44573dbf@mb8-2.1blu.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Joerg Bornemann <git@jbornemann.de>
X-From: git-owner@vger.kernel.org Sun Apr 05 23:34:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqZyp-0004GU-WE
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 23:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbZDEVco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 17:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752212AbZDEVco
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 17:32:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:56424 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751416AbZDEVcn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 17:32:43 -0400
Received: (qmail invoked by alias); 05 Apr 2009 21:32:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 05 Apr 2009 23:32:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18uxSwRt1supf3qjgr91QL8T/fh5YgPK1Ds0prtQK
	/NbxH9HjaWoXDY
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <0337ff5648e5e0dc583e255a44573dbf@mb8-2.1blu.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115715>

Hi,

On Sun, 5 Apr 2009, Joerg Bornemann wrote:

> Commit 584fa9cc ("git-gui: Avoid an infinite rescan loop in 
> handle_empty_diff.") introduced the global variable diff_empty_count, 
> which is used in diff.tcl. But this variable isn't declared anywhere 
> which results in an ugly error message box instead of the intended 
> informative message. This patch fixes this and removes the unnecessary 
> second initialization of current_diff_path.

Under which circumstances does this bug trigger?  I never saw it happen.

Ciao,
Dscho
