From: Andreas Ericsson <ae@op5.se>
Subject: Re: git and time
Date: Fri, 29 Sep 2006 09:52:34 +0200
Message-ID: <451CD0C2.2020805@op5.se>
References: <20060928013914.16514.qmail@web51005.mail.yahoo.com> <Pine.LNX.4.64.0609271918350.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthew L Foster <mfoster167@yahoo.com>,
	Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 29 09:53:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTDAw-00013N-Pp
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 09:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbWI2Hwi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 03:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbWI2Hwi
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 03:52:38 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:2211 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1030405AbWI2Hwg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Sep 2006 03:52:36 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id BC3386BD5F; Fri, 29 Sep 2006 09:52:35 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 621AA6BD11; Fri, 29 Sep 2006 09:52:34 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609271918350.3952@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28101>

Linus Torvalds wrote:
> 
> On Wed, 27 Sep 2006, Matthew L Foster wrote:
>> From a web display/generic notion of integrity perspective time order 
>> matters to me but it looks like I am the only one. Keeping track of 
>> _local_ commit time would not add any dependencies.
> 
> Actually, I think one problem here is that anybody why looks at just the 
> gitweb interface may not realize how git works.
> 
> If you use gitk as your primary way of learning about a git problem, the 
> whole time issue just goes away, because gitk shows the _real_ 
> relationships so well.
> 
> I used gitk in all my initial explanations of git, because it turned a 
> fairly abstract "here, let me explain how it works" into a "See? Look at 
> this" kind of situation.
> 

True that. I would have had a hard time introducing git as The SCM in 
the company if it hadn't been for gitk and qgit. They both let you just 
skip over 90% of that initial steep part of the learning curve and jump 
straight to work.

> I think gitweb is great (in a way I have _never_ felt about any of the CVS 
> web interfaces I have ever seen), but gitweb doesn't really explain how 
> things work as well as gitk does.
> 

Someone started hacking on a web-thingie to show the graph. Whatever 
happened to that? If it's no longer alive, perhaps we could add some 
qgit/gitk screenshots to the git wiki/docs so the people who spend most 
of their lives in browsers can get some visual aid in understanding the 
way git works.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
