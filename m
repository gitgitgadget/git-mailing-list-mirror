From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/git-reset.txt: Use HEAD~N syntax everywhere (unify examples)
Date: Sat, 02 Feb 2008 22:15:20 +0200
Organization: Private
Message-ID: <63x73yjr.fsf@blue.sea.net>
References: <3asc6spe.fsf@blue.sea.net>
	<7v7iho6p2m.fsf@gitster.siamese.dyndns.org>
	<20080202084406.GA15305@glandium.org> <8x235xa8.fsf@blue.sea.net>
	<20080202161813.GA19797@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 21:16:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLOmz-0001qi-Lg
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 21:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760322AbYBBUQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 15:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760454AbYBBUQF
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 15:16:05 -0500
Received: from main.gmane.org ([80.91.229.2]:46348 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760322AbYBBUQD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 15:16:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JLOmN-0003FV-8H
	for git@vger.kernel.org; Sat, 02 Feb 2008 20:15:59 +0000
Received: from a91-155-183-103.elisa-laajakaista.fi ([91.155.183.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 20:15:59 +0000
Received: from jari.aalto by a91-155-183-103.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 20:15:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-183-103.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:uLHOtryk+U5YCikBFWbpyjyk7MM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72301>

* Sat 2008-02-02 J. Bruce Fields <bfields@fieldses.org>
* Message-Id: 20080202161813.GA19797@fieldses.org
> On Sat, Feb 02, 2008 at 02:59:43PM +0200, Jari Aalto wrote:
>> I use HEAD~1 always, because I think the consistency in learning the
>> most important factor.
>> 
>> It does not matter what advanced users use. The documentation should
>> primarily focus the newcomers.
>
> That could have been an argument for disallowing the HEAD^ syntax
> entirely, but it's too late for that.
>
> Even if we eradicated all mention of ^ from the in-tree documentation,
> it would still show up in lots of out-of-tree documentation and
> examples.  So we have to introduce it to newbies.  Fortunately, it isn't
> that hard.
>
> One way we can help them is by continuing to mix the two in examples, so
> let's continue with the current mixture.


Yeah let's continue as usual. And every time you need to explain the
difference, when you could just teach one. The is no doubt that

    HEAD~N

is superior to

    HEAD^^^^^^^^^^^^^^^^^^^^^^^

Count that. Optimizing keystrokes is hardly ever a brilliant idea from
learning perspective.

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
