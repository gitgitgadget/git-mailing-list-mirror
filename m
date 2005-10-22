From: Andreas Ericsson <ae@op5.se>
Subject: Server side programs
Date: Sun, 23 Oct 2005 00:22:17 +0200
Message-ID: <435ABB99.5020908@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Oct 23 00:23:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETRl5-0001oQ-B9
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 00:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVJVWWT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Oct 2005 18:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVJVWWT
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Oct 2005 18:22:19 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:33994 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751181AbVJVWWS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2005 18:22:18 -0400
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id ED8686BCFE
	for <git@vger.kernel.org>; Sun, 23 Oct 2005 00:22:17 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10477>

Are git-receive-pack and git-upload-pack the only two binaries that get 
called directly over a SSH-tunnel?

The git tutorial explicitly mentions this for git-receive-pack. Several 
of the other docs (git-fetch-pack, git-peek-remote and git-clone-pack) 
mentions git-upload-pack. No other program from the git suite is 
mentioned as an immediate target for ssh connections.

The reason I'm asking is that I'm adding support for userrelative paths 
(git pull ssh://host:~user/somedir) and removing the possibilities to 
use a compromised but limited account for finding out what other 
useraccounts are available.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
