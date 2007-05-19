From: david@lang.hm
Subject: Re: Smart fetch via HTTP?
Date: Fri, 18 May 2007 17:50:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0705181742470.20116@asgard.lang.hm>
References: <20070515201006.GD3653@efreet.light.src> <20070517124006.GO4489@pasky.or.cz>
 <vpqlkfnipjl.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705181123590.3890@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 19 02:51:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpDAk-0007jN-QW
	for gcvg-git@gmane.org; Sat, 19 May 2007 02:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114AbXESAvp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 20:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbXESAvp
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 20:51:45 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:41429
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114AbXESAvo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 20:51:44 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l4J0onEF010754;
	Fri, 18 May 2007 17:50:49 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.LFD.0.98.0705181123590.3890@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47700>

On Fri, 18 May 2007, Linus Torvalds wrote:

> On Thu, 17 May 2007, Matthieu Moy wrote:
>>
>> Many (if not most?) of the people working in a big company, I'd say.
>> Year, it sucks, but people having used a paranoid firewall with a
>> not-less-paranoid and broken proxy understand what I mean.
>
> Well, we could try to support the git protocol over port 80..
>
> IOW, it's probably easier to try to get people to use
>
> 	git clone git://some.host:80/project
>
> and just run git-daemon on port 80, than it is to try to set of magic cgi
> scripts etc.
>
> Doing that with virtual hosts etc should be pretty trivial. Much more so
> than trying to make a git-cgi script.
>
> And yes, I do realize that in theory you can have http-aware firewalls
> that expect to see the normal http sequences in the first few packets in
> order to pass things through, but I seriously doubt it's very common.

they are actually more common than you think, and getting even more common 
thanks to IE

when a person browsing a hostile website will allow that website to take 
over the machine the demand is created for 'malware filters' for http, to 
do this the firewalls need to decode the http, and in the process limit 
you to only doing legitimate http.

it's also the case that the companies that have firewalls paranoid enough 
to not let you get to the git port are highly likely to be paranoid enough 
to have a malware filtering http firewall.

David Lang
