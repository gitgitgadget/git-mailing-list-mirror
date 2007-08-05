From: David Kastrup <dak@gnu.org>
Subject: Re: Terminology question about remote branches.
Date: Sun, 05 Aug 2007 13:38:07 +0200
Organization: Organization?!?
Message-ID: <85tzre8b4w.fsf@lola.goethe.zz>
References: <854pjfin68.fsf@lola.goethe.zz> <20070804092933.aaec6d52.seanlkml@sympatico.ca> <85ejijgzzg.fsf@lola.goethe.zz> <20070805100532.GG12507@coredump.intra.peff.net> <85172807-B7EB-47DD-813E-FAF5894E1190@zib.de> <20070805110200.GA18083@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 13:42:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHeVC-0005Am-27
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 13:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212AbXHELm0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 07:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbXHELm0
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 07:42:26 -0400
Received: from main.gmane.org ([80.91.229.2]:39986 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974AbXHELmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 07:42:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IHeUK-0000CX-Qn
	for git@vger.kernel.org; Sun, 05 Aug 2007 13:41:37 +0200
Received: from dslb-084-061-057-031.pools.arcor-ip.net ([84.61.57.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Aug 2007 13:41:36 +0200
Received: from dak by dslb-084-061-057-031.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Aug 2007 13:41:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-057-031.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:jPOLlAdJA8onXu1xtplWWeKFw+w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54997>

Jeff King <peff@peff.net> writes:

> On Sun, Aug 05, 2007 at 12:56:49PM +0200, Steffen Prohaska wrote:
>
>> beyond my imagination that I could have a local following/automerging
>> branch that is directly referring to a branch in a remote repo, without
>> have a remote-tracking branch.
>>
>> How could I create such a setup in the first place?
>>
>>     git branch --track something origin/something
>>     git checkout --track -b something origin/something
>>
>> are obvious, but what to say if I don't have origin/something?
>
> I believe the --track setup uses the tracking branches to figure out
> which remote/branch combo to track. To do it without a remote tracking
> branch, you would have to add the lines to your .git/config manually.

Fascinating, really fascinating.  Is there actually _anybody_ who
would not revert to phrases like "I believe" when describing git's
interaction with remote branches?

I don't find this particularly logical: origin/something basically
boils down referring to a commit.

Maybe git-branch --track should allow referring to remote:branch or
URLs or something directly rather than a remote tracking branch?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
