From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: how to backup git
Date: Mon, 12 May 2008 19:43:36 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805121909440.19665@iabervon.org>
References: <4827DEF6.1050005@gmail.com> <87ej87is50.fsf@offby1.atm01.sea.blarg.net> <alpine.DEB.1.00.0805121428310.30431@racer> <48285087.3090402@gmail.com> <alpine.LNX.1.00.0805121647540.19665@iabervon.org> <7vej87xioc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bill lam <cbill.lam@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 01:44:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvhgy-0006UL-0c
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 01:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523AbYELXni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 19:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754665AbYELXni
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 19:43:38 -0400
Received: from iabervon.org ([66.92.72.58]:44335 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754344AbYELXni (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 19:43:38 -0400
Received: (qmail 2558 invoked by uid 1000); 12 May 2008 23:43:36 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 May 2008 23:43:36 -0000
In-Reply-To: <7vej87xioc.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81966>

On Mon, 12 May 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> I think suggestions from old timers on this thread to first "git fetch" is
> to handle that concern.

Yeah, "git fetch" is the right solution (although it's a pain to do a 
backup of "every repo under <path>" or "every repo anywhere under <path>" 
that way, which I suspect of being the real issue). I just wanted to get a 
note into this thread of what problems using rsync can and cannot have, 
since it's different (both more and less reliable) from what the original 
poster asked about.

> It may not get the commit that is being created simultaneously when such 
> a fetch to backup repository is running (but that will be backed up 
> during the next round), but at least the contents of the backup 
> repository would be self contained and correct.

And simultaneous commit isn't really an issue; nothing will back up work 
you do right after the backup runs, and users can't tell whether they did 
the commit before or after the backup if it's close.

	-Daniel
*This .sig left intentionally blank*
