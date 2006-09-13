From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 23:09:33 +0200
Organization: At home
Message-ID: <ee9s1r$c4o$2@sea.gmane.org>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com> <20060913152451.GH23891@pasky.or.cz> <Pine.LNX.4.63.0609131729500.19042@wbgn013.biozentrum.uni-wuerzburg.de> <7vmz93a9v9.fsf@assigned-by-dhcp.cox.net> <ee9jv6$ga0$1@sea.gmane.org> <7vbqpja8wz.fsf@assigned-by-dhcp.cox.net> <ee9mff$qd1$1@sea.gmane.org> <7vhczb7ay9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 13 23:09:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNbzK-0007nw-IO
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 23:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWIMVJk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 17:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWIMVJj
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 17:09:39 -0400
Received: from main.gmane.org ([80.91.229.2]:30083 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751204AbWIMVJj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 17:09:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GNbz4-0007kM-R5
	for git@vger.kernel.org; Wed, 13 Sep 2006 23:09:27 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 23:09:26 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 23:09:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26947>

Junio C Hamano wrote:

> I'll try to code the one specified by the original strawman up
> sometime today; we can discuss enhancements after that.

I was thinking about implementing git-show-refs, "borrowing" format
parsing part from rpm (parseFormat function in rpmdb/header.c), but
what I had not found in core git was the function which parses object
into any_object like union; there is function which parses object,
but it extracts and returns only the common part as an object struct. 
And any_object union is local to object.c

I also thought that if format doesn't require object parsing (sha1id,
type, name and size we can get without parsing) then do not do parsing,
but I wonder if this is really worth it.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
