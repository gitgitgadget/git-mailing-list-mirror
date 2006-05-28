From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Support for configurable git command aliases
Date: Mon, 29 May 2006 00:57:26 +0200
Organization: At home
Message-ID: <e5d9sm$5d4$1@sea.gmane.org>
References: <torvalds@osdl.org> <Pine.LNX.4.64.0605262007230.5623@g5.osdl.org> <200605271252.k4RCqZhR003192@laptop11.inf.utfsm.cl> <20060528215945.GD10488@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon May 29 00:58:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkUD2-0001Mu-Sn
	for gcvg-git@gmane.org; Mon, 29 May 2006 00:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWE1W5i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 18:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWE1W5i
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 18:57:38 -0400
Received: from main.gmane.org ([80.91.229.2]:63362 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751027AbWE1W5h (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 18:57:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FkUCS-0001KG-Fv
	for git@vger.kernel.org; Mon, 29 May 2006 00:57:32 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 May 2006 00:57:32 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 May 2006 00:57:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20907>

Petr Baudis wrote:

> Dear diary, on Sat, May 27, 2006 at 02:52:35PM CEST, I got a letter
> where Horst von Brand <vonbrand@inf.utfsm.cl> said that...
>>
>> I don't like this syntax. What other stuff (beside "cmd") would be under
>> "[alias "co"]? Why not simply:
>> 
>>         [alias]
>>              co = commit -a
>>              publish = push public.site.com:/pub/scm/my-public-repo
> 
> Nice, I like this.
> 
> Well, the following isn't exactly the nicest code I have ever written...
> But it seems to work. ;-)

Well, if [alias] would be used also for giving default options for git
commands, e.g.

        [alias]
            log = log --pretty

(from what Petr "Pasky" Baudis said on IRC, currently on the right side
there should be only true git commands, which eliminates nicely problems
with recursion ;-), it would be better to ensure that aliases are checked
*only* for interactive sessions - otherwise using aliases for default
arguments would/could mess the scripts.

-- 
Jakub Narebski
Warsaw, Poland
