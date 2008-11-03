From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI revamp
Date: Mon, 03 Nov 2008 10:48:41 +0100
Organization: At home
Message-ID: <gemhdp$lev$1@ger.gmane.org>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz> <20081031003154.GA5745@sigill.intra.peff.net> <7v3ai9226q.fsf@gitster.siamese.dyndns.org> <1225691960.20883.41.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 10:50:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kww4Z-00075k-IM
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 10:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870AbYKCJs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 04:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754652AbYKCJs6
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 04:48:58 -0500
Received: from main.gmane.org ([80.91.229.2]:36462 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754635AbYKCJs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 04:48:57 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kww3E-0002KZ-GV
	for git@vger.kernel.org; Mon, 03 Nov 2008 09:48:48 +0000
Received: from abvp247.neoplus.adsl.tpnet.pl ([83.8.213.247])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 09:48:48 +0000
Received: from jnareb by abvp247.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 09:48:48 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvp247.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99923>

Sam Vilain wrote:
> On Sun, 2008-11-02 at 14:27 -0800, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>>>> +  * 'git push --matching' does what 'git push' does today (without
>>>> +    explicit configuration)
>>>
>>> I think this is reasonable even without other changes, just to override
>>> any configuration.
>> 
>> I don't.  Can't you say "git push $there HEAD" these days?  I vaguely
>> recall that there is a way to configure push that way for people too lazy
>> to type "origin HEAD" after "git push".
> 
> I don't think it's about laziness, it's more about making sure that
> without specifying behaviour, the action of the command is conservative.
> Pushing all matching refs is not conservative; it's "magic".  And in my
> experience, people get bitten by it, because they think, "ok, time to
> push this branch", type "git push" and then a lot more than they
> expected gets pushed.
> 
> I can see that some people want this behaviour by default; but to me
> "push the current branch back to where it came from" seems like far more
> a rational default for at least 90% of users.

"git remote <remote> push" for push matching?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
