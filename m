From: Robert Haines <rhaines@manchester.ac.uk>
Subject: Re: Pushing an --amend-ed commit [and a git-merge-theirs strategy]
Date: Tue, 3 Jun 2008 18:49:56 +0100
Message-ID: <A36634E4-D440-4E85-9567-7331FC201BFB@manchester.ac.uk>
References: <6B355924-0EA9-4AF8-B051-F17FC4530495@manchester.ac.uk> <484409F9.5020807@gnu.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jun 03 19:50:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3aer-0000Gs-LP
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 19:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbYFCRt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 13:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbYFCRt7
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 13:49:59 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:51026 "EHLO
	serenity.mcc.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305AbYFCRt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 13:49:58 -0400
Received: from gerhayn.mcc.ac.uk ([10.2.18.1])
	by serenity.mcc.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1K3adw-0006rJ-T4; Tue, 03 Jun 2008 18:49:56 +0100
Received: from leela.rcs.manchester.ac.uk ([130.88.1.66]:54914)
	by gerhayn.mcc.ac.uk with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1K3adw-0002lz-Oq; Tue, 03 Jun 2008 18:49:56 +0100
In-Reply-To: <484409F9.5020807@gnu.org>
X-Mailer: Apple Mail (2.924)
X-Authenticated-Sender: Robert Haines from leela.rcs.manchester.ac.uk [130.88.1.66]:54914
X-Authenticated-From: Robert.Haines@manchester.ac.uk
X-UoM: Scanned by the University Mail System. See http://www.itservices.manchester.ac.uk/email/filtering/information/ for details.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83681>

On 2 Jun 2008, at 15:55, Paolo Bonzini wrote:
>> 1) Right, changes all done and committed. Push to public repo.
>> 2) Bugger, missed out an obvious one-liner in a Makefile. Make  
>> change and --amend that last commit.
>> 3) Push to public repo again... Ah, "Not a strict subset" error,  
>> can't push...
>> It's obvious (I think) to me why I get this error - the commit now  
>> has a different hash so it looks like it would be the wrong thing  
>> to do to allow the push as far as git is concerned. Right?
>> So, is it safe to "use the --force" in this instance when pushing?  
>> This should just replace the old commit with the --amended commit  
>> with no side-effects, shouldn't it?
>
> Yes, but it would screw up other people that pulled from you.

Ah yes, forgot about that...

> If that's an issue (it most likely is, unless you're just pushing  
> just to your own mirror repository)

It's not an issue right now as I'm still experimenting, but it  
certainly will be when I let others lose on this stuff. It's really  
not something I see myself doing a lot - I usually test a lot more  
thoroughly before publishing to a public repo...

> it is better if you do it the other way round: adding your commits  
> on top of origin^, starting from the one that fixed a typo.  In  
> other words, make the history look like you hadn't used --amend.

<snip big explanation and code>

Thanks very much for the code and method. It goes over my head a bit  
right now, but I'll think on it and try it and see how I get on! A lot  
of what git can do scares me a bit still - mainly because it's me  
driving it...

Thanks also to the other people who answered me!

Cheers,
Rob
