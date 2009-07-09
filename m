From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: default aliases (ci, di, st, co)
Date: Thu, 09 Jul 2009 10:50:13 +0200
Message-ID: <4A55AF45.4040700@drmicha.warpmail.net>
References: <85b5c3130907081649s37f726f7id1a64f2fdbe609f@mail.gmail.com> <4A55958E.1050401@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ondrej Certik <ondrej@certik.cz>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Jul 09 10:50:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOpKx-0004xX-6A
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 10:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756327AbZGIIue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 04:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754927AbZGIIud
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 04:50:33 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42531 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754705AbZGIIuc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 04:50:32 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 7918B3B002F;
	Thu,  9 Jul 2009 04:50:31 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 09 Jul 2009 04:50:31 -0400
X-Sasl-enc: uT5s8opMaiLllROrHewDQ+sms0Sby+CZg7QopBZaTDeJ 1247129431
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A7B3DF563;
	Thu,  9 Jul 2009 04:50:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090707 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <4A55958E.1050401@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122950>

Andreas Ericsson venit, vidit, dixit 09.07.2009 09:00:
> Ondrej Certik wrote:
>> Hi,
>>
>> coming to git from mercurial and svn, here is the alias part of my .gitconfig:
>>
>> [alias]
>>     ci = commit
>>     di = diff --color-words
>>     st = status
>>     co = checkout
>>
>>
>> And all is fine until I share commands to checkout my branch (for
>> example) with other people, then basically I have to write those
>> commands in full (e.g. commit, checkout, ...), since I cannot assume
>> they have their .gitconfig setup the same way I do. Especially for
>> people who are new to git.
>>
>> What is the view on this in the git community?
> 
> 
> Personally I think "plain" aliases like you use above are evil.
> git is not svn or mercurial. If you use it like svn you'll be
> surprised sooner or later and your workflow will feel awkward or
> just plain wrong. hg and git are very similar, but the fact that
> hg assumed the svn shorthands implies to me that they've tried
> to retain a compatibility that does not, in fact, exist. DVCS
> systems are enormously different from centralized ones. Borrowing
> from centralized ones to a DVCS one feels utterly backwards.
> 
> 
>> Do most of you write
>>
>> git checkout -b branch ...
>>
>> (possibly with TAB completion) or do most of you write
>>
>> git co -b branch ...
>>
>> (like I do all the time, except when sharing my commands with other people)?
>>
> 
> I have no simple aliases for any of the commands. There's just no reason
> for them since tab completion works so well.
> 
> I do have one alias, which is "wsfix". It fixes whitespace fsckups I've
> added to the index but not yet committed to the worktree. It's not a
> particularly complex one, but not exactly simple either.
> 
> 
>> Could in principle those aliases be even made default by git? Or is
>> this not a good idea.
>>
> 
> I see no reason to add default aliases. It will make a mess of things
> when trying to explain workflows to people who have older versions of
> git where those default aliases aren't available. It'll add complexity
> to explanations, which is never a good thing.
> 
> If I have a vote, I vote no.
> 

Adding my no-vote to that, too.

Aliases are great, but default aliases are a problem. We saw this when
we introduced "git stage", and I don't think we're happy in retrorespect.

Having said that, collecting useful aliases (e.g. one, who, ...) in
contrib/ or in the wiki would be helpful.

Michael
