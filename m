From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: (topgit question) deleting a dependency
Date: Tue, 28 Apr 2009 14:12:31 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngve3mf.f45.sitaramc@sitaramc.homelinux.net>
References: <slrngvdgo4.kr7.sitaramc@sitaramc.homelinux.net>
 <20090428094138.GB9415@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 16:13:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyo3V-0005xb-LL
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 16:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630AbZD1OMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 10:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754182AbZD1OMt
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 10:12:49 -0400
Received: from main.gmane.org ([80.91.229.2]:35559 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbZD1OMt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 10:12:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lyo3D-0005PV-3E
	for git@vger.kernel.org; Tue, 28 Apr 2009 14:12:47 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 14:12:47 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 14:12:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117775>

On 2009-04-28, martin f krafft <madduck@madduck.net> wrote:

>> I know "tg depend" only has the "add" subcommand right now,
>> but is there a manual way of getting the effect of a
>> hypothetical "tg depend remove"?
>
> No, not yet, see http://bugs.debian.org/505303 for further
> discussion on the issue.

Yes, I'd seen that on a google search, and it made my head
hurt :-)  (My fault, not theirs...!)

I was latching onto the last line of that email: "Maybe in
your case this could be even simpler but this should be the
general process".

My situation _should_ be the simplest.  Every topgit branch
starts off from master, and they're all notionally
independent of each other.  As long as they're here, they're
"cooking", all together, in a branch called t/all.

When one branch is deemed to be cooked, a "tg export" takes
that code to master, and I intend to delete t/all and create
it afresh with the rest of the dependencies (the old set
minus the one that finished cooking).

I was hoping to hear if anyone sees any red flags in that
strategy.

Thanks again,

Sitaram
