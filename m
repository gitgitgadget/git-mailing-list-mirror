From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Stashing untracked files
Date: Sat, 29 Sep 2007 23:00:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709292259070.28395@racer.site>
References: <46FE9924.7080006@theory.org> <Pine.LNX.4.64.0709292201400.28395@racer.site>
 <EEE8F630-AE62-4425-96A0-239D54724DF4@lrde.epita.fr> <46FEC799.30803@theory.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>, Benoit SIGOURE <tsuna@lrde.epita.fr>
To: Neil Macneale <mac4-git@theory.org>
X-From: git-owner@vger.kernel.org Sun Sep 30 00:01:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbkNd-0003rv-Qk
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 00:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370AbXI2WBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 18:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754368AbXI2WBi
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 18:01:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:52999 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753861AbXI2WBi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 18:01:38 -0400
Received: (qmail invoked by alias); 29 Sep 2007 22:01:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 30 Sep 2007 00:01:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+shKx+H9ysNIGuf4vSnEZB2VicDiilK7DU744csz
	vx/htnyYvlfASS
X-X-Sender: gene099@racer.site
In-Reply-To: <46FEC799.30803@theory.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59497>

Hi,

[please do not cull me from the Cc: list, especially if you quote me.]

On Sat, 29 Sep 2007, Neil Macneale wrote:

> Performing an add would require me to remove those file from the index 
> at a later date in the event that I don't want to commit them on the 
> next commit.

Wrong.

If you "git add <new-file>" and then "git stash", it will no longer have 
the file in the index.  Instead, the index will agree with the HEAD (which 
does not have <new-file>).

Ciao,
Dscho
