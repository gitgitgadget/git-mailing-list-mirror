From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 0/4] gitweb: ViewVC-like "tree_blame" view
Date: Thu, 31 Aug 2006 11:20:53 +0200
Organization: At home
Message-ID: <ed69lm$285$1@sea.gmane.org>
References: <200608310043.12606.jnareb@gmail.com> <20060831082002.GT8856@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 31 11:21:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIijs-0003HM-Pn
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 11:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWHaJVY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 05:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWHaJVY
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 05:21:24 -0400
Received: from main.gmane.org ([80.91.229.2]:53394 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751133AbWHaJVX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 05:21:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GIijT-0003Eq-PU
	for git@vger.kernel.org; Thu, 31 Aug 2006 11:21:07 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 11:21:07 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 11:21:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26247>

Thomas Glanzmann wrote:


>> In response to Thomas Glanzmann (or rather a friend of his) request,
>> here is series of patches which adds to tree view information about
>> when last time and by whom was given file or directory touched. 
> 
> thanks, I bounced the messages to him.

Just to note: this is proof of concept. The final implementation should have
engine written in C, in "core git", like git-blame. Currently this is very
expensive, so I didn't made gitweb with tree_blame available...

BTW. my reply to the first message have link to "screenshot" (saved view of
page to HTML) of the output.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
