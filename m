From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] add --remote option to git-clone.
Date: Sat, 03 Feb 2007 10:06:44 +0100
Organization: At home
Message-ID: <eq1j8i$rtv$1@sea.gmane.org>
References: <Pine.LNX.4.63.0702020028540.18776@wbgn013.biozentrum.uni-wuerzburg.de> <20070201234706.GP17617@mellanox.co.il> <Pine.LNX.4.63.0702020050190.18870@wbgn013.biozentrum.uni-wuerzburg.de> <7vmz3xmju9.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702021146440.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vmz3wdjxu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 03 10:05:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDGq3-0004PN-BP
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 10:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946410AbXBCJFf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 04:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946411AbXBCJFe
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 04:05:34 -0500
Received: from main.gmane.org ([80.91.229.2]:50752 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946410AbXBCJFc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 04:05:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HDGpr-0007Ul-IT
	for git@vger.kernel.org; Sat, 03 Feb 2007 10:05:27 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 10:05:27 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 10:05:27 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38556>

Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> On Thu, 1 Feb 2007, Junio C Hamano wrote:
>> ...
>>> I am not against the general idea of tracking a subset of
>>> branches, but issues include:
>>>
>>> [explains why git-remote is a better place for this]
>>
>> Seeing your patch to git-remote, it feels more natural, too. Especially 
>> since that (or which? :-D) does not give the term "clone" a 
>> Microsoft'esque completely new meaning.
> 
> I did not find anything MS'esque in what MST did in his patch,
> though.  I think it is a reasonable thing to ask for from a
> clone.  For example, if you are coming from CVS or have used
> Cogito, cloning a single branch is not an unusual operation at
> all.

But when we clone whole repository we could have download whole
object database of cloned repo as-is (perhaps packing loose objects
in smart/git-aware transports).

By the way, there was discussed idea about marking pu-like branches
as being rewound (non-fast forwarding) in the config file, and somehow
transferring this information for git-clone for it to have '+' for
some refspecs. What happened to that idea? Was it abandoned because
reflogs are now enabled by default, are protected from pruning, and
it is easy to recover from accidental non-fast forward fetch which
shouldn't be?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
