From: Matthias Fechner <idefix@fechner.net>
Subject: Migrate from svn to git
Date: Wed, 26 May 2010 17:13:51 +0200
Message-ID: <4BFD3AAF.4080403@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 17:37:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHIfw-0003I1-1u
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 17:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941Ab0EZPhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 11:37:19 -0400
Received: from anny.lostinspace.de ([80.190.182.2]:31131 "EHLO
	anny.lostinspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981Ab0EZPhS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 11:37:18 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2010 11:37:18 EDT
Received: from server.idefix.lan (ppp-93-104-103-160.dynamic.mnet-online.de [93.104.103.160])
	(authenticated bits=0)
	by anny.lostinspace.de (8.14.3/8.14.3) with ESMTP id o4QFRC88046097
	for <git@vger.kernel.org>; Wed, 26 May 2010 17:27:16 +0200 (CEST)
	(envelope-from idefix@fechner.net)
Received: from server.idefix.lan (unknown [127.0.0.1])
	by server.idefix.lan (Postfix) with ESMTP id 5DFFC4F8B
	for <git@vger.kernel.org>; Wed, 26 May 2010 17:27:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at server.idefix.lan
Received: from server.idefix.lan ([127.0.0.1])
	by server.idefix.lan (server.idefix.lan [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sIF66w7kmnaz for <git@vger.kernel.org>;
	Wed, 26 May 2010 17:24:13 +0200 (CEST)
Received: from matthias-fechners-macbook.local (tmo-104-100.customers.d1-online.com [80.187.104.100])
	by server.idefix.lan (Postfix) with ESMTPA id 3354E4E71
	for <git@vger.kernel.org>; Wed, 26 May 2010 17:24:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.5 (anny.lostinspace.de [80.190.182.2]); Wed, 26 May 2010 17:27:16 +0200 (CEST)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on anny.lostinspace.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147807>

Hi,

I hope that is the correct list to ask some questions.
I understood that the idea behind git is completely different and I like 
the idea behind git.

But for the svn repository I want to convert I need some features and 
I'm not sure how / if to implement them in git.

Corrently the svn repo is divided into trunk branches and tags.
In each of this directory like trunk i have directories like hardware, 
software, docu and more.

For each of this subdirectories I have usergroups defined which has no 
access, read access or rw access.

If I understood the manual correctly I can stick on that structure and 
easily work here with the unix-permission to grant access to the folders?
I think I have to test then acl with freebsd to have more then one group 
for each directory.


The second question is, I someone commits some files with svn an email 
is sent to a svn-commit mailinglist so changes can easily be discussed.
The current mail is sent in html format with a colored diff, so it is 
easier to read.

Is something similar possible with git or do you suggest a complete 
approach?

Thanks a lot for answers.

Bye,
Matthias

-- 
"Programming today is a race between software engineers striving to build bigger and better idiot-proof programs, and the universe trying to produce bigger and better idiots. So far, the universe is winning." -- Rich Cook
