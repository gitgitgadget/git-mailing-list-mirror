From: Benedikt Schmidt <ry102@rz.uni-karlsruhe.de>
Subject: Re: The criss-cross merge case
Date: Thu, 28 Apr 2005 04:15:05 +0200
Message-ID: <87d5sf7il2.fsf@rzstud4.rz.uni-karlsruhe.de>
References: <42703194.80409@tupshin.com>
	<Pine.LNX.4.21.0504272051390.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Apr 28 04:02:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQyLs-0008KP-VN
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 04:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVD1CGr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 22:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVD1CGr
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 22:06:47 -0400
Received: from main.gmane.org ([80.91.229.2]:35730 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261329AbVD1CGa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 22:06:30 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DQyKO-0008Av-B9
	for git@vger.kernel.org; Thu, 28 Apr 2005 04:00:32 +0200
Received: from port-212-202-52-205.dynamic.qsc.de ([212.202.52.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Apr 2005 04:00:32 +0200
Received: from ry102 by port-212-202-52-205.dynamic.qsc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Apr 2005 04:00:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: port-212-202-52-205.dynamic.qsc.de
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:f6HcD5OQO3xOfNHxT/TiLcXNUfk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Wed, 27 Apr 2005, Tupshin Harper wrote:
>
>> Can you clarify what you mean by darcs' underlying diff not being that
>> great? It seems to function pretty much identically to gnu diff. In what
>> way would you want the underlying diff to be improved?
>
> GNU diff uses an algorithm which is tuned to handle finding the shortest
> diff among a large set of similar-length alternatives while comparing
> files which have a lot of repeated lines. The author of the paper it cites
> is really thinking about diffing DNA sequences or similar things.

AFAIK the paper mentioned in the GNU diff sources [1] is an improvement
to an earlier paper by the same author titled
"A File Comparison Program" - Miller, Myers - 1985.

Can you be more specific why the algorithm is a bad choice (performance,
quality of diff output)?

> It also can't detect content moves, which are a common thing to have, and
> which will be important in the long run, when we're trying to track
> modifications to content which also moved from place to place.

Ok, darcs doesn't handle block moves, so there is no need for an algorithm that
supports them (yet). Is there any free SCM that has support for block moves at
the moment? It seems like clearcase detects them, but I don't know where it
takes advantage of it.

Benedikt

[1] http://citeseer.ist.psu.edu/myers86ond.html

