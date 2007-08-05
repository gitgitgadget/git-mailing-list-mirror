From: David Kastrup <dak@gnu.org>
Subject: Re: Terminology question about remote branches.
Date: Sun, 05 Aug 2007 17:09:59 +0200
Message-ID: <85ps226mrc.fsf@lola.goethe.zz>
References: <854pjfin68.fsf@lola.goethe.zz>
	<7v8x8qfnev.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0708051519400.7631@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sun Aug 05 17:10:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHhk8-0001Mi-Oo
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 17:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248AbXHEPKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 11:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755163AbXHEPKE
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 11:10:04 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:53677 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755107AbXHEPKD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 11:10:03 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 49DA918B4C9;
	Sun,  5 Aug 2007 17:10:01 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 36F15ABE0E;
	Sun,  5 Aug 2007 17:10:01 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id E25FC2351A3;
	Sun,  5 Aug 2007 17:10:00 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id D8A4C1C3D500; Sun,  5 Aug 2007 17:09:59 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0708051519400.7631@beast.quantumfyre.co.uk> (Julian Phillips's message of "Sun\, 5 Aug 2007 15\:23\:12 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3862/Sun Aug  5 15:38:34 2007 on mail-in-10.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55032>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> On Sun, 5 Aug 2007, Junio C Hamano wrote:
>>
>> I think we have a brief discussion on #git before you brought
>> this up ;-)
>>
>> - local branches -- we know what they are.
>>
>> - remote tracking branches -- refs that appear in refs/remotes/
>>   in the current world order; they are updated only by copying
>>   the corresponding local branches at the remote site, and are
>>   meant to "keep track of what _they_ are doing".  In olden
>>   days before 1.5.0 with non separate remote layout,
>>   'refs/heads/origin' branch, and all the non default branches,
>>   were treated this way as well.  You were not supposed to make
>>   commit on them (because of the above "keep track of" reason),
>>   and having them under refs/heads were too confusing, which
>>   was the reason the separate remote layout was invented.
>>
>> You can have a local branch that is created by forking off of a
>> remote tracking branch, with the intention to "build on top" of
>> the corresponding remote tracking brach.  You can create such a
>> branch and mark it as such with --track option introduced in
>> v1.5.1 timeperiod.  This is a relatively new concept, but many
>> people find it useful.  We do not have the official term to call
>> this concept, and some people have misused the term "remote
>> tracking branches" to describe this, which made things very
>> confusing.
>>
>> We would need an official terminology for it.
>
> Following was mentioned earlier in this thread ... could we use that?
>
> tracking branch:
>   ref always points at a commit from the remote repo branch
>
> following branch:
>   ref either points at a commit from the remote repo branch, or a
>   local commit with a commit from the remote repo branch in the history
>
> perhaps?

An auto-merging branch?  The term is somewhat more technical so that
people are less likely to think it just a colloquial alternative
expression for "tracking".

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
