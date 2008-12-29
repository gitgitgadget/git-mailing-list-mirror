From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: user manual question
Date: Mon, 29 Dec 2008 17:27:59 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngli24v.8cd.sitaramc@sitaramc.homelinux.net>
References: <gj7mmo$fvk$4@ger.gmane.org>
 <slrnglf3qh.c7j.sitaramc@sitaramc.homelinux.net>
 <gj96pl$885$4@ger.gmane.org>
 <slrnglg90m.olt.sitaramc@sitaramc.homelinux.net>
 <gjauel$94s$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 18:33:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHLzL-0003ne-GQ
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 18:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbYL2R2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 12:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbYL2R2R
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 12:28:17 -0500
Received: from main.gmane.org ([80.91.229.2]:50602 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbYL2R2R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 12:28:17 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHLuV-0002dD-Eh
	for git@vger.kernel.org; Mon, 29 Dec 2008 17:28:11 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 17:28:11 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 17:28:11 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104117>

On 2008-12-29, Zorba <cr@altmore.co.uk> wrote:
> so a detached HEAD is just a HEAD that is not sitting on a tip ?

yes...

> i.e. if I do $ git reset --hard HEAD^
>
> ...pointing HEAD to the previous committ
>
> this is a detached HEAD

...but no.  This is because git reset moves the tip of the
branch also (in this case, backward by one commit from the
previous).  In effect, you're saying "discard my latest
commit and roll back by one".

"git checkout HEAD^" would get you a detached head though.
In this case you're saying "let the branch be where it is,
but let HEAD move up one level".  So HEAD is now NOT at a
tip, and it'a a detached head.

It's instructive to run "gitk --all" when you're doing these
experiments sometimes.

> (I thought a detached HEAD was maybe a head somewhere on another branch not 
> "reachable", i.e. a sibling, not a ancestor...
> or something like that)

no no that's just another branch that's all.

All this is pretty confusing in the beginning, but if you
don't lose your head, it'll all become clear eventually.

[What's that they say?  Oh yeah "thank you ladies and
gentlemen I'll be here all night"!]
