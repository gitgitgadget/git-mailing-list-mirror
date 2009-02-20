From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: merge smart enough to adapt to renames?
Date: Fri, 20 Feb 2009 00:36:07 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngprunn.hbo.sitaramc@sitaramc.homelinux.net>
References: <81bfc67a0902182212h578e677ck6029c56cb86f7bce@mail.gmail.com>
 <slrngpqquq.j03.sitaramc@sitaramc.homelinux.net>
 <81bfc67a0902191158x5f0f92d1p7e4af2f9cda50a12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 01:37:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaJOo-0000tR-K2
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 01:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758587AbZBTAgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 19:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758830AbZBTAgX
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 19:36:23 -0500
Received: from main.gmane.org ([80.91.229.2]:41384 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758802AbZBTAgW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 19:36:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LaJNK-0003rx-PT
	for git@vger.kernel.org; Fri, 20 Feb 2009 00:36:18 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 00:36:18 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 00:36:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110774>

On 2009-02-19, Caleb Cushing <xenoterracide@gmail.com> wrote:
>> Yes.  I maintain two copies of something (in different
>> repos) like this...
>
> nice... now the real kicker if I merge from another branch
> sunrise/reviewed and redirect it's package.mask to
> package.mask/sunrise will git be smart enough to differentiate from
> the gentoo.org one and the sunrise one? I think even more important is
> how would I even tell it to do that once I've moved the first one.

Not sure I understood this completely, but I've found it
helps to make the rename/move as a separate commit, then
start changing stuff.  In other words, do too many things in
the same commit, and you could lose this coolness.

There's some logic somewhere that says "if we can't find a
match to merge this file, let's see if we ever had the same
blob as the parent of the file in the MERGE_HEAD and we'll
use that as a base to do the merge".
