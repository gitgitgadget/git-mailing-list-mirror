From: Stefan =?utf-8?b?TsOkd2U=?= <stefan.naewe+git@gmail.com>
Subject: Q. regarding subtree merge
Date: Fri, 18 Apr 2008 09:36:30 +0000 (UTC)
Message-ID: <loom.20080418T091729-407@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 00:45:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jmn5V-00045P-Tu
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 11:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219AbYDRJkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2008 05:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754193AbYDRJkL
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 05:40:11 -0400
Received: from main.gmane.org ([80.91.229.2]:48820 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754178AbYDRJkL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2008 05:40:11 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Jmn4c-0001jl-II
	for git@vger.kernel.org; Fri, 18 Apr 2008 09:40:02 +0000
Received: from lxsrv96.atlas.de ([194.156.172.86])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Apr 2008 09:40:02 +0000
Received: from stefan.naewe+git by lxsrv96.atlas.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Apr 2008 09:40:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.156.172.86 (Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79868>

Hi all.

I tried the scenario described in 
$GIT_DIR/Documentation/howto/using-merge-subtree.txt and have some problems 
with it.

My setup:

I use git to track my changes in three different "project directories", lets
say:

...../src_root/libfoo
...../src_root/appbar
...../bin_root/installed

All three git repositories contain a topic branch (lets say 'current-work')
that I want to track. 

Now I want to setup one git repository containing only the three directories
'libfoo', 'appbar', and 'installed' that others can clone easily. Reading the
above howto document, I think this should be possible. 

I do:

  $ mkdir super-prj 
  $ cd super-prj 
  $ git init
  $ git add remote -f libfoo ../path/to/src_root/libfoo

OK. No problem. 

The problem arises after the second step of the howto:

  $ git merge -s ours --no-commit libfoo/current-work

Now, all files of 'libfoo' are in the current directory. This is not what I 
want.

Could someone please tell me what I'm doing wrong?

Thanks

Stefan
