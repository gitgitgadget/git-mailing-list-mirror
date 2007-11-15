From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: core.excludesfile clean-up
Date: Thu, 15 Nov 2007 15:16:21 +0100
Message-ID: <473C54B5.5060500@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 15:16:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsfWO-0006En-PY
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 15:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759AbXKOOQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 09:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756689AbXKOOQ2
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 09:16:28 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:20243 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756620AbXKOOQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 09:16:27 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IsfVW-0007W4-JA; Thu, 15 Nov 2007 15:15:50 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8ABCB6C4; Thu, 15 Nov 2007 15:16:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65123>

Junio,

in 039bc64e886 core.excludesfile clean-up you wrote:

 > We probably could change git-ls-files to use the standard set
 > when no excludes are specified on the command line and ignore
 > processing was asked, or something like that, but that will be a
 > change in semantics and might break people's scripts in a subtle
 > way.  I am somewhat reluctant to make such a change.

Just for the records: git-filter-branch uses git-ls-files in a way that 
requires that no exclude files are in effect. In particular, if the tree 
filter creates new files, they are unconditionally added. See the 
documentation of --tree-filter.

-- Hannes
