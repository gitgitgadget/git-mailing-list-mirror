From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: git rebase -i
Date: Fri, 20 Feb 2009 00:53:37 +0100
Message-ID: <gnkre1$g8s$1@ger.gmane.org>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com> <76718490902191255w24b30bd8jacaed8aa919d6526@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 00:55:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaIjc-0005xS-HF
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 00:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757607AbZBSXxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 18:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757284AbZBSXxt
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 18:53:49 -0500
Received: from main.gmane.org ([80.91.229.2]:47099 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755827AbZBSXxs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 18:53:48 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LaIiB-0002MS-Hw
	for git@vger.kernel.org; Thu, 19 Feb 2009 23:53:47 +0000
Received: from host-78-13-59-64.cust-adsl.tiscali.it ([78.13.59.64])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 23:53:47 +0000
Received: from giuseppe.bilotta by host-78-13-59-64.cust-adsl.tiscali.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 23:53:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: host-78-13-59-64.cust-adsl.tiscali.it
User-Agent: KNode/0.10.9
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110765>

On Thursday 19 February 2009 21:55, Jay Soffian wrote:

> On Thu, Feb 19, 2009 at 4:21 AM, John Tapsell <johnflux@gmail.com> wrote:
>> Hi,
>>
>>  I often do   'git rebase -i HEAD~10'  to rebase.  Since afaics it
>> doesn't matter if you go back 'too far' I just always use HEAD~10 even
>> if it's just for the last or so commit.
>>
>>  Would there be any objections to making  'git rebase -i' default to
>> HEAD~10  or maybe 16 or 20.  Having sensible defaults for commands
>> helps a bit with making it easier to use.
> 
> I think the following might be reasonable to support:
> 
> $ git rebase -i -10
> $ git rebase -i -n -10

This feature gets my vote. I actually gave the implementation a quick try,
but didn't get very far through it. I was actually considering making git
rev-parse support the syntax.

Yes, as remarked by Johannes there are issue when there are merges in between
(in which case -10 is most likely not the same as HEAD~10), but I would say
that this is in no way a good reason to deprive users from the comfort it can
give in most common situations.

-- 
Giuseppe "Oblomov" Bilotta
