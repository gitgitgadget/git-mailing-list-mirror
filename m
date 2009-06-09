From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Merge into locally modified files?
Date: Tue, 9 Jun 2009 00:46:20 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnh2rc6s.s8o.sitaramc@sitaramc.homelinux.net>
References: <2729632a0906081030k5048cb27p6950a0decaa7396a@mail.gmail.com>
 <200906082022.09936.johan@herland.net>
 <2729632a0906081214q43e45ce7p812bd02f34934691@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 02:46:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDpUB-0004zT-06
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 02:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbZFIAqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 20:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbZFIAqe
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 20:46:34 -0400
Received: from main.gmane.org ([80.91.229.2]:55618 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbZFIAqd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 20:46:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MDpU3-0002Bm-KN
	for git@vger.kernel.org; Tue, 09 Jun 2009 00:46:35 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 00:46:35 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 00:46:35 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121135>

On 2009-06-08 19:14:38, skillzero@gmail.com <skillzero@gmail.com> wrote:

> Is this something that would be pretty easy to add to git pull (or I
> guess really to git merge since pull is just fetch+merge)? Maybe
> something like a 'git pull --rebase-local'? If I wanted to add

I'd just use an alias.  Either a bash alias like
    alias cvsup='git stash && git pull && git stash pop'
or a git alias like
    git config --global alias.cvsup '!git stash && git pull && git stash pop'

The latter is probably better aesthetically, and you'd call
it by saying "git cvsup".

Far cleaner than patching git-pull, no?
