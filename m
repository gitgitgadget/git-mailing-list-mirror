From: Yaacov Akiba Slama <ya@slamail.org>
Subject: Re: git binary directory?
Date: Sat, 05 Nov 2005 23:43:11 +0200
Message-ID: <436D276F.7010302@slamail.org>
References: <436D2269.6090605@slamail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Nov 05 22:44:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYVoq-0005ZT-U7
	for gcvg-git@gmane.org; Sat, 05 Nov 2005 22:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVKEVnW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Nov 2005 16:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVKEVnW
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Nov 2005 16:43:22 -0500
Received: from [195.140.142.33] ([195.140.142.33]:38574 "EHLO
	c1-033.cyaris.net") by vger.kernel.org with ESMTP id S932204AbVKEVnV
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 5 Nov 2005 16:43:21 -0500
Received: from localhost ([127.0.33.1] helo=localhost.localdomain)
	by c1-033.cyaris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1EYVoh-0001iB-T0
	for git@vger.kernel.org; Sat, 05 Nov 2005 22:43:20 +0100
Received: from [127.0.0.1] (helo=[127.0.0.1])
	by localhost.localdomain with esmtp (Exim 4.54)
	id 1EYVod-0002Ii-K8
	for git@vger.kernel.org; Sat, 05 Nov 2005 23:43:11 +0200
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <436D2269.6090605@slamail.org>
X-Spam-Score: -2.8 (--)
X-Spam-Report: Spam detection software, running on the system "c1-033.cyaris.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Linus Torvalds wrote: > So I'd really suggest that
	while the "git-<tab><tab>" thing is perhaps > useful, we'd actually be
	better off with an /usr/lib/git directory > where we put the git
	executables by default. And just put "git" into > /usr/bin. > > That
	way, people who _want_ to use "git-<tab><tab>" can just add the > git
	binary directory to their path and directly access all of them. > And
	others can just use the plain "git" interface. > > That would mean that
	I'd have to learn to use "git whatchanged" and > "git diff-tree"
	instead of "git-whatchanged" and "git-diff-tree", but > hey, it's why
	we have that "git" script in the first place. > > What do people think?
	[...] 
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11185>

Linus Torvalds wrote:

> So I'd really suggest that while the "git-<tab><tab>" thing is perhaps 
> useful, we'd actually be better off with an /usr/lib/git directory 
> where we put the git executables by default. And just put "git" into 
> /usr/bin.
>
> That way, people who _want_ to use "git-<tab><tab>" can just add the 
> git binary directory to their path and directly access all of them. 
> And others can just use the plain "git" interface.
>
> That would mean that I'd have to learn to use "git whatchanged" and 
> "git diff-tree" instead of "git-whatchanged" and "git-diff-tree", but 
> hey, it's why we have that "git" script in the first place.
>
> What do people think?

I agree with you. I have 3268 entries in /usr/bin and git commands 
account for 3.3% of this number which is a lot.

In addition custom tab completion can be quite easily added to bash and zsh.

If you indeed put only git in /usr/bin, a good idea would be perhaps to 
implement (svn does that for instance) : "git help" to have a simple 
list of command (this is almost already there),  and "git help  
<command>" which can give the same result as "man git-<command>" because 
it's not clear from "man git" that one needs to see the man pages of the 
commands listed in "Porcelain-ish command".



--yas
