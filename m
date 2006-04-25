From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and other commit links ideas)
Date: Tue, 25 Apr 2006 21:00:48 +0200
Organization: At home
Message-ID: <e2lrk5$ed5$1@sea.gmane.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain> <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604250811230.3701@g5.osdl.org> <Pine.LNX.4.64.0604250833540.3701@g5.osdl.org> <e2lijt$aco$1@sea.gmane.org> <Pine.LNX.4.64.0604251004410.3701@g5.osdl.org> <BAYC1-PASMTP091348C4C33C5A0E83C012AEBF0@CEZ.ICE> <Pine.LNX.4.64.0604251106400.3701@g5.osdl.org> <BAYC1-PASMTP04D82622D9D5DA7E352079AEBF0@CEZ.ICE> <Pine.LNX.4.64.0604251125010.3701@g5.osdl.org> <e2lqf1$a5k$1@sea.gmane.org> <Pine.LNX.4.64.0604251151350.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Apr 25 21:00:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYSmL-0000vR-Lo
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 21:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWDYTAv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 15:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWDYTAv
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 15:00:51 -0400
Received: from main.gmane.org ([80.91.229.2]:15272 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751385AbWDYTAu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 15:00:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FYSm1-0000qe-8A
	for git@vger.kernel.org; Tue, 25 Apr 2006 21:00:33 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 21:00:33 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 21:00:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19170>

Linus Torvalds wrote:

> 
> 
> On Tue, 25 Apr 2006, Jakub Narebski wrote:
>> 
>> Additionally, in "related" links we require that object exist (core git),
>> regardless of detailed semantics.

And history browsers (gitk, qgit) can use it, drawing line, regardless of
semantics.

> And as I've now mentioned a hundred times, that's just unacceptable to me.
> No suggested use of this has actually been useful, that I can tell.

I don't mean we shouldn't define semantic for each use of "related" or
"note" header. Just like email X-* headres have detailed form and semantic
(long, long time ago Sender was X-Sender for example ;-). It's just a
toolkit.

As to suggested "related" (requiring object to exists) headers: "bind",
"prior", and perhaps "revert".

-- 
Jakub Narebski
Warsaw, Poland
