From: Johannes Sixt <j.sixt@viscovery.net>
Subject: 'git branch --no-merge' is ambiguous
Date: Fri, 25 Sep 2009 12:28:57 +0200
Message-ID: <4ABC9B69.5010205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Sep 25 12:29:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mr830-0007Cr-Vo
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 12:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbZIYK25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 06:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbZIYK24
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 06:28:56 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:5578 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbZIYK24 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 06:28:56 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mr82r-000782-VH; Fri, 25 Sep 2009 12:28:58 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A4E5F9614; Fri, 25 Sep 2009 12:28:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129073>

Look here:

 $ git branch --merge
 * master
 $ git branch --no-merge
 error: Ambiguous option: no-merge (could be --no-merged or --no-merged)
 usage: ...
     --no-merged <commit>  print only not merged branches
     --merged <commit>     print only merged branches

I tried to debug it, but parse_long_opt() is such awful spaghetti code
that I don't grok it. Please help.

-- Hannes
