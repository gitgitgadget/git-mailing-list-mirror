From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: "git add $ignored_file" fail
Date: Wed, 17 May 2006 00:41:34 +0200
Organization: At home
Message-ID: <e4dkes$8e7$1@sea.gmane.org>
References: <8aa486160605161507w3a27152dq@mail.gmail.com> <Pine.LNX.4.64.0605161526210.16475@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed May 17 00:42:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg8F4-0002q1-9u
	for gcvg-git@gmane.org; Wed, 17 May 2006 00:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWEPWmL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 18:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWEPWmK
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 18:42:10 -0400
Received: from main.gmane.org ([80.91.229.2]:35510 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932228AbWEPWmJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 18:42:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fg8Ec-0002h0-3l
	for git@vger.kernel.org; Wed, 17 May 2006 00:41:46 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 May 2006 00:41:46 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 May 2006 00:41:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20144>

Linus Torvalds wrote:

> Well, the thing is, git-add doesn't really take a "file name", it takes a 
> filename _pattern_.
> 
> Clearly we can't add everything that matches the pattern, because one 
> common case is to add a whole subdirectory, and thus clearly the 
> .gitignore file must override the pattern.
> 
> So it's consistent that it overrides it also for a single filename case, 
> no?

Well, if shell expansion cannot find a file matching pattern, it uses
pattern as file name literaly.

It would be nice to have easy (git core porcelain level) way to add files
which match ignore pattern.

-- 
Jakub Narebski
Warsaw, Poland
