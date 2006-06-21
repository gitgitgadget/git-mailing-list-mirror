From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Wed, 21 Jun 2006 16:52:49 +0200
Organization: At home
Message-ID: <e7bmfn$m7u$1@sea.gmane.org>
References: <e79921$u0e$1@sea.gmane.org> <87r71jspeo.wl%cworth@cworth.org> <e79c8t$8sd$1@sea.gmane.org> <20060620175505.GR2609@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jun 21 16:53:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft44j-0005XN-I7
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 16:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWFUOw6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 10:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWFUOw6
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 10:52:58 -0400
Received: from main.gmane.org ([80.91.229.2]:8660 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932120AbWFUOw5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 10:52:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ft44U-0005U7-9y
	for git@vger.kernel.org; Wed, 21 Jun 2006 16:52:46 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jun 2006 16:52:46 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jun 2006 16:52:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22276>

Petr Baudis wrote:

> Nope, you get the stuff in $PATH_INFO. And having at least just the
> project name in the path part would be quite nice, it's my common gripe
> with cvsweb as I frequently get to mangle with the query part manually
> (can be much faster than clicking around) and I have to carefully evade
> the project name part, which is something I would really expect to be in
> the "static" part of the URL.

What about the patch I just sent:  "[PATCH] gitweb: Make use of $PATH_INFO
for project parameter" (<11509012742493-git-send-email-jnareb@gmail.com>)?

It doesn't as of yet make use of that.

I wonder if this solution would work for mod_perl, or one would need some
Apache-specific package...

P.S. I meant to sent the patch as reply to this mail. Oops.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
