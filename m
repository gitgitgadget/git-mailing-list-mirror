From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: MinGW port updated, now self-hosting again
Date: Tue, 13 Mar 2007 11:14:17 +0100
Organization: eudaptics software gmbh
Message-ID: <45F67979.498A321F@eudaptics.com>
References: <45F675E8.2E4B58B4@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 11:14:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR41K-0001pJ-89
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 11:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbXCMKOK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 06:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbXCMKOK
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 06:14:10 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160]:21838 "EHLO
	linz.eudaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbXCMKOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 06:14:09 -0400
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP id 231E354D
	for <git@vger.kernel.org>; Tue, 13 Mar 2007 11:14:08 +0100 (CET)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42113>

Johannes Sixt wrote:
> 
> I've updated the MinGW port at
> 
> pull/clone: git://repo.or.cz/git/mingw.git
> gitweb:     http://repo.or.cz/w/git/mingw.git
> 
> Thanks to the recent additions of fake symlink support, this version is
> now self-hosting on Windows again.

I forgot to mention: To make the repository self-hosting, you must set

  git config core.symlinks false

but since you can do this only after a repository exists, a 'git clone'
will still fail during the checkout phase. To fix up the failure, just
enter the repository, set core.symlinks false, and follow-up with a 'git
reset --hard'.

-- Hannes
