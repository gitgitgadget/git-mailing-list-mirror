From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git reset --hard <commit> superfluous?
Date: Sat, 3 Jan 2009 06:34:04 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnglu1ms.63u.sitaramc@sitaramc.homelinux.net>
References: <20090103011319.GA24149@seberino.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 03 07:35:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJ06q-0002Qo-Vo
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 07:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbZACGeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 01:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbZACGeW
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 01:34:22 -0500
Received: from main.gmane.org ([80.91.229.2]:57244 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbZACGeW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 01:34:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LJ05R-0007GN-2T
	for git@vger.kernel.org; Sat, 03 Jan 2009 06:34:17 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Jan 2009 06:34:17 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Jan 2009 06:34:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104456>

On 2009-01-03, chris@seberino.org <chris@seberino.org> wrote:
> git reset --hard <commit>
> "resets" the current branch head.
>
> Is this equivalent to deleting the branch
> and doing
>
> git branch <branch> <commit> ??
>
> So "git reset --hard" is syntactic sugar and 'unnecessary' right?

only if you don't have any local changes to the work tree or
the index :-)

If you do, however, the reset throws them away, while the
longer method tries to preserves them, to the point of not
letting you switch if there are too many changes.
