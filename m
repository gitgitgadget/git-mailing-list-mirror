From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RFH: git show HEAD:$SUBMODULE
Date: Thu, 5 Feb 2009 17:46:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902051744520.7491@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 17:49:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV7PJ-0002lo-1A
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 17:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969AbZBEQqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 11:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754690AbZBEQqy
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 11:46:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:41382 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752121AbZBEQqx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 11:46:53 -0500
Received: (qmail invoked by alias); 05 Feb 2009 16:46:51 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp002) with SMTP; 05 Feb 2009 17:46:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+HrZQKVnCHAT+6Qdf76jESfyz+MuavHgaDGAEpmD
	Wuf+F/NmQsE59u
X-X-Sender: schindel@intel-tinevez-2-302
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108581>

Hi,

at the moment, 'show HEAD:$SUBMODULE' fails horribly, as git-show abuses 
the revision walker to parse the command line parameters, and the revision 
walker does not like a non-existing commit.

Instead, it would be nicer to show the user something like

	HEAD:$SUBMODULE
	submodule at commit $COMMIT_NAME

However, I have no clue how to go about getting that.  I want to avoid 
having to parse the parameters twice, but I also do not want to fsck up 
the revision walker...

Ideas?

Ciao,
Dscho
