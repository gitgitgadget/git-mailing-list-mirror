From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [minor usability suggestion] git rebase <upstream> --onto
 <newbase> ?
Date: Fri, 7 Nov 2008 15:10:32 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0811071504110.19665@iabervon.org>
References: <20081107092035.GA1339@elte.hu> <7vej1ngztd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 21:11:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyXgL-0000lA-0H
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 21:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbYKGUKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 15:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbYKGUKe
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 15:10:34 -0500
Received: from iabervon.org ([66.92.72.58]:60817 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbYKGUKd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 15:10:33 -0500
Received: (qmail 28084 invoked by uid 1000); 7 Nov 2008 20:10:32 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Nov 2008 20:10:32 -0000
In-Reply-To: <7vej1ngztd.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100327>

On Fri, 7 Nov 2008, Junio C Hamano wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> >  earth4:~/tip> git rebase 685aebb --onto linus
> >  Current branch core/urgent is up to date.
> > ...
> > For example "git log" is exemplary in this area as it accepts just 
> > about any permutation of parameters thrown at it, ...
> 
> Not really.
> 
> There may be oddball commands whose parameter order have been established
> differently long before "git log" came, but almost all of them now use the
> same convention used by the "git log" family, which is flags/options then
> revs (and then paths if the operation makes sense with paths).  And rebase
> is not one of the oddball ones.
> 
> Your "rebase" example is a rev then a flag/option, which is not how any
> other git command take its command line parameters.

"git log origin/master -p" works, though. It's paths, not revisions, that 
can't appear before options (or revisions).

	-Daniel
*This .sig left intentionally blank*
