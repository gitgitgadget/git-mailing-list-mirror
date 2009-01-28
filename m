From: Alec Clews <alecclews@gmail.com>
Subject: Re: How to install and use a custom merge driver
Date: Wed, 28 Jan 2009 23:31:30 +0000 (UTC)
Message-ID: <loom.20090128T232911-174@post.gmane.org>
References: <497FCC9A.9080008@gmail.com> <20090128061848.GA19165@coredump.intra.peff.net> <loom.20090128T230123-889@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 00:34:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSJv7-0005fy-ES
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 00:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757259AbZA1Xbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 18:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758031AbZA1Xbs
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 18:31:48 -0500
Received: from main.gmane.org ([80.91.229.2]:55045 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002AbZA1Xbr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 18:31:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LSJsj-00047S-U9
	for git@vger.kernel.org; Wed, 28 Jan 2009 23:31:43 +0000
Received: from 203.110.235.131 ([203.110.235.131])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 23:31:41 +0000
Received: from alecclews by 203.110.235.131 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 23:31:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 203.110.235.131 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107599>

Alec Clews <alecclews <at> gmail.com> writes:

> Is there someway to enable logging to see how git is making this choice?


Found the answer to my question.

GIT_MERGE_VERBOSITY=5
GIT_TRACE=true


Which results in

+ git merge --stat del2
trace: built-in: git 'merge' '--stat' 'del2'
Merging:
38f3eb9 Accepting delivery del1
virtual del2
found 1 common ancestor(s):
af9dc93 Creating empty staging repo
Auto-merging src/main.c
CONFLICT (add/add): Merge conflict in src/main.c
Automatic merge failed; fix conflicts and then commit the result.


So I'm none the wiser :-(. Any suggestions from wiser people than I?

Thanks

-Alec
