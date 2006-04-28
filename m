From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Two gitweb feature requests
Date: Fri, 28 Apr 2006 21:11:17 +0200
Organization: At home
Message-ID: <e2tpbc$ped$1@sea.gmane.org>
References: <1146144425.11909.450.camel@pmac.infradead.org> <e2tjqm$83n$1@sea.gmane.org> <Pine.LNX.4.64.0604281116020.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Apr 28 21:11:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZYMz-0001Wv-8d
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 21:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbWD1TLD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 15:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWD1TLD
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 15:11:03 -0400
Received: from main.gmane.org ([80.91.229.2]:41417 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751794AbWD1TLB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Apr 2006 15:11:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FZYMa-0001SG-HN
	for git@vger.kernel.org; Fri, 28 Apr 2006 21:10:48 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Apr 2006 21:10:48 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Apr 2006 21:10:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19286>

Linus Torvalds wrote:

> On Fri, 28 Apr 2006, Jakub Narebski wrote:
>>
>> I'd like to have 'parent directory' link for trees ('..' link) at the top
>> of it's contents. I know it is possible to use browser history for that,
>> but it would give greater similarity with 'directory listing' mode of WWW
>> servers.
> 
> Well, a git "tree" doesn't actually _have_ a parent. It potentially has
> multiple.

I have forgot about that. Sorry for the noise, then.

[...]

> So you do need that "browser history" one way or another. Either in the
> browser (use the "back button") or by encoding the "how did we get here"
> information in the URI and the dynamically generated page content.

Or use JavaScript via <a href="javascript:history.go(-1)">..</a>
But that wouldn't help me, because when I open the link in new window (new
tab), the new window (new tab) doesn't inherit history from parent... so
browser's "back" button doesn't work. Ah, well...

> The downside is that you'd have two different web-pages for the same tree
> depending on which commit it came from. Which is not a downside from a
> user perspective, but it's a downside from a caching/server perspective,
> since it means less reuse of pages (maybe gitweb already does that,
> though).

Perhaps if "how we get there" information was encoded via POST... but I
don't know if there would be the difference in caching c.f. GET (encoding
in URI).

-- 
Jakub Narebski
Warsaw, Poland
