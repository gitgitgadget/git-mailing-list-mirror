From: pbegeland <pbegeland@linea.gov.br>
Subject: dirty commits: =?UTF-8?Q?cause=3F=20how=20to=20prevent=20them=3F?=
Date: Tue, 10 Apr 2012 12:16:14 -0600
Message-ID: <4a0ed0da5e2c0fdc4e94a96f188ad60b@linea.gov.br>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 20:23:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHfiX-0007MY-O8
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 20:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099Ab2DJSW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 14:22:56 -0400
Received: from mx1.linea.gov.br ([186.232.60.112]:36947 "EHLO mx1.linea.gov.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755448Ab2DJSW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 14:22:56 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Apr 2012 14:22:55 EDT
Received: (qmail 20278 invoked from network); 10 Apr 2012 18:16:14 -0000
Received: from unknown (HELO roundcube) (pbegeland@[186.232.60.112])
          (envelope-sender <pbegeland@linea.gov.br>)
          by mx1.linea.gov.br (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 10 Apr 2012 18:16:14 -0000
X-Sender: pbegeland@linea.gov.br
User-Agent: RoundCube Webmail/0.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195116>

 Hi,

    I have a git superproject with a number of git submodules.
    Developers of those git submodules are recently reporting some 
 problems though when using them. They noticed some modified or untracked 
 files which are preventing them from pulling or committing changes of 
 their own.

    The system where the clones are as well as the central repositories, 
 have 2 different versions of git: 1.6.5 and 1.7.4.1.
    Looking at the clone of the developers who reported me the problems, 
 I do see dirty commits when doing a "git diff".
    By doing some search today at the net, I realized that there is 
 something in particular with v. 1.7.0 and later where the superproject 
 will display submodules as being modified when they contain untracked or 
 modified files, even if the compared ref matches the HEAD of the 
 submodule. And, commits will be marked as dirty.

    Do you think the problems are caused by the use of version 1.7.4.1?
    I'm trying to reproduce the problems as I wonder why only now such a 
 thing happened. (I've never observed dirty commits before)
    What is most strange to me is that doing a "git status" with version 
 1.6.5, submodules are also reported as being modified in one of the 
 clones of those develoepers.

    By reproducing the problem, I expect I have a clue why this started 
 happening only now.
    I also need to check how to have the developers clones cleaned. In a 
 superproject tree of one of them, a "git pull" is denied as it says to 
 him that he is in the middle of a conflicted merge.
    I'm not confident of giving any suggestion to developers at the 
 moment on how to have their clones cleaned since I don't understand well 
 what is going on.

    If you have any suggestion or recommendation, pls let me know. 
 (perhaps you need more details on my part for that...)

 Thanks,
 Patricia
