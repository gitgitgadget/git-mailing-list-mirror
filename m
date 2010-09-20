From: <nolan.ring@emc.com>
Subject: svn2git question:  error: unknown switch `t'
Date: Mon, 20 Sep 2010 13:39:41 -0400
Message-ID: <4E10ACF241081344B9702AA8C6440440C5B14FB331@MX01A.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 20 19:40:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxkLw-0005t7-7g
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 19:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372Ab0ITRkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 13:40:23 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:17792 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771Ab0ITRkW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 13:40:22 -0400
Received: from hop04-l1d11-si01.isus.emc.com (HOP04-L1D11-SI01.isus.emc.com [10.254.111.54])
	by mexforward.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id o8KHeK4c021718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 20 Sep 2010 13:40:21 -0400
Received: from mailhub.lss.emc.com (mailhub.lss.emc.com [10.254.221.145]) by hop04-l1d11-si01.isus.emc.com (RSA Interceptor) for <git@vger.kernel.org>; Mon, 20 Sep 2010 13:40:15 -0400
Received: from corpussmtp4.corp.emc.com (corpussmtp4.corp.emc.com [10.254.169.197])
	by mailhub.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id o8KHdg5W008674
	for <git@vger.kernel.org>; Mon, 20 Sep 2010 13:39:44 -0400
Received: from mxhub05.corp.emc.com ([128.221.46.113]) by corpussmtp4.corp.emc.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 20 Sep 2010 13:39:42 -0400
Received: from MX01A.corp.emc.com ([169.254.1.232]) by mxhub05.corp.emc.com
 ([128.221.46.113]) with mapi; Mon, 20 Sep 2010 13:39:42 -0400
Thread-Topic: svn2git question:  error: unknown switch `t'
Thread-Index: AQHLWOrNWRyv6DilqkeryTRaWP4YZg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-OriginalArrivalTime: 20 Sep 2010 17:39:42.0831 (UTC) FILETIME=[CEFA8FF0:01CB58EA]
X-EMM-MHVC: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156642>

All,

I'm running the command svn2git -v --notags --branches REbranches <URL>

and I'm getting the following:

If you want to create a new branch from this checkout, you may do so
(now or later) by using -b with the checkout command again. Example:
  git checkout -b <new_branch_name>
HEAD is now at 38b1da3... Update NEO targets to point to NeoMain kernel
Running command: git branch -t NeoMain@34 remotes/NeoMain@34
error: unknown switch `t'
usage: git branch [options] [-r | -a] [--merged | --no-merged]
   or: git branch [options] [-l] [-f] <branchname> [<start-point>]
   or: git branch [options] [-r] (-d | -D) <branchname>
   or: git branch [options] (-m | -M) [<oldbranch>] <newbranch>

Generic options
    -v, --verbose         be verbose
    --track               set up tracking mode (see git-pull(1))
    --color               use colored output
    -r                    act on remote-tracking branches
    --contains <commit>   print only branches that contain the commit
    --abbrev[=<n>]        use <n> digits to display SHA-1s

Specific git-branch actions:
    -a                    list both remote-tracking and local branches
    -d                    delete fully merged branch
    -D                    delete branch (even if not merged)
    -m                    move/rename a branch and its reflog
    -M                    move/rename a branch, even if target exists
    -l                    create the branch's reflog
    -f                    force creation (when already exists)
    --no-merged <commit>  print only not merged branches
    --merged <commit>     print only merged branches

Where did the -t come from?  What is this telling me?

Thanks much.

Nolan 
