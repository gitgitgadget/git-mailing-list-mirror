From: walt <wa1ter@myrealbox.com>
Subject: Re: git-bisect is magical
Date: Tue, 10 Jan 2006 12:43:05 -0800
Organization: none
Message-ID: <dq168p$3kt$1@sea.gmane.org>
References: <dpuoqf$3rp$1@sea.gmane.org> <Pine.LNX.4.64.0601091516460.5588@g5.osdl.org> <dq11c6$g15$1@sea.gmane.org> <Pine.LNX.4.64.0601101131540.4939@g5.osdl.org> <Pine.LNX.4.64.0601101143180.4939@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 10 21:43:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwQLU-0004r0-2Q
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 21:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbWAJUnb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 15:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWAJUnb
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 15:43:31 -0500
Received: from main.gmane.org ([80.91.229.2]:65261 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932607AbWAJUna (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 15:43:30 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EwQKo-0004gN-4b
	for git@vger.kernel.org; Tue, 10 Jan 2006 21:43:14 +0100
Received: from adsl-69-234-210-171.dsl.irvnca.pacbell.net ([69.234.210.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Jan 2006 21:43:14 +0100
Received: from wa1ter by adsl-69-234-210-171.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Jan 2006 21:43:14 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-210-171.dsl.irvnca.pacbell.net
User-Agent: Mail/News 1.6a1 (X11/20060110)
In-Reply-To: <Pine.LNX.4.64.0601101143180.4939@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14453>

Linus Torvalds wrote:
> 
> On Tue, 10 Jan 2006, Linus Torvalds wrote:
>> You can _undo_ the revert, so it's not permanent in that sense. Just do
>>
>> 	git reset --hard origin
>>
>> and your "master" branch will be forced back to the state that "origin" 
>> was in.
> 
> Btw, you can try this (careful - it will also undo any dirty state you 
> have in your working tree), and then do the "pull" again (which should now 
> be a trivial fast-forward) and then just try to do the "git revert" on the 
> new state.

Just by stumbling around and trying things at random, I did a
'git-checkout origin' which *seemed* to resolve the merge-conflict,
but left me feeling uneasy because I don't really understand what
I'm doing.  Can you give a short explanation of the difference
between 'git reset --hard origin' and 'git-checkout origin'?

> An even better option is obviously to figure out _why_ that commit broke 
> for you in the first place, and get it fixed up-stream...

I'm still waiting for the insulting email from the developer ;o)  How
long should I wait for a response before I start bugging other people?
