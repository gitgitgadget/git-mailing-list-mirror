From: Federico Mena Quintero <federico@novell.com>
Subject: [PATCH 0/4] Another round of the --track patches
Date: Tue, 02 Oct 2007 18:30:17 -0500
Message-ID: <1191367817.3776.192.camel@cacharro.xalalinux.org>
References: <1190077493.22387.54.camel@cacharro.xalalinux.org>
	 <1190077881.22387.63.camel@cacharro.xalalinux.org>
	 <7v3axbvbto.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 01:29:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcrB8-0002wW-6r
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 01:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756807AbXJBX2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 19:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754431AbXJBX2k
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 19:28:40 -0400
Received: from jericho.provo.novell.com ([137.65.248.124]:13638 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756780AbXJBX2j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 19:28:39 -0400
Received: from [164.99.193.181] ([164.99.193.181])
	by jericho.provo.novell.com with ESMTP; Tue, 02 Oct 2007 17:28:25 -0600
In-Reply-To: <7v3axbvbto.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.11.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59751>

On Tue, 2007-09-18 at 15:38 -0700, Junio C Hamano wrote:
> Federico Mena Quintero <federico@novell.com> writes:
> > -	retrieve data from the remote branch.  Set the
> > +	retrieve data from the remote branch, otherwise you'll have to
> > +	use "git pull <url>" explicitly.  Set the
> >  	branch.autosetupmerge configuration variable to true if you
> >  	want git-checkout and git-branch to always behave as if
> >  	'--track' were given.
> 
> Hmph.
> 
> I'd rather make them consistent by dropping the not-so-correct
> "otherwise" phrase from all three copies.  It is not "otherwise
> you'll have to", but "instead you can".

Sure, I've added better wording now.

> I am inclined to suggest rewording the message like this, and
> make this condition an error (i.e. "exit 1"):
[snip]

I like that message much better, and it's nice that it gives you the
snippet to put in your config file.  This is in patch 4/4.

Thanks for the review; I hope this can make it in now ;)

  Federico
