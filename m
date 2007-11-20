From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git in a Nutshell guide
Date: Wed, 21 Nov 2007 00:57:28 +0100
Organization: At home
Message-ID: <fhvs95$5qk$1@ger.gmane.org>
References: <1195477504.8093.15.camel@localhost> <fhsc7b$k4g$1@ger.gmane.org> <1195488877.10573.29.camel@localhost> <3057F6F3-BEAA-447A-AB79-A0AFB7DB8826@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 00:58:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iucyc-0000uk-RF
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 00:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755139AbXKTX5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 18:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752923AbXKTX5l
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 18:57:41 -0500
Received: from main.gmane.org ([80.91.229.2]:35357 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507AbXKTX5k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 18:57:40 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IucyC-0004n1-MC
	for git@vger.kernel.org; Tue, 20 Nov 2007 23:57:32 +0000
Received: from abvf224.neoplus.adsl.tpnet.pl ([83.8.203.224])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Nov 2007 23:57:32 +0000
Received: from jnareb by abvf224.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Nov 2007 23:57:32 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvf224.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65582>

Benoit Sigoure wrote:

> On Nov 19, 2007, at 5:14 PM, Jonas Juselius wrote:
>> On Mon, 2007-11-19 at 17:05 +0100, Jakub Narebski wrote:
>>> Do I understand correctly that you don't support cloning via git://
>>> protocol?
>>
>> Yes, that is correct. The machine is behind a number of firewalls,  
>> and I simply cannot be bothered to go through the bureaucracy...
> 
> You can create a repository on repo.or.cz then :)

Which can then function as a mirror.

> One of the things you said in your guide is that Git is easy to  
> learn.  I think this is wrong.  Git is way more complicated than most  
> other SCMs, especially compared to SVN.  Its documentation is far  
> behind, compared to what other SCMs have.  There is no real user  
> guide 

What about "Git User's Manual"?

> and the man pages are incomplete, at best.  I know saying this   
> is a bit harsh, especially to the people out there that are working  
> and sending patches to improve the documentation, but I think we have  
> to admit that it's true, even though Git is making progress on this  
> aspect.

That's sadly true, and confirmed (somewhat) by the fact that both in 2006
user's survey and in 2007 survey (see Git Wiki for summaries) one of more
common requests are for "better documentation" and "The Git Book" (showing
svnbook and hgbook as examples).

[cut]

I think that writing proper "Git Guide" aka "The Git Book" is hard because
of some things:

 1. Git has many useful advanced features. Describing those advanced
    features is not easy. For example git uses multiple branches in single
    repository paradigm freely, which makes learning curve a bit steeper;
    IIRC hgbook describes one branch per repos situation (at least at
    beginning), which is easier.

 2. Git has some historical cruft, including the fact that it began as
    series of low level tools (plumbing) and became proper SCM (acquired
    proper porcelain) later, what can be even now seen in documentation...

 3. Explanation of some features (like object model) would be much easier
    with some graphics (diagrams etc.), but chosen documentation format,
    AsciiDoc, doesn't make it easy...

Yust my 2 eurocents.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
