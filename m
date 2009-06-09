From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Possible eGit bug...
Date: Tue, 9 Jun 2009 13:40:29 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906091337390.5580@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 13:40:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDzh1-0000HP-4T
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 13:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303AbZFILka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 07:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755142AbZFILk3
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 07:40:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:45072 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752356AbZFILk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 07:40:29 -0400
Received: (qmail invoked by alias); 09 Jun 2009 11:40:30 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp039) with SMTP; 09 Jun 2009 13:40:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+uUDpeZWKuUMDsyVBsFHJS1AqMr6XD7koUw74/8G
	BHLLs4b+viuLf9
X-X-Sender: schindel@intel-tinevez-2-302
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121168>

Hi,

one of my users managed to create 4b825dc trees.  In case you do not know 
what that is: it is a completely empty tree:

	$ git hash-object -t tree --stdin < /dev/null

The way he managed to create those trees was by using "git rm --cached" to 
remove all tracked files from a subdirectory and then committing using 
eGit.

I have the slight suspicion that eGit is at fault here.  Possible?  
(Sorry, I cannot try myself...)

Ciao,
Dscho
