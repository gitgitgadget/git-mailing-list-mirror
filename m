From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (May 2009, #02; Sun, 17)
Date: Tue, 19 May 2009 09:23:33 +0200
Message-ID: <200905190923.33874.johan@herland.net>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org>
 <200905182355.21645.johan@herland.net>
 <7vpre5anaz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, markus.heidelberg@web.de,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 19 09:23:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Jfu-0001l9-5n
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 09:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707AbZESHXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 03:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbZESHXf
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 03:23:35 -0400
Received: from mx.getmail.no ([84.208.15.66]:44913 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752994AbZESHXf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 03:23:35 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJV00041R7BWFD0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 19 May 2009 09:23:35 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJV007CDR7ALKI0@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 19 May 2009 09:23:35 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.5.19.70500
User-Agent: KMail/1.11.3 (Linux/2.6.29-ARCH; KDE/4.2.3; x86_64; ; )
In-reply-to: <7vpre5anaz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119499>

On Tuesday 19 May 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > After some thinking, I don't like my original name
> > submodule.<name>.resolve, since ".resolve" sounds more like a merge
> > strategy or conflict resolution method, than a "how to deal with
> > submodule update" choice. I propose submodule.<name>.update instead.
>
> Sounds like a plan, even though I do not necessarily agree with the idea
> of automatically rebinding what is at the submodule path every time you
> update the toplevel project tree.

I agree that in many workflows this does not make sense, but I believe that 
(as with 'git submodule update --rebase') there are some cases where it does 
make sense, and I see no reason to support one, but not the other.

> And from my point of view, "rebind" (or "autorebind") would be more
> appropriate name than "update"

Feel free to fix up my patch with whatever the community finds most 
appropriate. Personally, I still like "update" better because it determines 
what "happens" on a git submodule update, but I'm not religious about this.

> (and I would probably set it to "never").

That's perfectly ok. So will I, in most of my repos. But there are cases 
(e.g. in the workflows at $dayjob) where this feature will be very valuable.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
