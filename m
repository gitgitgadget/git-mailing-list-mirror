From: Victor Bogado da Silva Lins <victor@bogado.net>
Subject: how to git-archive ignore some files?
Date: Tue, 06 May 2008 15:15:31 -0300
Message-ID: <1210097731.5238.3.camel@omicron.ep.petrobras.com.br>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 20:48:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtSDJ-0002GU-V9
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 20:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156AbYEFSrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 14:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbYEFSrp
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 14:47:45 -0400
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:51386 "EHLO
	spunkymail-a17.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751704AbYEFSro (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2008 14:47:44 -0400
X-Greylist: delayed 1923 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 May 2008 14:47:44 EDT
Received: from [127.0.0.1] (unknown [139.82.86.2])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by spunkymail-a17.g.dreamhost.com (Postfix) with ESMTP id B1FAF75102
	for <git@vger.kernel.org>; Tue,  6 May 2008 11:15:40 -0700 (PDT)
X-Mailer: Evolution 2.8.0 (2.8.0-40.el5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81374>

I want to use git-archive to create source packages, but my git
repository has a .gitignore that I don't want to be pushed into the
archive. So is it possible to keep the .gitignore file in the repository
and create an archive(*) without it? 

*) using git-archive, off course. 
