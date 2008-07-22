From: david@lang.hm
Subject: Re: Git Documentation
Date: Tue, 22 Jul 2008 00:56:02 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0807220035110.1125@asgard.lang.hm>
References: <d411cc4a0807212035v68c2ed95m93b77c1e61cfec9e@mail.gmail.com> <200807220917.57363.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 09:56:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLCj5-0007ec-2C
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 09:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbYGVHzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 03:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbYGVHzD
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 03:55:03 -0400
Received: from mail.lang.hm ([64.81.33.126]:59896 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108AbYGVHzC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 03:55:02 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m6M7suQQ018402;
	Tue, 22 Jul 2008 00:54:56 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <200807220917.57363.johan@herland.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89468>

On Tue, 22 Jul 2008, Johan Herland wrote:

> On Tuesday 22 July 2008, Scott Chacon wrote:
>> If anyone has any tips on how they think git should be taught, issues
>> they are asked a lot, problems newbies tend to have, something they
>> wish there were a screencast for or was better documented, etc -
>> please do contact me so I can incorporate it.
>
> You should at least take a look at this thread:
>
> http://thread.gmane.org/gmane.comp.version-control.git/88698
>
> (even though it goes off-topic after a while...)
>
>> If anyone has any tips on how they think git should be taught...
>
> It seems there are primarily two ways to teach Git:
>
> 1. Top-down: Start with simple use cases and commands. Teach people a
> minimal, but necessary set of porcelain commands to get them started. Stay
> _far_ away from plumbing commands and most of the command options.
>
> 2. Bottom-up: Start with how Git structures the data. Talk about blobs,
> trees, commits, refs, how everything is connected, and how various Git
> commands query and manipulate this structure. This _may_ involve a fair
> amount of plumbing commands, especially when discovering how the more
> complicated high-level commands manipulate the structure.
>
> Some people seem to prefer the first approach, other people prefer the other
> approach. Both paths lead to enlightenment ;). In many cases a bit of both
> may be useful. HOWEVER, I think it is _very_ important to keep in mind that
> these are two _different_ approaches, and the contexts in which they are
> taught should be kept separate. I would almost suggest splitting your
> website down the middle and make the difference between top-down and
> bottom-up immediately visible with, say, a different background color, or
> something else that immediately tells the user what "track" they are
> following...

possibly a combination of the two?

under the covers the git data-structures are pretty simple and explaining 
them (and the minimal tools to manipulate them) isn't that bad.

what gets ugly is when you then try to use the plumbing to do the 
non-trivial things.

so how about an optional 'under the covers' primer, covering just the 
trivial plumbing, then the high-level minimal introduction with a link on 
each of the commands as they are introduced (so that a person can dig into 
deeper detail if they want to, possibly including 'up until version X 
this command was implemented by the following script'), followed by links 
to sample work-flows and a full dive into the plumbing (because at this 
point the person should know enough to get by, now they need reference 
material and examples more then a tutorial).

ideally this would let people dive as deep as they are comfortable with, or 
skim the explanation for the functionality

I think one reason the 'plumbing first' approach gets a bad rap is that 
it's so easy to get caught up into how clever you can get with the 
plumbing. it's like teaching someone programming by spending a day 
introducing them to concepts and language syntax, and then giving them the 
entries in the obfuscated C contests as examples of how someone can use 
them to get work done, but skipping any mention of libc or other standard 
libraries.

on the other hand, teaching only porcelain is like teaching them <insert 
high-level *th generation buzzword language> without teaching any concept 
of what they computer is doing under the covers, they can work, and even 
get useful work done, but they will be limited on how effective they can 
be.


you can't be a great programmer until you can understand both levels, the 
under-the-covers 'plumbing' and the high level libraries of the 
'porcelain', trying to ignore either will limit you.

David Lang
