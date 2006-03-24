From: Panagiotis Issaris <takis@issaris.org>
Subject: [BUG] make test (t3600-rm.sh) fails
Date: Fri, 24 Mar 2006 11:14:25 +0100
Message-ID: <4423C681.3000302@issaris.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Mar 24 11:14:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMjJS-0007Oa-NT
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 11:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbWCXKOb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 05:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWCXKOb
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 05:14:31 -0500
Received: from alpha.uhasselt.be ([193.190.2.30]:16839 "EHLO alpha.uhasselt.be")
	by vger.kernel.org with ESMTP id S1751531AbWCXKOb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 05:14:31 -0500
Received: from localhost (datastorage.uhasselt.be [193.190.2.17])
	by alpha.uhasselt.be (Postfix) with ESMTP id 4A3101AB1A2;
	Fri, 24 Mar 2006 11:14:26 +0100 (CET)
Received: from [172.18.16.239] (edm-006.edm.uhasselt.be [193.190.10.6])
	by alpha.uhasselt.be (Postfix) with ESMTP id 9BFC01AB17E;
	Fri, 24 Mar 2006 11:14:25 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Virus-Scanned: by Amavisd antivirus & antispam cluster at uhasselt.be
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17904>

Hi,

Just a small report that "make test" fails on my system on the current 
git git tree:

...
* passed all 3 test(s)
*** t3600-rm.sh ***
Committing initial tree e5c556e46aae6124ff4a2a466c95004e92d9a2e4
*   ok 1: Pre-check that foo exists and is in index before git-rm foo
*   ok 2: Test that git-rm foo succeeds
*   ok 3: Post-check that foo exists but is not in index after git-rm foo
*   ok 4: Pre-check that bar exists and is in index before "git-rm -f bar"
*   ok 5: Test that "git-rm -f bar" succeeds
*   ok 6: Post-check that bar does not exist and is not in index after 
"git-rm -f bar"
*   ok 7: Test that "git-rm -- -q" succeeds (remove a file that looks 
like an option)
*   ok 8: Test that "git-rm -f" succeeds with embedded space, tab, or 
newline characters.
* FAIL 9: Test that "git-rm -f" fails if its rm fails
        git-rm -f baz
*   ok 10: When the rm in "git-rm -f" fails, it should not remove the 
file from the index
* failed 1 among 10 test(s)
make[2]: *** [t3600-rm.sh] Error 1
make[2]: Leaving directory `/usr/local/src/git/t'
make[1]: *** [test] Error 2
make[1]: Leaving directory `/usr/local/src/git'
make: *** [build-arch-stamp] Error 2


My system:
Ubuntu 5.10 aka Breezy
Linux issaris 2.6.15.060103 #1 Tue Jan 3 14:27:55 CET 2006 i686 GNU/Linux
model name      : Intel(R) Pentium(R) 4 CPU 3.20GHz

With friendly regards,
Takis
