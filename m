From: Dave Zarzycki <zarzycki@apple.com>
Subject: git-svn repo in weird state
Date: Thu, 18 Aug 2011 10:14:20 -0400
Message-ID: <85C67F68-AEF7-4E98-9388-C16BD04A68F8@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 16:14:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu3Mw-0003xV-5O
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 16:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518Ab1HROOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 10:14:43 -0400
Received: from honeycrisp.apple.com ([17.151.62.51]:48229 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119Ab1HROOk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 10:14:40 -0400
Received: from relay15.apple.com ([17.128.113.54])
 by mail-out.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTP id <0LQ4003EMNJLQJ71@mail-out.apple.com> for git@vger.kernel.org;
 Thu, 18 Aug 2011 07:14:10 -0700 (PDT)
X-AuditID: 11807136-b7c35ae000001055-d3-4e4d210fe3bd
Received: from koseret (koseret.apple.com [17.151.62.39])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay15.apple.com (Apple SCV relay)
 with SMTP id 36.FF.04181.F012D4E4; Thu, 18 Aug 2011 07:26:23 -0700 (PDT)
Received: from [17.153.19.95] (unknown [17.153.19.95])
 by koseret.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTPSA id <0LQ400CKXNJLKJ30@koseret.apple.com> for git@vger.kernel.org;
 Thu, 18 Aug 2011 07:14:10 -0700 (PDT)
X-Mailer: Apple Mail (2.1244.3)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHJMWRmVeSWpSXmKPExsUiON1OXZdf0dfP4MgbBYuuK91MDowenzfJ
	BTBGcdmkpOZklqUW6dslcGVsnryCuWAOW8W3KdMZGxins3YxcnJICJhIXPu3gxnCFpO4cG89
	WxcjF4eQQCeTxI+pW9lBErwCghI/Jt9j6WLk4GAWkJc4eF4WJMwsoCXx/VErC0T9XCaJLV0/
	wIayCWhIfDp1lxmkXlhARWLlPg+QMIuAqkT3uj9MIGFeARuJQ1+EQMIiAuISb4/PZIc4QV5i
	cctnxgmMvLOQLJ6FsHgWksULGJlXMQoWpeYkVhqa6iUWFOSk6iXn525iBIVKQ6HZDsYdf+UO
	MQpwMCrx8Fp89PYTYk0sK67MPcQowcGsJMKrKeLrJ8SbklhZlVqUH19UmpNafIhRmoNFSZz3
	6yegaoH0xJLU7NTUgtQimCwTB6dUA2OCWE6OSJviztUHq+09+yY32+Rt5yqdOsXWS7Ft2vW1
	Zv1LFS8zGCdOFlyTrP3rtvo8E3dlyWDtx3tMrwlcW95iFxw7j1fp/sKrSkUX13ekHjc/GjA9
	7KxRSMqkSbqO3kEbEmOT5+hm3rDmsrr+JCdaUVRZyOe/Fuuprh3c0yPXiZw+/jHhhxJLcUai
	oRZzUXEiAPwsSBwRAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179600>

I have a local git-svn repository that is now in a weird state and would any tips for how to debug this. Thanks!

davez



$ git --version
git version 1.7.6
$ git checkout master
warning: refname 'master' is ambiguous.
Already on 'master'
$ git show-ref | grep master
d510ee7a969c908a20ab8abab08dd3ad09870508 refs/heads/master
$ git svn rebase
warning: refname 'master' is ambiguous.
First, rewinding head to replay your work on top of it...
Fast-forwarded master to refs/remotes/svn/trunk.
error: Ref refs/heads/master is at d510ee7a969c908a20ab8abab08dd3ad09870508 but expected 014cd21f9f6e88e4515ed99c632308a954085a34
fatal: Cannot lock the ref 'refs/heads/master'.
Could not move back to refs/heads/master
rebase refs/remotes/svn/trunk: command returned error: 1

$ 
