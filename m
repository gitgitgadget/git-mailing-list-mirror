From: R&D4 <r&d4@dave-tech.it>
Subject: problem with cvs import and removed files
Date: Thu, 08 Dec 2005 16:27:27 +0100
Message-ID: <439850DF.7070407@dave-tech.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 08 16:30:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkNgJ-000229-A9
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 16:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVLHP1g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 10:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbVLHP1g
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 10:27:36 -0500
Received: from host46-203.pool8538.interbusiness.it ([85.38.203.46]:772 "HELO
	dave-tech.it") by vger.kernel.org with SMTP id S1750914AbVLHP1f
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Dec 2005 10:27:35 -0500
Received: (qmail 9862 invoked by uid 0); 8 Dec 2005 16:31:25 -0000
Received: from unknown (HELO ?192.168.0.24?) (192.168.2.253)
  by 192.168.2.1 with SMTP; 8 Dec 2005 16:31:25 -0000
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
To: git mailing list <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13365>


Hi Git gurus!

I'm trying to `git cvs import` this cvs repository
http://cvs.sourceforge.net/viewcvs.py/compiere

When trying to import module "utils" as follows:

git cvsimport -v -d 
:pserver:anonymous@cvs.sourceforge.net:/cvsroot/compiere -C utils utils

I have a problem about "non-existent revision" of a file:

cvs_direct initialized to CVSROOT /cvsroot/compiere
cvs rlog: Logging utils
request for non-existent rev 1.1 in file .project
DONE; creating master branch
cp: cannot stat `/home/cvs/compiere/utils/.git/refs/heads/origin': No
such file or directory
usage: git-read-tree (<sha> | -m [-u | -i] <sha1> [<sha2> [<sha3>]])
checkout failed: 256

In fact rev 1.1 of .project in main branch shows "file removed" 
(http://cvs.sourceforge.net/viewcvs.py/compiere/utils/.project?rev=1.2&view=log)

The same happen with some other module of this project.

I'm running git --version is:
0.99.9.GIT

and cvsps --version is:
2.1


Any clue in how to solve this kind of problem?
Is it possible to skip this file(s) and maybe include them later "manually"?

Thanks in advance and best regards,


-- 

Andrea

DAVE Srl - Electronics System House
e-mail address: r&d4@dave-tech.it
