From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: git-svn tags and branches
Date: Mon, 27 Aug 2007 17:42:36 +0200
Message-ID: <faurcl$p0o$1@sea.gmane.org>
References: <faulrb$483$1@sea.gmane.org> <867inhqaj9.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 17:42:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPgjU-00054v-V7
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 17:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756319AbXH0Pm2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 11:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756039AbXH0Pm1
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 11:42:27 -0400
Received: from main.gmane.org ([80.91.229.2]:56716 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756007AbXH0Pm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 11:42:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPgjO-0007AP-Up
	for git@vger.kernel.org; Mon, 27 Aug 2007 17:42:22 +0200
Received: from host-62-10-78-152.cust-adsl.tiscali.it ([62.10.78.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 17:42:22 +0200
Received: from giuseppe.bilotta by host-62-10-78-152.cust-adsl.tiscali.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 17:42:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-62-10-78-152.cust-adsl.tiscali.it
User-Agent: KNode/0.10.5
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56851>

On Monday 27 August 2007 17:09, David Kastrup wrote:

> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>>
>> Currently, git-svn imports svn tags as lightweight git tags.
> 
> It does?  I see them as branches.

Oh, I thought that them being in refs/remote/tags meant they
were remote tags. But yes, I had noticed them appearing with
git branch -r

>> I was susprised when I discovered this (from 'git describe'
>> failing and some helpful assistance on the IRC channel), so
>> I'm now wondering: is there a technical reason why they
>> aren't converted to annotated tags? If not, would it be
>> possible to implement this in git-svn, possibly with some
>> way to 'fix' existing git-svn repository?
> 
> I actually don't see how one can safely make them tags at all (rather
> than branches) since Subversion does not enforce the members of a
> "tags" subdirectory to remain unchanged after the initial copy.
> Basically, tags are not different from branches in Subversion from
> what you can do with them.

Although this is technically true, I doubt there are many Subversion
projects which alter the members of a tags subdirectory. So the fact
that it's technically possible doesn't really mean it happens.

I mean, even in git you can do some pretty dirty tag stuff. It may
not be as straightforward as in svn, but still ...

So yes, I still think that an option to convert svn tags to annotated
tags would be appropriate. Wether or not it should be default, it's
a different matter, of course.

-- 
Giuseppe "Oblomov" Bilotta
