From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git rebase -i onto HEAD~n
Date: Tue, 3 Feb 2009 17:18:39 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngogv3e.nak.sitaramc@sitaramc.homelinux.net>
References: <C5E2CAEE4A87D24DAB5334F62A72D1F43ADC9D@ELON17P32001A.csfb.cs-group.com>
 <20090203154457.GA6859@atjola.homenet>
 <C5E2CAEE4A87D24DAB5334F62A72D1F43ADCA0@ELON17P32001A.csfb.cs-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 18:20:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUOwg-0000lA-J5
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 18:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbZBCRS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 12:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbZBCRS4
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 12:18:56 -0500
Received: from main.gmane.org ([80.91.229.2]:60970 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbZBCRS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 12:18:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LUOvC-0001gc-4S
	for git@vger.kernel.org; Tue, 03 Feb 2009 17:18:50 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 17:18:50 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 17:18:50 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108220>

On 2009-02-03, Bisani, Alok <alok.bisani@credit-suisse.com> wrote:
>     # Leave editor for ~/gittest/.git/rebase-merge/git-rebase-todo with
>     squash 8df4c33 two
>     # deleted line with discard
>     squash 91f8267 three
>
>     # And get this error
>     grep: /home/user/gittest/.git/rebase-merge/done: No such file or directory
>     Cannot 'squash' without a previous commit

Quoting from "git help rebase"'s interactive mode section:

    If you want to fold two or more commits into one,
    replace the command "pick" with "squash" for the second
    and subsequent commit.

Keep the first one as "pick", don't make both of them
squash.

-- 
Sitaram

We've long needed a filesystem named after a vegetable --
Andrew Morton
