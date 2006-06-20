From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Tue, 20 Jun 2006 20:34:38 +0200
Organization: At home
Message-ID: <e79f3p$jcc$1@sea.gmane.org>
References: <e79921$u0e$1@sea.gmane.org> <87r71jspeo.wl%cworth@cworth.org> <e79c8t$8sd$1@sea.gmane.org> <20060620175505.GR2609@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jun 20 20:35:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsl4D-0003cU-0c
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 20:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWFTSfF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 14:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWFTSfF
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 14:35:05 -0400
Received: from main.gmane.org ([80.91.229.2]:4018 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750753AbWFTSfD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 14:35:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fsl3t-0003Yr-I3
	for git@vger.kernel.org; Tue, 20 Jun 2006 20:34:53 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 20:34:53 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 20:34:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22217>

Petr Baudis wrote:

> Dear diary, on Tue, Jun 20, 2006 at 07:46:11PM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...
>> Add to that the fact that above needs some support from web server
>> (e.g. Apache's mod_rewrite) and web server configuration, while gitweb tries
>> to be server agnostic...
> 
> Nope, you get the stuff in $PATH_INFO. And having at least just the
> project name in the path part would be quite nice, it's my common gripe
> with cvsweb as I frequently get to mangle with the query part manually
> (can be much faster than clicking around) and I have to carefully evade
> the project name part, which is something I would really expect to be in
> the "static" part of the URL.

But without web server support I think you would need one copy/symbolic link
per repository served.

> When we are talking about URLs, it would be quite nice if the query
> parameter names would be actually meaningful instead of some cryptic
> 'h', 'pg' and whatnot.

I guess that is because hash values are somewhat long (40 characters wide),
so one letter parameter names were chosen to shorten URL.

Dictionary:
 'a'  - action (e.g. summary, log, commitdiff, blob, tree)
 'o'  - order by (for sorting tables)
 'p'  - project (might include category/directory: cogito/cogito.git, 
        git/git.git, git/gitk.git)
 'f'  - filename (I plan to move it before hash-valued parameters, 
        perhaps except hb which usually is symbolic) 
 'pg' - page
 's'  - searchtext (shouldn't it be 'q', from querystring?)
 'h'  - hash
 'hp' - hash parent (not used yet I think)
 'hb' - hash base (i.e. head or tag; underused I think)

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
