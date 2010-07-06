From: Eric Raible <raible@gmail.com>
Subject: Re: how do I exclude a commit from set of commits to be pushed.
Date: Tue, 6 Jul 2010 19:04:37 +0000 (UTC)
Message-ID: <loom.20100706T205232-421@post.gmane.org>
References: <AANLkTiko8joz_a94QwHwdDwlsjXslu8LdWAnJuvShFFI@mail.gmail.com> <201007031804.33350.johan@herland.net> <AANLkTimmCdCn1dkbogdVqzPBMeGQDNEesM8zdarFL_wv@mail.gmail.com> <201007032239.44639.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 06 21:04:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWDRt-0002A4-LO
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 21:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948Ab0GFTEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 15:04:48 -0400
Received: from lo.gmane.org ([80.91.229.12]:49870 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753209Ab0GFTEr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 15:04:47 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OWDRm-00025e-4q
	for git@vger.kernel.org; Tue, 06 Jul 2010 21:04:46 +0200
Received: from mail.nextest.com ([12.96.234.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 21:04:46 +0200
Received: from raible by mail.nextest.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 21:04:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.96.234.114 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.375.86 Safari/533.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150396>

Johan Herland <johan <at> herland.net> writes:

> 
> On Saturday 03 July 2010, Mahesh Vaidya wrote:
> > git rebase -i $1 && git commit --amend && git rebase --continue
> 
> You would need to do "$1^" instead of $1, since 'rebase' works on all 
> commits _since_ the given commit (i.e. not including the given commit)....

The above will suffice if you just want to change the commit message.
If you want to change file contents you'll need a 'git add' as well.
