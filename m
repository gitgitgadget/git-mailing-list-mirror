From: Sylvain RABOT <srabot@steek.com>
Subject: Minor bug in bash completion
Date: Tue, 29 Dec 2009 15:36:58 +0100
Message-ID: <4B3A140A.60302@steek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Dec 29 15:37:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPdCD-0004wX-Rn
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 15:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbZL2OhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 09:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbZL2OhH
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 09:37:07 -0500
Received: from sarca.steek.com ([62.39.111.200]:52617 "EHLO sarca.steek.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbZL2OhG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 09:37:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by sarca.steek.com (Postfix) with ESMTP id 7B8AA95CA;
	Tue, 29 Dec 2009 15:37:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at sarca.steek.com
Received: from sarca.steek.com ([127.0.0.1])
	by localhost (sarca.steek.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wF05vLsVlzOh; Tue, 29 Dec 2009 15:36:59 +0100 (CET)
Received: from [192.168.1.190] (LMontsouris-152-62-23-90.w80-13.abo.wanadoo.fr [80.13.22.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: srabot@steek.com)
	by sarca.steek.com (Postfix) with ESMTPSA id 5230295C6;
	Tue, 29 Dec 2009 15:36:59 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135799>

Hello,

I found a bug in the git bash completion.
It occurs when I press tab to complete branch name when I want to pull 
from the origin.
Instead of completing the branch name it prompts me directly for my 
password on the origin remote.


                                                          I pressed tab 
here (just after mem)
                                                             |
srabot@khety:~/dev/ribeti.git[memcached]$ git pull origin 
memsrabot@git.ps.agematis.loc's password:
srabot@git.ps.agematis.loc's password:
cached
srabot@git.ps.agematis.loc's password:
 From git.ps.agematis.loc:/var/git/ribeti
 * branch            memcached  -> FETCH_HEAD
Already up-to-date.


I'm using :

Linux khety 2.6.31-16-generic #53-Ubuntu SMP Tue Dec 8 04:01:29 UTC 2009 
i686 GNU/Linux
GNU bash, version 4.0.33(1)-release (i486-pc-linux-gnu)
git version 1.6.6

Best regards.

-- 
Sylvain
