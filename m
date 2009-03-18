From: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
Subject: git cvsserver and database permissions
Date: Wed, 18 Mar 2009 20:20:05 -0300
Organization: DATACOM
Message-ID: <49C181A5.6070908@datacom.ind.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 00:21:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk550-0003Bl-BB
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 00:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbZCRXUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 19:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbZCRXUQ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 19:20:16 -0400
Received: from mail.datacom-telematica.com.br ([200.213.13.18]:55906 "EHLO
	mail.datacom-telematica.com.br" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751196AbZCRXUP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2009 19:20:15 -0400
Received: by mail.datacom-telematica.com.br (Postfix, from userid 65)
	id 7E4B32ACCE; Wed, 18 Mar 2009 20:20:06 -0300 (BRT)
Received: from [10.1.3.11] (unknown [10.1.3.11])
	by mail.datacom-telematica.com.br (Postfix) with ESMTP id 3A6CA2ACCD
	for <git@vger.kernel.org>; Wed, 18 Mar 2009 20:20:06 -0300 (BRT)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113702>

Hi

I'm trying to set up git cvsserver in a shared repository.

It works very well, but the database file for each branch (for example "gitcvs.master.sqlite") is created by the first user which access it and without group-write permissions, then I have to manually fix the permissions.

Shouldn't it honor core.sharedrepository?
Is there any place where I can configure it to create files with group-write permissions? 


Thank you,

 - Samuel

 
