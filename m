From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: cogito remote branch
Date: Sat, 10 Nov 2007 13:35:52 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711101323040.6138@castor.milkiway.cos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: jnareb@gmail.com
X-From: git-owner@vger.kernel.org Sat Nov 10 13:36:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqpZi-0001Q6-TC
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 13:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbXKJMgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 07:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbXKJMgM
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 07:36:12 -0500
Received: from mailout08.sul.t-online.de ([194.25.134.20]:54201 "EHLO
	mailout08.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751855AbXKJMgK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2007 07:36:10 -0500
Received: from fwd28.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1IqpZ9-0006lV-06; Sat, 10 Nov 2007 13:35:59 +0100
Received: from [192.168.2.100] (X6SENvZroh6uHn6JGuMB7Y-dqSta8xh0QDoeqKlytr6u09u+c-HqS2tC8MH28apgwX@[84.163.232.243]) by fwd28.t-online.de
	with esmtp id 1IqpZ5-2K7YFE0; Sat, 10 Nov 2007 13:35:55 +0100
X-X-Sender: michael@castor.milkiway.cos
X-ID: X6SENvZroh6uHn6JGuMB7Y-dqSta8xh0QDoeqKlytr6u09u+c-HqS2tC8MH28apgwX
X-TOI-MSGID: 48cfdd74-3fd6-4780-a872-d4f496d4726e
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64341>

>Michael Dressel wrote:
>> On Fri, 9 Nov 2007, Jon Loeliger wrote: 
>>> On Fri, 2007-11-09 at 10:10, MichaelTiloDressel@t-online.de wrote:
>>>
>>>>  There are just some features
>>>> which simplify things for me in cogito. E.g. in cogito in the 
simplest
>>>> way you don't need to be aware of the index. While with git
>>>> you have to remember to add the changes to the index explicitly
>>>> to get them committed. 
>>> 
>>> "git commit -a ..." might be useful for you.
>>> 
>>> Other lingering cogito-isms you think are lacking in git?
>> 
>> Thanks for the hint. I have to use git for a while to understand what 
may 
>> still be lacking (at least for me, if at all). Off the top of my head 
one 
>> other difference is that if I do a cg-push the remote (or origin) head 
is 
>> updated automatically, I think.

Jakub Narebski wrote:
>If you mean that tracking branches are updated on push, this is what
>git also does from some time (perhaps not in released version, so please
>wait or run 'master').

Ok nice. Another thing is that git-push will push all the tracking 
branches in refs/remotes/origin. 

I was wondering if it was possible to have some cogito like wrapper 
scripts (lets say kg-...) for git again which would use the git commands 
with some arguments in order to resemble the cogito behavior 
even more closely. But it dawned on me that this would most likely end up 
in a rather large amount of script code again.

Cheers,
Michael
