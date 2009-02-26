From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] shallow clone stuff
Date: Fri, 27 Feb 2009 00:31:17 +0100 (CET)
Message-ID: <cover.1235690903u.git.johannes.schindelin@gmx.de>
References: <alpine.DEB.1.00.0902262352380.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 27 00:32:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcphi-0000Ri-CA
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 00:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177AbZBZXaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 18:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbZBZXaF
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 18:30:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:59291 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754210AbZBZXaE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 18:30:04 -0500
Received: (qmail invoked by alias); 26 Feb 2009 23:30:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 27 Feb 2009 00:30:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18sxMR4NyAsBAAamU24DmMwoHp4rn8ZeFeec+J0JY
	PZKsn3Dmy4O2jt
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0902262352380.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111613>

The first patch fixes the current bug that --no-hardlinks is not heeded, 
and the second patch introduces the warning when cloning locally with a 
--depth parameter.

Johannes Schindelin (2):
  clone: do not ignore --no-hardlinks
  clone: ignore --depth when cloning locally (implicitly --local)

 Documentation/git-clone.txt |    4 ++++
 builtin-clone.c             |    5 ++++-
 t/t5701-clone-local.sh      |   14 ++++++++++++++
 3 files changed, 22 insertions(+), 1 deletions(-)
