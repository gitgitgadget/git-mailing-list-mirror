From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: git reset --merge misdocumented?
Date: Thu, 29 Jan 2009 02:17:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901290210540.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 02:18:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSLYQ-00042k-Ha
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 02:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755061AbZA2BRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 20:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754879AbZA2BRZ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 20:17:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:40996 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754845AbZA2BRY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 20:17:24 -0500
Received: (qmail invoked by alias); 29 Jan 2009 01:17:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 29 Jan 2009 02:17:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18A6GlFabEAJHE+STad/JlTa1UKyhBcxcDVoda6f3
	dftcffItn7LIRh
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107605>

Hi,

from the man page I thought that --merge would be just another way to say 
"git read-tree -u -m".

In particular, the man page says _nothing_ about resetting HEAD to 
something else.

Maybe somebody with l33ter dox skillz than me would like to fix that.

Ciao,
Dscho
