From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 2/3] Quoting paths in tests
Date: Mon, 15 Oct 2007 16:03:23 +0200
Message-ID: <86d4vgmq50.fsf@lola.quinscape.zz>
References: <4711486B.1050301@op5.se> <11924540291536-git-send-email-maillist@steelskies.com> <47136F71.1050107@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 16:37:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhQmW-00018R-7d
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 16:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbXJOOSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 10:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbXJOOSN
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 10:18:13 -0400
Received: from main.gmane.org ([80.91.229.2]:48158 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959AbXJOOSL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 10:18:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IhQj4-0006zz-4c
	for git@vger.kernel.org; Mon, 15 Oct 2007 14:15:22 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 14:15:22 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 14:15:22 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:Pqq7o543bMwW9mv9GM54XlF5Qbg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61001>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Jonathan del Strother schrieb:
>> -	svn import -m 'import for git-svn' . $svnrepo >/dev/null &&
>> +	svn import -m 'import for git-svn' . '$svnrepo' >/dev/null &&
>>  	cd .. &&
>>  	rm -rf import &&
>> -	git-svn init $svnrepo"
>> +	git-svn init '$svnrepo'"
>
> I don't see the point in changing an incorrect quoting to a different
> incorrect quoting that you fix up in a follow-up patch. It's *two*
> large patches to review instead of just one. I'm stopping the review
> here.

Since I consider it unlikely that Jonathan is making your life harder
on purpose, it might be somewhat more helpful to offer submission
advice:

Jonathan, try

git rebase -i HEAD~3

or so in order to consolidate the last 3 patches you did.  Interactive
rebase is one useful manner of munging history until it looks
reasonably nice for submission.  One major point of git's distributed
operation is that one can clean up the development history locally
before handing things out.

That makes the project repositories cleaner to understand.

-- 
David Kastrup
