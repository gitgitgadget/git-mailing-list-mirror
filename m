From: David Greaves <david@dgreaves.com>
Subject: Re: [RFC] Another way to provide help details. (was Re: [PATCH] Add
 help details to git help command.)
Date: Tue, 19 Apr 2005 15:41:34 +0100
Message-ID: <4265189E.6090801@dgreaves.com>
References: <200504172242.26326.elenstev@mesatop.com> <20050418102412.GJ1461@pasky.ji.cz> <4263E782.6040608@mesatop.com> <200504181940.54453.elenstev@mesatop.com> <20050419015124.GW5554@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steven Cole <elenstev@mesatop.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 16:42:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNtuH-0006sV-B9
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 16:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVDSOmh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 10:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVDSOmV
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 10:42:21 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:12161 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261513AbVDSOlj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 10:41:39 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 43C6FE6D77; Tue, 19 Apr 2005 15:39:58 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 04960-08; Tue, 19 Apr 2005 15:39:58 +0100 (BST)
Received: from oak.dgreaves.com (modem-2883.elk.dialup.pol.co.uk [81.76.171.67])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 5218AE6D73; Tue, 19 Apr 2005 15:39:57 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DNtuw-0006wd-HH; Tue, 19 Apr 2005 15:41:34 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050419015124.GW5554@pasky.ji.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Tue, Apr 19, 2005 at 03:40:54AM CEST, I got a letter
> where Steven Cole <elenstev@mesatop.com> told me that...
> 
>>Here is perhaps a better way to provide detailed help for each
>>git command.  A command.help file for each command can be
>>written in the style of a man page.
> 
> 
> I don't like it. I think the 'help' command should serve primarily as a
> quick reference, which does not blend so well with a manual page - it's
> too long and too convoluted by repeated output.
> 
> I'd just print the top comment from each file. :-)
> 

On the other hand, having more complete docs seems like an excellent 
idea (and other threads support that)
I'd certainly like to see more specification oriented documentation...
(even if it turns out to be disposable)

Steven, if you carry on sending more verbose docs I'll certainly read 
and work with you on editing them...

Nb kernel-doc doesn't seem appropriate for user level docs.
maybe, whilst there's so much flux, have:
   git man command
that just outputs text

If Petr wants the top comment to be extracted by help then maybe a 
bottom comment block could contain the more complete text?
I *really* think that the user docs should live in the source for now 
(hence I think that git man is better than going straight to man/docbook).

I wasn't sure whether to perlise the code or do a shell-lib - but 
looking at the algorithms needed in things like git status I reckon the 
shell will end up becoming a hackish mess of awk/sed/tr/sort/uniq/pipe 
(ie perl) anyway.

So I'm going to have a go at that - Petr, if you have a minute could you 
send me, off list, a bit of perl code that epitomises the style you like?

David

