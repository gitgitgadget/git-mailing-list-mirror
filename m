From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git reset --hard not removing some files
Date: Thu, 01 Jun 2006 19:21:19 +0200
Organization: At home
Message-ID: <e5n7lv$3tl$1@sea.gmane.org>
References: <20060601160052.GK14325@admingilde.org> <BAYC1-PASMTP04B113F61282BAE465D7F0AE900@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jun 01 19:22:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlqsG-0001Nk-SI
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 19:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWFARWR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 13:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWFARWR
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 13:22:17 -0400
Received: from main.gmane.org ([80.91.229.2]:65497 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030244AbWFARWQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jun 2006 13:22:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Flqrp-0001H4-2Y
	for git@vger.kernel.org; Thu, 01 Jun 2006 19:21:53 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Jun 2006 19:21:53 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Jun 2006 19:21:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21120>

Sean wrote:

> On Thu, 1 Jun 2006 18:00:52 +0200
> Martin Waitz <tali@admingilde.org> wrote:
> 
>> $ git reset --hard v1.3.3
>>
>> $ git status
>> # On branch refs/heads/test
>> #
>> # Untracked files:
>> #   (use "git add" to add to commit)
>> #
>> #       git-quiltimport
>> #       git-upload-tar
>> nothing to commit
> 
> Resetting to version 1.3.3 gets you an old version of the .gitignore
> file which doesn't ignore these two untracked files.  Reset --hard
> doesn't remove them because it only deals with tracked files.  Thus,
> they show up in your status report.

Do you think it is _frequently_ asked question, worth adding
to http://git.or.cz/gitwiki/GitFaq ?

-- 
Jakub Narebski
Warsaw, Poland
