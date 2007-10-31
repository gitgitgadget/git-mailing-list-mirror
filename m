From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 01:12:37 +0100
Organization: At home
Message-ID: <fg8h9l$b4n$1@ger.gmane.org>
References: <20071030044026.GA9600@thunk.org> <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org> <20071030053732.GA16963@hermes.priv> <alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org> <20071030160232.GB2640@hermes.priv> <alpine.LFD.0.999.0710301037120.30120@woody.linux-foundation.org> <vpq8x5kh4rr.fsf@bauges.imag.fr> <alpine.LFD.0.999.0710301056070.30120@woody.linux-foundation.org> <4727839B.9070205@obry.net> <alpine.LFD.0.999.0710301232000.30120@woody.linux-foundation.org> <20071030235823.GA22747@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 01:13:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In1D1-00026r-4u
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 01:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbXJaANG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 20:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752965AbXJaANF
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 20:13:05 -0400
Received: from main.gmane.org ([80.91.229.2]:40890 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123AbXJaAND (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 20:13:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1In1CV-00068R-4k
	for git@vger.kernel.org; Wed, 31 Oct 2007 00:12:51 +0000
Received: from abvp82.neoplus.adsl.tpnet.pl ([83.8.213.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Oct 2007 00:12:51 +0000
Received: from jnareb by abvp82.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Oct 2007 00:12:51 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvp82.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62767>

Jeff King wrote:

> On Tue, Oct 30, 2007 at 12:38:27PM -0700, Linus Torvalds wrote:
> 
>> So if you want to follow the RFC, you'd better give a real reason. And no, 
>> the existence of an RFC, and the fact that people use the same name for 
>> things that superficially _look_ the same is not a reason in itself.
>> 
>> So hands up, people. Anybody who asked for RFC quoting. Give a damn 
>> *reason* already!
> 
> I didn't ask for RFC quoting, but a nice side effect of URL syntax is
> that they are machine parseable. If you wanted to write a tool to pick
> the URLs out of this email and clone them as git repos, then how do you
> find the end of:
> 
>   http://host/git repo with spaces in the path
> 
> compared to:
> 
>   http://host/git+repo+with+spaces+in+the+path
> 
> I don't know if that's worth changing anything in git (in fact, I'm not
> even clear on _what_ people want to change; the point of this discussion
> seems to be to argue about terminology). But you did ask for any reason
> for quoting URLs.

You use

  'http://host/git repo with spaces in the path'

Theoretically, we can follow what other CLI tools dealing with URLs do
(like wget, lynx, ...), i.e. assume that URL is _not_ RFC-escaped if it
is in quotes, and assume that URL is properly escaped if it is not quoted.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
