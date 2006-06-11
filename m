From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb.cgi history not shown
Date: Sun, 11 Jun 2006 18:59:15 +0200
Organization: At home
Message-ID: <e6hi4g$k4a$1@sea.gmane.org>
References: <e5bfff550606102231o756f6d11lc46fecdad29568c0@mail.gmail.com> <Pine.LNX.4.64.0606102248360.5498@g5.osdl.org> <e5bfff550606102332v6afb7d51m43ad5d74ba226cf0@mail.gmail.com> <Pine.LNX.4.64.0606110902090.5498@g5.osdl.org> <Pine.LNX.4.64.0606110933040.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Jun 11 18:59:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpTHO-0002up-V2
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 18:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWFKQ7M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 12:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWFKQ7M
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 12:59:12 -0400
Received: from main.gmane.org ([80.91.229.2]:50925 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750773AbWFKQ7L (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 12:59:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FpTHD-0002tT-TH
	for git@vger.kernel.org; Sun, 11 Jun 2006 18:59:03 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Jun 2006 18:59:03 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Jun 2006 18:59:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21664>

Linus Torvalds wrote:


> Btw, this is also why I suggested adding a "--no-simplify-history" flag, 
> because in this case, that's exactly what _you_ want. The reason git is 
> doing something unexpected - and in your case inferior - is exactly that 
> what you want in this case is really not "explain the STATE of this file", 
> but you want "give me ALL THE HISTORY concerning this filename".
[...]
> Btw, the original "git whatchanged -p" answered exactly the question you 
> had, and the semantics changed when we rewrite "git whatchanged" to act 
> like "git log -p". 
[...]
> And I do agree that we should teach "git log" and friends to be able to 
> answer both questions, and that's what my suggested patch (fleshed out 
> properly, of course) should do.

Could we please 'git whatchanged -p' default to the original (before
rewrite) behavior, i.e. ALL THE HISTORY?

-- 
Jakub Narebski
Warsaw, Poland
