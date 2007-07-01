From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Sun, 01 Jul 2007 14:11:56 -0700
Message-ID: <4688189C.8040105@freedesktop.org>
References: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org> <7vy7i1b6bt.fsf@assigned-by-dhcp.cox.net> <20070701082202.GB6093@coredump.intra.peff.net> <Pine.LNX.4.64.0707011313580.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 01 23:12:30 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I56ib-0007O0-Ql
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 23:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbXGAVMT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 17:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbXGAVMT
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 17:12:19 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:37509 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbXGAVMS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 17:12:18 -0400
Received: (qmail 20359 invoked from network); 1 Jul 2007 21:12:17 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail2.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <Johannes.Schindelin@gmx.de>; 1 Jul 2007 21:12:17 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.4 (X11/20070622)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.64.0707011313580.4438@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51322>

Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 1 Jul 2007, Jeff King wrote:
> 
>> On Sat, Jun 30, 2007 at 12:17:10PM -0700, Junio C Hamano wrote:
>>
>>> So I am somewhat negative on this, unless there is a way for
>>> scripts to say "Even though I say 'git foo', I do mean 'git foo'
>>> not whatever the user has aliased".
>> I had submitted GIT_NOALIAS=1 patches a while back, but IIRC, the
>> consensus was that it was a bit too ugly and fragile in concept.
> 
> I think it is not GIT_NOALIAS that is ugly and fragile in concept. It is 
> the whole notion that you can define default parameters via aliases that 
> is ugly and fragile.
> 
> The possibility to say
> 
> 	git config alias.log '!rm -rf /home/peff'
> 
> on somebody _else's_ machine makes me go shudder.
> 
> And there's another thing. On some machines, rm is aliased to 'rm -i'. 
> That's good, right? NO! It _forces_ me to either look at the aliases on 
> that particular box, or alternatively (which is what I actually do), 
> specify _exactly_ what I want (I never do "rm", I always do "rm -i" or "rm 
> -f", or "git rm"). That's because the default behaviour is 
> _different_ on _different_ boxes. Repeat after me: consistency is good, 
> inconsistency is bad.

And to give a git-specific example, I suspect many people would see this
feature and immediately do "git config alias.commit "commit -a".

- Josh Triplett
