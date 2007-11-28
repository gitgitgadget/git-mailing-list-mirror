From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH v2] Teach 'git pull' about --rebase
Date: Wed, 28 Nov 2007 14:06:44 -0800
Message-ID: <37EFF273-D8E1-4042-966B-743CE9D753AA@midwinter.com>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site> <alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org> <Pine.LNX.4.64.0710260007450.4362@racer.site> <7v3avy21il.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0710261047450.4362@racer.site> <7v3aurcjpq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711281307420.27959@racer.site> <27E5EF3C-19EF-441C-BB12-0F5B29BEAEDB@midwinter.com> <Pine.LNX.4.64.0711282039430.27959@racer.site> <8c5c35580711281310h8764a33pba48e65010abf859@mail.gmail.com> <7vhcj63uhw.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711282156520.27959@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 23:07:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxV3k-0006wQ-4k
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 23:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757274AbXK1WGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 17:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757043AbXK1WGq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 17:06:46 -0500
Received: from tater.midwinter.com ([216.32.86.90]:45337 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752771AbXK1WGq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 17:06:46 -0500
Received: (qmail 2970 invoked from network); 28 Nov 2007 22:06:45 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=ntfags2jT9XFXe7SGnLYJ2JCRYtgOBQJmJ8XCoC8isCOWiCfcNKSIRsJR26NUfh1  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 28 Nov 2007 22:06:45 -0000
In-Reply-To: <Pine.LNX.4.64.0711282156520.27959@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66438>

On Nov 28, 2007, at 1:58 PM, Johannes Schindelin wrote:
> Besides, the operation "pull" is about getting remote changes  
> incorporated
> in your current branch.  IMHO "pull = fetch + merge" is only a  
> technical
> detail, and we should not be bound by it too much.

Yeah, I agree. I almost never use "pull" as is because I almost always  
want to rebase. That is, it's basically clutter for me as a command  
right now, and it would remain so even if a separate fetch+rebase  
command were added.

I think this may be a difference in perspective based on how one uses  
git. If I were an integrator I would probably use "pull" as is a lot  
more because I would want the merges represented explicitly in my  
history. But most of the time I'm working as a leaf node in the tree  
of repositories, interacting only with a central integration repo, and  
I basically never want a give-me-the-remote-changes operation (which  
is really more of a "sync me up with the latest changes from the rest  
of the team" operation) to put a merge in my history.

What's more, when I'm introducing git to new people in my environment,  
right now I tell them about fetch and rebase and pretty much have to  
tell them to avoid running "pull" until they're comfortable with git,  
since I know their histories would be full of meaningless merges  
otherwise. It'd be nice to have new people run one less command as  
part of their normal day-to-day work.

-Steve
