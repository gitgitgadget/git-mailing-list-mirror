From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: "git add $ignored_file" fail
Date: Wed, 17 May 2006 22:35:55 +0200
Organization: At home
Message-ID: <e4g1f4$anv$1@sea.gmane.org>
References: <8aa486160605161507w3a27152dq@mail.gmail.com> <Pine.LNX.4.64.0605161526210.16475@g5.osdl.org> <8aa486160605161542u704ccf03w@mail.gmail.com> <Pine.LNX.4.63.0605171306400.19012@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0605170604i689a8f7axa5aeb7752dc72072@mail.gmail.com> <8aa486160605170641p2ab8704o@mail.gmail.com> <e4f9eo$b60$1@sea.gmane.org> <1147893786.16654.5.camel@dv> <20060517153903.6b896fdd.seanlkml@sympatico.ca> <1147895816.30618.6.camel@dv> <Pine.LNX.4.64.0605171325200.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed May 17 22:36:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgSkt-0001jF-0Y
	for gcvg-git@gmane.org; Wed, 17 May 2006 22:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWEQUgY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 16:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWEQUgY
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 16:36:24 -0400
Received: from main.gmane.org ([80.91.229.2]:30860 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751092AbWEQUgX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 16:36:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FgSkY-0001gR-7A
	for git@vger.kernel.org; Wed, 17 May 2006 22:36:06 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 May 2006 22:36:06 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 May 2006 22:36:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20241>

Linus Torvalds wrote:

> On Wed, 17 May 2006, Pavel Roskin wrote:

>> [...] implementation should be easy - if the file
>> is present, but git-ls-file doesn't show it, tell the user to
>> adjust .gitignore or to use some flag like --force.
> 
> Umm. That's exactly the semantics for "git add" right now. We _always_ 
> respect the ignore rules.
> 
> That was what people were complaining about.
> 
> Although I think Santi realized why we do it, and isn't even complaining 
> any more. 
> 
> So we're all good again.

The changes in docummentation are nice and dandy, but it would be even nicer
if "git add" told us about "git update-index --add" when it adds no files,
as it is certainly the case when something is wrong (perhaps user
expectations, but still...).

-- 
Jakub Narebski
Warsaw, Poland
