From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Sun, 07 May 2006 15:30:15 +0200
Organization: At home
Message-ID: <e3ksoq$is$1@sea.gmane.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net> <87mzdx7mh9.wl%cworth@cworth.org> <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun May 07 15:30:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcjL9-0002Ts-Vy
	for gcvg-git@gmane.org; Sun, 07 May 2006 15:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWEGNaS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 09:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWEGNaR
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 09:30:17 -0400
Received: from main.gmane.org ([80.91.229.2]:6299 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932160AbWEGNaQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 09:30:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FcjKr-0002SV-Sl
	for git@vger.kernel.org; Sun, 07 May 2006 15:30:09 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 May 2006 15:30:09 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 May 2006 15:30:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19702>

Junio C Hamano wrote:

> The vocabulary we would want from the requestor side is probably
> (at least):
> 
>         I WANT to have these
>         I HAVE these
>         I'm MISSING these
>         Don't bother with these this time around (--since, ^v2.6.16, ...)

Wouldn't it be easier (sorry, no code yet) to have the following:

        I WANT to have these
        I HAVE these
        These are GRAFT PARENTLESS        

with the target side sending list of all parentless commits in the
info/grafts file. The source side will then do the grafting 'in memory' and
send the packs like normal, only with those cauterizing grafts in place.

Now I'm waiting for someone to say that it is too simple and cannot be done,
or that shallow clone/shallow fetch uses this method...

-- 
Jakub Narebski
Warsaw, Poland
