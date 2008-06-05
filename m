From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 0/2] git add --edit
Date: Thu, 5 Jun 2008 17:19:28 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806051719170.21190@racer>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer> <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer> <4847F49F.8090004@viscovery.net>
 <alpine.DEB.1.00.0806051548140.21190@racer> <48480123.7030903@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 18:22:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4IEA-0003x0-E0
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 18:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760659AbYFEQU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 12:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753223AbYFEQU7
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 12:20:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:56912 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760656AbYFEQU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 12:20:57 -0400
Received: (qmail invoked by alias); 05 Jun 2008 16:20:55 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 05 Jun 2008 18:20:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Hr15vss7HKw+0RyVYrRLDM2xelfaPy6kalpHdOk
	9+t1E/ANMRmG/r
X-X-Sender: gene099@racer
In-Reply-To: <48480123.7030903@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83941>


Changes relative to the first version:

- rename the apply option to --ignore-hunk-headers

- add a test

Johannes Schindelin (2):
  Allow git-apply to ignore the hunk headers
  git-add: introduce --edit (to edit the diff vs. the index)

 Documentation/git-add.txt   |    9 +++-
 Documentation/git-apply.txt |    7 +++-
 builtin-add.c               |   47 +++++++++++++++++++++++-
 builtin-apply.c             |   57 ++++++++++++++++++++++++++--
 t/t3702-add-edit.sh         |   86 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 198 insertions(+), 8 deletions(-)
 create mode 100755 t/t3702-add-edit.sh
