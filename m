From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Mon, 08 May 2006 06:02:53 +0200
Organization: At home
Message-ID: <e3mfss$rnd$1@sea.gmane.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net> <87mzdx7mh9.wl%cworth@cworth.org> <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net> <e3ksoq$is$1@sea.gmane.org> <7vy7xdgram.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon May 08 06:03:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcwxc-0000uA-4J
	for gcvg-git@gmane.org; Mon, 08 May 2006 06:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWEHECv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 00:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWEHECv
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 00:02:51 -0400
Received: from main.gmane.org ([80.91.229.2]:28094 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932278AbWEHECu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 00:02:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FcwxJ-0000sD-Jb
	for git@vger.kernel.org; Mon, 08 May 2006 06:02:45 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 May 2006 06:02:45 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 May 2006 06:02:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19757>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Wouldn't it be easier (sorry, no code yet) to have the following:
>>
>>         I WANT to have these
>>         I HAVE these
>>         These are GRAFT PARENTLESS
>>
>> with the target side sending list of all parentless commits in the
>> ... The source side will then do the grafting 'in memory' and
>> send the packs like normal, only with those cauterizing grafts in place.
> 
> I think that is essentially the outline of shallow clone
> proposal, except that you have to be careful and take not just
> "parentless" but other grafts (e.g. one that removes one parent
> from a merge commit to pretend that a side branch did not exist)
> into account as well.  I do not remember if I already coded it
> or not -- I might have.

Having grafts file being used for both joining history and cauterizing
history makes re-cauterizing (e.g. changing depth of clone) difficult at
best...

-- 
Jakub Narebski
Warsaw, Poland
