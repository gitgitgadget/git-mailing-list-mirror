From: Adam Nielsen <adam.nielsen@uq.edu.au>
Subject: post-receive-email doesn't list commits after a multi-branch push
Date: Tue, 16 Mar 2010 15:48:37 +1000
Organization: The University of Queensland
Message-ID: <4B9F1BB5.70902@uq.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 06:48:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrPe3-00020G-HB
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 06:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055Ab0CPFsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 01:48:42 -0400
Received: from mailhub3.uq.edu.au ([130.102.148.131]:35606 "EHLO
	mailhub3.uq.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab0CPFsl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 01:48:41 -0400
Received: from smtp4.uq.edu.au (smtp4.uq.edu.au [130.102.128.19])
	by mailhub3.uq.edu.au (8.13.8/8.13.8) with ESMTP id o2G5mcAl028393
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 15:48:39 +1000
Received: from [130.102.44.91] (era-nielsen1.library.uq.edu.au [130.102.44.91])
	by smtp4.uq.edu.au (8.13.8/8.13.8) with ESMTP id o2G5mcmW008189
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 15:48:38 +1000
User-Agent: Thunderbird 2.0.0.23 (X11/20091130)
X-UQ-FilterTime: 1268718519
X-Scanned-By: MIMEDefang 2.58 on UQ Mailhub on 130.102.148.131
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142301>

Hi all,

I have set up a few git repositories that use the post-receive-email 
script to send an e-mail with the commit logs.

This all works fine if only one branch at a time is updated, but if 
someone does a 'git push' with multiple branches having been updated (in 
my case I commit to one branch and then merge it with another), I get 
one e-mail per changed branch with no commit messages in any of them.

Has anyone else experienced this problem?  Is it a bug in 
post-receive-email or a limitation of the git hook system?

Thanks,
Adam.

(Please CC)
